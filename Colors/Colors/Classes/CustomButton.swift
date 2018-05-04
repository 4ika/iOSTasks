//
//  CustomButton.swift
//  Test
//
//  Created by I on 22.03.2018.
//  Copyright © 2018 Shyngys. All rights reserved.
//

import UIKit
import SpriteKit

class CustomButton: SKShapeNode {
    
    var label:SKLabelNode?
    
    init(text:String,path:CGPath) {
        super.init()
        self.path = path
        label = self.getLabel(text: text)
        self.addChild(label!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getLabel(text:String) -> SKLabelNode {
        let label = SKLabelNode.init(text: text)
        label.fontSize = Size.width/15
        label.fontName = "Gasalt-Regular"
        label.fontColor = Colors.labelColor
        label.position = CGPoint.init(x: (path?.boundingBox.origin.x)! + (path?.boundingBox.width)!/2 , y: (self.path?.boundingBox.origin.y)! + (path?.boundingBox.height)!/3.5)
        return label
    }
    
}


