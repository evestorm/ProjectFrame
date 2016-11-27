//
//  BaseViewModel.h
//  ProjectBase
//
//  Created by 向云飞 on 2016/10/17.
//  Copyright © 2016年 向云飞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BatchRequest.h"

typedef void(^success)(); /**< 成功回调*/
typedef void(^failure)(id failure);

@interface BaseViewModel : NSObject

+ (void)failure:(failure)failure tip:(NSString *)tip;

@end
