//
//  LoadingViewController.m
//  ProjectBase
//
//  Created by 向云飞 on 16/8/4.
//  Copyright © 2016年 向云飞. All rights reserved.
//

#import "LoadingViewController.h"
#import "UIView+LoadingView.h"

@implementation LoadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view beginLoading];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.view endLoading];
    });
    
}

@end
