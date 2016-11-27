//
//  NetworkAgent.m
//  Network
//
//  Created by MyMac on 16/1/5.
//  Copyright © 2016年 MyMac. All rights reserved.
//

#import "NetworkAgent.h"
#import "NetworkConfig.h"
#import "BaseRequest.h"
#import "AFNetworking.h"

#import <EGOCache.h>
#import "BaseRequest+Internal.h"
#import "checkNetwork.h"


@interface NetworkAgent ()

@property (nonatomic, strong) AFHTTPSessionManager *manager;
@property (nonatomic, strong) NSMutableDictionary *requestsRecord;
@property (nonatomic, strong) NetworkConfig *config;


@end

@implementation NetworkAgent


+ (NetworkAgent *)sharedInstance {
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
        _config = [NetworkConfig sharedInstance];
        _manager = [AFHTTPSessionManager manager];
        _manager.operationQueue.maxConcurrentOperationCount = 4;
        _requestsRecord = [NSMutableDictionary dictionary];
    }
    return self;
}


- (void)addRequest:(BaseRequest <APIRequest>*)request {
    
    //判断是否有网络
    if ([checkNetwork getNetworkTypeFromStatusBar] == NETWORK_TYPE_NONE) {
        if (request.delegate != nil) {
            [request.delegate requestFailed:request];
        }
        if (request.failureCompletionBlock) {
            request.failureCompletionBlock(request);
        }
        return;
    }
    
    
    NSString *url = request.urlString;
    
    // 是否使用 https
    if ([url hasPrefix:@"https"]) {
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
        self.manager.securityPolicy = securityPolicy;
    }
    
    // 是否使用自定义超时时间
    self.manager.requestSerializer.timeoutInterval = [request.child requestTimeoutInterval];
    self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    NSMutableDictionary *argument = request.requestArgument;
    
    NSString *cacheKey;
    if (argument.count > 0) {
        NSString *keys = [self getKeysValues:argument];
        cacheKey = [NSString stringWithFormat:@"%@?%@",url,keys];
    }else {
        cacheKey = [NSString stringWithFormat:@"%@",url];
    }
        
    // 检查是否有统一的参数添加
    argument = [self.config.processRule processArgumentWithRequest:request.requestArgument];
    
    //服务端数据接收类型
    if ([request.child respondsToSelector:@selector(requestSerializerType)]) {
        if ([request.child respondsToSelector:@selector(requestSerializerType)] == RequestSerializerTypeHTTP) {
            self.manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        }
        else{
            self.manager.requestSerializer = [AFJSONRequestSerializer serializer];
        }
    }
    
    //在这里判断是否有缓存
    EGOCache *cache = [EGOCache globalCache];
    
    //是否清除对应链接缓存
    if ([request.child isClearCache]) {
        for (NSString *key in cache.allKeys) {
            if ([key hasPrefix:url]) {
                [cache removeCacheForKey:key];
            }
        }
    }
    
    id object = [cache objectForKey:cacheKey];
    
    switch ([request.child clientRequestCachePolicy]) {
        case ClientReturnCacheDataThenLoad: { //有缓存就先返回缓存，同步请求数据
            if (object) {
                request.responseJSONObject = object;
                if (request.successCompletionBlock) {
                    request.successCompletionBlock(request);
                }else {
                    [request.delegate requestFinished:request];
                }
            }
            //这里传参数  返回数据
            [self getDataWithRequest:request url:url argument:argument cache:cache cacheKey:cacheKey];
            
            break;
        }
        case ClientReloadIgnoringLocalCacheData: { //忽略缓存，重新请求
            //不做处理，直接请求网络数据
            [self getDataWithRequest:request url:url argument:argument cache:cache cacheKey:cacheKey];
            
            break;
        }
        case ClientReturnCacheDataElseLoad: { //有缓存就用缓存，没有缓存就重新请求(用于数据不变时)
            if (object) {
                request.responseJSONObject = object;
                if (request.successCompletionBlock) {
                    request.successCompletionBlock(request);
                }else {
                    [request.delegate requestFinished:request];
                }
            }
            else {
               [self getDataWithRequest:request url:url argument:argument cache:cache cacheKey:cacheKey];
            }
            break;
        }
        case ClientReturnCacheDataDontLoad: { //有缓存就用缓存，没有缓存就不发请求，当做请求出错处理（用于离线模式）
            if (object) {
                request.responseJSONObject = object;
            }
            break;
        }
    }
    
}

