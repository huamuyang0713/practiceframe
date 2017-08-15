//
//  ViewUtils.swift
//  BaseFrame
//
//  Created by kin on 2017/7/20.
//  Copyright © 2017年 kin. All rights reserved.
//

import Foundation
import UIKit

struct ScreenSize {
    static let width = UIScreen.main.bounds.width
    static let height = UIScreen.main.bounds.height
}

extension UIView {
    public var X: CGFloat {
        get {
            return self.frame.origin.x
        }
        set {
            var rect = self.frame
            rect.origin.x = X
            self.frame = rect
        }
    }
    
    public var Y: CGFloat {
        get {
            return self.frame.origin.y
        }
        set {
            var rect = self.frame
            rect.origin.x = Y
            self.frame = rect
        }
    }
    
    public var width: CGFloat {
        get {
            return self.bounds.width
        }
        
        set {
            var rect = self.frame
            rect.size.width = width
            self.frame = rect
        }
    }
    
    public var height: CGFloat {
        get {
            return self.bounds.height
        }
        
        set {
            var rect = self.frame
            rect.size.height = height
            self.frame = rect
        }
    }
    
    
    
}
