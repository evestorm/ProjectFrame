//
//  BatchRequest.m
//  Network
//
//  Created by MyMac on 16/1/5.
//  Copyright © 2016年 MyMac. All rights reserved.
//

#import "BatchRequest.h"
#import "BaseRequest.h"
#import "BatchRequestAgent.h"

@interface BatchRequest () <RequestDelegate>

@property (nonatomic) NSInteger finishedCount;

@end

@implementation BatchRequest

- (id)initWithRequestArray:(NSArray *)requestArray {
    self = [super init];
    if (self) {
        _requestArray = [requestArray copy];
        _finishedCount = 0;
        for (BatchRequest * req in _requestArray) {
            if (![req isKindOfClass:[BaseRequest class]]) {
                NSLog(@"Error, request item must be LCBaseRequest instance.");
                return nil;
            }
        }
    }
    return self;
}

- (void)start{
    if (_finishedCount > 0) {
        NSLog(@"Error! Batch request has already started.");
        return;
    }
    [[BatchRequestAgent sharedInstance] addBatchRequest:self];
    [self toggleAccessoriesWillStartCallBack];
    for (BaseRequest * req in _requestArray) {
        req.delegate = self;
        [req start];
    }
}

- (void)stop{
    [self toggleAccessoriesWillStopCallBack];
    _delegate = nil;
    [self clearRequest];
    [self toggleAccessoriesDidStopCallBack];
    [[BatchRequestAgent sharedInstance] removeBatchRequest:self];
}

- (void)startWithBlockSuccess:(void (^)(id request))success failure:(void (^)(id request))failure{
    [self setCompletionBlockWithSuccess:success failure:failure];
    [self start];
}

- (void)setCompletionBlockWithSuccess:(void (^)(BatchRequest *batchRequest))success
                              failure:(void (^)(BatchRequest *batchRequest))failure {
    self.successCompletionBlock = success;
    self.failureCompletionBlock = failure;
}

- (void)clearCompletionBlock {
    // nil out to break the retain cycle.
    self.successCompletionBlock = nil;
    self.failureCompletionBlock = nil;
}


- (void)dealloc {
    [self clearRequest];
}

#pragma mark - Network Request Delegate

- (void)requestFinished:(BaseRequest *)request {
    _finishedCount++;
    if (_finishedCount >= _requestArray.count) {
        [self toggleAccessoriesWillStopCallBack];
        if ([_delegate respondsToSelector:@selector(batchRequestFinished:)]) {
            [_delegate batchRequestFinished:self];
        }
        if (_successCompletionBlock) {
            _successCompletionBlock(self);
        }
//        [self clearCompletionBlock];
        [self toggleAccessoriesDidStopCallBack];
    }
}

- (void)requestFailed:(BaseRequest *)request {
    [self toggleAccessoriesWillStopCallBack];
    // Stop
    for (BaseRequest *req in _requestArray) {
        [req stop];
    }
    // Callback
    if ([_delegate respondsToSelector:@selector(batchRequestFailed:)]) {
        [_delegate batchRequestFailed:self];
    }
    if (_failureCompletionBlock) {
        _failureCompletionBlock(self);
    }
    // Clear
    [self clearCompletionBlock];
    
    [self toggleAccessoriesDidStopCallBack];
    [[BatchRequestAgent sharedInstance] removeBatchRequest:self];
}

- (void)clearRequest {
    for (BaseRequest * req in _requestArray) {
        [req stop];
    }
    [self clearCompletionBlock];
}

#pragma mark - Request Accessoies

- (void)addAccessory:(id<RequestAccessory>)accessory {
    if (!self.requestAccessories) {
        self.requestAccessories = [NSMutableArray array];
    }
    [self.requestAccessories addObject:accessory];
}


@end


@implementation BatchRequest (RequestAccessory)

- (void)toggleAccessoriesWillStartCallBack {
    for (id<RequestAccessory> accessory in self.requestAccessories) {
        if ([accessory respondsToSelector:@selector(requestWillStart:)]) {
            [accessory requestWillStart:self];
        }
    }
}

- (void)toggleAccessoriesWillStopCallBack {
    for (id<RequestAccessory> accessory in self.requestAccessories) {
        if ([accessory respondsToSelector:@selector(requestWillStop:)]) {
            [accessory requestWillStop:self];
        }
    }
}

- (void)toggleAccessoriesDidStopCallBack {
    for (id<RequestAccessory> accessory in self.requestAccessories) {
        if ([accessory respondsToSelector:@selector(requestDidStop:)]) {
            [accessory requestDidStop:self];
        }
    }
}

@end
