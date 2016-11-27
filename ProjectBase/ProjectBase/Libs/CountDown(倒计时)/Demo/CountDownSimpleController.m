//
//  CountDownSimpleController.m
//  ProjectBase
//
//  Created by 向云飞 on 2016/10/22.
//  Copyright © 2016年 向云飞. All rights reserved.
//

#import "CountDownSimpleController.h"
#import "CountDown.h"

#import "CountDownViewController.h"

@interface CountDownSimpleController ()

@property (nonatomic, strong) CountDown *countDown;
@property (nonatomic, strong) UIButton *button;

@end

@implementation CountDownSimpleController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.countDown = [[CountDown alloc] init];
    
    [self.view addSubview:self.button];
    
}

- (void)rightClick {
    CountDownViewController *c = [[CountDownViewController alloc] init];
    [self.navigationController pushViewController:c animated:YES];

}

- (UIButton *)button {
    if (!_button) {
        _button = [[UIButton alloc] initWithFrame:CGRectMake(10, 80, 150, 44)];
        _button.backgroundColor = [UIColor redColor];
        [_button setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(fetchCoder) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

- (void)fetchCoder {
    
    NSTimeInterval seconds = 60;
    NSDate *finishDate = [NSDate dateWithTimeIntervalSinceNow:seconds];
    __weak typeof(self) weakSelf = self;
    [self.countDown countDownWithStartDate:[NSDate date] finishDate:finishDate completeBlock:^(NSInteger day, NSInteger hour, NSInteger minute, NSInteger second) {
        
        NSInteger totoalSeconds = day*24*60*60+hour*60*60 + minute*60+second;
        if (totoalSeconds == 0) {
            weakSelf.button.enabled = YES;
            [weakSelf.button setTitle:@"重新获取验证码" forState:UIControlStateNormal];
        }else {
            weakSelf.button.enabled = NO;
            [weakSelf.button setTitle:[NSString stringWithFormat:@"%ld秒后重新获取",(long)totoalSeconds] forState:UIControlStateNormal];
        }
    }];
}

- (void)dealloc {
    [self.countDown destoryTimer];
}


@end
