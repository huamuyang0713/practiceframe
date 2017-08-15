//
//  YYNetworkBackendAPIRequest.swift
//  BaseFrame
//
//  Created by kin on 2017/7/25.
//  Copyright © 2017年 kin. All rights reserved.
//

import Foundation

protocol YYNetworkBackendAPIRequestProtocol {
    var endpoint: String { get set }
    var method: YYNetworkService.Method { get set }
    var query: YYNetworkService.QueryType { get set }
    var parameters: [String : Any]? { get set }
    var headers: [String : String]? { get set }
}

public class YYNetworkBackendAPIRequest: YYNetworkBackendAPIRequestProtocol {
    
    let offset = 0
    let limit  = 10
    
    var headers: [String : String]?

    var parameters: [String : Any]?

    var query: YYNetworkService.QueryType

    var method: YYNetworkService.Method

    var endpoint: String = ""

    init() {
        headers = ["Content-Type" : "application/json"]
        method = .get
        query = .path
    }
    
}

extension YYNetworkBackendAPIRequest {
    func defaultJSONHeaders() -> [String : String] {
        return ["Content-Type" : "application/json"]
    }
}

extension YYNetworkBackendAPIRequest {
    func parameters(param: [String: Any]) -> YYNetworkBackendAPIRequest {
        var p: [String : Any]
        if self.parameters == nil {
            p = [:]
        } else {
            p = self.parameters!
        }
        for (key, value) in param {
            p.updateValue(value, forKey: key)
        }
        self.parameters = p
        return self
    }
    
    func endpoint(endP: String) -> YYNetworkBackendAPIRequest {
        self.endpoint = endP
        return self
    }
    
    func method(med: YYNetworkService.Method? = .get) -> YYNetworkBackendAPIRequest {
        self.method = med!
        return self
    }
    
    func queryType(type: YYNetworkService.QueryType? = .path) -> YYNetworkBackendAPIRequest {
        self.query = type!
        return self
    }
    
    func headers(head: [String : String]? = ["Content-Type" : "application/json"]) -> YYNetworkBackendAPIRequest {
        self.headers = head
        return self
    }
    
    func defaultParam() -> YYNetworkBackendAPIRequest {
        var p: [String : Any]
        if self.parameters == nil {
            p = [:]
        } else {
            p = self.parameters!
        }
        p.updateValue(offset, forKey: "offset")
        p.updateValue(limit, forKey: "limit")
        self.parameters = p
        return self
    }
}
