//
//  BadgeView.h
//  ProjectBase
//
//  Created by 向云飞 on 16/8/24.
//  Copyright © 2016年 向云飞. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kBadgeTipStr @"badgeTip"

typedef NS_ENUM(NSInteger,BadgePositionType) {
    BadgePositionTypeTopRight = 0,
    BadgePositionTypeBottomRight
};

@interface BadgeView : UIView

@property (nonatomic, copy) NSString *badgeValue;

@property (nonatomic, assign) BOOL showOutsideStroke; /**< 是否显示外描边*/

+ (BadgeView *)viewWithBadgeTip:(NSString *)badgeValue showOutsideStroke:(BOOL)showOutsideStroke;

+ (CGSize)badgeSizeWithStr:(NSString *)badgeValue font:(UIFont *)font;

- (CGSize)badgeSizeWithStr:(NSString *)badgeValue;

@end
