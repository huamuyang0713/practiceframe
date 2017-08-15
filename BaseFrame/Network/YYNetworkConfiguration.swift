//
//  YYNetworkConfiguration.swift
//  BaseFrame
//
//  Created by kin on 2017/7/24.
//  Copyright © 2017年 kin. All rights reserved.
//

import Foundation

public final class YYNetworkConfiguration {
    let baseURL = URL(string: "https://api.qnmami.com")!
    let domain = "kin.hq"
    
    public static var shared = YYNetworkConfiguration()
    
    public init() {
    
    }
}
