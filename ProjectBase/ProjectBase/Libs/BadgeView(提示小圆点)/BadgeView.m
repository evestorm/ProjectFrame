//
//  BadgeView.m
//  ProjectBase
//
//  Created by 向云飞 on 16/8/24.
//  Copyright © 2016年 向云飞. All rights reserved.
//

#define kMaxBadgeWidth 100.0f
#define kBadgeTextOffset 2.0f
#define kBadgePadding 2.0f

#import "BadgeView.h"

@interface BadgeView ()

@property (nonatomic, strong) UIColor *badgeBackgroundColor; /**< 背景颜色*/
@property (nonatomic, strong) UIColor *badgeTextColor; /**< 文本颜色*/
@property (nonatomic, strong) UIFont *badgeTextFont; /**< 文本字体大小*/

@end

@implementation BadgeView

- (instancetype)init {
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialization];
    }
    return self;
}

- (void)initialization {
    self.backgroundColor = [UIColor clearColor];
    _badgeBackgroundColor = [UIColor colorWithHexString:@"ffbd40"];
    _badgeTextColor = [UIColor whiteColor];
    if (kDevice_Is_iPhone6 || kDevice_Is_iPhone6Plus) {
        _badgeTextFont = [UIFont boldSystemFontOfSize:12.0f];
    }else {
        _badgeTextFont = [UIFont boldSystemFontOfSize:11.0f];
    }
}

+ (BadgeView *)viewWithBadgeTip:(NSString *)badgeValue showOutsideStroke:(BOOL)showOutsideStroke {
    if (!badgeValue || badgeValue.length == 0) {
        return nil;
    }
    BadgeView *badgeView = [[BadgeView alloc] init];
    badgeView.frame = [badgeView badgeFrameWithStr:badgeValue];
    badgeView.badgeValue = badgeValue;
    badgeView.showOutsideStroke = showOutsideStroke;
    return badgeView;
}

+ (CGSize)badgeSizeWithStr:(NSString *)badgeValue font:(UIFont *)font {
    if (!badgeValue || badgeValue.length == 0) {
        return CGSizeZero;
    }
    
    if (!font) {
        if (kDevice_Is_iPhone6 || kDevice_Is_iPhone6Plus) {
            font = [UIFont boldSystemFontOfSize:12.0f];
        }else {
            font = [UIFont boldSystemFontOfSize:11.0f];
        }
    }
    
    CGSize badgeSize = [badgeValue getSizeWithFont:font constrainedToSize:CGSizeMake(kMaxBadgeWidth, 20)];
    
    if (badgeSize.width < badgeSize.height) {
        badgeSize = CGSizeMake(badgeSize.height, badgeSize.height);
    }
    
    if ([badgeValue isEqualToString:kBadgeTipStr]) {
        badgeSize = CGSizeMake(4, 4);
    }
    return badgeSize;
}

- (CGSize)badgeSizeWithStr:(NSString *)badgeValue {
    return [BadgeView badgeSizeWithStr:badgeValue font:self.badgeTextFont];
}

- (CGRect)badgeFrameWithStr:(NSString *)badgeValue {
    CGSize badgeSize = [self badgeSizeWithStr:badgeValue];
    CGRect badgeFrame = CGRectMake(0, 0, badgeSize.width + 8, badgeSize.height + 8);
    return badgeFrame;
}

- (void)setShowOutsideStroke:(BOOL)showOutsideStroke {
    _showOutsideStroke = showOutsideStroke;
    [self setNeedsDisplay];
}

