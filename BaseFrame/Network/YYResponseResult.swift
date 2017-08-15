//
//  YYResponseResult.swift
//  BaseFrame
//
//  Created by kin on 2017/7/27.
//  Copyright © 2017年 kin. All rights reserved.
//

import Foundation

protocol YYResponseResultProtocol {
    associatedtype Value
    init(value: Value)
}


public enum YYResponseResultType {
    case object
    case list
}

public enum YYResponseResult<T>: YYResponseResultProtocol
//    , CustomStringConvertible, CustomDebugStringConvertible
            {
    case successObject(T)
    case successList([T])
    case failure(Error)
    
    init(value: T) {
        self = .successObject(value)
    }
    
    init(list: [T]) {
        self = .successList(list)
    }
    
    init(error: Error) {
        self = .failure(error)
    }
    
    public var isSuccess: Bool {
        switch self {
        case .successObject:
            return true
        case .successList:
            return true
        case .failure:
            return false
        }
    }
    
    public var object: T? {
        switch self {
        case .successObject(let v):
            return v
        case .successList:
            return nil
        case .failure:
            return nil
        }
    }
    
    public var list: [T]? {
        switch self {
        case .successObject:
            return nil
        case .successList(let l):
            return l
        case .failure:
            return nil
        }
    }
    
    public var error: Error? {
        switch self {
        case .successObject:
            return nil
        case .successList:
            return nil
        case .failure(let e):
            return e 
        }
    }
    
}

//extension YYResponseResult {
//    public var description: String {
//        return ""
//    }
//    
//    public var debugDescription: String {
//        return ""
//    }
//}
