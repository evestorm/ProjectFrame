//
//  BaseRequest.h
//  Network
//
//  Created by MyMac on 16/1/5.
//  Copyright © 2016年 MyMac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFURLRequestSerialization.h>

#define ClientRequestCache @"ClientRequestCache"

typedef void (^AFConstructingBlock)(id<AFMultipartFormData> formData);

typedef NS_ENUM(NSInteger , RequestMethod) {
    RequestMethodGet = 0,
    RequestMethodPost,
    RequestMethodHead,
    RequestMethodPut,
    RequestMethodDelete,
    RequestMethodPatch
};


typedef NS_ENUM(NSInteger , RequestSerializerType) {
    RequestSerializerTypeHTTP = 0,
    RequestSerializerTypeJSON
};


typedef NS_ENUM(NSInteger , ClientRequestCachePolicy) {
    ClientReturnCacheDataThenLoad = 0,   //有缓存就先返回缓存，同步请求数据
    ClientReloadIgnoringLocalCacheData,    //忽略缓存，重新请求
    ClientReturnCacheDataElseLoad,      //有缓存就用缓存，没有缓存就重新请求(用于数据不变时)
    ClientReturnCacheDataDontLoad,     //有缓存就用缓存，没有缓存就不发请求，当做请求出错处理（用于离线模式）
};

/*--------------------------------------------*/
@protocol APIRequest <NSObject>

@optional

/**
 *  接口地址
 *  @return 接口地址
 */
- (NSString *)apiMethodName;

/**
 *  参数字典
 */
- (NSMutableDictionary *)requestArgument;

/**
 *  可以使用两个根地址，比如可能会用到 CDN 地址、https之类的
 *  @return 是否使用副Url
 */
- (BOOL)useViceUrl;


/**
 *  请求方式，包括Get、Post、Head、Put、Delete、Patch，具体查看 LCRequestMethod
 *  @return 请求方式
 */
- (RequestMethod)requestMethod;

/**
 *  使用缓存方式 参考ClientRequestCachePolicy
 */
- (ClientRequestCachePolicy)clientRequestCachePolicy;

/**
 *  是否缓存数据 response 数据
 *  @return 是否缓存数据 response 数据
 */
- (BOOL)cacheResponse;

/**
 *  自定义超时时间
 *  @return 超时时间
 */
- (NSTimeInterval)requestTimeoutInterval;



/**
 *  自定义缓存超期时间
 */
- (NSTimeInterval)cacheAgeLimit;


/**
 *  是否清除对应链接缓存
 */
- (BOOL)isClearCache;


/**
 *  multipart 数据
 *  @return 用于 multipart 的数据block
 */
- (AFConstructingBlock)constructingBodyBlock;


/**
 *  处理responseJSONObject，当外部访问 self.responseJSONObject 的时候就会返回这个方法处理后的数据
 *  @param responseObject 输入的 responseObject ，在方法内切勿使用 self.responseJSONObject
 *  @return 处理后的responseJSONObject
 */
- (id)responseProcess:(id)responseObject;

/**
 *  是否忽略统一的参数加工
 *  @return 返回 YES，那么 self.responseJSONObject 将返回原始的数据
 */
- (BOOL)ignoreUnifiedResponseProcess;

/**
 *  返回完全自定义的接口地址
 *  @return 完全自定义的接口地址
 */
- (NSString *)customApiMethodName;

/**
 *  服务端数据接收类型，比如 LCRequestSerializerTypeJSON 用于 post json 数据
 *  @return 服务端数据接收类型
 */
- (RequestSerializerType)requestSerializerType;

@end

/*--------------------------------------------*/
@class BaseRequest;
@protocol RequestDelegate <NSObject>

@optional

- (void)requestFinished:(BaseRequest *)request;
- (void)requestFailed:(BaseRequest *)request;
- (void)requestProgress:(NSProgress *)progress;

@end


/*--------------------------------------------*/

@protocol RequestAccessory <NSObject>

@optional

- (void)requestWillStart:(id)request;
- (void)requestWillStop:(id)request;
- (void)requestDidStop:(id)request;

@end

@interface BaseRequest : NSObject


@property (nonatomic, strong) NSURLSessionDataTask *sessionDataTask;
@property (nonatomic, strong) NSMutableDictionary *requestArgument;
@property (nonatomic, weak) id<RequestDelegate> delegate;
@property (nonatomic, weak, readonly) id<APIRequest,RequestAccessory> child;
@property (nonatomic, strong) id responseJSONObject;
@property (nonatomic, strong, readonly) NSString *urlString;
@property (nonatomic, strong, readonly) NSMutableArray *requestAccessories;
@property (nonatomic, copy) void (^successCompletionBlock)(BaseRequest *);
@property (nonatomic, copy) void (^failureCompletionBlock)(BaseRequest *);
@property (nonatomic, copy) void (^progressBlock)(NSProgress * progress);


/**
 *  开始网络请求，使用 detegate 方式使用这个方法
 */
- (void)start;

/**
 *  停止网路请求
 */
- (void)stop;


/**
 *  block回调方式
 *  @param success 成功回调
 *  @param failure 失败回调
 */
- (void)startWithBlockSuccess:(void (^)(id request))success failure:(void (^)(id request))failure;


/**
 *  block回调方式
 *  @param progress 进度回调
 *  @param success  成功回调
 *  @param failure  失败回调
 */
- (void)startWithBlockProgress:(void (^)(NSProgress *progress))progress success:(void (^)(id request))success failure:(void (^)(id request))failure;

/**
 *  一般用于显示和隐藏 HUD
 *  @param accessory 插件
 */
- (void)addAccessory:(id<RequestAccessory>)accessory;

@end

@interface BaseRequest (RequestAccessory)

- (void)toggleAccessoriesWillStartCallBack;
- (void)toggleAccessoriesWillStopCallBack;
- (void)toggleAccessoriesDidStopCallBack;


@end
