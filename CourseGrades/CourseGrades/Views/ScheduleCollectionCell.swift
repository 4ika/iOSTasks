//
//  ScheduleCollectionCell.swift
//  CourseGrades
//
//  Created by I on 08.04.2018.
//  Copyright © 2018 Shyngys. All rights reserved.
//

import UIKit
import Cartography

class ScheduleCollectionCell: UICollectionViewCell {
    
    lazy var color_cell:Dictionary<Int,UIColor> = [
        0:UIColor.evenCell,
        1:UIColor.oddCell
    ]
    
    lazy var headerView:UIView = {
        let view = UIView.init()
        view.backgroundColor = UIColor.bgColor
        return view
    }()
    
    lazy var being:UILabel = {
        let label = UILabel.init()
        label.text = "Being"
        label.font = UIFont.init(name: "Arial", size: 15)
        label.textColor = UIColor.white
        return label
    }()
    
    lazy var coming:UILabel = {
        let label = UILabel.init()
        label.text = "Coming"
        label.font = UIFont.init(name: "Arial", size: 15)
        label.textColor = UIColor.white
        return label
    }()
    
    lazy var ball_being:UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.frame.width/21, height: self.frame.width/21))
        view.backgroundColor = UIColor.being
        view.layer.cornerRadius = self.frame.width/42
        return view
    }()
    
    lazy var ball_coming:UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.frame.width/21, height: self.frame.width/21))
        view.backgroundColor = UIColor.coming
        view.layer.cornerRadius = self.frame.width/42
        return view
    }()
    
    lazy var tableView:UITableView = {
        let table = UITableView.init(frame: CGRect.init(), style: UITableViewStyle.plain)
        table.register(ScheduleCell.self, forCellReuseIdentifier: CellIdentifiers.scheduleCell)
        table.separatorStyle = UITableViewCellSeparatorStyle.none
        table.backgroundColor = UIColor.bgColor
        table.allowsSelection = false
        table.showsVerticalScrollIndicator = false
        table.bounces = false
        table.delegate = self
        table.dataSource = self
        return table
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstrains()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() -> Void {
        self.addSubview(tableView)
        headerView.addSubview(ball_being)
        headerView.addSubview(ball_coming)
        headerView.addSubview(coming)
        headerView.addSubview(being)
    }
    
    func setupConstrains() -> Void {
        
        constrain(tableView){ tableView  in
            tableView.width == self.frame.width
            tableView.bottom == (tableView.superview?.bottom)!
            tableView.centerX == (tableView.superview?.centerX)!
            tableView.top == (tableView.superview?.top)!
        }
    
        constrain(being,coming,ball_coming,ball_being){come,be,ball_come,ball_be in
            
            ball_come.width == self.frame.width/21
            ball_come.height == self.frame.width/21
            ball_come.centerY == (ball_come.superview?.centerY)!
            ball_come.left == (ball_come.superview?.left)! + self.frame.width/8
            
            come.width == self.frame.width/6.9
            come.height == self.frame.width/20.7
            come.centerY == ball_come.centerY
            come.left == ball_come.right + self.frame.width/21
            
            ball_be.width == ball_come.width
            ball_be.height == ball_come.height
            ball_be.centerY == ball_come.centerY
            ball_be.left == come.right + self.frame.width/4.14
            
            be.width == come.width
            be.height == come.height
            be.centerY == come.centerY
            be.left == ball_be.right + self.frame.width/20.7
        }
    }
}
extension ScheduleCollectionCell: UITableViewDataSource,UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ScheduleCell.init(style: .default, reuseIdentifier: CellIdentifiers.scheduleCell, size:CGSize.init(width: UIScreen.main.bounds.width, height: self.bounds.height/8))
        cell.backgroundColor = UIColor.bgColor
        cell.view.backgroundColor = color_cell[indexPath.row % 2]
        cell.layer.cornerRadius = 10
        if indexPath.row % 2 == 0{
            cell.ball.backgroundColor = UIColor.being
        }
        else{
            cell.ball.backgroundColor = UIColor.coming
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.bounds.height/8
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.frame.width/12
    }
}
