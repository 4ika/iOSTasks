//
//  GameViewController.swift
//  Colors
//
//  Created by I on 14.03.2018.
//  Copyright © 2018 Shyngys. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    let skView:SKView = {
        
        let view = SKView.init(frame: UIScreen.main.bounds)
        view.ignoresSiblingOrder = true
        view.showsPhysics = true
//        view.showsFPS = true
//        view.showsNodeCount = true
        view.translatesAutoresizingMaskIntoConstraints = false
        let scene = MainMenu.init(size: UIScreen.main.bounds.size)
        view.texture(from: SKSpriteNode.init(texture: SKTexture.init(imageNamed: "Colors")))
        scene.scaleMode = .aspectFill
        view.presentScene(scene)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSKView()
    }
    func setupSKView() -> Void {
        self.view.addSubview(skView)
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
