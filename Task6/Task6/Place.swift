//
//  Place.swift
//  Task6
//
//  Created by I on 13.03.2018.
//  Copyright © 2018 Shyngys. All rights reserved.
//

import Foundation
import MapKit

class Place {
    var country:String?
    var city:String?
    var location:CLLocationCoordinate2D?
    init(country:String,city:String,location:CLLocationCoordinate2D) {
        self.country = country
        self.location = location
        self.city = city
    }
}
