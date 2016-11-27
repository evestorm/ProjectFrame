//
//  UIView+BadgeTip.h
//  ProjectBase
//
//  Created by 向云飞 on 16/8/24.
//  Copyright © 2016年 向云飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BadgeView.h"

@interface UIView (BadgeTip)

- (void)addBadgeTip:(NSString *)badgeValue withCenterPosition:(CGPoint)center;
- (void)addBadgeTip:(NSString *)badgeValue;
- (void)addBadgeTip:(NSString *)badgeValue withPosition:(BadgePositionType)positionType;
- (void)addBadgeTip:(NSString *)badgeValue toView:(UIView *)view withRelativePositionOfView:(BadgePositionType)relativePosition;



- (void)addBadgeTip:(NSString *)badgeValue withCenterPosition:(CGPoint)center showOutsideStroke:(BOOL)showOutsideStroke;
- (void)addBadgeTip:(NSString *)badgeValue showOutsideStroke:(BOOL)showOutsideStroke;
- (void)addBadgeTip:(NSString *)badgeValue withPosition:(BadgePositionType)positionType showOutsideStroke:(BOOL)showOutsideStroke;
- (void)addBadgeTip:(NSString *)badgeValue toView:(UIView *)view withRelativePositionOfView:(BadgePositionType)relativePosition showOutsideStroke:(BOOL)showOutsideStroke;

@end
