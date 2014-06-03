//
//  MainViewController.h
//  RedditApp
//
//  Created by Rajul Arora on 2014-05-22.
//  Copyright (c) 2014 Rajul Arora. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    NSMutableArray *tableData;
    NSMutableArray *imageURLs;
    NSMutableArray *domains;
    NSString *before;
    NSString *after;
}

@end
