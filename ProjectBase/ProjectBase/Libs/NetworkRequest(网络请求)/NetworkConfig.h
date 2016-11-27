//
//  NetworkConfig.h
//  Network
//
//  Created by MyMac on 16/1/5.
//  Copyright © 2016年 MyMac. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BaseRequest;

@protocol ProcessProtocol <NSObject>

@optional
// 加工argument
- (NSMutableDictionary *) processArgumentWithRequest:(NSMutableDictionary *)argument;
// 加工response
- (id) processResponseWithRequest:(id)response;

@end

@interface NetworkConfig : NSObject

+ (NetworkConfig *)sharedInstance;

@property (nonatomic, strong) NSString *mainBaseUrl;// 主url
@property (nonatomic, strong) NSString *viceBaseUrl;// 副url
@property (nonatomic, strong) id <ProcessProtocol> processRule;

@end
