//
//  LoginViewModel.h
//  ProjectBase
//
//  Created by 向云飞 on 2016/10/17.
//  Copyright © 2016年 向云飞. All rights reserved.
//

#import "BaseViewModel.h"

@interface LoginViewModel : BaseViewModel


/**
 微博登录

 @param viewController 当前控制器
 @param success        登录成功block
 @param failure        登录失败block
 */
+ (void)weiboLoginViewController:(UIViewController *)viewController success:(success)success failure:(failure)failure;


/**
 微信登录

 @param viewController 当前控制器
 @param success        登录成功block
 @param failure        登录失败block
 */
+ (void)weChatLoginViewController:(UIViewController *)viewController success:(success)success failure:(failure)failure;


/**
 QQ登录

 @param viewController 当前控制器
 @param success        登录成功block
 @param failure        登录失败block
 */
+ (void)QQLoginViewController:(UIViewController *)viewController success:(success)success failure:(failure)failure;


@end
