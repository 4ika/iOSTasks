//
//  ViewController.swift
//  Task6
//
//  Created by I on 13.03.2018.
//  Copyright © 2018 Shyngys. All rights reserved.
//

import UIKit
import MapKit
import Cartography
import CoreData

protocol Delegate{
    var places:[NSManagedObject]{set get}
    var willRemoveIndex:Int{get set}
}

class ViewController: UIViewController,Delegate {
    
    var selectedCountry:NSManagedObject?{
        didSet{
            if let place = selectedCountry{
                zoomRegion(place)
                title = place.value(forKey: "city") as? String
            }
        }
    }
    
    var places:[NSManagedObject] = []
    
    var willRemoveIndex: Int = -1
    
    var controllerPlacesIndex:Int = 0
    
    let typesMK:Dictionary<Int,MKMapType> = [
        0:MKMapType.hybrid,
        1:MKMapType.standard,
        2:MKMapType.satellite
    ]
    
    let segment:UISegmentedControl = {
        let segment = UISegmentedControl.init()
        segment.backgroundColor = UIColor.white
        segment.insertSegment(withTitle: "Standart", at: 0, animated: true)
        segment.insertSegment(withTitle: "Hybrid", at: 1, animated: true)
        segment.insertSegment(withTitle: "Satellite", at: 2, animated: true)
        segment.selectedSegmentIndex = 0
        segment.isUserInteractionEnabled = true
        segment.translatesAutoresizingMaskIntoConstraints = false
        segment.addTarget(self, action: #selector(segmentAction), for: UIControlEvents.valueChanged)
        return segment
    }()
    
    let bottomView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.6)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        return view
    }()
    
    let map:MKMapView = {
        let map = MKMapView.init(frame: UIScreen.main.bounds)
        return map
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstrains()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
        setAllAnnotation()
        map.mapType = typesMK[segment.selectedSegmentIndex]!
        controllerPlacesIndex = 0
        zoomRegion(places[controllerPlacesIndex])
        title = places[controllerPlacesIndex].value(forKey: "city") as? String
    }
    
    func setupView() -> Void {
        
        self.view.backgroundColor = UIColor.red
        let rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .organize, target: self, action: #selector(toListPlaces))
        self.navigationItem.setRightBarButton(rightBarButtonItem, animated: true)
        
        let longPressed = UILongPressGestureRecognizer.init(target: self, action: #selector(long_pressed))
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(taptap))
        self.bottomView.addGestureRecognizer(tap)
        self.map.addGestureRecognizer(longPressed)
        
        self.view.addSubview(map)
        self.view.addSubview(bottomView)
        bottomView.addSubview(segment)
        
        
     
        
    }
    
    func setupConstrains() -> Void {
        constrain(bottomView,segment){view,segment in
            
            view.width == (view.superview?.width)!
            view.height == (view.superview?.width)!/4
            view.centerX == (view.superview?.centerX)!
            view.bottom == (view.superview?.bottom)!
            
            segment.centerX == (segment.superview?.centerX)!
            segment.centerY == (segment.superview?.centerY)!
        }
    }

    
    @objc func segmentAction(sender:UISegmentedControl) -> Void {
        map.mapType = typesMK[sender.selectedSegmentIndex]!
    }
    
    @objc func toListPlaces() -> Void {
        let vc = PlacesController.init(places: self)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func taptap(sender: UITapGestureRecognizer) -> Void {
        let left = self.view.bounds.width/2 - segment.bounds.width/2 - 5
        let right = self.view.bounds.width/2 + segment.bounds.width/2 + 5
        if right <= sender.location(in: bottomView).x{
            controllerPlacesIndex = min(controllerPlacesIndex+1,places.count-1)
            if (places.count != 0){
                zoomRegion(places[controllerPlacesIndex])
            }
        }
        else if left >= sender.location(in: bottomView).x{
            controllerPlacesIndex = max(controllerPlacesIndex-1,0)
            if (places.count != 0){
                zoomRegion(places[controllerPlacesIndex])
            }
        }
    }
    
    func zoomRegion(_ place:NSManagedObject) -> Void {
        let location = CLLocationCoordinate2D.init(latitude: (place.value(forKey: "x") as? Double)!, longitude: (place.value(forKey: "y") as? Double)!)
        let region = MKCoordinateRegionMakeWithDistance(location, 1000, 1000)
        self.map.setRegion(region, animated: true)
    }
    
    @objc func long_pressed(sender:UILongPressGestureRecognizer) -> Void {
        
        let location = map.convert(sender.location(in: map), toCoordinateFrom: self.view)
        
        
        if(getBoolean(latitude: CGFloat(location.latitude), longitude: CGFloat(location.longitude))){
            
            let alert = UIAlertController(title: "Country", message: "City", preferredStyle: .alert)
            
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
                    let region = MKCoordinateRegionMakeWithDistance(location, 1000, 1000)
                    
                    self.map.setRegion(region, animated: true)
                    
                    self.addAnnotation(title: country!, subtitle: city!, location: location)
                    
                    self.saveData(country: country!, city: city!, x: location.latitude, y: location.longitude)
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
        else{
            print("Shyngys")
        }
    }
    func saveData(country:String,city:String,x:Double,y:Double) -> Void {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let context = appDelegate?.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Entity", in: context!)
        let item = NSManagedObject.init(entity: entity!, insertInto: context)
        item.setValue(x, forKey: "x")
        item.setValue(y, forKey: "y")
        item.setValue(country, forKey: "country")
        item.setValue(city, forKey: "city")
        
        do{
            try context?.save()
            places.append(item)
        }
        catch{
            print("error")
        }
    }
    
    func addAnnotation(title:String,subtitle:String,location:CLLocationCoordinate2D) -> Void {
        let pin = MKPointAnnotation.init()
        pin.title = title
        pin.subtitle = subtitle
        pin.coordinate = location
        self.map.addAnnotation(pin)
    }
    
    func setAllAnnotation() -> Void {
        for i in map.annotations{
            map.removeAnnotation(i)
        }
        for i in places{
            let location = CLLocationCoordinate2D.init(latitude: (i.value(forKey: "x") as? Double)!, longitude: (i.value(forKey: "y") as? Double)!)
            addAnnotation(title: (i.value(forKey: "country") as? String)! , subtitle: (i.value(forKey: "city") as? String)!, location: location)
        }
    }
    
    func getData() -> Void {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let context = appDelegate?.persistentContainer.viewContext
        let fetch = NSFetchRequest<NSFetchRequestResult>.init(entityName: "Entity")
        
        do{
            let result = try context?.fetch(fetch) as? [NSManagedObject]
            places = result!
        }
        catch{return}
    }
    
    func getBoolean(latitude: CGFloat,longitude:CGFloat) -> Bool {
        for l in places{
            if l.value(forKey: "x") as? CGFloat == latitude && l.value(forKey: "y") as? CGFloat == longitude{
                return true
            }
        }
        return false
    }
}

