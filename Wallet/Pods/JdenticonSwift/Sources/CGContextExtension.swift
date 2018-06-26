// Copyright © 2018 Alejandro Isaza.
//
// This file is part of JdenticonSwift. The full Trust copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.

import CoreGraphics

extension CGContext {
    func addPolygon(_ points: [CGPoint], invert: Bool = false) {
        if invert {
            _addPolygon(points.reversed())
        } else {
            _addPolygon(points)
        }
    }

    private func _addPolygon(_ points: [CGPoint]) {
        guard let first = points.first else {
            return
        }
        move(to: first)
        for point in points.dropFirst() {
            addLine(to: point)
        }
        closePath()
    }

    func addCircle(origin: CGPoint, radius: CGFloat, clockwise: Bool) {
        addArc(center: CGPoint(x: origin.x + radius, y: origin.y + radius), radius: radius, startAngle: 0, endAngle: 2 * .pi, clockwise: clockwise)
    }

    func addRectangle(_ rect: CGRect, invert: Bool = false) {
        addPolygon([
            CGPoint(x: rect.minX, y: rect.minY),
            CGPoint(x: rect.maxX, y: rect.minY),
            CGPoint(x: rect.maxX, y: rect.maxY),
            CGPoint(x: rect.minX, y: rect.maxY),
        ], invert: invert)
    }

    func addTriangle(in rect: CGRect, corner: Int) {
        switch corner % 4 {
        case 0:
            addPolygon([
                CGPoint(x: rect.maxX, y: rect.maxY),
                CGPoint(x: rect.minX, y: rect.maxY),
                CGPoint(x: rect.minX, y: rect.minY),
            ])
        case 1:
            addPolygon([
                CGPoint(x: rect.maxX, y: rect.minY),
                CGPoint(x: rect.minX, y: rect.minY),
                CGPoint(x: rect.minX, y: rect.maxY),
            ])
        case 2:
            addPolygon([
                CGPoint(x: rect.minX, y: rect.minY),
                CGPoint(x: rect.maxX, y: rect.minY),
                CGPoint(x: rect.maxX, y: rect.maxY),
            ])
        case 3:
            addPolygon([
                CGPoint(x: rect.maxX, y: rect.minY),
                CGPoint(x: rect.maxX, y: rect.maxY),
                CGPoint(x: rect.minX, y: rect.maxY ),
            ])
        default:
            break
        }
    }

    func addRhombus(in rect: CGRect, invert: Bool = false) {
        addPolygon([
            CGPoint(x: rect.midX, y: rect.minY),
            CGPoint(x: rect.maxX, y: rect.midY),
            CGPoint(x: rect.midX, y: rect.maxY),
            CGPoint(x: rect.minX, y: rect.midY),
        ], invert: invert)
    }
}
