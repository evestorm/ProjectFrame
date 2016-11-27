//
//  EaseBlankPageView.h
//  ProjectBase
//
//  Created by 向云飞 on 16/8/3.
//  Copyright © 2016年 向云飞. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,EaseBlankPageType) {
    EaseBlankPageTypeBlank = 0,     //空白页
    EaseBlankPageTypeNoNetWork      //无网络
};

@interface EaseBlankPageView : UIView

@property (nonatomic, strong) UIImageView *blankImageView;
@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UIButton *reloadButton;
@property (nonatomic, copy) void(^reloadButtonBlock)(id sender);


- (void)configWithType:(EaseBlankPageType)blankPageType hasData:(BOOL)hasData hasError:(BOOL)hasError reloadButtonBlock:(void(^)(id sender))block;

@end
