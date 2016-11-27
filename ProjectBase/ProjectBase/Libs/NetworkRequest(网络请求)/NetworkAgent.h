//
//  NetworkAgent.h
//  Network
//
//  Created by MyMac on 16/1/5.
//  Copyright © 2016年 MyMac. All rights reserved.
//

#import <Foundation/Foundation.h>



@class BaseRequest;
@interface NetworkAgent : NSObject

+ (NetworkAgent *)sharedInstance;
- (void)addRequest:(BaseRequest *)request;
- (void)cancelRequest:(BaseRequest *)request;

@end
