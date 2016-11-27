//
//  UIView+LoadingView.h
//  ProjectBase
//
//  Created by 向云飞 on 16/8/4.
//  Copyright © 2016年 向云飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoadingView.h"

@interface UIView (LoadingView)

@property (nonatomic, strong) LoadingView *loadingView;

- (void)beginLoading;
- (void)endLoading;

@end
