//
//  ContentViewController.swift
//  RedditApplication
//
//  Created by Rajul Arora on 2014-10-01.
//  Copyright (c) 2014 Rajul Arora. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        RedditNetwork.loadFrontPage ({ (error:NSError?) -> Void in
            if (error != nil){
                println("Loaded Front Page")
            }
        })
    }
}
