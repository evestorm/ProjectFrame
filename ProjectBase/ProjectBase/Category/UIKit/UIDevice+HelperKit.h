//
//  UIDevice+HelperKit.h
//  ProjectBase
//
//  Created by 向云飞 on 16/7/26.
//  Copyright © 2016年 向云飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (HelperKit)

/**
 *  获取设备类型
 */
+ (NSString *)devicePlatform;

/**
 *  获取设备类型
 */
+ (NSString *)devicePlatformString;


/**
 *  检测当前设备是否为iPad
 */
+ (BOOL)isiPad;

/**
 *  检测当前设备是否为iPhone
 */
+ (BOOL)isiPhone;

/**
 *  检测当前设备是否为iPod
 */
+ (BOOL)isiPod;

/**
 *  检测当前设备是否为模拟器
 */
+ (BOOL)isSimulator;

/**
 *  检测当前设备是否为视网膜屏幕
 */
+ (BOOL)isRetina;

/**
 *  检测当前设备是否为视网膜高清屏
 */
+ (BOOL)isRetinaHD;

/**
 *  获取当前设备的系统版本号
 */
+ (NSString *)iOSVersion;

/**
 *  获取当前设备的CPU频率
 */
+ (NSUInteger)cpuFrequency;

/**
 *  获取当前设备总线频率
 */
+ (NSUInteger)busFrequency;

/**
 *  获取当前设备的RAM大小
 */
+ (NSUInteger)ramSize;

/**
 *  获取当前设备的CPU 型号
 */
+ (NSUInteger)cpuNumber;

/**
 *  获取当前设备的内存大小
 */
+ (NSUInteger)totalMemory;

/**
 *  获取当前设备的已用内存大小
 */
+ (NSUInteger)userMemory;

/**
 *  获取当前设备的磁盘空间大小
 */
+ (NSNumber *)totalDiskSpace;

/**
 *  获取当前设备的空闲磁盘空间大小
 */
+ (NSNumber *)freeDiskSpace;

/**
 *  获取当前设备的MAC地址
 */
+ (NSString *)macAddress;

/**
 *  获取当前设备的UUID
 */
+ (NSString *)uniqueIdentifier;


@end
