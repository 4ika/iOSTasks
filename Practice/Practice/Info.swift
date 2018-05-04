//
//  Info.swift
//  Practice
//
//  Created by I on 15.03.2018.
//  Copyright © 2018 Shyngys. All rights reserved.
//

import UIKit
import Cartography
class Info: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var weather:Weather?
    var info:Dictionary<Int,String> = [:]
    var header:[String] = ["Temperature","Humidity","Wind Speed","Sunrice","Sunset"]
    
    lazy var dismiss:UIButton = {
        let button = UIButton().getButton(title: "Submit", fontName: "Arial", fontSize: self.view.bounds.width*0.045, bgColor: UIColor.init(red: 172/255, green: 249/255, blue: 196/255, alpha: 1))
        button.addTarget(self, action: #selector(dismissAction), for: UIControlEvents.touchUpInside)
        return button
    }()
    lazy var table:UITableView = {
        let tableRect = UIScreen.main.bounds
        let table = UITableView(frame: tableRect, style: UITableViewStyle.plain)
        table.delegate = self as UITableViewDelegate
        table.dataSource = self as UITableViewDataSource
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.rowHeight = table.bounds.width * 0.18
        table.showsVerticalScrollIndicator = false
        table.isScrollEnabled = false
        table.separatorStyle = .none
        table.allowsSelection = false
        table.backgroundColor = UIColor.white
        return table
    }()
    
    init(weather:Weather) {
        super.init(nibName: nil, bundle: nil)
        self.weather = weather
        info[0] = (weather.temp)!
        info[1] = (weather.humidity)!
        info[2] = (weather.windSpeed)!
        info[3] = (weather.sunrise)!
        info[4] = (weather.sunset)!
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(table)
        self.view.addSubview(dismiss)
        setupConstrains()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .value1, reuseIdentifier: "cell")
        cell.textLabel?.text = header[indexPath.row]
        cell.detailTextLabel?.text = (info[indexPath.row])!
        return cell
    }
    
    @objc func dismissAction() -> Void {
        navigationController?.popViewController(animated: true)
    }
    
    func setupConstrains() -> Void {
        constrain(dismiss,table){ dismiss,table in
            dismiss.centerX == (dismiss.superview?.centerX)!
            dismiss.width == 150
            dismiss.height == 35
            dismiss.bottom == (dismiss.superview?.bottom)! - 40
            
            table.height == self.view.bounds.height/1.5
            table.width == self.view.bounds.width
        }
    }
    
}
