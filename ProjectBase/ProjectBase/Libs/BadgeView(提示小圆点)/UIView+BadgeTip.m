//
//  UIView+BadgeTip.m
//  ProjectBase
//
//  Created by 向云飞 on 16/8/24.
//  Copyright © 2016年 向云飞. All rights reserved.
//

#import "UIView+BadgeTip.h"

#define kTagBadgeView  1000

@implementation UIView (BadgeTip)

- (void)addBadgeTip:(NSString *)badgeValue withCenterPosition:(CGPoint)center {
    [self addBadgeTip:badgeValue withCenterPosition:center showOutsideStroke:NO];
}

- (void)addBadgeTip:(NSString *)badgeValue {
    [self addBadgeTip:badgeValue showOutsideStroke:NO];
}

- (void)addBadgeTip:(NSString *)badgeValue withPosition:(BadgePositionType)positionType {
    [self addBadgeTip:badgeValue withPosition:positionType showOutsideStroke:NO];
}

- (void)addBadgeTip:(NSString *)badgeValue toView:(UIView *)view withRelativePositionOfView:(BadgePositionType)relativePosition {
    [self addBadgeTip:badgeValue toView:view withRelativePositionOfView:relativePosition showOutsideStroke:NO];
}



- (void)addBadgeTip:(NSString *)badgeValue withCenterPosition:(CGPoint)center showOutsideStroke:(BOOL)showOutsideStroke {
    if (!badgeValue || !badgeValue.length || [badgeValue isEqualToString:@"0"]) {
        [self removeBadgeTip];
    }else {
        if ([badgeValue integerValue] >= 100) {
            badgeValue = @"99+";
        }
        
        UIView *badgeV = [self viewWithTag:kTagBadgeView];
        if (badgeV && [badgeV isKindOfClass:[BadgeView class]]) {
            [(BadgeView *)badgeV setBadgeValue:badgeValue];
            [(BadgeView *)badgeV setShowOutsideStroke:showOutsideStroke];
            badgeV.hidden = NO;
        }else {
            badgeV = [BadgeView viewWithBadgeTip:badgeValue showOutsideStroke:showOutsideStroke];
            badgeV.tag = kTagBadgeView;
            [self addSubview:badgeV];
        }
        [badgeV setCenter:center];
    }
}

- (void)addBadgeTip:(NSString *)badgeValue showOutsideStroke:(BOOL)showOutsideStroke {
    if (!badgeValue || !badgeValue.length || [badgeValue isEqualToString:@"0"]) {
        [self removeBadgeTip];
    }else {
        if ([badgeValue integerValue] >= 100) {
            badgeValue = @"99+";
        }
        
        UIView *badgeV = [self viewWithTag:kTagBadgeView];
        if (badgeV && [badgeV isKindOfClass:[BadgeView class]]) {
            [(BadgeView *)badgeV setBadgeValue:badgeValue];
            badgeV.hidden = NO;
        }else {
            badgeV = [BadgeView viewWithBadgeTip:badgeValue showOutsideStroke:showOutsideStroke];
            badgeV.tag = kTagBadgeView;
            [self addSubview:badgeV];
        }
        CGSize badgeSize = badgeV.frame.size;
        CGSize selfSize = self.frame.size;
        CGFloat offset = 2.0;
        [badgeV setCenter:CGPointMake(selfSize.width- (offset+badgeSize.width/2),(offset +badgeSize.height/2))];
    }
}


- (void)addBadgeTip:(NSString *)badgeValue withPosition:(BadgePositionType)positionType showOutsideStroke:(BOOL)showOutsideStroke {
    if (!badgeValue || !badgeValue.length || [badgeValue isEqualToString:@"0"]) {
        [self removeBadgeTip];
    }else {
        if ([badgeValue integerValue] >= 100) {
            badgeValue = @"99+";
        }
        UIView *badgeV = [self viewWithTag:kTagBadgeView];
        if (badgeV && [badgeV isKindOfClass:[BadgeView class]]) {
            [(BadgeView *)badgeV setBadgeValue:badgeValue];
        }else{
            badgeV = [BadgeView viewWithBadgeTip:badgeValue showOutsideStroke:showOutsideStroke];
            badgeV.tag = kTagBadgeView;
            [self addSubview:badgeV];
        }
        //        CGSize badgeSize = badgeV.frame.size;
        CGSize selfSize = self.frame.size;
        //        CGFloat offset = 2.0;
        switch (positionType) {
            case BadgePositionTypeTopRight: {
                [badgeV setCenter:CGPointMake(selfSize.width, 0)];
                break;
            }
            case BadgePositionTypeBottomRight: {
                [badgeV setCenter:CGPointMake(self.width, selfSize.height)];
                break;
            }
        }
    }
}

- (void)addBadgeTip:(NSString *)badgeValue toView:(UIView *)view withRelativePositionOfView:(BadgePositionType)relativePosition showOutsideStroke:(BOOL)showOutsideStroke {
    if (!badgeValue || !badgeValue.length || [badgeValue isEqualToString:@"0"]) {
        [self removeBadgeTip];
    }else {
        if ([badgeValue integerValue] >= 100) {
            badgeValue = @"99+";
        }
        UIView *badgeV = [self viewWithTag:kTagBadgeView];
        if (badgeV && [badgeV isKindOfClass:[BadgeView class]]) {
            [(BadgeView *)badgeV setBadgeValue:badgeValue];
        }else{
            badgeV = [BadgeView viewWithBadgeTip:badgeValue showOutsideStroke:showOutsideStroke];
            badgeV.tag = kTagBadgeView;
            [self addSubview:badgeV];
        }
        switch (relativePosition) {
            case BadgePositionTypeTopRight:{
                [badgeV setCenter:CGPointMake(CGRectGetMaxX(view.frame), view.frame.origin.y)];
                break;
            }
            case BadgePositionTypeBottomRight:{
                [badgeV setCenter:CGPointMake(CGRectGetMaxX(view.frame), CGRectGetMaxY(view.frame))];
                break;
            }
        }
    }
}


- (void)removeBadgeTip {
    NSArray *subViews = [self subviews];
    if (subViews && subViews.count > 0) {
        for (UIView *aView in subViews) {
            if (aView.tag == kTagBadgeView && [aView isKindOfClass:[BadgeView class]]) {
                aView.hidden = YES;
            }
        }
    }
}

@end
