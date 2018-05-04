//
//  Extensions.swift
//  Practice
//
//  Created by I on 15.03.2018.
//  Copyright © 2018 Shyngys. All rights reserved.
//

import UIKit

extension UITextField{
    func getTextField(placeholder:String) -> UITextField {
        borderStyle = UITextBorderStyle.line
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 1
        attributedPlaceholder = NSAttributedString(string: placeholder ,attributes: [NSAttributedStringKey.foregroundColor: UIColor.init(red: 44/255, green: 68/255, blue: 162/255, alpha: 1)])
        return self
    }
}
extension UIButton{
    func getButton(title:String,fontName:String,fontSize:CGFloat,bgColor:UIColor) -> UIButton {
        setTitle(title, for: .normal)
        layer.cornerRadius = 10
        titleLabel?.font = UIFont.init(name: fontName, size: fontSize)
        backgroundColor = bgColor
        return self
    }
}
