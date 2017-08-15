//
//  YYNetworkService.swift
//  BaseFrame
//
//  Created by kin on 2017/7/24.
//  Copyright © 2017年 kin. All rights reserved.
//

import Foundation

class YYNetworkService {
    var cachePolicy: URLRequest.CachePolicy = .reloadIgnoringLocalCacheData
    var timeoutInterval = 10.0
    
    private var task: URLSessionDataTask?
    private var successCodes: CountableRange<Int> = 200..<299
    private var failureCodes: CountableRange<Int> = 400..<499
    
    enum Method: String {
        case get, post, put, delete
    }
    
    enum QueryType {
        case json, path
    }
    
    func makeRequest(with url: URL,
                     method: Method,
                     query type: QueryType,
                     params: [String: Any]? = nil,
                     headers: [String: String]? = nil,
                     success: ((Data?) -> Void)? = nil,
                     failure: ((_ data: Data?, _ error: NSError?, _ respinseCode: Int) -> Void)? = nil)  {
        
        var mutableRequest = makeQuery(with: url, params: params, type: type)
        
        mutableRequest.allHTTPHeaderFields = headers
        mutableRequest.httpMethod = method.rawValue
        
        let session = URLSession.shared
        
        task = session.dataTask(with: mutableRequest, completionHandler: { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse else {
                failure?(data, error as NSError?, 0)
                return
            }
            
            if let error = error {
                failure?(data, error as NSError, httpResponse.statusCode)
                return
            }
            
            if self.successCodes.contains(httpResponse.statusCode) {
                success?(data)
            } else if self.failureCodes.contains(httpResponse.statusCode) {
                debugPrint("request fail for \(error.debugDescription)")
                failure?(data, error as NSError?, httpResponse.statusCode)
            } else {
                // expected 'successCodes'
                debugPrint("request fail for \(error.debugDescription)")
                let info = [NSLocalizedDescriptionKey : "request failed with code \(httpResponse.statusCode)",
                    NSLocalizedFailureReasonErrorKey : "wrong handling logic"
                ]
                let err = NSError.init(domain: YYNetworkConfiguration.shared.domain, code: 0, userInfo: info)
                failure?(data, err, httpResponse.statusCode)
            }
        })
        
        task?.resume()
        
    }
    
    func cancel() {
        task?.cancel()
    }
    
    private func makeQuery(with url: URL, params: [String : Any]?, type: QueryType) -> URLRequest {
        switch type {
        case .json:
            var mutableRequest = URLRequest(url: url, cachePolicy: cachePolicy, timeoutInterval: timeoutInterval)
            
            if let param = params {
                mutableRequest.httpBody = try! JSONSerialization.data(withJSONObject: param, options: [])
            }
            return mutableRequest
            
        case .path:
            var query = ""
            params?.forEach({ (key, value) in
                query = query + "\(key)=\(value)&"
            })
            var components = URLComponents.init(url: url, resolvingAgainstBaseURL: true)!
            components.query = query
            return URLRequest.init(url: components.url!, cachePolicy: cachePolicy, timeoutInterval: timeoutInterval)
            
        }
    }
    
}
