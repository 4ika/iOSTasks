//
//  Sign-in.swift
//  DemoFirebase
//
//  Created by I on 11.04.2018.
//  Copyright © 2018 Shyngys. All rights reserved.
//

import UIKit
import Cartography
import Firebase
import FirebaseAuth

class SigninController: UIViewController {

    lazy var logoImage: UIImageView = {
        let image = UIImageView.init(image: UIImage.init(named:"logo"))
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView.init(frame: CGRect.init(x: 0, y: 0, width: 25, height: 25))
        indicator.activityIndicatorViewStyle = .white
        indicator.color = UIColor.logo
        indicator.isUserInteractionEnabled = true
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    lazy var emailInput:UITextField = {
        let input = UITextField.init()
        input.layer.borderWidth = 1
        input.layer.borderColor = UIColor.border.cgColor
        input.textColor = UIColor.logo
        input.backgroundColor = UIColor.white
        input.placeholder = "Enter email"
        input.textAlignment = .center
        input.layer.cornerRadius = 5
        return input
    }()
    
    lazy var passwordInput:UITextField = {
        let input = UITextField.init()
        input.layer.borderWidth = 1
        input.layer.borderColor = UIColor.border.cgColor
        input.textColor = UIColor.logo
        input.isSecureTextEntry = true
        input.backgroundColor = UIColor.white
        input.placeholder = "Enter password"
        input.textAlignment = .center
        input.layer.cornerRadius = 5
        return input
    }()
    
    lazy var signinButton:UIButton = {
        let button = UIButton.init()
        button.setTitle("Sign-in", for: .normal)
        button.backgroundColor = UIColor.logo
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(checkSignin), for: .allEvents)
        return button
    }()
    
    lazy var signupButton:UIButton = {
        let button = UIButton.init()
        button.setTitle("Sign-up here...", for: .normal)
        button.backgroundColor = UIColor.logo
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(signupAction), for: .allEvents)
        return button
    }()
    
    lazy var messageLabel:UILabel = {
        let label = UILabel.init()
        label.text = "Check your email.We sent you a verification link"
        label.sizeToFit()
        label.textColor = UIColor.clear
        return label
    }()
    
    lazy var forgotPassword:UIButton = {
        let button = UIButton.init()
        button.setTitle("Sign-up here...", for: .normal)
        button.backgroundColor = UIColor.logo
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(signupAction), for: .allEvents)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstrains()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        notificationCenter.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func signupAction() -> Void {
        self.present(UINavigationController.init(rootViewController: SignupController()), animated: true, completion: nil)
    }
    
    @objc func checkSignin()-> Void {
        view.endEditing(true)
        indicator.startAnimating()
        let emailText = emailInput.text!
        let passwordText = passwordInput.text!
        if emailInput.text != "" && passwordInput.text != "" {
            Auth.auth().signIn(withEmail: emailText, password: passwordText, completion: { (user, error) in
                if error == nil {
                    self.indicator.stopAnimating()
                    self.present(UINavigationController.init(rootViewController: ProfileController()), animated: true, completion: nil)
                }
                else{
                    self.messageLabel.textColor = UIColor.red
                    self.messageLabel.text = "User not sign-in. Something is wrong..."
                    self.indicator.stopAnimating()
                }
            })
        }
        else{
            self.messageLabel.textColor = UIColor.red
            self.messageLabel.text = "Not filled all information... Try again"
            self.indicator.stopAnimating()
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        let userInfo = notification.userInfo!
        let keyboardHeight = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.height
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(endEditing))
        view.addGestureRecognizer(tap)

        if view.frame.origin.y >= 0{
            view.frame.origin.y += -keyboardHeight/4
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        let userInfo = notification.userInfo!
        let keyboardHeight = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.height
        view.gestureRecognizers = nil
        view.frame.origin.y -= -keyboardHeight/4
    }
    
    @objc func endEditing() -> Void {
        view.endEditing(true)
    }
    
    func setupViews() -> Void {
        self.view.backgroundColor = UIColor.white
        self.view.addSubviews([emailInput,passwordInput,signinButton,messageLabel,signupButton,indicator,logoImage])
        self.view.backgroundColor = UIColor.white
    }
    
    func setupConstrains() -> Void {
        constrain(emailInput,passwordInput,signinButton,messageLabel,signupButton,indicator,logoImage){ emailInput,passwordInput,signinButton,messageLabel,signupButton,indicator,logoImage in
            
            emailInput.width == 250
            emailInput.height == 35
            emailInput.centerX == (emailInput.superview?.centerX)!
            emailInput.bottom == (emailInput.superview?.centerY)! + 20
            
            messageLabel.height == 18
            messageLabel.centerX == (messageLabel.superview?.centerX)!
            messageLabel.bottom == emailInput.top - 15
            
            logoImage.width == 120
            logoImage.height == 120
            logoImage.centerX == (logoImage.superview?.centerX)!
            logoImage.bottom == messageLabel.top - 30
           
            passwordInput.width == emailInput.width
            passwordInput.height == emailInput.height
            passwordInput.centerX == emailInput.centerX
            passwordInput.top == emailInput.bottom + 20
            
            signinButton.width == passwordInput.width * 0.7
            signinButton.height == 30
            signinButton.centerX == passwordInput.centerX
            signinButton.top == passwordInput.bottom + 20
            
            signupButton.centerX == (signinButton.superview?.centerX)!
            signupButton.width == signinButton.width
            signupButton.height == signinButton.height
            signupButton.bottom == (signinButton.superview?.bottom)! - 20
            
            indicator.width == 25
            indicator.height == 25
            indicator.centerX == (indicator.superview?.centerX)!
            indicator.top == signinButton.bottom + 25
            
        }
    }
}
