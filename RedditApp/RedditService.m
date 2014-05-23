//
//  RedditService.m
//  RedditApp
//
//  Created by Rajul Arora on 2014-05-21.
//  Copyright (c) 2014 Rajul Arora. All rights reserved.
//

#import "RedditService.h"

@implementation RedditService

-(void)setResultHandlerBlock:(void(^)(NSDictionary *dictionary))handlerBlock{
    resultHandlerBlock = handlerBlock;
}

-(void)setErrorHandlerBlock:(void(^)(NSError *error))errorBlock{
    errorHandlerBlock = errorBlock;
}

-(void)GETRequestwith:(NSDictionary *)params and:(NSString *)urlString{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
    ^(void){
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            resultHandlerBlock(responseObject);
        }
        failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            errorHandlerBlock(error);
        }];
                       
    });
}

@end
