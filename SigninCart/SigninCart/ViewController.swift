//
//  ViewController.swift
//  SigninCart
//
//  Created by I on 22.02.2018.
//  Copyright © 2018 Shyngys. All rights reserved.
//

import UIKit
import Cartography

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        setupView()
        setupConstrains()
    
    }
    
    lazy var label:UILabel = UILabel().getLabel(text: "Вход", underline: false, aligment: .center, fontName: "Arial", fontSize: 25)
    
    lazy var forgotLabel:UILabel = UILabel().getLabel(text: "Забыли пароль?", underline: true, aligment: .right, fontName: "Arial", fontSize: self.view.bounds.width*0.045)
    
    lazy var createLabel:UILabel = UILabel().getLabel(text: "Вы не зарегестрированы?", underline: true, aligment: .left, fontName: "Arial", fontSize: self.view.bounds.width*0.045)
    
    lazy var submit:UIButton = UIButton().getButton(title: "Войти", fontName: "Arial", fontSize: self.view.bounds.width*0.045, bgColor: UIColor.init(red: 44/255, green: 68/255, blue: 162/255, alpha: 1))
    
    lazy var create:UIButton = UIButton().getButton(title: "Создать", fontName: "Arial", fontSize: self.view.bounds.width*0.045, bgColor: UIColor.init(red: 172/255, green: 249/255, blue: 196/255, alpha: 1))
    
    lazy var email:UITextField = UITextField().getTextField(placeholder: "Введите ваш номер или эл.почту")
    
    lazy var password:UITextField = UITextField().getTextField(placeholder: "Пароль")
    
    lazy var image:UIImageView = {
        let image = UIImageView()
        image.backgroundColor = UIColor.lightGray
        image.layer.cornerRadius = self.view.bounds.width/7
        image.clipsToBounds = true
        return image
    }()
    
    func setupView() -> Void {
        self.view.addSubview(image)
        self.view.addSubview(label)
        self.view.addSubview(email)
        self.view.addSubview(password)
        self.view.addSubview(forgotLabel)
        self.view.addSubview(submit)
        self.view.addSubview(createLabel)
        self.view.addSubview(create)
    }
    
    func setupConstrains() -> Void {
        constrain(image,label){image,label in
            
            image.height == self.view.bounds.width/3.5
            image.width == image.height
            image.centerX == image.superview!.centerX
            image.top == (image.superview?.top)! + self.view.bounds.width/5
            
            label.width == image.height
            label.centerX == image.centerX
            
            distribute(by: 15, vertically: image, label)
        }
        
        constrain(email,password,submit,forgotLabel){email,password,submit,forgotLabel in
            
            email.width == self.view.bounds.width - 50
            email.height == self.view.bounds.width/7.5
            email.centerX == (email.superview?.centerX)!
            email.bottom == (email.superview?.centerY)!
            
            password.width == email.width
            password.height == email.height
            password.centerX == email.centerX
            
            submit.width == email.width
            submit.height == email.height
            submit.centerX == email.centerX
            
            forgotLabel.width == submit.width
            forgotLabel.centerX == submit.centerX
            
            distribute(by: 15, vertically: email, password,forgotLabel,submit)
            
        }
        
        constrain(create,createLabel){create,createLabel in
            
            create.height == self.view.bounds.width/10
            create.width == self.view.bounds.width/4
            create.bottom == (create.superview?.bottom)! - 5
            create.right == (create.superview?.right)! - 25
            
            createLabel.width == self.view.bounds.width - self.view.bounds.width/4
            createLabel.bottom == create.bottom - 10
            createLabel.left == (createLabel.superview?.left)! + 25
            
        }
    }
}

