//
//  WaterScene.swift
//  WaterReminder
//
//  Created by FayTek on 2/25/25.
//

import SwiftUI
import AVFoundation
import SpriteKit

class WaterScene: SKScene {
    private var waterNode: SKShapeNode!
    private var frostEffect: SKEmitterNode?
    private var steamEffect: SKEmitterNode?
    private var condensationEffect: SKEmitterNode?
    private var dripEffect: SKEmitterNode?
    private var fogEffect: SKEmitterNode?
    private var iceCubes: [SKSpriteNode] = []
    private var wipeSoundPlayer: AVAudioPlayer?
    
    var waterTemperature: String = "Cold" // "Cold", "Hot", or "Normal"
    
    override func didMove(to view: SKView) {
        backgroundColor = .clear
        setupWater()
        addBubbles()
        addIceCubes()
        applyTemperatureEffect()
        prepareWipeSound()
    }
    
    private func setupWater() {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 50))
        path.addCurve(to: CGPoint(x: size.width, y: 50), controlPoint1: CGPoint(x: size.width * 0.3, y: 60), controlPoint2: CGPoint(x: size.width * 0.7, y: 40))
        
        waterNode = SKShapeNode(path: path.cgPath)
        waterNode.strokeColor = .blue
        waterNode.fillColor = .blue
        waterNode.lineWidth = 3
        addChild(waterNode)
        animateWater()
    }
    
    private func animateWater() {
        let waveUp = SKAction.moveBy(x: 0, y: 5, duration: 0.8)
        let waveDown = SKAction.moveBy(x: 0, y: -5, duration: 0.8)
        let waveSequence = SKAction.sequence([waveUp, waveDown])
        waterNode.run(SKAction.repeatForever(waveSequence))
    }
    
    private func prepareWipeSound() {
        if let soundURL = Bundle.main.url(forResource: "wipe_sound", withExtension: "mp3") {
            do {
                wipeSoundPlayer = try AVAudioPlayer(contentsOf: soundURL)
                wipeSoundPlayer?.prepareToPlay()
            } catch {
                print("Error loading wipe sound: \(error.localizedDescription)")
            }
        }
    }
    
    private func playWipeSound() {
        wipeSoundPlayer?.play()
    }
    
    private func addBubbles() {
        let bubbleTexture = SKTexture(imageNamed: "bubble")
        let bubbleEmitter = SKEmitterNode()
        bubbleEmitter.particleTexture = bubbleTexture
        bubbleEmitter.particleBirthRate = 5
        bubbleEmitter.particleLifetime = 4
        bubbleEmitter.particleSpeed = 10
        bubbleEmitter.particleAlpha = 0.8
        bubbleEmitter.position = CGPoint(x: size.width / 2, y: 10)
        addChild(bubbleEmitter)
    }
    
    private func addIceCubes() {
        iceCubes.removeAll()
        for _ in 1...3 {
            let iceCube = SKSpriteNode(imageNamed: "ice_cube")
            iceCube.size = CGSize(width: 20, height: 20)
            iceCube.position = CGPoint(x: CGFloat.random(in: 10...size.width - 10), y: CGFloat.random(in: 20...80))
            iceCube.physicsBody = SKPhysicsBody(rectangleOf: iceCube.size)
            iceCube.physicsBody?.affectedByGravity = false
            iceCube.physicsBody?.linearDamping = 0.8
            addChild(iceCube)
            iceCubes.append(iceCube)
        }
        adjustIceMelting()
    }
    
    private func adjustIceMelting() {
        for iceCube in iceCubes {
            iceCube.removeAllActions()
            if waterTemperature == "Hot" {
                let melt = SKAction.scale(to: 0, duration: 5)
                let fadeOut = SKAction.fadeOut(withDuration: 5)
                let remove = SKAction.removeFromParent()
                let sequence = SKAction.sequence([melt, fadeOut, remove])
                iceCube.run(sequence)
            } else if waterTemperature == "Normal" {
                let melt = SKAction.scale(to: 0, duration: 15)
                let fadeOut = SKAction.fadeOut(withDuration: 15)
                let remove = SKAction.removeFromParent()
                let sequence = SKAction.sequence([melt, fadeOut, remove])
                iceCube.run(sequence)
            }
        }
    }
    
    private func applyTemperatureEffect() {
        frostEffect?.removeFromParent()
        steamEffect?.removeFromParent()
        condensationEffect?.removeFromParent()
        dripEffect?.removeFromParent()
        fogEffect?.removeFromParent()
        adjustIceMelting()
        
        if waterTemperature == "Cold" {
            frostEffect = SKEmitterNode(fileNamed: "FrostEffect.sks")
            frostEffect?.position = CGPoint(x: size.width / 2, y: size.height - 20)
            addChild(frostEffect!)
            
            condensationEffect = SKEmitterNode(fileNamed: "CondensationEffect.sks")
            condensationEffect?.position = CGPoint(x: size.width / 2, y: size.height - 10)
            addChild(condensationEffect!)
            
            dripEffect = SKEmitterNode(fileNamed: "DripEffect.sks")
            dripEffect?.position = CGPoint(x: size.width / 2, y: size.height - 30)
            addChild(dripEffect!)
        } else if waterTemperature == "Hot" {
            steamEffect = SKEmitterNode(fileNamed: "SteamEffect.sks")
            steamEffect?.position = CGPoint(x: size.width / 2, y: size.height - 20)
            addChild(steamEffect!)
        }
        
        if waterTemperature == "Hot" && condensationEffect != nil {
            fogEffect = SKEmitterNode(fileNamed: "FogEffect.sks")
            fogEffect?.position = CGPoint(x: size.width / 2, y: size.height - 15)
            addChild(fogEffect!)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            fogEffect?.particleAlpha = 0.5
            fogEffect?.particleLifetime = 0.5
            fogEffect?.position = location
            fogEffect?.run(SKAction.fadeOut(withDuration: 0.3))
            playWipeSound()
        }
    }
}
