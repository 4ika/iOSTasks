//
//  Tweet.swift
//  SimpleFirebaseApp
//
//  Created by Darkhan on 03.04.18.
//  Copyright © 2018 SDU. All rights reserved.
//

import Foundation
import FirebaseDatabase
import Firebase


class Tweet{
    private var content: String?
    private var user_email: String?
    private var date: String?
//    private var fullName: String?
    
    init(content: String,user_email: String,date:String) {
        self.content = content
        self.user_email = user_email
        self.date = date
//        self.fullName = fullName
    }
    
    init(snapshot: DataSnapshot) {
        let tweet = snapshot.value as! NSDictionary
        content = tweet.value(forKey: "content") as? String
        user_email = tweet.value(forKey: "user_email") as? String
        date = tweet.value(forKey: "date") as? String
//        fullName = tweet.value(forKey: "fullName") as? String
    }
    var Content: String?{
        get{
            return content
        }
    }
    var User_email: String?{
        get{
            return user_email
        }
    }
    var Date:String?{
        get{
            return date
        }
    }
    
//    var FullName:String?{
//        get{
//            return fullName
//        }
//    }
    func toJSONFormat()-> Any{
        return ["content": content,
                "user_email": user_email,"date":date]
    }
    
}
