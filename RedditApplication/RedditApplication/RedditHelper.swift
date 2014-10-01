//
//  RedditHelper.swift
//  RedditApplication
//
//  Created by Rajul Arora on 2014-09-24.
//  Copyright (c) 2014 Rajul Arora. All rights reserved.
//

import Foundation

class RedditUser{
    var username:NSString = NSString()
    var isLoggedIn:Bool = false
    
    class var sharedInstance:RedditUser{
        struct Static{
            static let instance: RedditUser = RedditUser()
        }
        return Static.instance
    }
    
    init() {
        println("Singleton Initiated")
    }
    
    class func login(){
        if(RedditUser.sharedInstance.username.length > 0 && !RedditUser.sharedInstance.isLoggedIn){
            println("Logging in user")
        }
    }
}