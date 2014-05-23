//
//  RedditService.h
//  RedditApp
//
//  Created by Rajul Arora on 2014-05-21.
//  Copyright (c) 2014 Rajul Arora. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@interface RedditService : NSObject{
    void(^resultHandlerBlock)(NSDictionary *results);
    void(^errorHandlerBlock)(NSError *error);
}

-(void)setResultHandlerBlock:(void(^)(NSDictionary *dictionary))handlerBlock;
-(void)setErrorHandlerBlock:(void(^)(NSError *error))errorBlock;
-(void)GETRequestwith:(NSDictionary *)params and:(NSString *)urlString;
@end
