//
//  ViewController.swift
//  CourseGrades
//
//  Created by I on 05.04.2018.
//  Copyright © 2018 Shyngys. All rights reserved.
//

import UIKit
import Cartography



class ScheduleController: UIViewController {

    lazy var days:[String] = ["Monday","Tuesday","Wednesday","Thursday","Friday"]
    
    lazy var collectionView:UICollectionView = {
        
        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .horizontal
    
        let collection = UICollectionView.init(frame: CGRect.init(), collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.register(ScheduleCollectionCell.self, forCellWithReuseIdentifier: "myCell")
        collection.isPagingEnabled = true
        return collection
        
    }()
    
//    lazy var pickerView: UIPickerView = {
//        let picker = UIPickerView.init()
//        picker.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 100)
//        picker.contentMode = .scaleAspectFit
//        picker.backgroundColor = UIColor.lightGray
//        picker.delegate = self
//        picker.dataSource = self
////        picker.transform = CGAffineTransform.init(rotationAngle: -90 * (.pi/180))
//        picker.center = self.view.center
//        return picker
//    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupNavigationBar()
        setupConstrains()
    }
    
    func setupViews() -> Void {
        self.view.backgroundColor = UIColor.red
        self.view.addSubview(collectionView)
//        self.view.addSubview(pickerView)
//        self.view.addSubviews([collectionView,pickerView])
    }
    
    func setupNavigationBar() -> Void {
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.backgroundColor = UIColor.bgColor
    }
    
    func setupConstrains() -> Void {
        constrain(collectionView){ collectionView in
            
            collectionView.width == UIScreen.main.bounds.width
            collectionView.height == UIScreen.main.bounds.height * 0.9  - (navigationController?.navigationBar.bounds.maxY)!
            collectionView.bottom == (collectionView.superview?.bottom)!
            collectionView.centerX == (collectionView.superview?.centerX)!

        }
    }
    
}

extension ScheduleController: UICollectionViewDelegate, UICollectionViewDataSource  {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return days.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as? ScheduleCollectionCell
        return cell!
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
    }
    
}

extension ScheduleController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

//extension ScheduleController : UIPickerViewDelegate, UIPickerViewDataSource {
//
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return days.count
//    }
//
//
//    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
//        let label = UILabel.init()
//        label.text = days[row]
//        label.textColor = UIColor.red
////        label.transform = CGAffineTransform.init(rotationAngle: 90 * (.pi/180))
//        return label
//    }
//}