- (void)getDataWithRequest:(BaseRequest <APIRequest>*)request url:(NSString *)url argument:(NSMutableDictionary *)argument cache:(EGOCache *)cache cacheKey:(NSString *)cacheKey{
    
    
    if ([request.child requestMethod] == RequestMethodGet) {  //get请求
        request.sessionDataTask = [self.manager GET:url parameters:argument progress:^(NSProgress * _Nonnull downloadProgress) {
            [self handleRequestProgress:downloadProgress request:request];
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            request.responseJSONObject = responseObject;
            
            //判断是否需要缓存请求的数据
            if ([request.child cacheResponse]) {
                if ([request.child cacheAgeLimit] == -1) {
                    [cache setObject:responseObject forKey:cacheKey];
                }else {
                    [cache setObject:responseObject forKey:cacheKey withTimeoutInterval:[request.child cacheAgeLimit]];
                }
                
            }
            
            [self handleRequestSuccess:task];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self handleRequestFailure:task];
        }];
    }
    else if ([request.child requestMethod] == RequestMethodPost){ //post请求
        
        if ([request.child respondsToSelector:@selector(constructingBodyBlock)] && [request.child constructingBodyBlock]) {
            request.sessionDataTask = [self.manager POST:url parameters:argument constructingBodyWithBlock:[request.child constructingBodyBlock] progress:^(NSProgress * _Nonnull uploadProgress) {
                [self handleRequestProgress:uploadProgress request:request];
            } success:^(NSURLSessionDataTask *task, id  _Nullable responseObject) {
                request.responseJSONObject = responseObject;
                
                //判断是否需要缓存请求的数据
                if ([request.child cacheResponse]) {
                    if ([request.child cacheAgeLimit] == -1) {
                        [cache setObject:responseObject forKey:cacheKey];
                    }else {
                        [cache setObject:responseObject forKey:cacheKey withTimeoutInterval:[request.child cacheAgeLimit]];
                    }
                    
                }
                
                [self handleRequestSuccess:task];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self handleRequestFailure:task];
            }];
        }
        else{
            request.sessionDataTask = [self.manager POST:url parameters:argument progress:^(NSProgress * _Nonnull uploadProgress) {
                [self handleRequestProgress:uploadProgress request:request];
            } success:^(NSURLSessionDataTask * task, id  _Nullable responseObject) {
                request.responseJSONObject = responseObject;
                
                //判断是否需要缓存请求的数据
                if ([request.child cacheResponse]) {
                    if ([request.child cacheAgeLimit] == -1) {
                        [cache setObject:responseObject forKey:cacheKey];
                    }else {
                        [cache setObject:responseObject forKey:cacheKey withTimeoutInterval:[request.child cacheAgeLimit]];
                    }
                    
                }
                
                [self handleRequestSuccess:task];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self handleRequestFailure:task];
            }];
        }
    }
    [self addOperation:request];
    
}


- (NSString *)getKeysValues:(NSMutableDictionary *)dict{
    NSArray *allKeys = [dict allKeys];
    NSString *keys;
    for (NSString *key in allKeys) {
        if (keys) {
            keys = [NSString stringWithFormat:@"%@&%@=%@",keys,key,[dict objectForKey:key]];
        }else {
            keys = [NSString stringWithFormat:@"%@=%@",key,[dict objectForKey:key]];
        }
        
    }
    
    return keys;
}

- (void)handleRequestProgress:(NSProgress *)progress request:(BaseRequest *)request{
    if (request.delegate && [request.delegate respondsToSelector:@selector(requestProgress:)]) {
        [request.delegate requestProgress:progress];
    }
    if (request.progressBlock) {
        request.progressBlock(progress);
    }
}

- (void)handleRequestSuccess:(NSURLSessionDataTask *)sessionDataTask{
    NSString *key = [self keyForRequest:sessionDataTask];
    BaseRequest *request = _requestsRecord[key];
    
    if (request) {
        
        [request toggleAccessoriesWillStopCallBack];
        
        if (request.delegate != nil) {
            [request.delegate requestFinished:request];
        }
                
        if (request.successCompletionBlock) {
            
            request.successCompletionBlock(request);
            
        }
        [request toggleAccessoriesDidStopCallBack];
        
    }
    
    [self removeOperation:sessionDataTask];
    [request clearCompletionBlock];
}

- (void)handleRequestFailure:(NSURLSessionDataTask *)sessionDataTask{
    NSString *key = [self keyForRequest:sessionDataTask];
    BaseRequest *request = _requestsRecord[key];
    if (request) {
        [request toggleAccessoriesWillStopCallBack];
        if (request.delegate != nil) {
            [request.delegate requestFailed:request];
        }
        if (request.failureCompletionBlock) {
            request.failureCompletionBlock(request);
        }
        [request toggleAccessoriesDidStopCallBack];
    }
    
    [self removeOperation:sessionDataTask];
    [request clearCompletionBlock];
    
}

- (void)cancelRequest:(BaseRequest *)request {
    [request.sessionDataTask cancel];
    [self removeOperation:request.sessionDataTask];
    [request clearCompletionBlock];
}


- (void)removeOperation:(NSURLSessionDataTask *)operation {
    NSString *key = [self keyForRequest:operation];
    @synchronized(self) {
        [_requestsRecord removeObjectForKey:key];
    }
}


- (void)addOperation:(BaseRequest *)request {
    if (request.sessionDataTask != nil) {
        NSString *key = [self keyForRequest:request.sessionDataTask];
        @synchronized(self) {
            self.requestsRecord[key] = request;
        }
    }
}

- (NSString *)keyForRequest:(NSURLSessionDataTask *)object {
    NSString *key = [@(object.taskIdentifier) stringValue];
    return key;
}


@end
