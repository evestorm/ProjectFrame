//
//  UIView+LoadingView.m
//  ProjectBase
//
//  Created by 向云飞 on 16/8/4.
//  Copyright © 2016年 向云飞. All rights reserved.
//

#import "UIView+LoadingView.h"

static char LoadingViewKey;

@implementation UIView (LoadingView)

- (void)setLoadingView:(LoadingView *)loadingView {
    [self willChangeValueForKey:@"LoadingViewKey"];
    objc_setAssociatedObject(self, &LoadingViewKey, loadingView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"LoadingViewKey"];
}

- (LoadingView *)loadingView {
    return objc_getAssociatedObject(self, &LoadingViewKey);
}

- (void)beginLoading {
    if (!self.loadingView) {
        self.loadingView = [[LoadingView alloc] initWithFrame:self.bounds];
        [self addSubview:self.loadingView];
        [self.loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
        }];
    }
    [self.loadingView startAnimation];
}

- (void)endLoading {
    if (self.loadingView) {
        [self.loadingView stopAnimation];
        [self.loadingView removeFromSuperview];
    }
}

@end
