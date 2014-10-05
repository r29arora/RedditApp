//
//  ContentViewController.swift
//  RedditApplication
//
//  Created by Rajul Arora on 2014-10-01.
//  Copyright (c) 2014 Rajul Arora. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {

    @IBOutlet weak var bottomBar: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var pagination:RKPagination = RKPagination()
    var isLoadingNewLinks:Bool = false
    var collection:NSMutableArray = NSMutableArray(capacity: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.bringSubviewToFront(self.bottomBar)
        self.navigationController?.navigationBarHidden = false
        self.navigationController?.navigationBar.translucent = true
        
        self.isLoadingNewLinks = true
        
        RedditNetwork.loadFrontPage({ (collection:[AnyObject]!, pagination:RKPagination!, error:NSError!) -> Void in
            
            self.collection.addObjectsFromArray(collection)
            self.pagination = pagination
            self.isLoadingNewLinks = false
            
        }, pagination: self.pagination)
        
    }
}
