//
//  UIImage + Extensions.swift
//  New Horizon Labs
//
//  Created by Maynard on 2018/3/22.
//  Copyright © 2018年 Pengxianhe. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    class func imageWithColor(_ color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
}
