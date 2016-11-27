//
//  LoadingView.m
//  ProjectBase
//
//  Created by 向云飞 on 16/8/4.
//  Copyright © 2016年 向云飞. All rights reserved.
//

#import "LoadingView.h"

@interface LoadingView ()

@property (nonatomic, assign) CGFloat loopAngle;
@property (nonatomic, assign) CGFloat logoAlpha;
@property (nonatomic, assign) CGFloat angleStep;
@property (nonatomic, assign) CGFloat alphaStep;

@end

@implementation LoadingView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _loopImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loading_loop"]];
        _logoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loading_logo"]];
        _loopImageView.center = self.center;
        _logoImageView.center = self.center;
        [self addSubview:_logoImageView];
        [self addSubview:_loopImageView];
        [_loopImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self);
        }];
        
        [_logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self);
        }];
        
        _loopAngle = 0.0;
        _logoAlpha = 1.0;
        _angleStep = 360/3;
        _alphaStep = 1.0/3.0;
        
    }
    return self;
}

- (void)startAnimation {
    self.hidden = NO;
    if (_isLoading) {
        return;
    }
    _isLoading = YES;
    [self loadingAnimation];
}

- (void)stopAnimation {
    self.hidden = YES;
    _isLoading = NO;
}

- (void)loadingAnimation{
    static CGFloat duration = 0.25f;
    _loopAngle += _angleStep;
    if (_logoAlpha >= 1.0 || _logoAlpha <= 0.0) {
        _alphaStep = -_alphaStep;
    }
    _logoAlpha += _alphaStep;
    [UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        CGAffineTransform loopAngleTransform = CGAffineTransformMakeRotation(_loopAngle * (M_PI / 180.0f));
        _loopImageView.transform = loopAngleTransform;
        _logoImageView.alpha = _logoAlpha;
    } completion:^(BOOL finished) {
        if (_isLoading && [self superview] != nil) {
            [self loadingAnimation];
        }else{
            [self removeFromSuperview];
            
            _loopAngle = 0.0;
            _logoAlpha = 1,0;
            _alphaStep = ABS(_alphaStep);
            CGAffineTransform loopAngleTransform = CGAffineTransformMakeRotation(_loopAngle * (M_PI / 180.0f));
            _loopImageView.transform = loopAngleTransform;
            _logoImageView.alpha = _logoAlpha;
        }
    }];
}

@end
