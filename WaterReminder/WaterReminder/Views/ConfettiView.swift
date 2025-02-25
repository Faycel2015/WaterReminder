//
//  ConfettiView.swift
//  WaterReminder
//
//  Created by FayTek on 2/25/25.
//

import SwiftUI

struct ConfettiView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        let confettiLayer = CAEmitterLayer()
        confettiLayer.emitterPosition = CGPoint(x: UIScreen.main.bounds.width / 2, y: -10)
        confettiLayer.emitterShape = .line
        confettiLayer.emitterSize = CGSize(width: UIScreen.main.bounds.width, height: 1)
        
        let confettiCell = CAEmitterCell()
        confettiCell.contents = UIImage(named: "confetti")?.cgImage
        confettiCell.birthRate = 20
        confettiCell.lifetime = 3.5
        confettiCell.velocity = 150
        confettiCell.velocityRange = 50
        confettiCell.emissionLongitude = .pi
        confettiCell.scale = 0.2
        confettiCell.scaleRange = 0.1
        confettiLayer.emitterCells = [confettiCell]
        
        view.layer.addSublayer(confettiLayer)
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}
