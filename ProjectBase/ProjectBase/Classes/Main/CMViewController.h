//
//  CMViewController.h
//  ProjectBase
//
//  Created by 向云飞 on 16/8/4.
//  Copyright © 2016年 向云飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMViewController : UIViewController {
    UIView *_titleView;
    UILabel *_titleLabel;
}


@property(nonatomic, readonly) UILabel *titleLabel;
@property(nonatomic) int naviBackIndex;

- (void)_handleEndEditing;
//页面返回事件
- (void)_handleViewBack;
//从导航栏栈中获取UIViewController
- (UIViewController *)viewControllerWithNaviIndex:(int)naviIndex;

//从导航栏栈中移除控制器
- (void)removeController:(Class)viewController;

//隐藏导航栏后解决滑动返回失效问题
- (void)hideNavCanBack;

////获取配置文件数据
//- (void)getConfigurationWithCache:(BOOL)useCache;
//
////登录
//- (void)login;


//添加网页
//- (void)addWebView:(NSString *)title url:(NSString *)url useWebPageTitle:(BOOL)useWebPageTitle;
//- (void)addWebView:(NSString *)path useWebPageTitle:(BOOL)useWebPageTitle;

- (void)setRefreshControl:(UIScrollView *)scrollView refreshAction:(SEL)refreshAction; // 集成刷新控件
- (void)setUploadControl:(UIScrollView *)scrollView uploadAction:(SEL)uploadAction; // 集成加载控件

@end