- (void)setBadgeValue:(NSString *)badgeValue {
    _badgeValue = badgeValue;
    self.frame = [self badgeFrameWithStr:badgeValue];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    if (self.badgeValue.length) {
        CGSize badgeSize = [self badgeSizeWithStr:_badgeValue];
        CGRect badgeBackgroundFrame = CGRectMake(kBadgeTextOffset,kBadgeTextOffset,badgeSize.width + 2 * kBadgePadding,badgeSize.height + 2 * kBadgePadding);
        CGRect badgeBackgroundPaddingFrame = CGRectMake(0, 0, badgeBackgroundFrame.size.width + 2 * kBadgePadding, badgeBackgroundFrame.size.height + 2 * kBadgePadding);
        
        if ([self badgeBackgroundColor]) {
            if (![self.badgeValue isEqualToString:kBadgeTipStr] && self.showOutsideStroke) {//外白色描边
                CGContextSetFillColorWithColor(context, [[UIColor whiteColor] CGColor]);
                
                if (badgeSize.width > badgeSize.height) {
                    CGFloat circleWith = badgeBackgroundPaddingFrame.size.height;
                    CGFloat totalWidth = badgeBackgroundPaddingFrame.size.width;
                    CGFloat diffWidth = totalWidth - circleWith;
                    CGPoint originPoint = badgeBackgroundPaddingFrame.origin;
                    
                    
                    CGRect leftCicleFrame = CGRectMake(originPoint.x, originPoint.y, circleWith, circleWith);
                    CGRect centerFrame = CGRectMake(originPoint.x +circleWith/2, originPoint.y, diffWidth, circleWith);
                    CGRect rightCicleFrame = CGRectMake(originPoint.x +(totalWidth - circleWith), originPoint.y, circleWith, circleWith);
                    CGContextFillEllipseInRect(context, leftCicleFrame);
                    CGContextFillRect(context, centerFrame);
                    CGContextFillEllipseInRect(context, rightCicleFrame);
                    
                }else{
                    CGContextFillEllipseInRect(context, badgeBackgroundPaddingFrame);
                }
            }
            //badge背景色
            CGContextSetFillColorWithColor(context, [[self badgeBackgroundColor] CGColor]);
            if (badgeSize.width > badgeSize.height) {
                CGFloat circleWith = badgeBackgroundFrame.size.height;
                CGFloat totalWidth = badgeBackgroundFrame.size.width;
                CGFloat diffWidth = totalWidth - circleWith;
                CGPoint originPoint = badgeBackgroundFrame.origin;
                
                CGRect leftCicleFrame = CGRectMake(originPoint.x, originPoint.y, circleWith, circleWith);
                CGRect centerFrame = CGRectMake(originPoint.x +circleWith/2, originPoint.y, diffWidth, circleWith);
                CGRect rightCicleFrame = CGRectMake(originPoint.x +(totalWidth - circleWith), originPoint.y, circleWith, circleWith);
                CGContextFillEllipseInRect(context, leftCicleFrame);
                CGContextFillRect(context, centerFrame);
                CGContextFillEllipseInRect(context, rightCicleFrame);
            }else{
                CGContextFillEllipseInRect(context, badgeBackgroundFrame);
            }
        }
        
        //badgeValue
        if (![self.badgeValue isEqualToString:kBadgeTipStr]) {
            CGContextSetFillColorWithColor(context, [[self badgeTextColor] CGColor]);
            
            NSMutableParagraphStyle *badgeTextStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
            [badgeTextStyle setLineBreakMode:NSLineBreakByWordWrapping];
            [badgeTextStyle setAlignment:NSTextAlignmentCenter];
            
            NSDictionary *badgeTextAttributes = @{NSFontAttributeName: [self badgeTextFont],NSForegroundColorAttributeName: [self badgeTextColor],NSParagraphStyleAttributeName: badgeTextStyle,};
            
            [[self badgeValue] drawInRect:CGRectMake(CGRectGetMinX(badgeBackgroundFrame) + kBadgeTextOffset,CGRectGetMinY(badgeBackgroundFrame) + kBadgeTextOffset,badgeSize.width, badgeSize.height)withAttributes:badgeTextAttributes];
        }
    }
    CGContextRestoreGState(context);
}

@end
