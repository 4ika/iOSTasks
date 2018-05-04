//
//  NextController.swift
//  DemoFirebase
//
//  Created by I on 09.04.2018.
//  Copyright © 2018 Shyngys. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import Cartography
import FirebaseDatabase
import GrowingTextView


class ProfileController: UIViewController {

    var reference:DatabaseReference?
    
    var tweets:[Tweet] = []
    
    var k_height:CGFloat = 0
    
    var currentSelecting: IndexPath?
    
    private let cellIdentifier = "cell"
    
    lazy var textView: GrowingTextView = {
        let textView = GrowingTextView.init()
        textView.delegate = self
        textView.maxLength = 140
        textView.trimWhiteSpaceWhenEndEditing = true
        textView.placeholder = "Say something..."
        textView.placeholderColor = UIColor(white: 0.8, alpha: 1.0)
        textView.minHeight = 40.0
        textView.maxHeight = 170.0
        textView.backgroundColor = UIColor.white
        textView.layer.borderWidth = 2
        textView.layer.borderColor = UIColor.logo.cgColor
        textView.layer.cornerRadius = 5
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
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
    
    lazy var tableView: UITableView = {
        let table = UITableView.init()
        table.register(TweetsTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        table.separatorStyle = UITableViewCellSeparatorStyle.none
        table.showsVerticalScrollIndicator = false
        table.delegate = self
        table.dataSource = self
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstrains()
        setupNavigationBar()
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
    
    
    func setupViews() -> Void {
        
        reference = Database.database().reference()
        indicator.startAnimating()
        tableView.alpha = 0
        
        reference?.child("tweets").observe(DataEventType.value, with: { (snapshot) in
            self.tweets.removeAll()
            for snap in snapshot.children {
                let tweet = Tweet.init(snapshot: snap as! DataSnapshot)
                self.tweets.append(tweet)
            }
            self.tweets.reverse()
            self.tableView.reloadData()
            self.indicator.stopAnimating()
            self.tableView.alpha = 1
        })
        self.view.addSubviews([tableView,indicator,textView])
        self.view.backgroundColor = UIColor.white
    }
    
    func setupNavigationBar() -> Void {
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Sent", style: .plain, target: self, action: #selector(sentTweets))
        navigationItem.titleView = logoImage
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "Sign-out", style: .plain, target: self, action: #selector(sign_out))
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.logo], for: .normal)
        navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.logo], for: .normal)

    }

    func setupConstrains() -> Void {
        constrain(tableView,indicator,textView){tableView,indicator,textView in
            
            indicator.center == (indicator.superview?.center)!
            indicator.width == 25
            indicator.height == 25
            
            textView.bottom == (textView.superview?.bottom)! - 1.5
            textView.left == (textView.superview?.left)! + 1.5
            textView.right == (textView.superview?.right)! - 1.5
            
            tableView.width == UIScreen.main.bounds.width
            tableView.top == (tableView.superview?.top)!
            tableView.bottom == (tableView.superview?.bottom)!
            tableView.centerX == (tableView.superview?.centerX)!
        }
    }
    
    func getTodayString() -> String{
        
        let date = Date()
        let calender = Calendar.current
        let components = calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
        
        let year = components.year
        let month = components.month
        let day = components.day
        let hour = components.hour
        let minute = components.minute
        
        let today_string = String(year!) + "-" + String(month!) + "-" + String(day!) + ", " + String(hour!)  + ":" + String(minute!)
        
        return today_string
        
    }
    
    @objc func sign_out() -> Void {
        do{
            try Auth.auth().signOut()
        }
        catch{}
        self.present(SignupController(), animated: true, completion: nil)
    }
    
    @objc func endEditing() -> Void {
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        let userInfo = notification.userInfo!
        let keyboardHeight = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.height
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(endEditing))
        textView.placeholder = "Say something..."
        textView.placeholderColor = UIColor(white: 0.8, alpha: 1.0)
        view.addGestureRecognizer(tap)
        k_height = keyboardHeight
        textView.frame.origin.y += -keyboardHeight
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        let userInfo = notification.userInfo!
        let keyboardHeight = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.height
        view.gestureRecognizers = nil
        textView.frame.origin.y -= -keyboardHeight
        k_height = keyboardHeight
    }
    
    @objc func sentTweets() -> Void {
        if(textView.text != ""){
            let date = self.getTodayString()
            let tweet = Tweet.init(content: textView.text!, user_email: (Auth.auth().currentUser?.email)!, date: date)
            self.reference?.child("tweets").childByAutoId().setValue(tweet.toJSONFormat())
            self.tweets.append(tweet)
            self.tableView.reloadData()
            textView.text = ""
        }
        else{
            textView.placeholder = "Please,type something..."
            textView.placeholderColor = UIColor.red
        }
        view.endEditing(true)
    }
    
}

extension ProfileController: GrowingTextViewDelegate{
    func textViewDidChangeHeight(_ textView: GrowingTextView, height: CGFloat) {
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
            textView.frame.origin.y += -self.k_height
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.frame.origin.y = 0
        textField.resignFirstResponder()
        return true
    }
}

extension ProfileController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TweetsTableViewCell
        cell?.selectionStyle = UITableViewCellSelectionStyle.none
        cell?._tweet = tweets[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath
        currentSelecting = row
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cell = tableView.cellForRow(at: indexPath) as? TweetsTableViewCell
        if currentSelecting != nil{
            if currentSelecting == indexPath{
                if cell?.bounds.height == 110 {
                    cell?.arrowImage = UIImage.init(named: "up")!
                    return UITableViewAutomaticDimension
                }
                else{
                    cell?.arrowImage = UIImage.init(named: "down")!
                    return 110
                }
            }
            else{
                cell?.arrowImage = UIImage.init(named: "down")!
                return 110
            }
        }
        return 110
    }

}
