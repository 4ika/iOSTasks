//
//  MessageController.swift
//  CourseGrades
//
//  Created by I on 08.04.2018.
//  Copyright © 2018 Shyngys. All rights reserved.
//

import UIKit
import Cartography

class MessageController: UIViewController {
    lazy var color_cell:Dictionary<Int,UIColor> = [
        0:UIColor.evenCell,
        1:UIColor.oddCell
    ]
    
    lazy var tableView:UITableView = {
        let table = UITableView.init(frame: CGRect.init(), style: UITableViewStyle.plain)
        table.register(MessageCell.self, forCellReuseIdentifier: CellIdentifiers.messageCell)
        table.separatorStyle = UITableViewCellSeparatorStyle.none
        table.backgroundColor = UIColor.bgColor
        table.allowsSelection = false
        table.showsVerticalScrollIndicator = false
        table.bounces = false
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
        self.view.addSubview(tableView)
    }
    
    func setupNavigationBar() -> Void {
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor.bgColor
    }
    
    func setupConstrains() -> Void {
        constrain(tableView){ tableView  in
            tableView.width == self.view.frame.width
            tableView.bottom == (tableView.superview?.bottom)!
            tableView.centerX == (tableView.superview?.centerX)!
            tableView.top == (tableView.superview?.top)! + (navigationController?.navigationBar.bounds.maxY)!
        }
    }

}
extension MessageController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MessageCell.init(style: .default, reuseIdentifier: CellIdentifiers.messageCell, size:CGSize.init(width: UIScreen.main.bounds.width, height: self.view.bounds.height/8))
        cell.backgroundColor = UIColor.bgColor
        cell.view.backgroundColor = color_cell[indexPath.row % 2]
        if indexPath.row % 2 == 0{
            cell.ball.backgroundColor = UIColor.being
        }
        else{
            cell.ball.backgroundColor = UIColor.clear
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.bounds.height/8
    }
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete{
//            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.right)
//            tableView.reloadData()
//        }
//    }

}
