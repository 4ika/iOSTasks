//
//  ListOfContactsCell.swift
//  Test
//
//  Created by I on 29.05.2018.
//  Copyright © 2018 Shyngys. All rights reserved.
//

import UIKit
import Cartography
import Kingfisher

class ListOfContactsCell: UITableViewCell {
    
     private let width = UIDevice.current.localizedModel == "iPhone" ? UIScreen.main.bounds.width : 600
    
    lazy var photo : UIImageView = {
        let image = UIImageView.init()
        image.image = UIImage.init(named: "photo")
        image.kf.indicatorType = .activity
        image.clipsToBounds = true
        image.layer.cornerRadius = width * 0.05
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var fullName : UILabel = {
        let label = UILabel.init()
        label.text = "Shyngys Orynbassar"
        label.textColor = .darkText
        label.font = UIFont.systemFont(ofSize: width * 0.05)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var gender : UILabel = {
        let label = UILabel.init()
        label.text = "Male"
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: width * 0.045)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        
        self.addSubview(photo)
        self.addSubview(fullName)
        self.addSubview(gender)
        
    }
    
    func setupConstrains() -> Void {
        
        constrain(photo, fullName, gender){ photo, fullName, gender in
            
            photo.width == width * 0.215
            photo.height == width * 0.215
            photo.centerY == (photo.superview?.centerY)!
            photo.left == (photo.superview?.left)! + width * 0.0625
            
            fullName.left == photo.right + width * 0.05
            fullName.top == photo.top + width * 0.025
            fullName.right == (fullName.superview?.right)! - width * 0.05
            fullName.height == width * 0.075
            
            gender.left == fullName.left
            gender.right == fullName.right
            gender.top == fullName.bottom + width * 0.025
            gender.height == width * 0.075
            
        }
        
    }
}
