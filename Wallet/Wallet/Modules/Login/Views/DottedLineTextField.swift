//
//  DottedLineTextField.swift
//  Wallet
//
//  Created by Maynard on 2018/5/11.
//  Copyright © 2018年 New Horizon Labs. All rights reserved.
//

import UIKit

extension UITextField {
    func setLeftOffset(_ offset: CGFloat) {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: offset, height: 0))
        self.leftView = view
        self.leftViewMode = .always
    }
}

class DottedLineTextField: UITextField {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        let context = UIGraphicsGetCurrentContext()!
        let path = UIBezierPath(rect: rect)
        UIColor.colorWithHex(hex: "#B0B8CA").setStroke()
        path.lineWidth = 1
        context.saveGState()
        context.setLineDash(phase: 0, lengths: [4, 2])
        path.stroke()
        context.restoreGState()
        
    }
 
    override func awakeFromNib() {
        super.awakeFromNib()
        setLeftOffset(9)
    }
}

