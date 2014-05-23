//
//  MainViewController.m
//  RedditApp
//
//  Created by Rajul Arora on 2014-05-22.
//  Copyright (c) 2014 Rajul Arora. All rights reserved.
//

#import "MainViewController.h"
#import "RedditService.h"
#import <CSAnimationView.h>
#import <MZFormSheetController.h>
#import <FlatUIKit.h>

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        tableData = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    CGRect screenRect =[[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    CGRect tableViewFrame = CGRectMake(0, 0, screenWidth, screenHeight);
    UITableView *contentTableView = [[UITableView alloc] initWithFrame:tableViewFrame];
    contentTableView.backgroundColor = [UIColor whiteColor];
    //[self.view addSubview:contentTableView];
    [contentTableView setDataSource:self];
    [contentTableView setDelegate:self];
    [contentTableView setAllowsSelection:YES];
    [self.view addSubview:contentTableView];
    [self.navigationController.navigationBar configureFlatNavigationBarWithColor:[UIColor midnightBlueColor]];
    RedditService *redditNetwork = [[RedditService alloc] init];
    
    [redditNetwork setResultHandlerBlock:^(NSDictionary *dictionary) {
        NSDictionary *dataDict = [dictionary objectForKey:@"data"];
        NSDictionary *chilrenDict = [dataDict objectForKey:@"children"];
        for (NSDictionary *dict in chilrenDict){
            [tableData addObject:[[dict objectForKey:@"data"] objectForKey:@"title"]];
            [contentTableView reloadData];
        }
    }];
    [redditNetwork setErrorHandlerBlock:^(NSError *error){
        NSLog(@"Error: %@", error);
        FUIAlertView *alertView = [[FUIAlertView alloc] initWithTitle:@"Error Retrieving Data"
                                                            message:[error localizedDescription]
                                                            delegate:nil
                                                    cancelButtonTitle:@"Ok"
                                                    otherButtonTitles:nil];
        alertView.titleLabel.textColor = [UIColor cloudsColor];
        alertView.titleLabel.font = [UIFont boldFlatFontOfSize:16];
        alertView.messageLabel.textColor = [UIColor cloudsColor];
        alertView.messageLabel.font = [UIFont flatFontOfSize:14];
        alertView.backgroundOverlay.backgroundColor = [[UIColor cloudsColor] colorWithAlphaComponent:0.8];
        alertView.alertContainer.backgroundColor = [UIColor midnightBlueColor];
        alertView.defaultButtonColor = [UIColor cloudsColor];
        alertView.defaultButtonShadowColor = [UIColor asbestosColor];
        alertView.defaultButtonFont = [UIFont boldFlatFontOfSize:16];
        alertView.defaultButtonTitleColor = [UIColor asbestosColor];
        [alertView show];
            
    }];
    [redditNetwork GETRequestwith:nil and:@"http://reddit.com/hot.json"];
}  


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UIFont *)fontForCell
{
    return [UIFont systemFontOfSize:11];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Index Path: %@",indexPath);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        cell.textLabel.numberOfLines = 4;
        cell.textLabel.font = [self fontForCell];
    }
    cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
