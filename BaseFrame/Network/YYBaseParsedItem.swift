//
//  YYBaseParsedItem.swift
//  BaseFrame
//
//  Created by kin on 2017/7/25.
//  Copyright © 2017年 kin. All rights reserved.
//

import Foundation
import ObjectMapper

public protocol YYBaseParsedItem {
    var code: Int! { get }
    var message: String? { get }
}

public class YYBaseItem: YYBaseParsedItem, Mappable {
    public var message: String?
    public var code: Int!

    public required init?(map: Map) {
        
    }
    
    public func mapping(map: Map) {
        message <- map["message"]
        code    <- map["code"]
    }
    
}

public class YYObjectItem<T: Mappable>: YYBaseItem {
    var object: T?
    
    public required init?(map: Map) {
        super.init(map: map)
    }
    
    public override func mapping(map: Map) {
        super.mapping(map: map)
        object <- map["data"]
    }
}

public class YYListItem<T: Mappable>: YYBaseItem {
    var list: [T]?
    
    public required init?(map: Map) {
        super.init(map: map)
    }
    
    public override func mapping(map: Map) {
        super.mapping(map: map)
        list <- map["data.list"]
    }
}
