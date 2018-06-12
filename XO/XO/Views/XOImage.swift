//
//  XOImage.swift
//  XO
//
//  Created by I on 11.05.2018.
//  Copyright © 2018 Shyngys. All rights reserved.
//

import UIKit

class XOImage: UIImageView {
    var player:String?
    var activated:Bool! = false
    
    func setPlayer(_ player:String) -> Void {
        self.player = player
        
        if activated == false {
            if player == "x" {
                image = UIImage.init(named: "x")
            }
            else{
                image = UIImage.init(named: "o")
            }
            activated = true
        }
    }
}
