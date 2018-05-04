//
//  Next.swift
//  Task8
//
//  Created by I on 01.04.2018.
//  Copyright © 2018 Shyngys. All rights reserved.
//

import UIKit

class Next: UIViewController {
    lazy var table:UITableView = {
        let table = UITableView(frame: UIScreen.main.bounds, style: UITableViewStyle.plain)
        table.delegate = self
        table.dataSource = self
        table.showsVerticalScrollIndicator = false
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.showsVerticalScrollIndicator = false
        table.separatorStyle = .none
        table.isScrollEnabled = false
        return table
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(table)
        self.view.backgroundColor = UIColor.blue
    }
}
extension Next:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Shyngys"
        return cell
    }
    
    
}

extension Next:UITableViewDelegate{
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.layer.transform = CATransform3DMakeScale(0.1, 1, 0.1)
        UIView.animate(withDuration: 1) {
            cell.layer.transform = CATransform3DMakeScale(1, 1, 1)
        }
    }
}
