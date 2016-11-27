//
//  StarRateView.m
//  StarRateView
//
//  Created by MyMac on 15/10/27.
//  Copyright © 2015年 MyMac. All rights reserved.
//

#import "StarRateView.h"

#define DEFALUT_STAR_NUMBER 5
#define ANIMATION_TIME_INTERVAL 0.2


@interface StarRateView ()

@property (nonatomic,strong) UIView *foregroundStarView;

@property (nonatomic,strong) UIView *backgroundStarView;

@end

@implementation StarRateView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
     return [self initWithFrame:frame numberOfStars:DEFALUT_STAR_NUMBER backgroundImage:nil foregroundImage:nil];
}

- (instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSUInteger)numberOfStars backgroundImage:(UIImage *)backgroundImage foregroundImage:(UIImage *)foregroundImage{
    self = [super initWithFrame:frame];
    if (self) {
        self.numberOfStars = numberOfStars;
        self.background_star_image = backgroundImage;
        self.foreground_star_image = foregroundImage;
        [self buildDataAndUI];
    }
    return self;
}

#pragma mark - 设置数据和创建UI
- (void)buildDataAndUI{
    self.scorePercent = 1;
    self.hasAnimation = NO;
    self.allowIncompleteStar = NO;
    
    self.foregroundStarView = [self createStarViewWithImage:self.foreground_star_image];
    self.backgroundStarView = [self createStarViewWithImage:self.background_star_image];
    
    [self addSubview:self.backgroundStarView];
    [self addSubview:self.foregroundStarView];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTapRateView:)];
    tapGesture.numberOfTapsRequired = 1;
    [self addGestureRecognizer:tapGesture];
}

- (void)userTapRateView:(UITapGestureRecognizer *)gesture{
    CGPoint tapPoint = [gesture locationInView:self];
    CGFloat offsetX = tapPoint.x;
    CGFloat realStarScore = offsetX / (self.bounds.size.width / self.numberOfStars);
    CGFloat starScore = self.allowIncompleteStar ? realStarScore : ceil(realStarScore);
//    self.scorePercent = starScore / self.numberOfStars;
    self.scorePercent = starScore;
}

/**
 *  创建星星
 */
- (UIView *)createStarViewWithImage:(UIImage *)image{
  
    UIView *view = [[UIView alloc] initWithFrame:self.bounds];
    view.clipsToBounds = YES;
    view.backgroundColor = [UIColor clearColor];
    
    CGFloat StarsW = self.bounds.size.width / self.numberOfStars;
    CGFloat StarsH = self.bounds.size.height;
    
    for (int i = 0; i < self.numberOfStars; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.frame = CGRectMake(i * StarsW, 0, StarsW, StarsH);
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [view addSubview:imageView];
    }
    return view;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    __weak StarRateView *weakSelf = self;
    
    CGFloat animationTimeInterval = self.hasAnimation ? ANIMATION_TIME_INTERVAL : 0;
    [UIView animateWithDuration:animationTimeInterval animations:^{
        weakSelf.foregroundStarView.frame = CGRectMake(0, 0, weakSelf.bounds.size.width * weakSelf.scorePercent / weakSelf.numberOfStars, weakSelf.bounds.size.height);
    }];
    
}

- (void)setScorePercent:(CGFloat)scorePercent{
    if (_scorePercent == scorePercent) return;
    
    if (scorePercent < 0) {
        _scorePercent = 0;
    }else{
        _scorePercent = scorePercent;
    }
    
    
//    if (scorePercent < 0) {
//        _scorePercent = 0;
//    }else if (scorePercent > 1){
//        _scorePercent = 1;
//    }else{
//        _scorePercent = scorePercent;
//    }
    
    if ([self.delegate respondsToSelector:@selector(starRateView:sorcePercentDidChange:)]) {
        [self.delegate starRateView:self sorcePercentDidChange:scorePercent];
    }
    
    [self setNeedsLayout];
    
}

@end
