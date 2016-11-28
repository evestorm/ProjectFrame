//
//  CommonAlertView.h
//  ProjectBase
//
//  Created by 向云飞 on 16/8/10.
//  Copyright © 2016年 向云飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CommonAlertView;
@protocol CommonAlertViewDelegate <NSObject>

- (void)clickedDialogButtonTouchUpInside:(CommonAlertView *)alertView buttonAtIndex:(NSInteger)buttonIndex;

@optional
- (void)alertViewWhenClose;

@end

@interface CommonAlertView : UIView

@property (nonatomic, strong) UIView *parentView; /**< 父视图*/
@property (nonatomic, strong) UIView *dialogView; /**< 弹窗视图*/
@property (nonatomic, strong) UIView *containerView;  /**< 弹窗中的容器视图 (在这里添加UI)*/
@property (nonatomic, strong) UIView *buttonView;    /**< 添加底部按钮的视图*/

@property (nonatomic, strong) NSArray *buttonTitles; /**< 按钮文字*/
@property (nonatomic, strong) NSArray *buttonBgColors; /**< 按钮背景颜色*/
@property (nonatomic, strong) NSArray *buttonTextColors; /**< 按钮文字颜色*/

@property (nonatomic, strong) UIColor *buttonBgViewColor; /**< 按钮底部背景色*/
@property (nonatomic, strong) UIFont *buttonTextFont; /**< 按钮文字字体*/
@property (nonatomic, assign) BOOL clickedBgCloseAlertView; /**< 点击后面背景关闭弹窗 默认关闭*/
@property (nonatomic, strong) UIColor *lineViewColor; /**< 内容和底部按钮分割线颜色 */
@property (nonatomic, strong) UIColor *verticalLineColor; /**< 竖线颜色*/
@property (nonatomic, assign) BOOL topCorner; /**< 顶部圆角*/
@property (nonatomic, assign) BOOL isUseDelegate; /**< 是否使用代理*/

@property (nonatomic, assign) NSInteger time; /**< 多少秒弹窗自动消失, 默认为0*/
@property (nonatomic, assign) CGFloat layerCorner; /**< 设置圆角*/

@property (nonatomic, weak) id<CommonAlertViewDelegate> delegate;

@property (nonatomic, copy) void(^onButtonTouchUpInside)(CommonAlertView *alertView, int buttonIndex);

- (instancetype)init;

- (instancetype)initWithOffsetY:(CGFloat)offsetY;

- (instancetype)initWithParentView:(UIView *)parentView;

- (void)show;

- (void)close;

- (void)setOnButtonTouchUpInside:(void(^)(CommonAlertView *alertView,int buttonIndex))onButtonTouchUpInside;






@end
