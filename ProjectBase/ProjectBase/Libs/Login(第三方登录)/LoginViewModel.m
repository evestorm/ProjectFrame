//
//  LoginViewModel.m
//  ProjectBase
//
//  Created by 向云飞 on 2016/10/17.
//  Copyright © 2016年 向云飞. All rights reserved.
//

#import "LoginViewModel.h"


@implementation LoginViewModel


/**
 微博登录
 
 @param viewController 当前控制器
 @param success        登录成功block
 @param failure        登录失败block
 */
+ (void)weiboLoginViewController:(UIViewController *)viewController success:(success)success failure:(failure)failure {
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
    snsPlatform.loginClickHandler(viewController,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        if (response.responseCode == UMSResponseCodeSuccess) {
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] objectForKey:snsPlatform.platformName];
            NSString *avatar = snsAccount.iconURL;
            NSString *username = snsAccount.userName;
            NSString *usid = snsAccount.usid;
            NSString *accessToken = snsAccount.accessToken;
            NSString *refreshToken = snsAccount.refreshToken;
            
            DBLog(@"%@===%@===%@===%@===%@",avatar,username,usid,accessToken,refreshToken);
            
        }else {
            [self failure:failure tip:@"微博授权失败!"];
        }
    });
}


/**
 微信登录
 
 @param viewController 当前控制器
 @param success        登录成功block
 @param failure        登录失败block
 */
+ (void)weChatLoginViewController:(UIViewController *)viewController success:(success)success failure:(failure)failure {
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession];
    snsPlatform.loginClickHandler(viewController,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        if (response.responseCode == UMSResponseCodeSuccess) {
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] objectForKey:snsPlatform.platformName];
            
            NSString *access_token = snsAccount.accessToken;
            NSString *openid = snsAccount.openId;
            NSString *unionid = snsAccount.unionId;
            NSString *nickname = snsAccount.userName;
            NSString *avatar = snsAccount.iconURL;
            NSString *sex = response.thirdPlatformUserProfile[@"sex"]; //性别
            
            
            DBLog(@"%@===%@===%@===%@===%@===%@",access_token,openid,unionid,nickname,avatar,sex);
            
        }else {
            [self failure:failure tip:@"微信授权失败!"];
        }
    });
}


/**
 QQ登录
 
 @param viewController 当前控制器
 @param success        登录成功block
 @param failure        登录失败block
 */
+ (void)QQLoginViewController:(UIViewController *)viewController success:(success)success failure:(failure)failure {
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
    snsPlatform.loginClickHandler(viewController,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        if (response.responseCode == UMSResponseCodeSuccess) {
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] objectForKey:snsPlatform.platformName];
            
            NSString *access_token = snsAccount.accessToken;
            NSString *usid = snsAccount.usid;
            NSString *nickname = snsAccount.userName;
            NSString *avatar = snsAccount.iconURL;
            NSString *sex = response.thirdPlatformUserProfile[@"gender"];
            
            DBLog(@"%@===%@===%@===%@===%@",access_token,usid,nickname,avatar,sex);
            
        }else {
            [self failure:failure tip:@"QQ授权失败!"];
        }
    });
}

@end
