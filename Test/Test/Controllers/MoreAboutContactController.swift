//
//  MoreAboutContactController.swift
//  Test
//
//  Created by I on 29.05.2018.
//  Copyright © 2018 Shyngys. All rights reserved.
//

import UIKit
import Cartography
import Kingfisher

class MoreAboutContactController: UIViewController {

     private let width = UIDevice.current.localizedModel == "iPhone" ? UIScreen.main.bounds.width : 600
    
    var contact : Contact?
    
    private let titles : Dictionary<Int, String> = [
        0 : "Name:",
        1 : "Surname:",
        2 : "E-mail:",
        3 : "Gender:",
        4 : "Emp.name:",
        5 : "Emp.position:",
        6 : "IP Address:"
    ]
    
    
    lazy var photo : UIImageView = {
        let image = UIImageView.init()
        image.image = UIImage.init(named: "photo")
        image.kf.indicatorType = .activity
        image.clipsToBounds = true
        image.layer.cornerRadius = width * 0.05
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var tableView : UITableView = {
        let table = UITableView.init(frame: CGRect.zero)
        table.register(ListOfContactsCell.self, forCellReuseIdentifier: CellIdentifier.moreAboutContact)
        table.layer.cornerRadius = width * 0.0535
        table.layer.borderWidth = 1
        table.layer.borderColor = UIColor.lightGray.cgColor
        table.showsVerticalScrollIndicator = false
        table.translatesAutoresizingMaskIntoConstraints = false
        table.isScrollEnabled = false
        table.allowsMultipleSelection = false
        table.allowsSelection = false
        table.delegate = self
        table.dataSource = self
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        setupNavigationController()
        setupViews()
        setupConstrains()
    }
    
    func setupBackground() -> Void {
        self.view.backgroundColor = .white
        let url = URL.init(string: (contact?.photo)!)!
        self.photo.kf.setImage(with: url)
    }
    
    func setupViews() -> Void {
        self.view.addSubview(photo)
        self.view.addSubview(tableView)
    }
    
    func setupNavigationController() -> Void {
        self.title = "About Contact"
    }
    
    func setupConstrains() -> Void {
        
        constrain(photo, tableView){photo, tableView in
            
            photo.width == width * 0.615
            photo.height == width * 0.585
            photo.centerX == (photo.superview?.centerX)!
            photo.bottom == (photo.superview?.centerY)! - width * 0.08
            
            tableView.width == width * 0.75
            tableView.top == photo.bottom + width * 0.0535
            tableView.height == 7 * width * 0.12
            tableView.centerX == (tableView.superview?.centerX)!
            
        }
        
    }
    
    
}

extension MoreAboutContactController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return width * 0.12
    }
    
}

extension MoreAboutContactController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .value1, reuseIdentifier: CellIdentifier.moreAboutContact)
        
        cell.textLabel?.text = titles[indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: width * 0.035)
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: width * 0.04)
        cell.detailTextLabel?.textColor = .darkGray
        
        switch indexPath.row {
            case 0:
                cell.detailTextLabel?.text = contact?.name
            case 1:
                cell.detailTextLabel?.text = contact?.surname
            case 2:
                cell.detailTextLabel?.text = contact?.email
            case 3:
                cell.detailTextLabel?.text = contact?.gender
            case 4:
                cell.detailTextLabel?.text = contact?.employmentName
            case 5:
                cell.detailTextLabel?.text = contact?.employmentPosition
            default:
                cell.detailTextLabel?.text = contact?.ipAddress
        }
        
        return cell
    }
    
}
