//
//  weChatPayModel.h
//  ProjectBase
//
//  Created by 向云飞 on 2016/10/6.
//  Copyright © 2016年 向云飞. All rights reserved.
//  微信支付model


//****************************************************************************
//*            在导入微信SDK以后要在工程中链接以下库                               *
//* SystemConfiguration.framework,Security.framework,CoreTelephony.framework *
//* libz.tbd,libsqlite3.0.tbd,libc++.tbd                                     *
//****************************************************************************



#import <Foundation/Foundation.h>

@interface weChatPayModel : NSObject

@property (nonatomic, copy) NSString *appid; /**< 唯一ID*/

@property (nonatomic, copy) NSString *partnerid; /**< 商家向财付通申请的商家id*/

@property (nonatomic, copy) NSString *prepayid; /**< 预支付订单*/

@property (nonatomic, copy) NSString *noncestr; /**< 随机串*/

@property (nonatomic, copy) NSString *timestamp; /**< 时间戳*/

@property (nonatomic, copy) NSString *package; /**< 微信提供的签名*/

@property (nonatomic, copy) NSString *sign; /**< 商家自有签名*/

@end
