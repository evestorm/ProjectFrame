//
//  LineMenuView.m
//  ProjectBase
//
//  Created by 向云飞 on 16/8/10.
//  Copyright © 2016年 向云飞. All rights reserved.
//

#import "LineMenuView.h"



@interface LineMenuView (){
    CGRect _animateFromFrame;
    CGRect _animateToFrame;
    CGFloat _menuHeight;
    CGFloat _menuWidth;
    UIView *_prevTargetView;
    CGRect _prevTargetRect;
}


@property (nonatomic, strong) UIView *view;
@property (nonatomic, strong) UIWindow *mainWindow;
@property (nonatomic, strong) ContainerWindow *window;
@property (nonatomic, assign) BOOL animate;


@end

@implementation LineMenuView
@synthesize menuVisible = _menuVisible;

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initlization];
    }
    return self;
}

- (void)initlization {
    _view = [UIView  new];
    _window = [[ContainerWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _view.backgroundColor = [UIColor colorWithHexString:@"454545"];
    _view.layer.cornerRadius = 5.f;
    _menuHeight = 30.f;
    _menuWidth = 180;
    _prevTargetView = nil;
    _prevTargetRect = CGRectZero;
    _animate = NO;
    UIApplication *appliction = [UIApplication sharedApplication];
    _mainWindow = appliction.keyWindow;
    [_window addSubview:self.view];
    __weak typeof(self) weakSelf = self;
    _window.tapBeyondSubViewsBlock = ^(){
        [weakSelf setMenuVisible:NO animated:/*weakSelf.animate*/NO];
    };
}


+ (instancetype)shareLineMenu {
    static LineMenuView *lineMenu;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        lineMenu = [[LineMenuView alloc] init];
    });
    return lineMenu;
}


- (void)setMenuItems:(NSArray *)menuItems {
    _menuItems = menuItems;
    [self setupSubViews];
}


- (void)setTargetRect:(CGRect)targetRect inView:(UIView *)targetView {
    if (CGRectEqualToRect(_prevTargetRect, targetRect) && targetView == _prevTargetView) {
        return;
    }
    _prevTargetView = targetView;
    _prevTargetRect = targetRect;
    
    
    _animateFromFrame = CGRectMake(targetRect.origin.x, targetRect.origin.y, 0, _menuHeight);
    _animateToFrame = CGRectMake(targetRect.origin.x - _menuWidth, targetRect.origin.y, _menuWidth, _menuHeight);
    _animateFromFrame = [targetView convertRect:_animateFromFrame toView:_mainWindow];
    _animateFromFrame = [self.window convertRect:_animateFromFrame fromWindow:_mainWindow];
    _animateToFrame = [targetView convertRect:_animateToFrame toView:_mainWindow];
    _animateToFrame = [self.window convertRect:_animateToFrame fromWindow:_mainWindow];
    self.view.frame = _animateFromFrame;
    
    [self.window makeKeyAndVisible];
    
}

- (void)setMenuVisible:(BOOL)menuVisible animated:(BOOL)animated {
    _menuVisible = menuVisible;
    _animate = animated;
    if (menuVisible) {
        if (animated) {
            [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionLayoutSubviews | UIViewAnimationOptionCurveEaseInOut
                             animations:^{
                                 self.view.frame = _animateToFrame;
                             } completion:nil];
        } else {
            self.view.frame = _animateToFrame;
        }
    } else {
        if (animated) {
            [UIView animateWithDuration:0.25 animations:^{
                self.view.frame = _animateFromFrame;
            } completion:^(BOOL finished) {
                [self resignAfterInvisible];
            }];
        } else {
            self.view.frame = _animateFromFrame;
            [self resignAfterInvisible];
        }
    }
}

- (void)resignAfterInvisible {
    [self.window resignKeyWindow];
    [_mainWindow makeKeyAndVisible];
    _prevTargetRect = CGRectZero;
    _prevTargetView = nil;
    _animate = NO;
    _menuVisible = NO;
}


- (void)setMenuVisible:(BOOL)menuVisible {
    [self setMenuVisible:menuVisible animated:NO];
}

- (BOOL)isMenuVisible {
    return _menuVisible;
}

#pragma mark - private methods
- (void)setupSubViews {
    [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    [self.menuItems enumerateObjectsUsingBlock:^(LineMenuItem *menuItem, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:[menuItem valueForKey:@"title"] forState:UIControlStateNormal];
        [button setImage:[menuItem valueForKey:@"image"] forState:UIControlStateNormal];
        [button setImage:[menuItem valueForKey:@"selectedImage"] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(tapMenu:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
        button.tag = idx;
        [self.view addSubview:button];
    }];
    [self layoutSubviews];
}

- (void)layoutSubviews {
    NSInteger menuCount = self.menuItems.count;
    //using autolayout
    __weak typeof(self) weakSelf = self;
    [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            if (idx == 0) {
                make.left.equalTo(weakSelf.view);
            } else {
                UIView *view = weakSelf.view.subviews[idx -1];
                make.left.equalTo(view.mas_right);
                make.width.equalTo(view.mas_width);
            }
            
            if (idx == menuCount -1) {
                make.right.equalTo(weakSelf.view);
            }
            
            make.top.equalTo(weakSelf.view);
            make.bottom.equalTo(weakSelf.view);
        }];
    }];
    
}

- (UIView *)lineViewWithMenuItem:(LineMenuItem *)menuItem {
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor blackColor];
    return lineView;
}


- (void)tapMenu:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didTapMenuIndex:)]) {
        [self.delegate didTapMenuIndex:sender.tag];
    }
    [self setMenuVisible:NO animated:YES];
}


@end


@implementation ContainerWindow

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    __block UIView *viewHitted = nil;
    __weak typeof(self) weakSelf = self;
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj1, NSUInteger idx1, BOOL * _Nonnull stop1) {
            CGRect frame = [obj1 convertRect:obj1.bounds toView:weakSelf];
            if (CGRectContainsPoint(frame, point)) {
                viewHitted = obj1;
                *stop1 = YES;
            }
        }];
        if (viewHitted) {
            *stop = YES;
        }
        if (!viewHitted && CGRectContainsPoint(obj.frame, point)) {
            viewHitted = obj;
            *stop = YES;
        }
    }];
    if (!viewHitted) {
        if (self.tapBeyondSubViewsBlock) {
            self.tapBeyondSubViewsBlock();
        }
        [[UIApplication sharedApplication].keyWindow sendEvent:event];
    }
    return viewHitted;
}

@end
