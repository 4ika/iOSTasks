//
//  APIRequest.swift
//  Test
//
//  Created by I on 29.05.2018.
//  Copyright © 2018 Shyngys. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class APIRequest {
    
    static let shared = APIRequest()
    
    var contacts : [Contact] = []
    
    private init(){}
    
    func parseJSON(completion: @escaping () -> Void) -> Void {
        
        let url = URL.init(string: "http://www.mocky.io/v2/5a488f243000004c15c3c57e")!
        
        Alamofire.request(url).responseJSON { (response) in
            
            switch response.result {
                
                case .success(let responseString):
                    self.contacts = Mapper<Contact>().mapArray(JSONArray: responseString as! [[String : Any]])
                    completion()
                
                case .failure(let error):
                    print(error)
                
            }
        }
        
    }
}
