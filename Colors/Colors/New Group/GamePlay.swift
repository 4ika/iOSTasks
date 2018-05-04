//
//  GamePlay.swift
//  Colors
//
//  Created by I on 15.03.2018.
//  Copyright © 2018 Shyngys. All rights reserved.
//

import UIKit
import SpriteKit
import CoreMotion
import AudioToolbox

class GamePlay: SKScene , SKPhysicsContactDelegate{
    
    let manager = CMMotionManager.init()
    
    var array:[Int] = [0,1,2,3]
    
    lazy var bottom:SKShapeNode = {
        
        let x = 2*Size.height/40
        let y = 10
        let width = Size.width-4*Size.height/40
        let height  = Size.height/40
        
        let rect:CGRect = CGRect.init(x: x, y: CGFloat(y), width: width, height: height)
        return SKShapeNode().getBlock(bounds:rect, color: Colors.colorsForBlock[array[3]])
    }()
    
    lazy var left:SKShapeNode = {
        
        let x = 10
        let y = 2*Size.height/40
        let width = Size.height/40
        let height  = Size.height - 4*Size.height/40
        
        let rect:CGRect = CGRect.init(x: CGFloat(x), y: y, width: width, height: height)
        return SKShapeNode().getBlock(bounds:rect, color: Colors.colorsForBlock[array[0]])
    }()
    
    lazy var right:SKShapeNode = {
        
        let x = Size.width - 10-Size.height/40
        let y = 2*Size.height/40
        let width = Size.height/40
        let height  = Size.height - 4*Size.height/40
        
        let rect:CGRect = CGRect.init(x: x, y: y, width: width, height: height)
        return SKShapeNode().getBlock(bounds:rect, color: Colors.colorsForBlock[array[1]])
    }()
    
    lazy var top:SKShapeNode = {
        
        let x = 2*Size.height/40
        let y =  Size.height - Size.height/40 - 10
        let width = Size.width-4*Size.height/40
        let height  = Size.height/40
        
        let rect:CGRect = CGRect.init(x: x , y: y, width: width , height: height)
        return SKShapeNode().getBlock(bounds:rect, color: Colors.colorsForBlock[array[2]])
    }()
    
    lazy var ball:SKShapeNode = {
        let position = CGPoint.init(x: Size.width/2, y: Size.height/2)
        let node = SKShapeNode().getBall(radius: 20, position: position, color: Colors.colorsForBlock[array[2]])
        return node
    }()
    
    lazy var tapLabel:SKLabelNode = {
        let position = CGPoint.init(x: Size.width/2 , y: Size.height/2)
        let fontSize = CGFloat.init(Size.width/20)
        let label = SKLabelNode().getLabel(position, fontSize, text: "Tap tap here")
        return label
    }()
    
    override func didMove(to view: SKView) {
        
        addChildren()
        
        motionManager()
        
        setupView()

    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        generateColor()
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!.location(in: self)
        if ((self.view?.bounds.contains(touch))!){
                 addChild(ball)
        }
    }
    
    override func update(_ currentTime: TimeInterval) {

    }
    
    func setupView() -> Void {
        backgroundColor = Colors.backgroundColor
        self.physicsWorld.contactDelegate = self
        
//        let animateLabel = SKAction.sequence([SKAction.fadeIn(withDuration: 0.5),SKAction.wait(forDuration: 0.5),SKAction.fadeOut(withDuration: 0.5)])
//
//        tapLabel.run(SKAction.repeatForever(animateLabel))
    }
    
    func motionManager() -> Void {
        
        manager.startAccelerometerUpdates()
        manager.accelerometerUpdateInterval = 0.01
        manager.startAccelerometerUpdates(to: OperationQueue.main) { (data,error ) in
            self.physicsWorld.gravity = CGVector.init(dx: (data?.acceleration.x)!*2, dy: (data?.acceleration.y)!*2)
            print(data!)
        }
        
    }
    
    func addChildren() -> Void {
       //addChild(tapLabel)
        addChild(bottom)
        addChild(left)
        addChild(right)
        addChild(top)
    }
    
    func generateColor() -> Void {
        array.shuffle()
        setColorForShapeNode(shape: top, index: 0)
        setColorForShapeNode(shape: bottom, index: 1)
        setColorForShapeNode(shape: left, index: 2)
        setColorForShapeNode(shape: right, index: 3)
        setColorForShapeNode(shape: ball, index: Int(arc4random_uniform(4)))
    }
    
    func setColorForShapeNode(shape:SKShapeNode, index:Int) -> Void {
        shape.fillColor = Colors.colorsForBlock[array[index]]
        shape.strokeColor = Colors.colorsForBlock[array[index]]
    }
   
}
