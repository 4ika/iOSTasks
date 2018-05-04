//
//  ViewController.swift
//  Task8
//
//  Created by I on 31.03.2018.
//  Copyright © 2018 Shyngys. All rights reserved.
//

import UIKit
import Cartography

class ViewController: UIViewController {
    
    lazy var _text1:UITextField = {
        let text = UITextField.init()
        text.backgroundColor = UIColor.white
        text.layer.cornerRadius = 10
        return text
    }()
    
    lazy var _text2:UITextField = {
        let text = UITextField.init()
        text.backgroundColor = UIColor.white
        text.layer.cornerRadius = 10
        return text
    }()
    
    lazy var _button:UIButton = {
        let button = UIButton.init()
        button.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
        button.setTitle("Next", for: .normal)
        button.layer.cornerRadius = 10
        button.alpha = 0
        button.addTarget(self, action: #selector(touch), for: UIControlEvents.allEvents)
        return button
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 1.5, animations: {
            self._text1.center.x = self.view.center.x
            self._text2.center.x = self.view.center.x
        }) { _ in
            UIView.animate(withDuration: 1, animations: {
                self._button.alpha = 1
            })
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.red
        self.view.addSubview(_text1)
        self.view.addSubview(_text2)
        self.view.addSubview(_button)
        setupConstrains()
    }
//    container?.addSubview(destinationView!)
//    destinationView?.transform = CGAffineTransform.identity
//    sourceView?.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
    @objc func touch() -> Void {
        let segue = UIStoryboardSegue.init(identifier: "segue", source: self, destination: Next())
        let source = segue.source
        let destination = segue.destination
        let sourceView = source.view
        let destinationView = destination.view
        let container = sourceView?.superview
        destinationView?.center = (sourceView?.center)!
        destinationView?.transform = CGAffineTransform.init(scaleX: 0.01, y: 0.01)
        self.view.addSubview(destinationView!)
        destinationView?.center = (sourceView?.center)!
        
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut, animations: {
            container?.addSubview(destinationView!)
            destinationView?.transform = CGAffineTransform.identity
            sourceView?.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        }) { _ in
            segue.source.present(destination, animated: true, completion: nil)
        }
    }
    
    func setupConstrains() -> Void {
        constrain(_text1,_text2,_button){ v1,v2,v3 in
            
            v1.centerX == (v1.superview?.centerX)! - 1000
            v1.bottom == (v1.superview?.centerY)! - 20
            v1.width == self.view.frame.width/2
            v1.height == self.view.frame.width/10
            
            v2.width == v1.width
            v2.height == v1.height
            v2.centerX == (v2.superview?.centerX)! + 1000
            v2.top == (v2.superview?.centerY)! + 10
            
            v3.centerX == (v3.superview?.centerX)!
            v3.height == self.view.frame.width/13
            v3.width == self.view.frame.width/5
            v3.top == v2.bottom + 20
            
        }
    }
}

