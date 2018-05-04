//
//  TweetsTableViewCell.swift
//  DemoFirebase
//
//  Created by I on 12.04.2018.
//  Copyright © 2018 Shyngys. All rights reserved.
//

import UIKit
import Cartography

class TweetsTableViewCell: UITableViewCell {
    
    var _tweet:Tweet?{
        didSet{
            guard let twt:Tweet = _tweet else {return}
            
            let paragraphStyle = NSMutableParagraphStyle.init()
            
            let attributedText = NSMutableAttributedString.init(string: "\(twt.User_email!)\n" , attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 17), NSAttributedStringKey.foregroundColor : UIColor.darkGray])
            
            paragraphStyle.lineSpacing = 0
            attributedText.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedText.string.count))
            
            attributedText.append(NSAttributedString.init(string: "\(twt.Date!)\n", attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 16), NSAttributedStringKey.foregroundColor : UIColor.lightGray]))
            
            paragraphStyle.lineSpacing = 10
            attributedText.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedText.string.count))

            attributedText.append(NSAttributedString.init(string: twt.Content!, attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 15),NSAttributedStringKey.foregroundColor : UIColor.border ]))
            
            tweet.attributedText = attributedText
        }
    }
    
    var arrowImage:UIImage = UIImage.init(named: "down")!{
        didSet{
            arrow.image = arrowImage
        }
    }
    
    lazy var separatorCell:UIView = {
        let line = UIView.init()
        line.backgroundColor = UIColor.logo
        return line
    }()
    
    
    lazy var imageview:UIImageView = {
        let image = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 40, height: 40))
        image.layer.cornerRadius = image.bounds.width/2
        image.backgroundColor = UIColor.white
        image.image = UIImage.init(named: "logo")
        return image
    }()
    
    lazy var tweet:UITextView = {
        let text = UITextView.init()
        text.backgroundColor = UIColor.white
        text.font = UIFont.init(name: "Arial", size: 17)
        text.isScrollEnabled = false
        text.isEditable = false
        text.isSelectable = false
        text.sizeToFit()
        return text
    }()
    
    lazy var arrow:UIImageView = {
        let image = UIImageView.init()
        image.backgroundColor = UIColor.white
        image.image = arrowImage
        return image
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstrains()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() -> Void {
        self.addSubviews([imageview,tweet,separatorCell,arrow])
    }
    
    func setupConstrains() -> Void {
        constrain(imageview,tweet,separatorCell,arrow){imageview,tweet,separatorCell,arrow in
            
            imageview.height == 40
            imageview.width == 40
            imageview.top == (imageview.superview?.top)! + 10
            imageview.left == (imageview.superview?.left)! + 20

            tweet.left == imageview.right + 10
            tweet.right == (tweet.superview?.right)! - 10
            tweet.top == (tweet.superview?.top)!
            tweet.bottom == (tweet.superview?.bottom)!
            
            separatorCell.width == UIScreen.main.bounds.width * 0.9
            separatorCell.height == 1.5
            separatorCell.centerX == (separatorCell.superview?.centerX)!
            separatorCell.bottom == (separatorCell.superview?.bottom)!
            
            arrow.width == 20
            arrow.height == 20
            arrow.centerX == imageview.centerX
            arrow.bottom == (arrow.superview?.bottom)! - 10
        }
    }
}
