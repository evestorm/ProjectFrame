//
//  AlertAction.m
//  Daiyanxiu
//
//  Created by MyMac on 16/3/28.
//  Copyright © 2016年 MyMac. All rights reserved.
//  UIAlertController block封装

#import "AlertAction.h"
#import <UIKit/UIKit.h>

@implementation AlertAction

/**
 *  模式对话框
 *
 *  @param title        标题
 *  @param msg          提示内容
 *  @param block        返回点击的按钮index
 *  @param cancelString 取消按钮文本 必须以nil结束
 */
+ (void)showAlertWithTitle:(NSString *)title msg:(NSString *)msg chooseBlock:(void (^)(NSInteger))block buttonsStatement:(NSString *)cancelString, ... {
    NSMutableArray *argsArray = [[NSMutableArray alloc] initWithCapacity:2];
    [argsArray addObject:cancelString];
    id arg;
    va_list argList;
    if(cancelString) {
        va_start(argList,cancelString);
        while ((arg = va_arg(argList,id))) {
            [argsArray addObject:arg];
        }
        va_end(argList);
    }
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    for (int i = 0; i < argsArray.count; i ++) {
        UIAlertActionStyle style =  (0 == i) ? UIAlertActionStyleCancel: UIAlertActionStyleDefault;
        //创建Actions
        UIAlertAction *action = [UIAlertAction actionWithTitle:[argsArray objectAtIndex:i] style:style handler:^(UIAlertAction *action) {
            if (block) {
                block(i);
            }
        }];
        [alertController addAction:action];
    }
    
    [[AlertAction getTopViewController] presentViewController:alertController animated:YES completion:nil];
    
}

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
+ (void)showActionSheetWithTitle:(NSString *)title message:(NSString *)message chooseBlock:(void (^)(NSInteger))block cancelButtonTitle:(NSString *)cancelString destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitle:(NSString *)otherButtonTitle, ... {
    NSMutableArray* argsArray = [[NSMutableArray alloc] initWithCapacity:3];
    if (cancelString) {
        [argsArray addObject:cancelString];
    }
    
    id arg;
    va_list argList;
    
    if(otherButtonTitle) {
        [argsArray addObject:otherButtonTitle];
        va_start(argList,otherButtonTitle);
        while ((arg = va_arg(argList,id))) {
            [argsArray addObject:arg];
        }
        va_end(argList);
    }
    
    if (destructiveButtonTitle) {
        [argsArray addObject:destructiveButtonTitle];
    }
    
    if (argsArray.count < 2) {
        return;
    }
    
    UIAlertController* alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    for (int i = 0; i < argsArray.count; i++) {
        UIAlertActionStyle style =  (0 == i)? UIAlertActionStyleCancel: UIAlertActionStyleDefault;
        
        if (argsArray.count - 1 == i && destructiveButtonTitle) {
            
            style = UIAlertActionStyleDestructive;
        }
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:[argsArray objectAtIndex:i] style:style handler:^(UIAlertAction *action) {
            if (block) {
                block(i);
            }
        }];
        [alertController addAction:action];
    }
    
    [[AlertAction getTopViewController] presentViewController:alertController animated:YES completion:nil];
    
}


+ (UIViewController*)getTopViewController {
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows) {
            if (tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        result = nextResponder;
    } else {
        result = window.rootViewController;
    }
    return result;
}

@end
