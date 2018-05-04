//
//  ScheduleCell.swift
//  CourseGrades
//
//  Created by I on 05.04.2018.
//  Copyright © 2018 Shyngys. All rights reserved.
//

import UIKit
import Cartography

class ScheduleCell: UITableViewCell {
    
    var width = UIScreen.main.bounds.width
    
    var  size:CGSize = CGSize.init(width: 0, height: 0)
    
    lazy var courseName: UILabel = {
        let label = UILabel.init()
        label.text = "Personal Development in Computer Science"
        label.font = UIFont.init(name: "Arial", size: width/25)
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.sizeToFit()
        label.numberOfLines = 0
        return label
    }()
    
    lazy var teacherName: UILabel = {
        let label = UILabel.init()
        label.text = "Ivanov A."
        label.textAlignment = .right
        label.font = UIFont.init(name: "Arial", size: width/30)
        label.textColor = UIColor.white
        return label
    }()
    
    lazy var beginTime: UILabel = {
        let label = UILabel.init()
        label.text = "9:00"
        label.textColor = UIColor.white
        label.font = UIFont.init(name: "Arial", size: width/30)
        return label
    }()
    
    lazy var endTime: UILabel = {
        let label = UILabel.init()
        label.text = "9:00"
        label.textColor = UIColor.white
        label.font = UIFont.init(name: "Arial", size: width/30)
        return label
    }()
    
    lazy var view:UIView = {
        let view = UIView.init(frame: CGRect.init())
        return view
    }()
    
    lazy var ball:UIView = {
        let view = UIView.init(frame: CGRect.init())
        return view
    }()
    
    lazy var headerView:UIView = {
        let view = UIView.init()
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
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        ball.layer.cornerRadius = self.size.width/42
        ball.clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() -> Void {
        
        view.addSubview(courseName)
        view.addSubview(teacherName)
        view.addSubview(beginTime)
        view.addSubview(endTime)
        
        self.addSubview(view)
        self.addSubview(ball)
    }
    
    func setupConstrains() -> Void {
        constrain(view,ball,courseName,teacherName,beginTime,endTime){view,ball,courseName,teacherName,beginTime,endTime in
            
            view.width == size.width * 0.9
            view.height == size.height
            view.center == (view.superview?.center)!
            
            ball.right == view.left + self.size.width/42
            ball.width == self.size.width/21
            ball.height == self.size.width/21
            ball.top == view.top + self.size.width/42
            
            beginTime.bottom == (beginTime.superview?.centerY)!
            beginTime.left == (beginTime.superview?.left)! + 15
            beginTime.height == 15
            beginTime.width == 30
            
            endTime.top == (endTime.superview?.centerY)!
            endTime.width == beginTime.width
            endTime.height == beginTime.height
            endTime.left == beginTime.left
            
            teacherName.right == (teacherName.superview?.right)! - 10
            teacherName.centerY == endTime.top
            teacherName.width == 80
            teacherName.height == 30
            
            courseName.centerY == (courseName.superview?.centerY)!
            courseName.left == beginTime.right + 20
            courseName.right == teacherName.left - 20
             courseName.height == heightForView(text: self.courseName.text! , font: self.courseName.font, width: UIScreen.main.bounds.width * 0.9 - 165)
            
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
