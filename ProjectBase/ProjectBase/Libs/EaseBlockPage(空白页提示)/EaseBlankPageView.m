//
//  EaseBlankPageView.m
//  ProjectBase
//
//  Created by 向云飞 on 16/8/3.
//  Copyright © 2016年 向云飞. All rights reserved.
//

#import "EaseBlankPageView.h"

@implementation EaseBlankPageView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)configWithType:(EaseBlankPageType)blankPageType hasData:(BOOL)hasData hasError:(BOOL)hasError reloadButtonBlock:(void (^)(id))block {
    
    if (hasData) {
        [self removeFromSuperview];
        return;
    }
    
    self.alpha = 1.0f;
    
    //图片
    [self addSubview:self.blankImageView];
    [self.blankImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.bottom.equalTo(self.mas_centerY);
    }];
    
    //提示
    [self addSubview:self.tipLabel];
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.centerX.equalTo(self);
        make.top.equalTo(_blankImageView.mas_bottom);
    }];
    
    _reloadButtonBlock = nil;
    
    if (hasError) {
        //重新加载按钮
        [self addSubview:self.reloadButton];
        [self.reloadButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.mas_equalTo(_tipLabel.mas_bottom);
        }];
        
        self.reloadButton.hidden = NO;
        _reloadButtonBlock = block;
        self.blankImageView.image = [UIImage imageNamed:@"blankpage_image_Sleep"];
        self.tipLabel.text = @"貌似出了点差错\n真忧伤呢";
    }else {
        if (_reloadButton) {
            _reloadButton.hidden = YES;
        }
        
        NSString *imageName,*tipStr;
        switch (blankPageType) {
            case EaseBlankPageTypeBlank: {
                imageName = @"blankpage_image_Sleep";
                tipStr = @"暂无数据";
                break;
            }
            case EaseBlankPageTypeNoNetWork: {
                imageName = @"blankpage_image_loadFail";
                tipStr = @"暂无网络";
                break;
            }
        }
        
        self.blankImageView.image = [UIImage imageNamed:imageName];
        self.tipLabel.text = tipStr;
        
    }
}


- (void)reloadButtonClick:(UIButton *)sender {
    self.hidden = YES;
    [self removeFromSuperview];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (_reloadButtonBlock) {
            _reloadButtonBlock(sender);
        }
    });
}


#pragma mark - getter and setter
- (UIImageView *)blankImageView {
    if (!_blankImageView) {
        _blankImageView = [[UIImageView alloc] init];
    }
    return _blankImageView;
}

- (UILabel *)tipLabel {
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.font = [UIFont systemFontOfSize:15.0f];
        _tipLabel.textColor = [UIColor lightGrayColor];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        _tipLabel.numberOfLines = 0;
    }
    return _tipLabel;
}

- (UIButton *)reloadButton {
    if (!_reloadButton) {
        _reloadButton = [[UIButton alloc] init];
        [_reloadButton setImage:[UIImage imageNamed:@"blankpage_button_reload"] forState:UIControlStateNormal];
        _reloadButton.adjustsImageWhenHighlighted = NO;
        [_reloadButton addTarget:self action:@selector(reloadButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _reloadButton;
}

@end
