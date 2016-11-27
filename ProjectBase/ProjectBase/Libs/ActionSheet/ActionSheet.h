//
//  ActionSheet.h
//  ProjectBase
//
//  Created by 向云飞 on 16/9/3.
//  Copyright © 2016年 向云飞. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ActionSheetBlock)(NSInteger selectedIndex,NSString *message);
typedef void(^ActionSheetCancelBlock)();

@interface ActionSheet : UIView

- (instancetype)initWithMessageArray:(NSArray <NSString *>*)messageArray cancel:(NSString *)cancel clickBlock:(ActionSheetBlock)clickBlock cancelBlock:(ActionSheetCancelBlock)cancelBlock;

- (instancetype)initWithMessageArray:(NSArray<NSString *> *)messageArray clickBlock:(ActionSheetBlock)clickBlock;

- (void)showActionSheet;

- (void)dismissActionSheet;

@end
