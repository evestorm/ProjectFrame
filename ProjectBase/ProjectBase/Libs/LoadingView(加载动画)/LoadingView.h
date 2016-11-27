//
//  LoadingView.h
//  ProjectBase
//
//  Created by 向云飞 on 16/8/4.
//  Copyright © 2016年 向云飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingView : UIView

@property (nonatomic, strong) UIImageView *loopImageView;
@property (nonatomic, strong) UIImageView *logoImageView;

@property (nonatomic, assign, readonly) BOOL isLoading;

- (void)startAnimation;

- (void)stopAnimation;

@end
