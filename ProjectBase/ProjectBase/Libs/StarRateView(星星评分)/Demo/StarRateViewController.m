//
//  StarRateViewController.m
//  ProjectBase
//
//  Created by 向云飞 on 2016/10/22.
//  Copyright © 2016年 向云飞. All rights reserved.
//

#import "StarRateViewController.h"

#import "StarRateView.h"

@interface StarRateViewController ()<StarRateViewDelegate>

@property (nonatomic,strong) StarRateView *star;

@end

@implementation StarRateViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    StarRateView *star = [[StarRateView alloc] initWithFrame:CGRectMake(10, 30, [UIScreen mainScreen].bounds.size.width - 60, 23) numberOfStars:5 backgroundImage:[UIImage imageNamed:@"b27_icon_star_gray"] foregroundImage:[UIImage imageNamed:@"b27_icon_star_red"]];
    star.scorePercent = 1;
    star.allowIncompleteStar = NO;
    star.hasAnimation = YES;
    star.delegate = self;
    [self.view addSubview:star];
    
}


- (void)starRateView:(StarRateView *)starRateView sorcePercentDidChange:(CGFloat)newSorcePercent{
    NSLog(@"%f",newSorcePercent);
}

@end
