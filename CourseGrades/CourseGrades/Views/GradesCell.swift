//
//  GradesCell.swift
//  CourseGrades
//
//  Created by I on 06.04.2018.
//  Copyright © 2018 Shyngys. All rights reserved.
//

import UIKit
import Cartography

class GradesCell: UITableViewCell {
    
    private let width = UIScreen.main.bounds.width
    
    internal var sublabels: [UILabel] = []
    
    private var height:CGFloat = 0.0
    
    var font_label:UIFont?{
        didSet{
            for i in self.sublabels{
                i.font = font_label
            }
        }
    }
    
    var color:UIColor?{
        didSet{
            for i in self.sublabels{
                i.textColor = color
            }
        }
    }
    
    var data:Grade?{
        didSet{
            code.text = data?.code
            courseName.text = data?.courseName
            credit.text = data?.credit
            midterm1.text = data?.midterm1
            midterm2.text = data?.midterm2
            final.text = data?.final
            average.text = data?.average
    
            constrain(courseName){ courseName in
                courseName.height == heightForView(text: self.courseName.text!, font: self.courseName.font, width: width/3.5 )
            }
        }
    }
    
    lazy var code: UILabel = {
        let label = UILabel.init()
        label.textAlignment = .center
        label.font = UIFont.init(name: "Arial", size: 12)
        label.text = "Code"
        return label
    }()
    
    lazy var courseName: UILabel = {
        let label = UILabel.init()
        label.textAlignment = .center
        label.font = UIFont.init(name: "Arial", size: 12)
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    
    lazy var credit: UILabel = {
        let label = UILabel.init()
        label.textAlignment = .center
        label.font = UIFont.init(name: "Arial", size: 12)
        return label
    }()
    
    lazy var midterm1: UILabel = {
        let label = UILabel.init()
        label.textAlignment = .center
        label.font = UIFont.init(name: "Arial", size: 12)
        return label
    }()
    
    lazy var midterm2: UILabel = {
        let label = UILabel.init()
        label.textAlignment = .center
        label.font = UIFont.init(name: "Arial", size: 12)
        return label
    }()
    
    lazy var final: UILabel = {
        let label = UILabel.init()
        label.textAlignment = .center
        label.font = UIFont.init(name: "Arial", size: 12)
        return label
    }()
    
    lazy var average: UILabel = {
        let label = UILabel.init()
        label.textAlignment = .center
        label.font = UIFont.init(name: "Arial", size: 12)
        return label
    }()
    
    init(style: UITableViewCellStyle, reuseIdentifier: String?,height: CGFloat) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.height = height
        setupViews()
        setupConstrains()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() -> Void {
        self.addSubview(code)
        self.addSubview(courseName)
        self.addSubview(credit)
        self.addSubview(midterm1)
        self.addSubview(midterm2)
        self.addSubview(final)
        self.addSubview(average)
        
        sublabels = [code,courseName,credit,midterm2,midterm1,final, average]
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
    
    func setupConstrains() -> Void {
        constrain(code,courseName,credit,midterm1,midterm2,final,average){ code,courseName,credit,midterm1,midterm2,final,average in
            
            code.centerY == (code.superview?.centerY)!
            code.width == width/5.3
            code.height == self.height
            code.left == (code.superview?.left)! + 5
            
            courseName.left == code.right
            courseName.centerY == code.centerY
            courseName.width == width/3.5
            
            credit.centerY == courseName.centerY
            credit.width == width/11
            credit.height == code.height
            credit.left == courseName.right
            
            midterm1.centerY == credit.centerY
            midterm1.left == credit.right
            midterm1.height == credit.height
            midterm1.width == credit.width
            
            midterm2.centerY == midterm1.centerY
            midterm2.left == midterm1.right
            midterm2.height == midterm1.height
            midterm2.width == midterm1.width
            
            final.centerY == midterm2.centerY
            final.left == midterm2.right
            final.height == midterm2.height
            final.width == midterm2.width
            
            average.centerY == final.centerY
            average.left == final.right
            average.height == final.height
            average.width == final.width
        }
    }
}
