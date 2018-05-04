//
//  MessageCell.swift
//  CourseGrades
//
//  Created by I on 08.04.2018.
//  Copyright © 2018 Shyngys. All rights reserved.
//

import UIKit
import Cartography

class MessageCell: UITableViewCell {
    
    lazy var width = UIScreen.main.bounds.width
    lazy var size = CGSize.init()
    
    lazy var time: UILabel = {
        let label = UILabel.init()
        label.text = "9:00 PM"
        label.font = UIFont.init(name: "Arial", size: width/30)
        label.textColor = UIColor.titleTable
        label.textAlignment = .right
        label.sizeToFit()
        label.numberOfLines = 0
        return label
    }()
    
    lazy var name: UILabel = {
        let label = UILabel.init()
        label.text = "Orynbasar Shyngys"
        label.textAlignment = .left
        label.font = UIFont.init(name: "Arial", size: width/25)
        label.textColor = UIColor.white
        return label
    }()
    
    lazy var title: UILabel = {
        let label = UILabel.init()
        label.text = "New Tasks"
        label.textColor = UIColor.white
        label.font = UIFont.init(name: "Arial", size: width/30)
        return label
    }()
    
    lazy var message: UILabel = {
        let label = UILabel.init()
        label.text = "Dear students! Due to next week..."
        label.textColor = UIColor.titleTable
        label.font = UIFont.init(name: "Arial", size: width/27)
        return label
    }()
    
    lazy var view:UIView = {
        let view = UIView.init(frame: CGRect.init())
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        return view
    }()
    
    lazy var ball:UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: width/21, height: width/21))
        view.layer.cornerRadius = self.size.width/42
        view.clipsToBounds = true
        return view
    }()
    
    lazy var labelLogo: UILabel = {
        let label = UILabel.init()
        label.text = "SO"
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight(rawValue: 6))
        return label
    }()
    
    lazy var logo: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: width/7.5, height: width/7.5))
        view.layer.cornerRadius = view.bounds.width/2
        view.backgroundColor = UIColor.cyan
        return view
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    init(style: UITableViewCellStyle, reuseIdentifier: String?,size:CGSize) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.size = size
        setupViews()
        setupConstrains()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() -> Void {
    
        layer.cornerRadius = 10
        
        view.addSubviews([time,name,title,message,logo])
        
        logo.addSubview(labelLogo)
        
        self.addSubviews([view,ball])
    }
    
    
    func setupConstrains() -> Void {
        constrain(view,ball,time,name,title,message,logo,labelLogo){view,ball,time,name,title,message,logo,labelLogo in
            
            view.width == size.width * 0.9
            view.height == size.height
            view.center == (view.superview?.center)!
            
            ball.right == view.left + self.size.width/42
            ball.width == self.size.width/21
            ball.height == self.size.width/21
            ball.top == view.top + self.size.width/39
            
            time.width == width/7.5
            time.height == width/21
            time.right == (time.superview?.right)! - width/27.6
            time.top  == (time.superview?.top)! + width/41.4
            
            name.width == width/2.76
            name.height == width/21
            name.top == (name.superview?.top)! + width/42
            name.left == (name.superview?.left)! + width/5.75
            
            title.width == name.width
            title.height == name.height
            title.top == name.bottom + 5
            title.left == name.left
            
            message.right == time.right - width/8.28
            message.height == name.height
            message.left == name.left
            message.top == (title.bottom) + width/40
            
            logo.width == width/7.5
            logo.height == width/7.5
            logo.centerY == (logo.superview?.centerY)!
            logo.centerX == (logo.superview?.left)! +  width/11.5
            
            labelLogo.center == (labelLogo.superview?.center)!
            labelLogo.width == logo.width/1.5
            labelLogo.height == logo.width/1.5
        }
        

    }
    
    func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.height
    }
}
