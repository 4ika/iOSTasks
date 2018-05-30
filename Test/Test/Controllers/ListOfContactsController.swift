//
//  ViewController.swift
//  Test
//
//  Created by I on 29.05.2018.
//  Copyright © 2018 Shyngys. All rights reserved.
//

import UIKit
import Cartography
import Kingfisher

class ListOfContactsController : UIViewController {

    private let width = UIDevice.current.localizedModel == "iPhone" ? UIScreen.main.bounds.width : 600
    
    private let _width = UIScreen.main.bounds.width
    
    private var topMargin : CGFloat = 0.0
    
    private var contacts : [Contact] = []
    
    private var filteredContacts : [Contact] = []
    
    private var allowsAnimation : Bool = true
    
    private var searchActive : Bool = false
    
    lazy var tableView : UITableView = {
        let table = UITableView.init(frame: CGRect.zero)
        table.register(ListOfContactsCell.self, forCellReuseIdentifier: CellIdentifier.listOfContacts)
        table.separatorStyle = .singleLine
        table.separatorInset = UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 10)
        table.showsVerticalScrollIndicator = false
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        return table
    }()
    
    lazy var searchBar : UISearchBar = {
        let searcher = UISearchBar.init()
        searcher.searchBarStyle = UISearchBarStyle.minimal
        searcher.placeholder = " Search..."
        searcher.sizeToFit()
        searcher.isTranslucent = false
        searcher.delegate = self
        return searcher
    }()
    
    lazy var segmentControl : UISegmentedControl = {
        let items : [String] = ["All", "Female", "Male"]
        let filter = UISegmentedControl.init(items: items)
        filter.selectedSegmentIndex = 0
        filter.addTarget(self, action: #selector(changeStateOfFilter), for: UIControlEvents.allEvents)
        return filter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        setupNavigationController()
        setupViews()
        setupVariables()
        setupConstrains()
        downloadContacts()
    }    
    
    func setupBackground() -> Void {
        self.view.backgroundColor = .white
    }
    
    func setupVariables() -> Void {
        topMargin = (self.navigationController?.navigationBar.bounds.maxY)! + CGFloat(UIApplication.shared.statusBarFrame.height)
    }
    
    func setupNavigationController() -> Void {
        self.title = "Contacts"
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .search, target: self, action: #selector(startSearchByFullName))
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "filter"), style: UIBarButtonItemStyle.done, target: self, action: #selector(startFilterByGender))
    }
    
    
    
    func setupViews() -> Void {
        self.view.addSubview(segmentControl)
        self.view.addSubview(searchBar)
        self.view.addSubview(tableView)
    }
    
    func setupConstrains() -> Void {
        constrain(tableView, searchBar, segmentControl){ tableView, searchBar, segmentControl in
            
            searchBar.width == width
            searchBar.height == width * 0.095
            searchBar.centerX == (searchBar.superview?.centerX)! - _width
            searchBar.top == (searchBar.superview?.top)! + (topMargin + width * 0.0175)
            
            segmentControl.width == searchBar.width * 0.95
            segmentControl.height == searchBar.height
            segmentControl.centerX == (segmentControl.superview?.centerX)!
            segmentControl.top == searchBar.top
            
            tableView.width == width
            tableView.height == (tableView.superview?.height)!
            tableView.centerX == (tableView.superview?.centerX)!
            tableView.top == (tableView.superview?.top)! + (topMargin + width * 0.095 + 2 + width * 0.0175)
        }
    }
    
    func setupContacts() -> Void {
        contacts = APIRequest.shared.contacts
        filteredContacts = contacts
        tableView.reloadData()
    }
    
    func downloadContacts() -> Void {
        APIRequest.shared.parseJSON {
            self.setupContacts()
        }
    }
    
    func filterByGender(index:Int) -> Void {
        switch index {
            case 0 :
                filteredContacts = contacts
            case 1 :
                filteredContacts = contacts.filter({ (contact) -> Bool in
                    return contact.gender! == "Female"
                })
            default:
                filteredContacts = contacts.filter({ (contact) -> Bool in
                    return contact.gender! == "Male"
                })
        }
    }
    
    @objc func startSearchByFullName() -> Void {
        if allowsAnimation {
            UIView.animate(withDuration: 0.3, animations: {
                self.segmentControl.frame.origin.x += self._width
            }, completion: { (_) in
                UIView.animate(withDuration: 0.3, animations: {
                    self.searchBar.frame.origin.x +=  self._width
                })
            })
            allowsAnimation = !allowsAnimation
        }
    }
    
    @objc func startFilterByGender() -> Void {
        if !allowsAnimation {
            UIView.animate(withDuration: 0.3, animations: {
                self.searchBar.frame.origin.x -= self._width
            }, completion: { (_) in
                UIView.animate(withDuration: 0.3, animations: {
                    self.segmentControl.frame.origin.x -=  self._width
                })
            })
            allowsAnimation = !allowsAnimation
            filterByGender(index: segmentControl.selectedSegmentIndex)
            tableView.reloadData()
            self.view.endEditing(true)
        }
        
    }
    
    @objc func changeStateOfFilter() -> Void {
        filterByGender(index: segmentControl.selectedSegmentIndex)
        tableView.reloadData()
    }
    
}

extension ListOfContactsController : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredContacts = filteredContacts.filter({ (contact) -> Bool in
            guard let text = searchBar.text else {return false}
            if !text.isEmpty {
                return "\(contact.name!) \(contact.surname!)".contains(text)
            }
            return true
        })
        
        if(filteredContacts.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        self.tableView.reloadData()
    }

    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }
    
    private func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }

    
}

extension ListOfContactsController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return width * 0.245
    }
    
}

extension ListOfContactsController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive || allowsAnimation) {
            return filteredContacts.count
        }
        
        self.view.endEditing(true)
        filteredContacts = contacts
        return filteredContacts.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.listOfContacts) as! ListOfContactsCell
        let contact = filteredContacts[indexPath.row]
        
        cell.accessoryType = .disclosureIndicator
        cell.fullName.text = "\(contact.name!) \(contact.surname!)"
        cell.gender.text = contact.gender!
        cell.photo.kf.setImage(with: URL.init(string: contact.photo!))

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        allowsAnimation = true
        self.view.endEditing(true)
        let vc = MoreAboutContactController()
        vc.contact = filteredContacts[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}


