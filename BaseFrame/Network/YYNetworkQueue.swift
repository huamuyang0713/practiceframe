//
//  YYNetworkQueue.swift
//  BaseFrame
//
//  Created by kin on 2017/7/25.
//  Copyright © 2017年 kin. All rights reserved.
//

import Foundation

public class YYNetworkQueue {
    public static var shared: YYNetworkQueue = YYNetworkQueue()
    
    let queue = OperationQueue()
    
    public init() { }
    
    public func addOperation(_ op: Operation) {
        queue.addOperation(op)
    }
}
