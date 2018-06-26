// Copyright © 2018 Alejandro Isaza.
//
// This file is part of JdenticonSwift. The full Trust copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.

import UIKit

public final class ColorTheme {
    public let hue: CGFloat
    public let saturation: CGFloat
    public let colors: [UIColor]

    public init(hue: CGFloat, saturation: CGFloat = 0.5) {
        self.hue = hue
        self.saturation = saturation
        colors = [
            // Dark gray
            UIColor(hue: 0, saturation: 0, lightness: grayscaleLightness(0)),
            // Mid color
            UIColor(correctedHue: hue, saturation: saturation, lightness: colorLightness(0.5)),
            // Light gray
            UIColor(hue: 0, saturation: 0, lightness: grayscaleLightness(1)),
            // Light color
            UIColor(correctedHue: hue, saturation: saturation, lightness: colorLightness(1)),
            // Dark color
            UIColor(correctedHue: hue, saturation: saturation, lightness: colorLightness(0)),
        ]
    }

    /// Given a suggested index return another index that combines well with the other selected indices.
    public func validateIndex(_ index: Int, selected: [Int]) -> Int {
        if isDuplicate(index: index, values: [0, 4], selected: selected) || isDuplicate(index: index, values: [2, 3], selected: selected) {
            return 1
        } else {
            return index
        }
    }

    func isDuplicate(index: Int, values: [Int], selected: [Int]) -> Bool {
        if !values.contains(index) {
            return false
        }
        for value in values {
            if selected.contains(value) {
                return true
            }
        }
        return false
    }
}

func colorLightness(_ value: CGFloat) -> CGFloat {
    return lightness(value, min: 0.4, max: 0.8)
}

func grayscaleLightness(_ value: CGFloat) -> CGFloat {
    return lightness(value, min: 0.3, max: 0.9)
}

func lightness(_ value: CGFloat, min: CGFloat, max: CGFloat) -> CGFloat {
    let lightness = min + value * (max - min)
    return Swift.min(1, Swift.max(0, lightness))
}
