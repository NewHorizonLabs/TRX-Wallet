// Copyright © 2018 Alejandro Isaza.
//
// This file is part of JdenticonSwift. The full Trust copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.

import CoreGraphics

public final class IconGenerator {
    let size: CGFloat
    let context: CGContext
    let hash: Data
    let digits: [UInt8]
    var selectedColors = [UIColor]()

    var cellSize: CGFloat {
        return size / 4
    }

    public init(size: CGFloat, hash: Data) {
        self.size = size
        self.hash = hash

        var digits = [UInt8](repeating: 0, count: hash.count * 2)
        var index = 0
        for byte in hash {
            digits[index] = (byte & 0xf0) >> 4
            digits[index+1] = byte & 0x0f
            index += 2
        }
        self.digits = digits

        let colorSpace = CGColorSpaceCreateDeviceRGB()
        context = CGContext(data: nil, width: Int(size), height: Int(size), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)!
        context.translateBy(x: 0, y: size)
        context.scaleBy(x: 1, y: -1)

        selectColors()
    }

    private func selectColors() {
        let value = hash.withUnsafeBytes { (ptr: UnsafePointer<UInt32>) in
            return ptr.advanced(by: hash.count/4 - 1).pointee.byteSwapped & 0x0fffffff
        }
        let colorTheme = ColorTheme(hue: CGFloat(value) / CGFloat(0x0fffffff))

        var selectedColorIndices = [Int]()
        for i in 0 ..< 3 {
            let index = Int(digits[8 + i]) % colorTheme.colors.count
            selectedColorIndices.append(colorTheme.validateIndex(index, selected: selectedColorIndices))
        }

        selectedColors = selectedColorIndices.map({ colorTheme.colors[$0] })
    }

    public func render() -> CGImage? {
        renderShape(colorIndex: 0, shapes: outerShapes, index: 2, rotationIndex: 3, positions: [
            CGPoint(x: 1, y: 0),
            CGPoint(x: 2, y: 0),
            CGPoint(x: 2, y: 3),
            CGPoint(x: 1, y: 3),
            CGPoint(x: 0, y: 1),
            CGPoint(x: 3, y: 1),
            CGPoint(x: 3, y: 2),
            CGPoint(x: 0, y: 2),
        ])
        renderShape(colorIndex: 1, shapes: outerShapes, index: 4, rotationIndex: 5, positions: [
            CGPoint(x: 0, y: 0),
            CGPoint(x: 3, y: 0),
            CGPoint(x: 3, y: 3),
            CGPoint(x: 0, y: 3),
        ])
        renderShape(colorIndex: 2, shapes: centerShapes, index: 1, rotationIndex: nil, positions: [
            CGPoint(x: 1, y: 1),
            CGPoint(x: 2, y: 1),
            CGPoint(x: 2, y: 2),
            CGPoint(x: 1, y: 2),
        ])

        return context.makeImage()
    }

    func renderShape(colorIndex: Int, shapes: [Shape], index: Int, rotationIndex: Int?, positions: [CGPoint]) {
        var r = 0
        if let rotationIndex = rotationIndex {
            r = Int(digits[rotationIndex])
        }
        let shape = shapes[Int(digits[index]) % shapes.count]

        context.setFillColor(selectedColors[colorIndex % selectedColors.count].cgColor)

        for (index, position) in zip(positions.indices, positions) {
            context.saveGState()
            context.translateBy(x: position.x * cellSize, y: position.y * cellSize)
            context.translateBy(x: cellSize/2, y: cellSize/2)
            switch r % 4 {
            case 1:
                context.rotate(by: CGFloat.pi/2)
            case 2:
                context.rotate(by: CGFloat.pi)
            case 3:
                context.rotate(by: -CGFloat.pi/2)
            default:
                break
            }
            context.translateBy(x: -cellSize/2, y: -cellSize/2)

            shape.draw(in: context, size: cellSize, index: index)
            context.fillPath()

            context.restoreGState()
            r += 1
        }
    }
}
