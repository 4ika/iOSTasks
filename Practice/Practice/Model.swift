//
//  File.swift
//  Practice
//
//  Created by I on 15.03.2018.
//  Copyright © 2018 Shyngys. All rights reserved.
//

import Foundation
class Weather{
    var name:String?
    var temp:String?
    var humidity:String?
    var windSpeed:String?
    var sunrise:String?
    var sunset:String?
    init(name:String,temp:String,humidity:String,windSpeed:String,sunrise:String,sunset:String) {
        self.name = name
        self.temp = temp
        self.humidity = humidity
        self.windSpeed = windSpeed
        self.sunset = sunset
        self.sunrise = sunrise
    }
}
