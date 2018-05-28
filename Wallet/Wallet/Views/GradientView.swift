

//
//  GradientView.swift
//  Wallet
//
//  Created by Maynard on 2018/5/7.
//  Copyright © 2018年 New Horizon Labs. All rights reserved.
//

import UIKit

class GradientView: UIView {

    @IBInspectable var firstColor: UIColor = UIColor.white {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable var secondColor: UIColor = UIColor.black {
        didSet {
            setNeedsDisplay()
        }
    }
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        let context = UIGraphicsGetCurrentContext()!
        
        let gradient = CGGradient(colorsSpace: nil, colors: [firstColor.cgColor, secondColor.cgColor] as CFArray, locations: [0, 1])!
        let rectanglePath = UIBezierPath(roundedRect: rect, cornerRadius: self.layer.cornerRadius)
        context.saveGState()
        rectanglePath.addClip()
        context.drawLinearGradient(gradient, start: CGPoint(x: rect.minX, y: rect.midY), end: CGPoint(x: rect.maxX, y: rect.midY), options: [])
        context.restoreGState()
    }

}
