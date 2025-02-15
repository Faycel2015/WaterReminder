//
//  Animations.swift
//  WaterReminder
//
//  Created by FayTek on 2/15/25.
//

import SwiftUICore

struct LiquidAnimation: GeometryEffect {
    var amount: CGFloat = 0

    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(CGAffineTransform(translationX: 0, y: size.height * amount))
    }
}
