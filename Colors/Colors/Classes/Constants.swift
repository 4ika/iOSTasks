//
//  Constants.swift
//  Colors
//
//  Created by I on 15.03.2018.
//  Copyright © 2018 Shyngys. All rights reserved.
//

import Foundation
import UIKit

struct Size{
    static let bounds = UIScreen.main.bounds
    static let width = bounds.width
    static let height = bounds.height
}

struct Colors{
    static let labelColor:UIColor = UIColor.init(red: 74/255, green: 144/255, blue: 226/255, alpha: 1)
    static let backgroundColor:UIColor = UIColor.init(red: 184/255, green: 233/255, blue: 134/255, alpha: 1)
    //static let backgroundColor:UIColor = UIColor.init(red: 232/255, green: 232/255, blue: 232/255, alpha: 1)
    static let colorsForBlock:[UIColor] = [UIColor.init(red: 1, green: 102/255, blue: 102/255, alpha: 1),UIColor.init(red: 153/255, green: 1, blue: 153/255, alpha: 1),UIColor.init(red: 1, green: 1, blue: 153/255, alpha: 1),UIColor.init(red: 74/255, green: 144/255, blue: 226/255, alpha: 1)]
}

struct ColliderType {
    static let ball = 1
    static let block = 2
}
