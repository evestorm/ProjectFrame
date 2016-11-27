//
//  PayAPI.h
//  ProjectBase
//
//  Created by 向云飞 on 2016/10/6.
//  Copyright © 2016年 向云飞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "weChatPayModel.h"
#import "alipayModel.h"

typedef NS_ENUM(NSInteger,weChatPayErrorCode) {
    weChatPayError_Cancel = 1000001,     //支付取消
    weChatPayError_Failure = 1000002     //支付失败
};


typedef NS_ENUM(NSInteger,aliPayErrorCode) {
    aliPayError_Cancel = 1100001,       //支付取消
    aliPayError_Failure = 1100002       //支付失败
};

@interface PayAPI : NSObject

+ (instancetype)sharePayAPI;

- (BOOL)handleOpenUrl:(NSURL *)url;


/**
 发起微信支付

 @param model        支付参数
 @param successBlock 成功回调
 @param failure      失败回调
 */
- (void)weChatPayWithPayModel:(weChatPayModel *)model success:(void(^)(void))successBlock failure:(void(^)(NSInteger error))failure;



/**
 支付宝支付

 @param model        支付参数(未拼接好)
 @param successBlock 成功回调
 @param failure      失败回调
 */
- (void)aliPayWithPayModel:(alipayModel *)model success:(void(^)(void))successBlock failure:(void(^)(NSInteger error))failure;




/**
 支付宝支付

 @param modelStr     支付参数(已拼接好)
 @param successBlock 成功回调
 @param failure      失败回调
 */
- (void)aliPayWithPayModelStr:(NSString *)modelStr success:(void(^)(void))successBlock failure:(void(^)(NSInteger error))failure;



@end
