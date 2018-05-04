//
//  MainMenu.swift
//  Colors
//
//  Created by I on 15.03.2018.
//  Copyright © 2018 Shyngys. All rights reserved.
//

import UIKit
import SpriteKit

class MainMenu: SKScene {
    
    lazy var imageScoreLabel:SKSpriteNode = {
        let size = CGSize(width: Size.height/20, height: Size.height/20)
        let position = CGPoint.init(x: Size.width/1.25, y: Size.height/1.08)
        let node = SKSpriteNode.init().getNode(position, size, imageName: "gold-medal (1)")
        return node
    }()
    
    lazy var scoreLabel:SKLabelNode = {
        let position = CGPoint.init(x: Size.width/1.15 + imageScoreLabel.size.width/2, y: Size.height/1.09)
        let fontSize = CGFloat.init(Size.width/10)
        let label = SKLabelNode.init().getLabel(position , fontSize, text: "230")
        return label
    }()
    
    lazy var gameName:SKLabelNode = {
        let position = CGPoint.init(x: Size.width/2 , y: Size.height/1.5)
        let fontSize = CGFloat.init(Size.width/5)
        let label = SKLabelNode.init().getLabel(position , fontSize , text: "Colors")
        return label
    }()
    
//    lazy var newGameLabel:SKShapeNode = {
//
//        let button = CustomButton.init(text: "Shyngys")
//        button.position = CGPoint.init(x: 200, y: 200)
////        let position = CGPoint.init(x: Size.width/2 , y: Size.height/2)
////        let fontSize = CGFloat.init(Size.width/10)
////        let label = SKLabelNode.init().getLabel(position , fontSize , text: "New Game")
////        label.color = Colors.colorsForBlock[1]
////        return label
//        return button
//    }()
    
    lazy var newGameLabel:CustomButton = {
        let bounds = CGRect.init(x: Size.width/2 - 100 , y: Size.height/2 , width: 200, height: 35)
        let path =  CGPath.init(roundedRect: bounds, cornerWidth: 12, cornerHeight: 12, transform: nil)
        let b = CustomButton.init(text: "New Game", path: path)
        b.fillColor = Colors.backgroundColor
        b.strokeColor = UIColor.white
        b.lineWidth = 2
        return b
    }()
    
    lazy var settingsLabel:SKLabelNode = {
        let position = CGPoint.init(x: Size.width/2 , y: Size.height/2.5)
        let fontSize = CGFloat.init(Size.width/10)
        let label = SKLabelNode.init().getLabel(position, fontSize, text: "Options")
        return label
    }()
    
    lazy var button:SKSpriteNode = {
        let position = CGPoint.init(x: Size.width/2, y: Size.height/2)
        let size = CGSize.init(width: 60, height: 60)
        let node = SKSpriteNode.init().getNode(position, size, imageName: "play")
        return node
    }()

    override func didMove(to view: SKView) {
        addChildren()
        setupView()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        if newGameLabel.contains(touch.location(in: self)){
            let startGame = GamePlay.init(size: Size.bounds.size)
            startGame.scaleMode = .aspectFill
            newGameLabel.alpha = 0.5
            self.view?.presentScene(startGame, transition: .doorsOpenHorizontal(withDuration: 2))
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
    }
    
    func setupView() -> Void {
        backgroundColor = Colors.backgroundColor
    }
    
    func addChildren() -> Void {
        //addChild(button)
        addChild(imageScoreLabel)
        addChild(scoreLabel)
        addChild(gameName)
        addChild(newGameLabel)
        addChild(settingsLabel)
//        addChild(SKShapeNode().getButton())
        //addChild(bottom)
    }
}
