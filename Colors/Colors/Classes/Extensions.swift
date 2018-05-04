//
//  Extension.swift
//  Colors
//
//  Created by I on 15.03.2018.
//  Copyright © 2018 Shyngys. All rights reserved.
//

import Foundation
import SpriteKit

extension SKShapeNode{
    func getBlock(bounds:CGRect,color:UIColor) -> SKShapeNode {
        let border = SKPhysicsBody.init(edgeLoopFrom: bounds)
        border.restitution = 0.5
        border.friction = 0
        let rect = SKShapeNode.init(rect: bounds, cornerRadius: 8)
        rect.strokeColor = color
        rect.fillColor = color
        rect.physicsBody = border
        rect.physicsBody?.categoryBitMask = UInt32(ColliderType.block)
        rect.physicsBody?.collisionBitMask = UInt32(ColliderType.ball)
        rect.physicsBody?.contactTestBitMask = UInt32(ColliderType.ball)
        return rect
    }
    func getBall(radius:CGFloat,position:CGPoint,color:UIColor) ->  SKShapeNode{
        let circle = SKShapeNode.init(circleOfRadius: radius)
        circle.fillColor = color
        circle.strokeColor = color
        circle.position = position
        circle.physicsBody = SKPhysicsBody.init(circleOfRadius: 20)
        circle.physicsBody?.isDynamic = true
        circle.physicsBody?.categoryBitMask = UInt32(ColliderType.ball)
        circle.physicsBody?.collisionBitMask = UInt32(ColliderType.block)
        circle.physicsBody?.contactTestBitMask = UInt32(ColliderType.ball)
        return circle
    }
}
extension Array {
    mutating func shuffle() {
        for _ in 0..<((count>0) ? (count-1) : 0) {
            sort { (_,_) in arc4random() < arc4random() }
        }
    }
}
extension SKLabelNode{
    func getLabel(_ position:CGPoint,_ fontSize:CGFloat,text:String) -> SKLabelNode {
        self.position = position
        self.fontSize = fontSize
        self.text = text
        self.fontName = "Gasalt-Thin"
        self.fontColor = Colors.labelColor
        self.color = UIColor.red
        return self
    }
}
extension SKSpriteNode{
    func getNode(_ position:CGPoint,_ size:CGSize,imageName:String) -> SKSpriteNode {
        if imageName != "" {
            self.texture = SKTexture.init(imageNamed: imageName)
        }
        self.position = position
        self.size = size
        return self
    }
}
