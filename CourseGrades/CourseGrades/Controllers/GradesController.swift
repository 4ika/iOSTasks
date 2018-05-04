//
//  GradesController.swift
//  CourseGrades
//
//  Created by I on 06.04.2018.
//  Copyright © 2018 Shyngys. All rights reserved.
//

import UIKit
import Cartography
import DropDown

class GradesController: UIViewController {
    
    let dropDown = DropDown()
    
    lazy var grades:[Grade] = {
        let grade1 = Grade.init(code: "Code", courseName: "Course name", midterm1: "MT1", midterm2: "MT2", credit: "CR", final: "FIN", average: "AVG")
        
        let grade2 = Grade.init(code: "CSS 305", courseName: "System Programming", midterm1: "90", midterm2: "78", credit: "3", final: "90", average: "85")
        
        return [grade1,grade2,grade2,grade2,grade2,grade2,grade2,grade2,grade2]
    }()
    
    lazy var cell_color:Dictionary<Int,UIColor> = [
        0:UIColor.evenCell,
        1:UIColor.oddCell
    ]
    
    lazy var headerLabel: UILabel = {
        let label = UILabel.init()
        label.text = "2015 - 2016"
        return label
    }()
    
    lazy var headerView: UIButton = {
        let view = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 200, height: 200))
        view.backgroundColor = UIColor.bgColor
        view.setTitle("2015 - 2016 | 2 term", for: .normal)
        return view
    }()
    
    lazy var tableView:UITableView = {
        let table = UITableView.init(frame: CGRect.init(), style: UITableViewStyle.plain)
        table.register(GradesCell.self, forCellReuseIdentifier: CellIdentifiers.gradesCell)
        table.separatorStyle = UITableViewCellSeparatorStyle.none
        table.backgroundColor = UIColor.bgColor
        table.bounces = false
        table.showsVerticalScrollIndicator = false
        table.allowsSelection = false
        table.delegate = self
        table.dataSource = self
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstrains()
    }
    
    func setupViews() -> Void {
        
        dropDown.anchorView = tableView
    
        dropDown.animationEntranceOptions = UIViewAnimationOptions.beginFromCurrentState
        
        dropDown.animationExitOptions = UIViewAnimationOptions.beginFromCurrentState
        
        dropDown.arrowIndicationX = UIScreen.main.bounds.width/2
        
        dropDown.downScaleTransform = CGAffineTransform.identity
        
        dropDown.animationduration = 1.5
        
        dropDown.dataSource = ["2015 - 2016 | 2 term","2015 - 2016 | 2 term","2015 - 2016 | 2 term","2015 - 2016 | 2 term"]
        
        dropDown.backgroundColor = UIColor.bgColor
        
        self.view.addSubview(tableView)
        self.view.backgroundColor = UIColor.init(red: 44/255, green: 51/255, blue: 85/255, alpha: 1)
        headerView.addTarget(self, action: #selector(dropDownShow), for: UIControlEvents.allEvents)
        
    }
    
    func setupConstrains() -> Void {
        constrain(tableView){ tableView in
            tableView.width == self.view.frame.width * 0.95
            tableView.bottom == (tableView.superview?.bottom)!
            tableView.centerX == (tableView.superview?.centerX)!
            tableView.height == self.view.frame.height - (navigationController?.navigationBar.frame.maxY)!
        }
    }
    
    @objc private func dropDownShow() {
        dropDown.show()
    }
}


extension GradesController: UITableViewDelegate , UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return grades.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = GradesCell.init(style: .default, reuseIdentifier: CellIdentifiers.gradesCell, height: 20)
        if indexPath.row == 0{
            cell.backgroundColor = UIColor.bgColor
            cell.color = UIColor.titleTable
            cell.font_label = UIFont.init(name: "Arial", size: 10)
        }
        else{
            cell.backgroundColor = cell_color[indexPath.row % 2]
            cell.color = UIColor.white
            cell.font_label = UIFont.init(name: "Arial", size: 12)
        }
        cell.data = grades[indexPath.row]
        cell.layer.cornerRadius = 5
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 20
        }
        return 70
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
}


