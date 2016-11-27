//
//  UIView+EaseBlankPageView.h
//  ProjectBase
//
//  Created by 向云飞 on 16/8/3.
//  Copyright © 2016年 向云飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EaseBlankPageView.h"

@interface UIView (EaseBlankPageView)

@property (nonatomic, strong) EaseBlankPageView *blankPageView;

- (void)configBlankPage:(EaseBlankPageType)blankPageType hasData:(BOOL)hasData hasError:(BOOL)hasError reloadButtonBlock:(void(^)(id sender))block;


@end
