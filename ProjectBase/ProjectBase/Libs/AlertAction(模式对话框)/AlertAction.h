//
//  AlertAction.h
//  Daiyanxiu
//
//  Created by MyMac on 16/3/28.
//  Copyright © 2016年 MyMac. All rights reserved.
//  UIAlertController block封装

#import <Foundation/Foundation.h>

@interface AlertAction : NSObject

/**
 *  模式对话框
 *
 *  @param title        标题
 *  @param msg          提示内容
 *  @param block        返回点击的按钮index
 *  @param cancelString 取消按钮文本 必须以nil结束
 */
+ (void)showAlertWithTitle:(NSString*)title msg:(NSString*)msg chooseBlock:(void (^)(NSInteger buttonIdx))block  buttonsStatement:(NSString *)cancelString, ...;

/**
 *  显示UIActionSheet模式对话框
 *
 *  @param title                  标题
 *  @param message                消息内容
 *  @param block                  返回block,buttonIdx:destructiveButtonTitle分别为0 otherButtonTitle从后面开始，如果destructiveButtonTitle没有，buttonIndex1开始，反之2开始，cancel是最后一个
 *  @param cancelString           取消文本
 *  @param destructiveButtonTitle 特殊标记按钮，默认红色
 *  @param otherButtonTitle       其他选项,必须以nil结束
 */
+ (void)showActionSheetWithTitle:(NSString*)title message:(NSString*)message chooseBlock:(void (^)(NSInteger buttonIdx))block cancelButtonTitle:(NSString*)cancelString destructiveButtonTitle:(NSString*)destructiveButtonTitle otherButtonTitle:(NSString*)otherButtonTitle,...;


+ (UIViewController*)getTopViewController;
@end
