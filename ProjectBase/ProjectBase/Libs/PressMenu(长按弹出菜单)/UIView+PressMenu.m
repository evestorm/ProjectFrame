//
//  UIView+PressMenu.m
//  ProjectBase
//
//  Created by 向云飞 on 16/8/11.
//  Copyright © 2016年 向云飞. All rights reserved.
//

#import "UIView+PressMenu.h"
#import <objc/runtime.h>

@implementation UIView (PressMenu)

static const NSString *kPressMenuSelectorPrefix = @"easePressMenuClicked_";
static char PressMenuTitlesKey, PressMenuBlockKey,PressMenuGestureKey,MenuVCKey;


- (void)addPressMenuTitles:(NSArray *)menuTitles menuClickedBlock:(void (^)(NSInteger, NSString *))block {
    self.userInteractionEnabled = YES;
    self.menuClickedBlock = block;
    self.menuTitles = menuTitles;
    if (!self.longPressGesture) {
        self.longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handlePress:)];
    }
}


- (void)showMenuTitles:(NSArray *)menuTitles menuClickedBlock:(void (^)(NSInteger, NSString *))block {
    self.menuClickedBlock = block;
    self.menuTitles = menuTitles;
    [self showMenu];
}

- (BOOL)isMenuVCVisible {
    if (self.menuVC) {
        return [self.menuVC isMenuVisible];
    }
    return NO;
}

- (void)removePressMenu {
    if (self.menuVC) {
        [self.menuVC setMenuVisible:NO animated:YES];
        self.menuVC = nil;
    }
    if ([self.longPressGesture isKindOfClass:[UILongPressGestureRecognizer class]]) {
        [self removeGestureRecognizer:self.longPressGesture];
        self.longPressGesture = nil;
    }
    if (self.menuClickedBlock) {
        self.menuClickedBlock = nil;
    }
    if (self.menuTitles) {
        self.menuTitles = nil;
    }
    
    
}

#pragma mark - action methods
- (void)handlePress:(UILongPressGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateBegan) {
        [self showMenu];
    }
}

- (void)showMenu {
    [self becomeFirstResponder];
    NSMutableArray *menuItems = [[NSMutableArray alloc] initWithCapacity:self.menuTitles.count];
    Class cls = [self class];
    SEL imp = @selector(pressMenuClicked:);
    for (int i = 0; i < self.menuTitles.count; i ++) {
        NSString *title = [self.menuTitles objectAtIndex:i];
        //注册名添加方法SEL sel的具体实现在pressMenuClicked:方法中
        SEL sel = sel_registerName([[NSString stringWithFormat:@"%@%d:",kPressMenuSelectorPrefix,i] UTF8String]);
        class_addMethod(cls, sel, [cls instanceMethodForSelector:imp], "v@");
        UIMenuItem *item = [[UIMenuItem alloc] initWithTitle:title action:sel];
        [menuItems addObject:item];
    }
    
    UIMenuController *menu = [UIMenuController sharedMenuController];
    [menu setMenuItems:menuItems];
    [menu setTargetRect:self.frame inView:self.superview];
    [menu setMenuVisible:YES animated:YES];
    self.menuVC = menu;
    
}

- (void)pressMenuClicked:(id)sender {
    NSString *selStr = NSStringFromSelector(_cmd);
    NSString *indexStr = [selStr substringFromIndex:kPressMenuSelectorPrefix.length];
    NSInteger index = indexStr.integerValue;
    if (index >= 0 && index < self.menuTitles.count) {
        NSString *title = [self.menuTitles objectAtIndex:index];
        if (self.menuClickedBlock) {
            self.menuClickedBlock(index,title);
        }
    }
}


#pragma mark - getter
- (void)setMenuTitles:(NSArray *)menuTitles {
    objc_setAssociatedObject(self, &PressMenuTitlesKey, menuTitles, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSArray *)menuTitles {
    return objc_getAssociatedObject(self, &PressMenuTitlesKey);
}

- (void)setMenuClickedBlock:(void (^)(NSInteger, NSString *))menuClickedBlock {
    objc_setAssociatedObject(self, &PressMenuBlockKey, menuClickedBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void (^)(NSInteger, NSString *))menuClickedBlock {
    return objc_getAssociatedObject(self, &PressMenuBlockKey);
}

- (void)setLongPressGesture:(UILongPressGestureRecognizer *)longPressGesture {
    objc_setAssociatedObject(self, &PressMenuGestureKey, longPressGesture, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UILongPressGestureRecognizer *)longPressGesture {
    return objc_getAssociatedObject(self, &PressMenuGestureKey);
}

- (void)setMenuVC:(UIMenuController *)menuVC {
    objc_setAssociatedObject(self, &MenuVCKey, menuVC, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIMenuController *)menuVC {
    return objc_getAssociatedObject(self, &MenuVCKey);
}

#pragma mark -  canPerformAction
- (BOOL)canBecomeFirstResponder {
    if (self.menuClickedBlock) {
        return YES;
    }else {
        return [super canBecomeFirstResponder];
    }
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (self.menuClickedBlock) {
        for (int i = 0; i < self.menuTitles.count; i ++) {
            if (action == NSSelectorFromString([NSString stringWithFormat:@"%@%d:",kPressMenuSelectorPrefix,i])) {
                return YES;
            }
        }
        return NO;
    }else {
        return [super canPerformAction:action withSender:sender];
    }
}

@end
