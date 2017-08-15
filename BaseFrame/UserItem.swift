//
//  UserItem.swift
//  BaseFrame
//
//  Created by kin on 2017/7/26.
//  Copyright © 2017年 kin. All rights reserved.
//

import Foundation
import ObjectMapper

public class UserItem: YYBaseItem {
    var name: String?
    var user_id: Int?
    
   
    public required init?(map: Map) {
        super.init(map: map)
    }
    
    public override func mapping(map: Map) {
        super.mapping(map: map)
        name <- map["name"]
        user_id <- map["user_id"]
    }
    
}


public class GoodsInfo: YYBaseItem {
    var id : String?
    var brand : String?
    var cover : String!
    var discount : Float?
    var list_price : String?
    var price : String?
    var site : String?
    
    public required init?(map: Map) {
        super.init(map: map)
    }
    
    public override func mapping(map: Map) {
        super.mapping(map: map)
        id <- map["id"]
        brand <- map["brand"]
        cover <- map["cover"]
        discount <- map["discount"]
        list_price <- (map["list_price"], TransformOf<String, Int>(fromJSON: { String($0!) }, toJSON: { $0.map { Int($0)! } }))
        price <- (map["price"], TransformOf<String, Int>(fromJSON: { String($0!) }, toJSON: { $0.map { Int($0)! } }))
        site <- map["site"]
    }
}
