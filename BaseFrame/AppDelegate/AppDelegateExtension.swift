//
//  AppDelegateExtension.swift
//  BaseFrame
//
//  Created by kin on 2017/7/20.
//  Copyright © 2017年 kin. All rights reserved.
//

import Foundation

extension AppDelegate {
    
    func registerApplePush() {}
    
    func registerURLProtocl() {
        URLProtocol.registerClass(YYURLProtocol.self)
    }
    
}
