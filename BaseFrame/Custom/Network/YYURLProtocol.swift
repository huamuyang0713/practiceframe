//
//  YYURLProtocol.swift
//  BaseFrame
//
//  Created by kin on 2017/7/20.
//  Copyright © 2017年 kin. All rights reserved.
//

import UIKit

class YYURLProtocol: URLProtocol {
    var receiveData: NSMutableData?
    var urlResponse: URLResponse?
    var dataTask: URLSessionDataTask?
    
    override class func canInit(with request: URLRequest) -> Bool {
        if URLProtocol.property(forKey: YYURLProtocolInfo.key, in: request) != nil {
            return false
        }
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        let newRequest = (request as NSURLRequest).mutableCopy() as! NSMutableURLRequest
        let originHost = request.url?.host
        if "baidu.com" == originHost {
            let originURL = request.url?.absoluteString
            let newURL = originURL?.replacingOccurrences(of: originHost!, with: "")
            newRequest.url = URL(string: newURL!)
        }
        return newRequest as URLRequest
    }
    
    override func startLoading() {
        if let cachedResponse = self.getResponse() {
            self.client?.urlProtocol(self, didReceive: cachedResponse.response, cacheStoragePolicy: .notAllowed)
            self.client?.urlProtocol(self, didLoad: cachedResponse.data)
            self.client?.urlProtocolDidFinishLoading(self)
        } else {
            self.sendRequest()
        }
    }
    
    override func stopLoading() {
        self.dataTask?.cancel()
        self.dataTask = nil
        self.receiveData = nil
        self.urlResponse = nil
    }
    
    override class func requestIsCacheEquivalent(_ a: URLRequest, to b: URLRequest) -> Bool {
        return super.requestIsCacheEquivalent(a, to: b)
    }
    
    func sendRequest() {
        let newRequest = (self.request as NSURLRequest).mutableCopy() as? NSMutableURLRequest
        if newRequest != nil {
            URLProtocol.setProperty(true, forKey: YYURLProtocolInfo.key, in: newRequest!)
            let config = URLSessionConfiguration.default
            let urlSession = URLSession.init(configuration: config, delegate: self, delegateQueue: nil)
            self.dataTask = urlSession.dataTask(with: self.request)
            self.dataTask?.resume()
        }
    }
    
    func getResponse() -> CachedURLResponse? {
        if let filePath = self.filePathForCache() {
            if FileManager.default.fileExists(atPath: filePath) {
                return NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? CachedURLResponse
            }
            return nil
        }
        return nil
    }
    
   fileprivate func saveResponse(response: URLResponse, data: Data) {
        if let filePath = self.filePathForCache() {
            let cacheResponse = CachedURLResponse.init(response: response, data: data, userInfo: nil, storagePolicy: .notAllowed)
            NSKeyedArchiver.archiveRootObject(cacheResponse, toFile: filePath)
        }
    }
    
    fileprivate func filePathForCache() -> String? {
        if let key = self.request.url?.absoluteString {
            let tempDic = NSTemporaryDirectory()
            let filePath = tempDic.appending(key.MD5())
            return filePath
        }
        return nil
    }
    
    struct YYURLProtocolInfo {
       static let key = "YYURLPROTOCOLKEY"
    }
    
}

extension YYURLProtocol: URLSessionDataDelegate {
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        self.client?.urlProtocol(self, didLoad: data)
        self.receiveData?.append(data)
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        self.client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        self.urlResponse = response
        self.receiveData = NSMutableData()
        completionHandler(.allow)
    }
    
}

extension YYURLProtocol: URLSessionTaskDelegate {
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if error != nil {
            self.client?.urlProtocol(self, didFailWithError: error!)
        } else {
            self.client?.urlProtocolDidFinishLoading(self)
            if let resp = self.urlResponse {
                self.saveResponse(response: resp, data: self.receiveData?.copy() as! Data)
            }
        }
    }
}
