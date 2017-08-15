//
//  YYNetworkBackendService.swift
//  BaseFrame
//
//  Created by kin on 2017/7/25.
//  Copyright © 2017年 kin. All rights reserved.
//

import Foundation


public let DidPerformUnauthorizedOperation = "DidPerformUnauthorizedOperation"

class YYNetworkBackendService {
    private let conf: YYNetworkConfiguration
    private let service = YYNetworkService()
    
    init(_ conf: YYNetworkConfiguration) {
        self.conf = conf
    }
    
    func request(_ request: YYNetworkBackendAPIRequest,
                 success: ((AnyObject?) -> Void)? = nil,
                 failure: ((NSError) -> Void)? = nil) {
        let url = conf.baseURL.appendingPathComponent(request.endpoint)
        
        let headers = request.headers // 特殊设置，如认证token
        
        service.makeRequest(with: url, method: request.method, query: request.query, params: request.parameters, headers: headers, success: { (data) in
            var json: AnyObject? = nil
            if let data = data {
                json = try? JSONSerialization.jsonObject(with: data, options: []) as AnyObject
            }
//            print(json)
            success?(json)
        }, failure: { data, error, statusCode in
            if statusCode == 401 {
                // Operation not authorized
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: DidPerformUnauthorizedOperation), object: nil)
                return
            }
            if let data = data {
                let json = try? JSONSerialization.jsonObject(with: data, options: []) as AnyObject
                let info = [
                    NSLocalizedDescriptionKey : json?["error"] as? String ?? "",
                    NSLocalizedFailureReasonErrorKey : "probably not allowed action..."
                ]
                let err = NSError.init(domain: self.conf.domain, code: 0, userInfo: info)
                failure?(err)
            } else {
                failure?(error ?? NSError.init(domain: self.conf.domain, code: 0, userInfo: nil))
            }
        })
    }
    
    func cancel() {
        service.cancel()
    }
    
    
}
