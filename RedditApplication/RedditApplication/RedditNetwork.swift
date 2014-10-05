//
//  RedditNetwork.swift
//  RedditApplication
//
//  Created by Rajul Arora on 2014-10-02.
//  Copyright (c) 2014 Rajul Arora. All rights reserved.
//

import Foundation

class RedditNetwork {
    
    class func loadFrontPage(completion:RKListingCompletionBlock, pagination: RKPagination){
        RKClient.sharedClient().frontPageLinksWithPagination(pagination, completion: completion)
    }
    
    class func login(username:NSString, password:NSString, completion:RKCompletionBlock){
        RKClient.sharedClient().signInWithUsername(username, password: password, completion: completion)
    }
    
}