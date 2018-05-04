//
//  List.swift
//  Practice
//
//  Created by I on 15.03.2018.
//  Copyright © 2018 Shyngys. All rights reserved.
//

import UIKit

class List: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var w:Delegate?
    
    lazy var table:UITableView = {
        let tableRect = UIScreen.main.bounds
        let table = UITableView(frame: tableRect, style: UITableViewStyle.plain)
        table.delegate = self as UITableViewDelegate
        table.dataSource = self as UITableViewDataSource
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.rowHeight = table.bounds.width * 0.18
        table.showsVerticalScrollIndicator = false
        table.backgroundColor = UIColor.white
        return table
    }()
    
    init(d:Delegate) {
        self.w = d
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(table)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (w?.weathers.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
        let weather = w?.weathers[indexPath.row]
        cell.textLabel?.text = weather?.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc  = Info.init(weather:(w?.weathers[indexPath.row])!)
        navigationController?.pushViewController(vc, animated:true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
           w?.weathers.remove(at: indexPath.row)
           tableView.reloadData()
        }
    }
   
}
