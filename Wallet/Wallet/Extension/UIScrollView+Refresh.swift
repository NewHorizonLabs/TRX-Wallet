//
//  UIScrollView+Refresh.swift
//  New Horizon Labs
//
//  Created by 彭显鹤 on 2018/4/22.
//  Copyright © 2018年 Pengxianhe. All rights reserved.
//

import Foundation
import MJRefresh

extension UIScrollView {
    func addRefreshHeader(block: (() -> Void)?) {
        let header = MJRefreshNormalHeader(refreshingBlock: block)
        header?.ignoredScrollViewContentInsetTop = 20
        self.mj_header = header
        
    }
    
    func endRefresh() {
        self.mj_header.endRefreshing()
    }
}
