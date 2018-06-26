// Copyright © 2018 Alejandro Isaza.
//
// This file is part of JdenticonSwift. The full Trust copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.

import UIKit

extension UIColor {
    convenience init(hue: CGFloat, saturation: CGFloat, lightness: CGFloat) {
        let m2 = lightness <= 0.5 ? lightness * (saturation + 1) : lightness + saturation - lightness * saturation
        let m1 = lightness * 2 - m2
        self.init(
            red: UIColor.hueToRgb(m1, m2, hue * 6 + 2),
            green: UIColor.hueToRgb(m1, m2, hue * 6),
            blue: UIColor.hueToRgb(m1, m2, hue * 6 - 2),
            alpha: 1
        )
    }

    convenience init(correctedHue hue: CGFloat, saturation: CGFloat, lightness: CGFloat) {
        // The corrector specifies the perceived middle lightnesses for each hue
        let correctors = [0.55, 0.5, 0.5, 0.46, 0.6, 0.55, 0.55] as [CGFloat]
        let corrector = correctors[Int(hue * 6 + 0.5)]

        // Adjust the input lightness relative to the corrector
        let l: CGFloat
        if lightness < 0.5 {
            l = lightness * corrector * 2
        } else {
            l = corrector + (lightness - 0.5) * (1 - corrector) * 2
        }

        self.init(hue: hue, saturation: saturation, lightness: l)
    }

    private static func hueToRgb(_ m1: CGFloat, _ m2: CGFloat, _ h: CGFloat) -> CGFloat {
        let newH: CGFloat
        if h < 0 {
            newH = h + 6
        } else if h > 6 {
            newH = h - 6
        } else {
            newH = h
        }
        return
            newH < 1 ? m1 + (m2 - m1) * newH :
            newH < 3 ? m2 :
            newH < 4 ? m1 + (m2 - m1) * (4 - newH) :
            m1
    }
}
