//
//  Grades.swift
//  CourseGrades
//
//  Created by I on 07.04.2018.
//  Copyright © 2018 Shyngys. All rights reserved.
//

import Foundation
class Grade{
    
    var code : String?
    var courseName : String?
    var midterm1 : String?
    var midterm2 : String?
    var credit : String?
    var final : String?
    var average : String?
    
    init(code:String,courseName : String,midterm1 : String,midterm2 : String,credit : String,final : String,average : String) {
        self.code = code
        self.courseName = courseName
        self.credit = credit
        self.average = average
        self.midterm2 = midterm2
        self.midterm1 = midterm1
        self.final = final
    }
}
