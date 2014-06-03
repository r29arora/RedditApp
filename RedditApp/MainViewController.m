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
#import <POP/POP.h>

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        tableData = [[NSMutableArray alloc] init];
        imageURLs = [[NSMutableArray alloc] init];
        domains = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
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
        NSDictionary *childrenDict = [dataDict objectForKey:@"children"];
        
        for (NSDictionary *dict in childrenDict){
            [tableData addObject:[[dict objectForKey:@"data"] objectForKey:@"title"]];
            [imageURLs addObject:[[dict objectForKey:@"data"] objectForKey:@"url"]];
            [domains addObject:[[dict objectForKey:@"data"] objectForKey:@"domain"]];
            [contentTableView reloadData];
        }
        NSLog(@"%@",imageURLs);
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
        cell.textLabel.numberOfLines = 2;
        cell.detailTextLabel.numberOfLines = 1;
        cell.textLabel.font = [self fontForCell];
        cell.detailTextLabel.font = [self fontForCell];
        
    }
    
    cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [domains objectAtIndex:indexPath.row];
    cell.imageView.autoresizesSubviews = YES;
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {

    
    //1. Setup the CATransform3D structure
    CATransform3D rotation;
    rotation = CATransform3DMakeRotation( (90.0*M_PI)/180, 0.0, 0.7, 0.4);
    rotation.m34 = 1.0/ -600;
    
    
    //2. Define the initial state (Before the animation)
    cell.layer.shadowColor = [[UIColor blackColor]CGColor];
    cell.layer.shadowOffset = CGSizeMake(10, 10);
    cell.alpha = 0;
    
    cell.layer.transform = rotation;
    cell.layer.anchorPoint = CGPointMake(0, 0.5);
    
    
    //3. Define the final state (After the animation) and commit the animation
    [UIView beginAnimations:@"rotation" context:NULL];
    [UIView setAnimationDuration:0.8];
    cell.layer.transform = CATransform3DIdentity;
    cell.alpha = 1;
    cell.layer.shadowOffset = CGSizeMake(0, 0);
    [UIView commitAnimations];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
