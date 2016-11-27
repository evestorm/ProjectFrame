//
//  BatchRequestAgent.h
//  Network
//
//  Created by MyMac on 16/1/5.
//  Copyright © 2016年 MyMac. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BatchRequest;

@interface BatchRequestAgent : NSObject

+ (BatchRequestAgent *)sharedInstance;

- (void)addBatchRequest:(BatchRequest *)request;

- (void)removeBatchRequest:(BatchRequest *)request;

@end
