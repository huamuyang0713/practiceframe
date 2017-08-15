//
//  YYBaseView.swift
//  BaseFrame
//
//  Created by kin on 2017/8/14.
//  Copyright © 2017年 kin. All rights reserved.
//

import Foundation
import UIKit

class YYBaseView: UIView {
    var vm: YYBaseViewModel?
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func bindViewModel(viewModel: YYBaseViewModel) {
        vm = viewModel
    }
    
    
}
