//
//  PayAPI.m
//  ProjectBase
//
//  Created by 向云飞 on 2016/10/6.
//  Copyright © 2016年 向云飞. All rights reserved.
//

#import "PayAPI.h"
#import "WXApi.h"
#import <AlipaySDK/AlipaySDK.h>
#import "DataSigner.h"

@interface PayAPI ()<WXApiDelegate>

@property (nonatomic, copy) void(^WXPaySuccess)();
@property (nonatomic, copy) void(^WXPayError)(NSInteger payError);

@end

@implementation PayAPI

static id _instance;

+ (instancetype)sharePayAPI {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[PayAPI alloc] init];
    });
    return _instance;
}

- (BOOL)handleOpenUrl:(NSURL *)url {
    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            [self payCallBackWithResult:resultDic];
            
        }];
    }
    
    if ([url.host isEqualToString:@"platformapi"]) {
        [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
            [self payCallBackWithResult:resultDic];
            
        }];
    }
    return [WXApi handleOpenURL:url delegate:self];

}


#pragma mark - 微信支付
- (void)weChatPayWithPayModel:(weChatPayModel *)model success:(void (^)(void))successBlock failure:(void (^)(NSInteger))failure {
    self.WXPaySuccess = successBlock;
    self.WXPayError = failure;
    //发起微信支付
    PayReq *req = [[PayReq alloc] init];
    req.openID = model.appid;
    req.partnerId = model.partnerid;
    req.prepayId = model.prepayid;
    req.nonceStr = model.noncestr;
    req.timeStamp = [model.timestamp intValue];
    req.package = model.package;
    req.sign = model.sign;
    [WXApi sendReq:req];
}

- (void)onResp:(BaseResp *)resp {
    if ([resp isKindOfClass:[PayResp class]]) {
        PayResp *response = (PayResp *)resp;
        switch (response.errCode) {
                case WXSuccess:{
                    self.WXPaySuccess();
                    break;
                }
                case WXErrCodeUserCancel:{
                    self.WXPayError(weChatPayError_Cancel);
                    break;
                }
            default:{
                self.WXPayError(weChatPayError_Failure);
                break;
            }
        }
    }
}



#pragma mark - 支付宝支付
- (void)aliPayWithPayModelStr:(NSString *)modelStr success:(void (^)(void))successBlock failure:(void (^)(NSInteger))failure {
    //应用注册scheme
    NSString *appScheme = @"daiyanxiu1096508605";
    
    self.WXPaySuccess = successBlock;
    self.WXPayError = failure;
    [[AlipaySDK defaultService] payOrder:modelStr fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        [self payCallBackWithResult:resultDic];
    }];
}

- (void)aliPayWithPayModel:(alipayModel *)model success:(void (^)(void))successBlock failure:(void (^)(NSInteger))failure {
    
    //应用注册scheme
    NSString *appScheme = @"daiyanxiu1096508605";
    
    //商品参数拼接
    NSString *orderSpec = [model description];

    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    NSString *privateKey = @"";
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];

    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            [self payCallBackWithResult:resultDic];
        }];
    }
}



- (void)payCallBackWithResult:(NSDictionary *)resultDic {
    NSInteger resultCode = [resultDic[@"resultStatus"] integerValue];
    switch (resultCode) {
            case 9000:  //支付成功
            self.WXPaySuccess();
            break;
            case 6001:  //支付取消
            self.WXPayError(aliPayError_Cancel);
            break;
        default:  //支付失败
            self.WXPayError(aliPayError_Failure);
            break;
    }
}

@end
