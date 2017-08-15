//
//  YYResponseArrayMapper.swift
//  BaseFrame
//
//  Created by kin on 2017/7/25.
//  Copyright © 2017年 kin. All rights reserved.
//

import Foundation
import ObjectMapper

final class YYResponseArrayMapper<T: Mappable>: YYMapper {
    static func process(_ obj: AnyObject?) -> YYResponseResult<T> {
        guard let json = obj as? [String : AnyObject] else {
            return .failure(NSError.mapCodeError(code: .typeDoesnotMatch))
        }
        
        let result = Mapper<YYListItem<T>>().map(JSON: json)
        if result?.code == 0, let list = result?.list {
            return .successList(list)
        } else {
            return .failure(NSError.mapCodeError(code: .parseFailed))
        }
    }
    
}
