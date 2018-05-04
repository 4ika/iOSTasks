//
//  ViewController.swift
//  DemoFirebase
//
//  Created by I on 09.04.2018.
//  Copyright © 2018 Shyngys. All rights reserved.
//

import UIKit
import Cartography
import Firebase
import FirebaseAuth

class SignupController : UIViewController {
    
    lazy var logoImage: UIImageView = {
        let image = UIImageView.init(image: UIImage.init(named:"logo"))
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(pickerImageTap))
        image.addGestureRecognizer(tap)
        image.contentMode = .scaleAspectFit
        image.isUserInteractionEnabled = true
        image.layer.borderWidth = 1
        image.layer.borderColor = UIColor.logo.cgColor
        image.layer.cornerRadius = 10
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
    
    lazy var fullNameInput:UITextField = {
        let input = UITextField.init()
        input.layer.borderWidth = 1
        input.layer.borderColor = UIColor.border.cgColor
        input.backgroundColor = UIColor.white
        input.placeholder = "Full name"
        input.textColor = UIColor.logo
        input.textAlignment = .center
        input.layer.cornerRadius = 5
        return input
    }()
    
    lazy var passwordInput:UITextField = {
        let input = UITextField.init()
        input.layer.borderWidth = 1
        input.layer.borderColor = UIColor.border.cgColor
        input.backgroundColor = UIColor.white
        input.isSecureTextEntry = true
        input.placeholder = "Enter password"
        input.textColor = UIColor.logo
        input.textAlignment = .center
        input.layer.cornerRadius = 5
        return input
    }()

    lazy var createUserButton:UIButton = {
        let button = UIButton.init()
        button.setTitle("Sign-up", for: .normal)
        button.backgroundColor = UIColor.logo
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(createUser), for: .allEvents)
        return button
    }()
    
    lazy var signinButton:UIButton = {
        let button = UIButton.init()
        button.setTitle("Sign-in here...", for: .normal)
        button.backgroundColor = UIColor.logo
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(signinAction), for: .allEvents)
        return button
    }()
    
    lazy var messageLabel:UILabel = {
        let label = UILabel.init()
        label.text = "Check your email.We sent you a verification link"
        label.sizeToFit()
        label.textColor = UIColor.clear
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupNavigationBar()
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
    
    @objc func signinAction() -> Void {
        self.present(UINavigationController.init(rootViewController: SigninController()), animated: true, completion: nil)
    }
    
    @objc func createUser() -> Void {
        let emailText = emailInput.text!
        let passwordText = passwordInput.text!
        if emailInput.text != "" && passwordInput.text != "" {
            indicator.startAnimating()
            Auth.auth().createUser(withEmail: emailText, password: passwordText, completion: { (user, fail) in
                if fail == nil {
                    user?.createProfileChangeRequest().displayName = self.fullNameInput.text!
                    user?.sendEmailVerification(completion: { (error) in
                        self.messageLabel.textColor = UIColor.green
                        if error == nil {
                            self.present(UINavigationController.init(rootViewController: ProfileController()), animated: true, completion: nil)
                            self.indicator.stopAnimating()
                        }
                    })
                }
                else{
                    self.messageLabel.text = "Something is wrong.Please try again ... "
                    self.messageLabel.textColor = UIColor.red
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
            view.frame.origin.y += -keyboardHeight/3
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        let userInfo = notification.userInfo!
        let keyboardHeight = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.height
        view.gestureRecognizers = nil
        view.frame.origin.y -= -keyboardHeight/3
    }
    
    @objc func endEditing() -> Void {
        view.endEditing(true)
    }
    
    func setupViews() -> Void {
        self.view.addSubviews([emailInput,passwordInput,createUserButton,messageLabel,signinButton,fullNameInput,indicator,logoImage])
        self.view.backgroundColor = UIColor.white
    }
    
    func setupNavigationBar() -> Void {
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationItem.title = "Twitter"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.logo]
    }
    
    func setupConstrains() -> Void {
        constrain(emailInput,passwordInput,createUserButton,messageLabel,fullNameInput,signinButton,indicator,logoImage){ emailInput,passwordInput,createUserButton,messageLabel,fullNameInput,signinButton,indicator,logoImage in
            
            
            emailInput.width == 250
            emailInput.height == 35
            emailInput.centerX == (emailInput.superview?.centerX)!
            emailInput.bottom == (emailInput.superview?.centerY)! + 20
        
            messageLabel.height == 18
            messageLabel.centerX == (messageLabel.superview?.centerX)!
            messageLabel.bottom == emailInput.top - 15
            
            logoImage.width == 125
            logoImage.height == 125
            logoImage.centerX == (logoImage.superview?.centerX)!
            logoImage.bottom == messageLabel.top - 30
            
            fullNameInput.width == emailInput.width
            fullNameInput.centerX == emailInput.centerX
            fullNameInput.height == emailInput.height
            fullNameInput.top == emailInput.bottom + 20
            
            passwordInput.width == emailInput.width
            passwordInput.height == emailInput.height
            passwordInput.centerX == emailInput.centerX
            passwordInput.top == fullNameInput.bottom + 20
            
            createUserButton.width == passwordInput.width * 0.7
            createUserButton.height == 30
            createUserButton.centerX == passwordInput.centerX
            createUserButton.top == passwordInput.bottom + 20
            
            signinButton.centerX == (signinButton.superview?.centerX)!
            signinButton.width == createUserButton.width
            signinButton.height == createUserButton.height
            signinButton.bottom == (signinButton.superview?.bottom)! - 20
            
            indicator.width == 25
            indicator.height == 25
            indicator.centerX == (indicator.superview?.centerX)!
            indicator.top == createUserButton.bottom + 25
            
        }
        
    }
    
    @objc func pickerImageTap(sender: UITapGestureRecognizer) -> Void {
        print("qfwefweg")
        let picker = UIImagePickerController()
        
        picker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        
        let actionSheets = UIAlertController.init(title: "Photo source", message: "Choose a source", preferredStyle: .actionSheet)
        
        actionSheets.addAction(UIAlertAction.init(title: "Photo Library", style: .default, handler: { (action) in
            picker.sourceType = .photoLibrary
            self.present(picker, animated: true, completion: nil)
        }))
        
        actionSheets.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheets, animated: true, completion: nil)
        
    }
}

extension SignupController : UINavigationControllerDelegate ,UIPickerViewDelegate {

    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let img = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.logoImage.image = img
        dismiss(animated: true, completion: nil)
    }
}
