//
//  PlacesController.swift
//  Task6
//
//  Created by I on 13.03.2018.
//  Copyright © 2018 Shyngys. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class PlacesController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var delegate:Delegate?
    
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
    
    init(places:Delegate) {
        super.init(nibName: nil, bundle: nil)
        self.delegate = places
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
        return delegate!.places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: "cell")
        let place = delegate?.places[indexPath.row]
        let longPress = UILongPressGestureRecognizer.init(target: self, action: #selector(long_pressed))
        longPress.name = "\(indexPath.row)"
        cell.textLabel?.text = place?.value(forKey: "country") as? String
        cell.backgroundColor = UIColor.white
        cell.detailTextLabel?.text = place?.value(forKey: "city") as? String
        cell.addGestureRecognizer(longPress)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let place = delegate?.places[indexPath.row]
        let vc = navigationController?.viewControllers.first! as? ViewController
        vc?.selectedCountry = place
        navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            if indexPath.row <= (delegate?.places.count)! - 1{
                let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
                let context = appDelegate.persistentContainer.viewContext
                context.delete((delegate?.places[indexPath.row])!)
                delegate?.places.remove(at: indexPath.row)
                do{
                    try context.save()
                }
                catch{
                    print("error")
                }
                table.reloadData()
            }
        }
    }
    
    @objc func long_pressed(sender:UILongPressGestureRecognizer) -> Void {
    
        let alert = UIAlertController(title: "Editing", message: "You can edit...", preferredStyle: .alert)
        
        alert.addTextField { (textField) -> Void in
            textField.placeholder = "Country"
        }
        
        alert.addTextField { (textField) -> Void in
            textField.placeholder = "City"
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (_) -> Void in
            print("Cancel")
        }
        let saveAction = UIAlertAction(title: "Save", style: .default) { (_) -> Void in
            
            let country = alert.textFields?[0].text!
            let city = alert.textFields?[1].text!
            
            if(country != "" && city != ""){
                let place = self.delegate?.places[Int(sender.name!)!]
                place?.setValue(country, forKey: "country")
                place?.setValue(city, forKey: "city")
                self.delegate?.places[Int(sender.name!)!] = place!
                self.table.reloadData()
            }
            else{
                let alert = UIAlertController(title: "Error", message: "Try again..", preferredStyle: .alert)
                
                let cancelAction = UIAlertAction(title: "Ok", style: .default) { (_) -> Void in
                    print("OK")
                }
                
                alert.addAction(cancelAction)
                
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        alert.addAction(cancelAction)
        alert.addAction(saveAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
}
