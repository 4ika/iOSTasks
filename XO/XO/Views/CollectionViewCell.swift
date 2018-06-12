//
//  CollectionViewCell.swift
//  XO
//
//  Created by I on 10.05.2018.
//  Copyright © 2018 Shyngys. All rights reserved.
//

import UIKit
import Cartography

class CollectionViewCell: UICollectionViewCell {
    
    lazy var image:XOImage = {
        let image = XOImage.init(frame: CGRect.zero)
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstrains()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() -> Void{
        self.addSubview(image)
    }
    
    func setupConstrains() -> Void {
        constrain(image){ image in
            image.height == (image.superview?.height)! * 0.7
            image.width == (image.superview?.width)! * 0.7
            image.center == (image.superview?.center)!
        }
    }
}
