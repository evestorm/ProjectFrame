//
//  NSString+HelperKit.h
//  ProjectBase
//
//  Created by 向云飞 on 16/7/30.
//  Copyright © 2016年 向云飞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface NSString (HelperKit)

#pragma mark - 时间戳或者是NSDate转字符
+ (NSString *)stringWithDateNumber:(long long)integer;

+ (NSString *)stringWithDateNumber:(long long)integer formatter:(NSString *)formatter;

+ (NSString *)stringWithDate:(NSDate *)date;

+ (NSString *)stringWithDate:(NSDate *)date formatter:(NSString *)formatter;

#pragma mark - 计算文字的尺寸大小
/**
 *  根据最大宽度 计算文本尺寸
 *
 *  @param font 文本字体
 *  @param maxW 文本最大宽度
 *
 *  @return 返回文字尺寸
 */
- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW;

/**
 *  根据最大高度 计算文本尺寸
 *
 *  @param font 文本字体
 *  @param maxH 文本最大高度
 *
 *  @return 返回文字尺寸
 */
- (CGSize)sizeWithFont:(UIFont *)font maxH:(CGFloat)maxH;

/**
 *  根据指定size 计算文本尺寸
 *
 *  @param font 文本字体
 *  @param size 指定size
 *
 *  @return 返回文本尺寸
 */
- (CGSize)getSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;

/**
 *  根据指定的最大size 计算文字的大小
 *
 *  @param font    文本字体
 *  @param maxSize 指定的最大size
 *
 *  @return 返回文本尺寸
 */
- (CGSize)sizeWithFont:(UIFont *)font andMaxSize:(CGSize)maxSize;

/**
 *  计算文本尺寸 默认为最宽
 *
 *  @param font 文本字体
 *
 *  @return 返回文本尺寸
 */
- (CGSize)sizeWithFont:(UIFont *)font;


#pragma mark - URLEncodeding 编码
- (NSString *)URLEncodedString;


#pragma mark - 修改字符串属性
/**
 *  修改字符串中某一段字符串属性
 *
 *  @param text             待修改字符串
 *  @param pendingCharacter 要修改属性的字符串
 *  @param color            要修改属性的字符串颜色
 *
 *  @return 返回修改之后的字符串
 */
+ (NSMutableAttributedString *)getAttributeFromText:(NSString *)text pendingCharacter:(NSString *)pendingCharacter pendingColor:(UIColor *)color;

/**
 *  修改字符串中某一段字符串属性
 *
 *  @param text             待修改字符串
 *  @param pendingCharacter 要修改属性的字符串
 *  @param color            要修改属性的字符串颜色
 *  @param font             要修改属性的字符串字体
 *
 *  @return 返回修改之后的字符串
 */
+ (NSMutableAttributedString *)getAttributeFromText:(NSString *)text pendingCharacter:(NSString *)pendingCharacter pendingColor:(UIColor *)color pendingFont:(UIFont *)font;

/**
 *  批量修改字符串中某几段字符属性
 *
 *  @param texts             待修改字符串数组
 *  @param pendingCharacters 待修改属性的字符串数组
 *  @param colors            待修改属性的字符串颜色数组
 *
 *  @return 返回修改之后的字符串
 */
+ (NSMutableAttributedString *)getAttributeFromTexts:(NSArray *)texts pendingCharacters:(NSArray *)pendingCharacters pendingColors:(NSArray *)colors;

/**
 *  批量修改字符串中某几段字符属性
 *
 *  @param texts             待修改字符串数组
 *  @param pendingCharacters 待修改属性的字符串数组
 *  @param colors            待修改属性的字符串颜色数组
 *  @param fonts             待修改属性的字符串字体数组
 *
 *  @return 返回修改之后的字符串
 */
+ (NSMutableAttributedString *)getAttributeFromTexts:(NSArray *)texts pendingCharacters:(NSArray *)pendingCharacters pendingColors:(NSArray *)colors pendingFont:(NSArray *)fonts;

/**
 *  图文混排:文字+图片
 *
 *  @param texts             待修改字符串数组
 *  @param pendingCharacters 待修改属性的字符串数组
 *  @param colors            待修改属性的字符串颜色数组
 *  @param fonts             待修改属性的字符串字体数组
 *
 *  @return 返回修改之后的字符串
 */
+ (NSMutableAttributedString *)getAttributeFromText:(NSString *)text imageName:(NSString *)imageName imageRect:(CGRect)imageRect imageInFront:(BOOL)imageinfront;


#pragma mark - string data 互转
/**
 *  string转data
 *
 */
- (NSData *)stringToData;

/**
 *  data转string
 *
 */
+ (NSString *)toStringWithData:(NSData *)data;


#pragma mark - 判断字符串时候为邮件、电话号码、身份证、密码校验
/**
 *  判断字符串是否为邮件
 *
 *  @return 正确返回YES 错误返回NO
 */
- (BOOL)isEmail;

/**
 *  判断字符串是否为邮件
 *
 *  @return 正确返回YES 错误返回NO
 */
+ (BOOL)isEmail:(NSString *)email;

/**
 *  判断字符串时候为移动电话号码
 *
 *  @return 正确返回YES 错误返回NO
 */
- (BOOL)isMobilePhone;

/**
 *  判断字符串时候为移动电话号码
 *
 *  @return 正确返回YES 错误返回NO
 */

+ (BOOL)isMobilePhone:(NSString *)mobilePhone;

/**
 *  判断字符串时候为身份证
 *
 *  @return 正确返回YES 错误返回NO
 */

- (BOOL)isPersonID;

/**
 *  判断字符串时候为身份证
 *
 *  @return 正确返回YES 错误返回NO
 */

+ (BOOL)isPersonID:(NSString *)personID;



#pragma mark - 加密和解密
/**
 *  md5加密
 *
 *  @return 返回32位MD5加密字符
 */
- (NSString *)stringToMD5;

/**
 *  md5加密
 *
 *  @return 返回16位MD5加密字符
 */
- (NSString *)stringTo16MD5;

/**
 *  sha1加密
 *
 *  @return 返回sha1加密字符
 */
- (NSString *)sha1;

/**
 *  sha256加密
 *
 *  @return 返回sha256加密字符
 */
- (NSString *)sha256;

/**
 *  sha512加密
 *
 *  @return 返回sha512加密字符
 */
- (NSString *)sha512;




#pragma mark - 获取沙盒应用路径
+ (NSString *)documentPath;

+ (NSString *)tmpPath;

+ (NSString *)cachePath;

//转为documents下的子文件夹(做数据库存储用)
@property (nonatomic,copy,readonly) NSString *documentsSubFolder;







@end
