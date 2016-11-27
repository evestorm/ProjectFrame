//
//  BatchRequestAgent.m
//  Network
//
//  Created by MyMac on 16/1/5.
//  Copyright © 2016年 MyMac. All rights reserved.
//

#import "BatchRequestAgent.h"

@interface BatchRequestAgent ()

@property (strong, nonatomic) NSMutableArray *requestArray;

@end

@implementation BatchRequestAgent

+ (BatchRequestAgent *)sharedInstance {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}


- (id)init {
    self = [super init];
    if (self) {
        _requestArray = [NSMutableArray array];
    }
    return self;
}

- (void)addBatchRequest:(BatchRequest *)request {
    @synchronized(self) {
        [_requestArray addObject:request];
    }
}

- (void)removeBatchRequest:(BatchRequest *)request {
    @synchronized(self) {
        [_requestArray removeObject:request];
    }
}

@end
