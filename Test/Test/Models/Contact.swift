//
//  Contact.swift
//  Test
//
//  Created by I on 29.05.2018.
//  Copyright © 2018 Shyngys. All rights reserved.
//

import Foundation
import ObjectMapper

class Contact : Mappable {
    
    var name : String?
    var surname : String?
    var email : String?
    var gender : String?
    var ipAddress : String?
    var photo : String?
    var employmentName : String?
    var employmentPosition : String?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        self.name <- map["first_name"]
        self.surname <- map["last_name"]
        self.email <- map["email"]
        self.gender <- map["gender"]
        self.ipAddress <- map["ip_address"]
        self.photo <- map["photo"]
        self.employmentName <- map["employment.name"]
        self.employmentPosition <- map["employment.position"]
    }
    
    
}
