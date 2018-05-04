//
//  Extensions.swift
//  SigninCart
//
//  Created by I on 23.02.2018.
//  Copyright © 2018 Shyngys. All rights reserved.
//

import Foundation
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
extension UILabel{
    func getLabel(text:String,underline:Bool,aligment:NSTextAlignment,fontName:String,fontSize:CGFloat) -> UILabel {
        textColor = UIColor.gray
        if underline == true{
            attributedText = NSAttributedString(string: text, attributes:
                [.underlineStyle: NSUnderlineStyle.styleSingle.rawValue])
        }
        self.text = text
        textAlignment = aligment
        isUserInteractionEnabled = true
        self.font = UIFont.init(name: fontName, size: fontSize)
        return self
    }
}
