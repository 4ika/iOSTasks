//
//  ViewController.swift
//  Practice
//
//  Created by I on 15.03.2018.
//  Copyright © 2018 Shyngys. All rights reserved.
//

import UIKit
import Cartography
import Alamofire
protocol Delegate {
    var weathers:[Weather]{get set}
}
class ViewController: UIViewController,Delegate {
    
    var weathers:[Weather] = []
    
    lazy var textfield:UITextField = UITextField().getTextField(placeholder: "")
    
    lazy var info:UILabel = {
        let label = UILabel.init()
        label.textColor = UIColor.gray
        label.text = ""
        label.textAlignment = .left
        label.isUserInteractionEnabled = true
        label.font = UIFont.init(name: "Arial", size: 20)
        label.numberOfLines = 6
        return label
    }()
    
    lazy var submit:UIButton = {
        let button = UIButton().getButton(title: "Submit", fontName: "Arial", fontSize: self.view.bounds.width*0.045, bgColor: UIColor.init(red: 172/255, green: 249/255, blue: 196/255, alpha: 1))
        button.addTarget(self, action: #selector(submitAction), for: UIControlEvents.touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstrains()
    }
    
    func setupView() -> Void {
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .organize, target: self, action: #selector(barButtonAction))
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(textfield)
        self.view.addSubview(submit)
        self.view.addSubview(info)
    }
    
    func setupConstrains() -> Void {
        constrain(textfield,submit,info){ textfield,submit,info in
            textfield.width == self.view.bounds.width - 60
            textfield.height == 50
            textfield.centerX == (textfield.superview?.centerX)!
            textfield.top == (textfield.superview?.top)! + self.view.bounds.height/4
            
            submit.width == 200
            submit.height == 40
            submit.centerX == textfield.centerX
            submit.top == textfield.bottom + 30
            
            info.width == self.view.bounds.width
            info.height == self.view.bounds.height/2
            info.left == (info.superview?.left)! + 30
            info.top == (info.superview?.top)! + self.view.bounds.height/2.4
            
        }
    }
    
    @objc func submitAction() -> Void {
        let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(textfield.text!)&appid=a644894d0dc1f4eb3f946b445c31dd30")
        if(textfield.text != "" && textfield.text != nil){
            Alamofire.request(url!).responseJSON { (responce) in
                if let result = responce.result.value as? NSDictionary{
                    print(result)
                    if result.count != 2{
                        let weather =  Weather.init(
                            name: self.textfield.text!,
                            temp: String(describing: (result["main"] as! NSDictionary)["temp"]!),
                            humidity: String(describing: (result["main"] as! NSDictionary)["humidity"]!), windSpeed: String(describing: (result["wind"] as! NSDictionary)["speed"]!), sunrise: String(describing: (result["sys"] as! NSDictionary)["sunrise"]!), sunset: String(describing: (result["sys"] as! NSDictionary)["sunset"]!)
                        )
                        self.weathers.append(weather)
                        self.info.text = "Temperature: \((weather.temp!))\nHumidity: \((weather.humidity!))\nWindSpeed: \((weather.windSpeed!))\nSunrise: \((weather.sunrise!))\nSunset: \((weather.sunset!))"
                    }
                    else{
                        self.error()
                        self.info.text = ""
                    }
                    
                }
                else{
                    self.error()
                    self.info.text = ""
                }
            }
        }
        else{
            self.error()
            self.info.text = ""
            
        }
    }
    
    @objc func barButtonAction() -> Void {
        let vc  = List.init(d: self)
        navigationController?.pushViewController(vc, animated: true)
    }
    func error() -> Void {
        let alert = UIAlertController(title: "Error", message: "Try again..", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Ok", style: .default) { (_) -> Void in
            print("OK")
        }
        
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
}

