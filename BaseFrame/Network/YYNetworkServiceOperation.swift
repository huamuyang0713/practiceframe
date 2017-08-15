//
//  YYNetworkServiceOperation.swift
//  BaseFrame
//
//  Created by kin on 2017/7/25.
//  Copyright © 2017年 kin. All rights reserved.
//

import Foundation

public class YYNetworkServiceOperation<A: YYBaseItem>: YYNetworkOperation {
    let service: YYNetworkBackendService
    var request: YYNetworkBackendAPIRequest
    
    var completion: ((YYResponseResult<A>) -> Void)?
    
    private var responseResultType: YYResponseResultType = .object
    
    override init() {
        self.service = YYNetworkBackendService(YYNetworkConfiguration.shared)
        self.request = YYNetworkBackendAPIRequest()
        super.init()
    }
    
    
    public override func start() {
        super.start()
        service.request(request, success: handleSuccess, failure: handleFailure)
    }
    
    override public func cancel() {
        service.cancel()
        super.cancel()
    }
    
    public func startObjectRequest() {
        responseResultType = .object
        YYNetworkQueue.shared.addOperation(self)
    }
    
    public func startListRequest() {
        responseResultType = .list
        YYNetworkQueue.shared.addOperation(self)
    }
    
    
    
    
    /// response result call back
    ///
    /// - Parameter block: callback
    public func setCompleteCallBack(block: @escaping (YYResponseResult<A>) -> Void) {
        completion = block
    }
    
    
    private func handleSuccess(_ response: AnyObject?) {
        
        guard let callBack = self.completion else {
            self.finish()
            return
        }
        if responseResultType == .object {
            let resultO = YYResponseMapper<A>.process(response)
            callBack(resultO as Any as! YYResponseResult<A>)
        } else {
            let resultL = YYResponseArrayMapper<A>.process(response)
            callBack(resultL as Any as! YYResponseResult<A>) 
        }
        
        self.finish()
        
    }
    
    private func handleFailure(_ error: NSError) {
        if let callBack = completion {
            callBack(.failure(error))
        }
        self.finish()
    }
    
    
}
