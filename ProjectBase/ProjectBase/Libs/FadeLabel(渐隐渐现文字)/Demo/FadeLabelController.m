//
//  FadeLabelController.m
//  ProjectBase
//
//  Created by 向云飞 on 2016/10/23.
//  Copyright © 2016年 向云飞. All rights reserved.
//

#import "FadeLabelController.h"
#import "FadeLabel.h"

@interface FadeLabelController ()

@property (nonatomic, strong) FadeLabel *fadeLabel;

@end

@implementation FadeLabelController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.fadeLabel];
    [self.fadeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(self.view).with.offset(50);
        make.right.mas_equalTo(self.view).with.offset(-50);
    }];
    
    self.fadeLabel.text = @"渐隐渐现Label渐隐渐现Label渐隐渐现Label渐隐渐现Label渐隐渐现Label渐隐渐现Label";
    [self.fadeLabel sizeToFit];
    
    [self.fadeLabel fadeWithComplete:^{
        DBLog(@"显示完毕");
    }];

}

- (FadeLabel *)fadeLabel {
    if (!_fadeLabel) {
        _fadeLabel = [[FadeLabel alloc] init];
        _fadeLabel.font = [UIFont fontWithSize:24.0f];
        _fadeLabel.textColor = [UIColor blueColor];
        _fadeLabel.numberOfLines = 0;
    }
    return _fadeLabel;
}

//- (void)viewWillLayoutSubviews {
//    self.fadeLabel.frame = CGRectMake(16, 16, self.view.frame.size.width - 32, self.view.frame.size.height - 32 - 20);
//}



@end
