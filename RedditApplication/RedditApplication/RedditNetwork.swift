//
//  RedditNetwork.swift
//  RedditApplication
//
//  Created by Rajul Arora on 2014-10-02.
//  Copyright (c) 2014 Rajul Arora. All rights reserved.
//

import Foundation


class RedditNetwork {

    class func loadFrontPage(){
        let manager:AFHTTPRequestOperationManager = AFHTTPRequestOperationManager(baseURL: NSURL(string: "http://reddit.com"))
        manager.GET(".json", parameters: nil, success: { (operation:AFHTTPRequestOperation!, responseObject:AnyObject!) -> Void in
            println("Success JSON: \(responseObject.description)")
            
        }) { (operation:AFHTTPRequestOperation!, error:NSError!) -> Void in
            println("error")
        }
    }
    
    class func login(username:NSString, password:NSString, completion:RKCompletionBlock)
    {
        RKClient.sharedClient().signInWithUsername(username, password: password, completion: completion)
    }
    
}