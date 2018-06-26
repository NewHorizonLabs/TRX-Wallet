// Copyright © 2018 Alejandro Isaza.
//
// This file is part of JdenticonSwift. The full Trust copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.

import Foundation

protocol Shape {
    func draw(in context: CGContext, size: CGFloat, index: Int)
}

struct CutCorner: Shape {
    func draw(in context: CGContext, size: CGFloat, index: Int) {
        let k = CGFloat(size) * 0.42
        context.addPolygon([
            CGPoint(x: 0, y: 0),
            CGPoint(x: size, y: 0),
            CGPoint(x: size, y: size - k * 2),
            CGPoint(x: size - k, y: size),
            CGPoint(x: 0, y: size),
        ])
    }
}

struct SideTriangle: Shape {
    func draw(in context: CGContext, size: CGFloat, index: Int) {
        let w = size / 2
        let h = size * 0.8
        context.addTriangle(in: CGRect(x: size - w, y: 0, width: w, height: h), corner: 2)
    }
}

struct MiddleSquare: Shape {
    func draw(in context: CGContext, size: CGFloat, index: Int) {
        let s = size / 3
        context.addRect(CGRect(x: s, y: s, width: size - s, height: size - s))
    }
}

struct CornerSquare: Shape {
    func draw(in context: CGContext, size: CGFloat, index: Int) {
        let inner = size * 0.1
        let outer = max(1, size * 0.25)
        context.addRect(CGRect(x: outer, y: outer, width: size - inner - outer, height: size - inner - outer))
    }
}

struct OffCenterCircle: Shape {
    func draw(in context: CGContext, size: CGFloat, index: Int) {
        let m = size * 0.15
        let s = size * 0.5
        context.addCircle(origin: CGPoint(x: size - s - m, y: size - s - m), radius: s / 2, clockwise: true)
    }
}

struct NegativeTriangle: Shape {
    func draw(in context: CGContext, size: CGFloat, index: Int) {
        let inner = size * 0.1
        let outer = inner * 4

        context.addRect(CGRect(x: 0, y: 0, width: size, height: size))
        context.addPolygon([
            CGPoint(x: outer, y: outer),
            CGPoint(x: size - inner, y: outer),
            CGPoint(x: outer + (size - outer - inner) / 2, y: size - inner),
        ].reversed())
    }
}

struct CutSquare: Shape {
    func draw(in context: CGContext, size: CGFloat, index: Int) {
        context.addPolygon([
            CGPoint(x: 0, y: 0),
            CGPoint(x: size, y: 0),
            CGPoint(x: size, y: size * 0.7),
            CGPoint(x: size * 0.4, y: size * 0.4),
            CGPoint(x: size * 0.7, y: size),
            CGPoint(x: 0, y: size),
        ])
    }
}

struct CornerPlusTriangle: Shape {
    func draw(in context: CGContext, size: CGFloat, index: Int) {
        context.addRect(CGRect(x: 0, y: 0, width: size, height: size / 2))
        context.addRect(CGRect(x: 0, y: size/2, width: size / 2, height: size / 2))
        context.addTriangle(in: CGRect(x: size/2, y: size/2, width: size / 2, height: size / 2), corner: 1)
    }
}

struct NegativeSquare: Shape {
    func draw(in context: CGContext, size: CGFloat, index: Int) {
        let inner = size * 0.14
        let outer = size * 0.35

        context.addRectangle(CGRect(x: 0, y: 0, width: size, height: size))
        context.addRectangle(CGRect(x: outer, y: outer, width: size - outer - inner, height: size - outer - inner), invert: true)
    }
}

struct NegativeCircle: Shape {
    func draw(in context: CGContext, size: CGFloat, index: Int) {
        let inner = size * 0.12
        let outer = inner * 3

        context.addRectangle(CGRect(x: 0, y: 0, width: size, height: size), invert: true)
        context.addCircle(origin: CGPoint(x: outer, y: outer), radius: (size - inner - outer) / 2, clockwise: false)
    }
}

struct NegativeRhombus: Shape {
    func draw(in context: CGContext, size: CGFloat, index: Int) {
        let m = size * 0.25
        context.addRectangle(CGRect(x: 0, y: 0, width: size, height: size))
        context.addRhombus(in: CGRect(x: m, y: m, width: size - m, height: size - m), invert: true)
    }
}

struct ConditionalCircle: Shape {
    func draw(in context: CGContext, size: CGFloat, index: Int) {
        let m = size * 0.4
        let s = size * 1.2
        if index == 0 {
            context.addCircle(origin: CGPoint(x: m, y: m), radius: s / 2, clockwise: true)
        }
    }
}

struct HalfTriangle: Shape {
    func draw(in context: CGContext, size: CGFloat, index: Int) {
        context.addTriangle(in: CGRect(x: size / 2, y: size / 2, width: size / 2, height: size / 2), corner: 3)
    }
}

struct Triangle: Shape {
    let corner: Int

    init(corner: Int = 0) {
        self.corner = corner
    }

    func draw(in context: CGContext, size: CGFloat, index: Int) {
        context.addTriangle(in: CGRect(x: 0, y: 0, width: size, height: size), corner: corner)
    }
}

struct BottomHalfTriangle: Shape {
    func draw(in context: CGContext, size: CGFloat, index: Int) {
        context.addTriangle(in: CGRect(x: 0, y: size / 2, width: size, height: size / 2), corner: 0)
    }
}

struct Rhombus: Shape {
    func draw(in context: CGContext, size: CGFloat, index: Int) {
        context.addRhombus(in: CGRect(x: 0, y: 0, width: size, height: size))
    }
}

struct Circle: Shape {
    func draw(in context: CGContext, size: CGFloat, index: Int) {
        let m = size / 6
        context.addCircle(origin: CGPoint(x: m, y: m), radius: size / 2 - m, clockwise: true)
    }
}

let centerShapes: [Shape] = [
    CutCorner(),
    SideTriangle(),
    MiddleSquare(),
    CornerSquare(),
    OffCenterCircle(),
    NegativeTriangle(),
    CutSquare(),
    HalfTriangle(),
    CornerPlusTriangle(),
    CutSquare(),
    NegativeCircle(),
    HalfTriangle(),
    NegativeRhombus(),
    ConditionalCircle(),
]

let outerShapes: [Shape] = [
    Triangle(),
    BottomHalfTriangle(),
    Rhombus(),
    Circle(),
]
