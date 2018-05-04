//
//  Extensions.swift
//  CourseGrades
//
//  Created by I on 10.04.2018.
//  Copyright © 2018 Shyngys. All rights reserved.
//

import UIKit

extension UIView{
    func addSubviews(_ subviews:[UIView]) -> Void {
        for i in subviews{
            self.addSubview(i)
        }
    }
}
