//
//  BaseRequest.m
//  Network
//
//  Created by MyMac on 16/1/5.
//  Copyright © 2016年 MyMac. All rights reserved.
//

#import "BaseRequest.h"
#import "NetworkAgent.h"
#import "NetworkConfig.h"
#import <AFNetworking.h>


@interface BaseRequest ()

//@property (nonatomic, strong) id cacheJson;
@property (nonatomic, weak) id<APIRequest,RequestAccessory> child;
@property (nonatomic, strong) NSMutableArray *requestAccessories;
@property (nonatomic, strong) NetworkConfig *config;

@end

@implementation BaseRequest

- (instancetype)init
{
    self = [super init];
    if (self) {
        if ([self conformsToProtocol:@protocol(APIRequest)]) {
            _child = (id<APIRequest,RequestAccessory>)self;
        }
        else {
            NSAssert(NO, @"子类必须要实现APIRequest这个protocol");
        }
        _config = [NetworkConfig sharedInstance];
        
    }
    return self;
}


/**
 *  @author yunFei, 16-01-05 20:01:19
 *
 *  新增实现类
 */

/**
 *  参数字典
 */
- (NSMutableDictionary *)requestArgument{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    return dict;
}

/**
 *  是否缓存数据 response 数据
 *  @return 是否缓存数据 response 数据
 */
- (BOOL)cacheResponse{
    return YES;
}


/**
 *  数据请求方式(默认POST请求)
 */
- (RequestMethod)requestMethod{
    return RequestMethodPost;
}

/**
 *  是否忽略统一的参数加工
 *  @return 返回 YES，那么 self.responseJSONObject 将返回原始的数据
 */
- (BOOL)ignoreUnifiedResponseProcess{
    return YES;
}

/**
 *  自定义超时时间
 *  @return 超时时间
 */
- (NSTimeInterval)requestTimeoutInterval{
    return 30.0f;
}


/**
 *  自定义缓存超期时间
 */
- (NSTimeInterval)cacheAgeLimit {
    return -1;
}



/**
 *  使用缓存方式 参考ClientRequestCachePolicy
 */
- (ClientRequestCachePolicy)clientRequestCachePolicy {
    return ClientReturnCacheDataThenLoad;
}


/**
 *  是否清除缓存
 */
- (BOOL)isClearCache {
    return NO;
}


- (void)start{
    [self toggleAccessoriesWillStartCallBack];
    [[NetworkAgent sharedInstance] addRequest:self];
}

- (void)startWithBlockSuccess:(void (^)(id))success failure:(void (^)(id))failure{    
    self.successCompletionBlock = success;
    self.failureCompletionBlock = failure;
    
    [self start];
}

- (void)startWithBlockProgress:(void (^)(NSProgress *))progress success:(void (^)(id))success failure:(void (^)(id))failure{
    self.progressBlock = progress;
    self.successCompletionBlock = success;
    self.failureCompletionBlock = failure;
    [self start];
}

- (id)responseJSONObject{
    id responseJSONObject = nil;
    // 统一加工response
    if (self.config.processRule && [self.config.processRule respondsToSelector:@selector(processResponseWithRequest:)]) {
        if (([self.child respondsToSelector:@selector(ignoreUnifiedResponseProcess)] && ![self.child ignoreUnifiedResponseProcess]) ||
            ![self.child respondsToSelector:@selector(ignoreUnifiedResponseProcess)]) {
            responseJSONObject = [self.config.processRule processResponseWithRequest:_responseJSONObject];
            if ([self.child respondsToSelector:@selector(responseProcess:)]){
                responseJSONObject = [self.child responseProcess:responseJSONObject];
            }
            return responseJSONObject;
        }
    }
    
    if ([self.child respondsToSelector:@selector(responseProcess:)]){
        responseJSONObject = [self.child responseProcess:_responseJSONObject];
        return responseJSONObject;
    }
    return _responseJSONObject;
}

- (NSString *)urlString{
    if ([self.child respondsToSelector:@selector(customApiMethodName)]) {
        return [self.child customApiMethodName];
    }
    else{
        NSString *baseUrl = nil;
        
        if ([self.child respondsToSelector:@selector(useViceUrl)] && [self.child useViceUrl]){
            baseUrl = self.config.viceBaseUrl;
        }
        else{
            baseUrl = self.config.mainBaseUrl;
        }
        if (baseUrl) {
            return [baseUrl stringByAppendingString:[self.child apiMethodName]];
        }
        return [self.child apiMethodName];
    }
}

- (NSString *)getKeysValues:(NSMutableDictionary *)dict{
    NSArray *allKeys = [dict allKeys];
    NSString *keys;
    for (NSString *key in allKeys) {
        keys = [NSString stringWithFormat:@"%@=%@",key,[dict objectForKey:key]];
    }
    return keys;
}

- (void)stop{
    [self toggleAccessoriesWillStopCallBack];
    self.delegate = nil;
    [[NetworkAgent sharedInstance] cancelRequest:self];
    [self toggleAccessoriesDidStopCallBack];
}


- (void)clearCompletionBlock {
    self.successCompletionBlock = nil;
    self.failureCompletionBlock = nil;
    self.progressBlock = nil;
}


#pragma mark - Request Accessoies
- (void)addAccessory:(id<RequestAccessory>)accessory {
    if (!self.requestAccessories) {
        self.requestAccessories = [NSMutableArray array];
    }
    [self.requestAccessories addObject:accessory];
}


@end

@implementation BaseRequest (RequestAccessory)

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
