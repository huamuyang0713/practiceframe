//
//  YYMapper.swift
//  BaseFrame
//
//  Created by kin on 2017/7/25.
//  Copyright © 2017年 kin. All rights reserved.
//

import Foundation

protocol YYResponseMapperProtocol {
    associatedtype Item
    static func process(_ obj: AnyObject?) throws -> Item
}

internal enum YYResponseMapperError: Error {
    case invalid
    case missingAttribute
    case parseFailed
    case noMore
}

class YYMapper {
//    func process(_ obj: AnyObject?, mapper: ((Any?) throws -> T) throws -> Any) { assertionFailure("need override method") }
    // mapper函数可根据约定数据结构进行抽象扩展，也可在对应请求中继承子类（麻烦）
}
