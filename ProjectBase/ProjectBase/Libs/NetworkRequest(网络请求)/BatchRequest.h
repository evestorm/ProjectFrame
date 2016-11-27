//
//  BatchRequest.h
//  Network
//
//  Created by MyMac on 16/1/5.
//  Copyright © 2016年 MyMac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseRequest.h"


@class BatchRequest;
@protocol BatchRequestDelegate <NSObject>

- (void)batchRequestFinished:(BatchRequest *)batchRequest;

- (void)batchRequestFailed:(BatchRequest *)batchRequest;

@end

@interface BatchRequest : NSObject

@property (strong, nonatomic, readonly) NSArray *requestArray;

@property (nonatomic, copy) void (^successCompletionBlock)(BatchRequest *);

@property (nonatomic, copy) void (^failureCompletionBlock)(BatchRequest *);

@property (nonatomic, weak) id<BatchRequestDelegate> delegate;

@property (nonatomic, strong) NSMutableArray *requestAccessories;

- (id)initWithRequestArray:(NSArray *)requestArray;

- (void)start;

- (void)stop;


/**
 *  block回调方式
 *
 *  @param success 成功回调
 *  @param failure 失败回调
 */
- (void)startWithBlockSuccess:(void (^)(id request))success failure:(void (^)(id request))failure;



- (void)clearCompletionBlock;

- (void)addAccessory:(id<RequestAccessory>)accessory;

@end

@interface BatchRequest (RequestAccessory)

- (void)toggleAccessoriesWillStartCallBack;
- (void)toggleAccessoriesWillStopCallBack;
- (void)toggleAccessoriesDidStopCallBack;

@end
