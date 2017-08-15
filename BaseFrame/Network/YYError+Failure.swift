//
//  YYError+Failure.swift
//  BaseFrame
//
//  Created by kin on 2017/7/25.
//  Copyright © 2017年 kin. All rights reserved.
//

import Foundation


public enum YYErrorCode: Int {
    case `default` = 0
    case authentication
    case noSuchKey
    case typeDoesnotMatch
    case invalid
    case missingAttribute
    case parseFailed
    case noMore
}

extension NSError {
    public class func cannotParseResponse() -> NSError {
        let info = [NSLocalizedDescriptionKey : " Can't parse response.  Please debug. "]
        return NSError.init(domain: String(describing: self), code: YYErrorCode.default.rawValue, userInfo: info)
    }
    
    public class func mapCodeError(code: YYErrorCode) -> Error {
        return mapError(code: code, msg: self.debugDescription())
    }
    
    public class func mapMessageError(msg: String) -> Error {
        return mapError(code: YYErrorCode.default, msg:  msg)
    }
    
    
    public class func mapError(code: YYErrorCode, msg: String) -> Error {
        let info = [NSLocalizedDescriptionKey : msg]
        return NSError.init(domain: String(describing: self), code: code.rawValue, userInfo: info)
    }
    
}
