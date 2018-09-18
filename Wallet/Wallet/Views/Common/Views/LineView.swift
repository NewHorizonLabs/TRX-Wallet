//
//  LineView.swift
//  New Horizon Labs
//
//  Created by  on 2018/3/31.
//  Copyright © 2018年 RayboWallet. All rights reserved.
//

import UIKit

class LineView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.lineColor
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.lineColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
}
