//
//  UserInfoOperation.swift
//  BaseFrame
//
//  Created by kin on 2017/7/26.
//  Copyright © 2017年 kin. All rights reserved.
//

import Foundation

public class UserInfoOperation: YYNetworkServiceOperation<UserItem> {
    
//    public override init() {
//        super.init()
//        request = YYNetworkBackendAPIRequest().parameters(param: ["user_id" : "1"]).endpoint(endP: "/user/sns-info")
//        setCompleteCallBack { (result) in
//            if result.isSuccess {
//                let user = result.object
//                print(user?.name ?? "empty value")
//            } else {
//            
//            }
//        }
//    }

    public override func startObjectRequest() {
        request = YYNetworkBackendAPIRequest().parameters(param: ["user_id" : "1"]).endpoint(endP: "/user/sns-info")
        setCompleteCallBack { (result) in
            if result.isSuccess {
                let user = result.object
                print(user?.name ?? "empty value")
            } else {
                
            }
        }
        
        super.startObjectRequest()
    }
    
    
    
}


public class GoodsListoperation: YYNetworkServiceOperation<GoodsInfo> {
    override init() {
        super.init()
    }
    
    public override func startListRequest() {
        request = YYNetworkBackendAPIRequest().parameters(param: [:]).endpoint(endP: "/shop/goods/site-goods").defaultParam()
//        setCompleteCallBack { (result) in
//            if result.isSuccess {
//                if let list = result.list {
//                    if let goods = list.first {
//                        print(goods.cover)
//                    }
//                }
//                
//            }
//        }
        super.startListRequest()
    }
}
