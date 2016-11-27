//
//  BadgeViewController.m
//  ProjectBase
//
//  Created by 向云飞 on 16/8/24.
//  Copyright © 2016年 向云飞. All rights reserved.
//

#import "BadgeViewController.h"
#import "UIView+BadgeTip.h"
@implementation BadgeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(30, 30, 100, 30)];
    button.backgroundColor = [UIColor redColor];
    [self.view addSubview:button];
    
    [button addBadgeTip:kBadgeTipStr];
//    [button addBadgeTip:@"12" withPosition:BadgePositionTypeBottomRight showOutsideStroke:YES];
    
    [button addBadgeTip:@"123" withPosition:BadgePositionTypeTopRight showOutsideStroke:YES];
    
    
}

@end
