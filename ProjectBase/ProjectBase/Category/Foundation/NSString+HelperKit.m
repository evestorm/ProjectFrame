//
//  NSString+HelperKit.m
//  ProjectBase
//
//  Created by 向云飞 on 16/7/30.
//  Copyright © 2016年 向云飞. All rights reserved.
//

#import "NSString+HelperKit.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (HelperKit)


#pragma mark - 时间戳或者是NSDate转字符
+ (NSString *)stringWithDateNumber:(long long)integer {
    return [self stringWithDateNumber:integer formatter:@"yyyy-MM-dd HH:mm"];
}

+ (NSString *)stringWithDateNumber:(long long)integer formatter:(NSString *)formatter {
    if (integer <= 0) return @"";
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:integer];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    if (!formatter) {
        formatter = @"yyyy-MM-dd HH:mm:ss";
    }
    
    [dateFormatter setDateFormat:formatter];
    NSString *currentDateStr = [dateFormatter stringFromDate:date];
    return currentDateStr;
    
}

+ (NSString *)stringWithDate:(NSDate *)date {
    return [self stringWithDate:date formatter:@"yyyy-MM-dd HH:mm"];
}

+ (NSString *)stringWithDate:(NSDate *)date formatter:(NSString *)formatter {
    
    if (!date) {
        return @"";
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    if (!formatter) {
        formatter = @"yyyy-MM-dd HH:mm:ss";
    }
    
    [dateFormatter setDateFormat:formatter];
    NSString *currentDateStr = [dateFormatter stringFromDate:date];
    return currentDateStr;
}


#pragma mark - 计算文字的尺寸大小
/**
 *  根据最大宽度 计算文本尺寸
 *
 *  @param font 文本字体
 *  @param maxW 文本最大宽度
 *
 *  @return 返回文字尺寸
 */
- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW {
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, 0.0);
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attr context:nil].size;
}

/**
 *  根据最大高度 计算文本尺寸
 *
 *  @param font 文本字体
 *  @param maxH 文本最大高度
 *
 *  @return 返回文字尺寸
 */
- (CGSize)sizeWithFont:(UIFont *)font maxH:(CGFloat)maxH {
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(0.0, maxH);
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attr context:nil].size;
}

/**
 *  根据指定size 计算文本尺寸
 *
 *  @param font 文本字体
 *  @param size 指定size
 *
 *  @return 返回文本尺寸
 */
- (CGSize)getSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size {
    CGSize resultSize = CGSizeZero;
    if (self.length <= 0) {
        return resultSize;
    }
    resultSize = [self boundingRectWithSize:size options:(NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName: font} context:nil].size;
    resultSize = CGSizeMake(MIN(size.width, ceilf(resultSize.width)), MIN(size.height, ceilf(resultSize.height)));
    return resultSize;
}

/**
 *  根据指定的最大size 计算文字的大小
 *
 *  @param font    文本字体
 *  @param maxSize 指定的最大size
 *
 *  @return 返回文本尺寸
 */
- (CGSize)sizeWithFont:(UIFont *)font andMaxSize:(CGSize)maxSize {
    NSDictionary *arrts = @{NSFontAttributeName:font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:arrts context:nil].size;
}

/**
 *  计算文本尺寸 默认为最宽
 *
 *  @param font 文本字体
 *
 *  @return 返回文本尺寸
 */
- (CGSize)sizeWithFont:(UIFont *)font {
    return [self sizeWithFont:font maxW:MAXFLOAT];
}


#pragma mark - URLEncodeding 编码
- (NSString *)URLEncodedString {
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self, (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]", NULL, kCFStringEncodingUTF8));
    return encodedString;
}


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
+ (NSMutableAttributedString *)getAttributeFromText:(NSString *)text pendingCharacter:(NSString *)pendingCharacter pendingColor:(UIColor *)color {
    NSMutableAttributedString *mutableString = [[NSMutableAttributedString alloc] initWithString:text];
    [mutableString addAttribute:NSForegroundColorAttributeName value:color range:[text rangeOfString:pendingCharacter]];
    return mutableString;
}

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
+ (NSMutableAttributedString *)getAttributeFromText:(NSString *)text pendingCharacter:(NSString *)pendingCharacter pendingColor:(UIColor *)color pendingFont:(UIFont *)font {
    NSMutableAttributedString *mutableString = [[NSMutableAttributedString alloc] initWithString:text];
    [mutableString addAttribute:NSForegroundColorAttributeName value:color range:[text rangeOfString:pendingCharacter]];
    [mutableString addAttribute:NSFontAttributeName value:font range:[text rangeOfString:pendingCharacter]];
    return mutableString;
}

/**
 *  批量修改字符串中某几段字符属性
 *
 *  @param texts             待修改字符串数组
 *  @param pendingCharacters 待修改属性的字符串数组
 *  @param colors            待修改属性的字符串颜色数组
 *
 *  @return 返回修改之后的字符串
 */
+ (NSMutableAttributedString *)getAttributeFromTexts:(NSArray *)texts pendingCharacters:(NSArray *)pendingCharacters pendingColors:(NSArray *)colors {
    NSMutableAttributedString *mutableString = [[NSMutableAttributedString alloc] init];
    if (texts.count != pendingCharacters.count || texts.count != colors.count) return nil;
    
    for (int i = 0; i < texts.count; i ++) {
        [mutableString appendAttributedString:[NSString getAttributeFromText:texts[i] pendingCharacter:pendingCharacters[i] pendingColor:colors[i]]];
    }
    
    return mutableString;
}

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
+ (NSMutableAttributedString *)getAttributeFromTexts:(NSArray *)texts pendingCharacters:(NSArray *)pendingCharacters pendingColors:(NSArray *)colors pendingFont:(NSArray *)fonts {
    NSMutableAttributedString *mutableString = [[NSMutableAttributedString alloc] init];
    if (texts.count != pendingCharacters.count || texts.count != colors.count || texts.count != fonts.count) return nil;
    
    for (int i = 0; i < texts.count; i ++) {
        [mutableString appendAttributedString:[NSString getAttributeFromText:texts[i] pendingCharacter:pendingCharacters[i] pendingColor:colors[i] pendingFont:fonts[i]]];
    }

    return mutableString;
    
}

+ (NSMutableAttributedString *)getAttributeFromText:(NSString *)text imageName:(NSString *)imageName imageRect:(CGRect)imageRect imageInFront:(BOOL)imageinfront{
    NSMutableAttributedString *mutableString = [[NSMutableAttributedString alloc] initWithString:text];
    
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    attch.image = [UIImage imageNamed:imageName];
    attch.bounds = imageRect;
    
    NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
    
    
    if (imageinfront) {
        [mutableString insertAttributedString:string atIndex:0];
    } else {
        [mutableString appendAttributedString:string];
    }
    
    return mutableString;
}


#pragma mark - string data 互转
/**
 *  string转data
 *
 */
- (NSData *)stringToData {
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}

/**
 *  data转string
 *
 */
+ (NSString *)toStringWithData:(NSData *)data {
    if (data && [data isKindOfClass:[NSData class]]) {
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    
    return nil;
}


#pragma mark - 判断字符串时候为邮件、电话号码、身份证
/**
 *  判断字符串是否为邮件
 *
 *  @return 正确返回YES 错误返回NO
 */
- (BOOL)isEmail {
    return [NSString isEmail:self];
}

/**
 *  判断字符串是否为邮件
 *
 *  @return 正确返回YES 错误返回NO
 */
+ (BOOL)isEmail:(NSString *)email {
    NSString *reg =
    @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
    @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
    @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
    @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
    @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
    @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
    @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", reg];
    return [predicate evaluateWithObject:[email lowercaseString]];
}

/**
 *  判断字符串时候为移动电话号码
 *
 *  @return 正确返回YES 错误返回NO
 */
- (BOOL)isMobilePhone {
    return [NSString isMobilePhone:self];
}

/**
 *  判断字符串时候为移动电话号码
 *
 *  @return 正确返回YES 错误返回NO
 */

+ (BOOL)isMobilePhone:(NSString *)mobilePhone {
    NSString *pattern = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9])|(17[0,0-9]))\\d{8}$";
    NSPredicate *mobilePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    if ([mobilePredicate evaluateWithObject:mobilePhone]) {
        return YES;
    }
    
    return NO;
}

/**
 *  判断字符串时候为身份证
 *
 *  @return 正确返回YES 错误返回NO
 */

- (BOOL)isPersonID {
    return [NSString isPersonID:self];
}

/**
 *  判断字符串时候为身份证
 *
 *  @return 正确返回YES 错误返回NO
 */

+ (BOOL)isPersonID:(NSString *)personID {
    // 判断位数
    if (personID.length != 15 && personID.length != 18) {
        return NO;
    }
    NSString *carid = personID;
    long lSumQT = 0;
    // 加权因子
    int R[] ={7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 };
    // 校验码
    unsigned char sChecker[11]={'1','0','X', '9', '8', '7', '6', '5', '4', '3', '2'};
    
    // 将15位身份证号转换成18位
    NSMutableString *mString = [NSMutableString stringWithString:personID];
    if (personID.length == 15) {
        [mString insertString:@"19" atIndex:6];
        long p = 0;
        const char *pid = [mString UTF8String];
        
        for (int i = 0; i<= 16; i++) {
            p += (pid[i] - 48) * R[i];
        }
        
        int o = p % 11;
        NSString *string_content = [NSString stringWithFormat:@"%c", sChecker[o]];
        [mString insertString:string_content atIndex:[mString length]];
        carid = mString;
    }
    
    // 判断地区码
    NSString * sProvince = [carid substringToIndex:2];
    if (![self _areaCode:sProvince]) {
        return NO;
    }
    
    // 判断年月日是否有效
    // 年份
    int strYear = [[self _substringWithString:carid begin:6 end:4] intValue];
    // 月份
    int strMonth = [[self _substringWithString:carid begin:10 end:2] intValue];
    // 日
    int strDay = [[self _substringWithString:carid begin:12 end:2] intValue];
    
    NSTimeZone *localZone = [NSTimeZone localTimeZone];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setTimeZone:localZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:[NSString stringWithFormat:@"%d-%d-%d 12:01:01",
                                                  strYear, strMonth, strDay]];
    if (date == nil) {
        return NO;
    }
    
    const char *PaperId  = [carid UTF8String];
    // 检验长度
    if(18 != strlen(PaperId)) return NO;
    // 校验数字
    for (int i = 0; i < 18; i++) {
        if ( !isdigit(PaperId[i]) && !(('X' == PaperId[i] || 'x' == PaperId[i]) && 17 == i) ) {
            return NO;
        }
    }
    
    // 验证最末的校验码
    for (int i=0; i<=16; i++) {
        lSumQT += (PaperId[i]-48) * R[i];
    }
    
    if (sChecker[lSumQT%11] != PaperId[17] ) {
        return NO;
    }
    return YES;
}


#pragma mark - 加密和解密
/**
 *  md5加密
 *
 *  @return 返回32位MD5加密字符
 */
- (NSString *)stringToMD5 {
    if (self == nil || self.length == 0) {
        return nil;
    }
    
    unsigned char digest[CC_MD5_DIGEST_LENGTH], i;
    CC_MD5([self UTF8String], (int)[self lengthOfBytesUsingEncoding:NSUTF8StringEncoding], digest);
    NSMutableString *ms = [NSMutableString string];
    
    for (i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [ms appendFormat:@"%02x", (int)(digest[i])];
    }
    
    return [ms copy];
    
}

/**
 *  md5加密
 *
 *  @return 返回16位MD5加密字符
 */
- (NSString *)stringTo16MD5 {
    if (self == nil || [self length] == 0) {
        return nil;
    }
    
    return [[self stringToMD5] substringWithRange:NSMakeRange(8, 16)];
}

/**
 *  sha1加密
 *
 *  @return 返回sha1加密字符
 */
- (NSString *)sha1 {
    if (self == nil || [self length] == 0) {
        return nil;
    }
    
    unsigned char digest[CC_SHA1_DIGEST_LENGTH], i;
    CC_SHA1([self UTF8String], (int)[self lengthOfBytesUsingEncoding:NSUTF8StringEncoding], digest);
    NSMutableString *ms = [NSMutableString string];
    
    for ( i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [ms appendFormat:@"%02x", (int)(digest[i])];
    }
    
    return [ms copy];
}

/**
 *  sha256加密
 *
 *  @return 返回sha256加密字符
 */
- (NSString *)sha256 {
    if (self == nil || [self length] == 0) {
        return nil;
    }
    
    unsigned char digest[CC_SHA256_DIGEST_LENGTH], i;
    CC_SHA256([self UTF8String], (int)[self lengthOfBytesUsingEncoding:NSUTF8StringEncoding], digest);
    NSMutableString *ms = [NSMutableString string];
    
    for (i = 0; i < CC_SHA256_DIGEST_LENGTH; i++) {
        [ms appendFormat: @"%02x", (int)(digest[i])];
    }
    
    return [ms copy];
}

/**
 *  sha512加密
 *
 *  @return 返回sha512加密字符
 */
- (NSString *)sha512 {
    if (self == nil || [self length] == 0) {
        return nil;
    }
    
    unsigned char digest[CC_SHA512_DIGEST_LENGTH], i;
    CC_SHA512([self UTF8String], (int)[self lengthOfBytesUsingEncoding:NSUTF8StringEncoding], digest);
    NSMutableString *ms = [NSMutableString string];
    
    for (i = 0; i < CC_SHA512_DIGEST_LENGTH; i++) {
        [ms appendFormat: @"%02x", (int)(digest[i])];
    }
    
    return [ms copy];
}


#pragma mark - 获取沙盒应用路径
+ (NSString *)documentPath {
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
}

+ (NSString *)tmpPath {
    return [NSHomeDirectory() stringByAppendingPathComponent:@"tmp"];
}

+ (NSString *)cachePath {
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches"];
}

/**
 *  转为documents下的子文件夹
 */
-(NSString *)documentsSubFolder{
    
    NSString *documentFolder=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    return [NSString makeSubFolderInSuperFolder:documentFolder subFloder:self];
    
}

/**
 *  文件夹处理
 */
+(NSString *)makeSubFolderInSuperFolder:(NSString *)superFolder subFloder:(NSString *)subFloder{
    
    NSString *folder=[NSString stringWithFormat:@"%@/%@",superFolder,subFloder];
    
    BOOL isDir = NO;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    BOOL existed = [fileManager fileExistsAtPath:folder isDirectory:&isDir];
    
    if ( !(isDir == YES && existed == YES) )
    {
        [fileManager createDirectoryAtPath:folder withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return folder;
}

#pragma mark - Private
/**
 * 功能:判断是否在地区码内
 * 参数:地区码
 */
+ (BOOL)_areaCode:(NSString *)code {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"北京" forKey:@"11"];
    [dic setObject:@"天津" forKey:@"12"];
    [dic setObject:@"河北" forKey:@"13"];
    [dic setObject:@"山西" forKey:@"14"];
    [dic setObject:@"内蒙古" forKey:@"15"];
    [dic setObject:@"辽宁" forKey:@"21"];
    [dic setObject:@"吉林" forKey:@"22"];
    [dic setObject:@"黑龙江" forKey:@"23"];
    [dic setObject:@"上海" forKey:@"31"];
    [dic setObject:@"江苏" forKey:@"32"];
    [dic setObject:@"浙江" forKey:@"33"];
    [dic setObject:@"安徽" forKey:@"34"];
    [dic setObject:@"福建" forKey:@"35"];
    [dic setObject:@"江西" forKey:@"36"];
    [dic setObject:@"山东" forKey:@"37"];
    [dic setObject:@"河南" forKey:@"41"];
    [dic setObject:@"湖北" forKey:@"42"];
    [dic setObject:@"湖南" forKey:@"43"];
    [dic setObject:@"广东" forKey:@"44"];
    [dic setObject:@"广西" forKey:@"45"];
    [dic setObject:@"海南" forKey:@"46"];
    [dic setObject:@"重庆" forKey:@"50"];
    [dic setObject:@"四川" forKey:@"51"];
    [dic setObject:@"贵州" forKey:@"52"];
    [dic setObject:@"云南" forKey:@"53"];
    [dic setObject:@"西藏" forKey:@"54"];
    [dic setObject:@"陕西" forKey:@"61"];
    [dic setObject:@"甘肃" forKey:@"62"];
    [dic setObject:@"青海" forKey:@"63"];
    [dic setObject:@"宁夏" forKey:@"64"];
    [dic setObject:@"新疆" forKey:@"65"];
    [dic setObject:@"台湾" forKey:@"71"];
    [dic setObject:@"香港" forKey:@"81"];
    [dic setObject:@"澳门" forKey:@"82"];
    [dic setObject:@"国外" forKey:@"91"];
    
    if ([dic objectForKey:code] == nil) {
        return NO;
    }
    return YES;
}

+ (NSString *)_substringWithString:(NSString *)str begin:(NSInteger)begin end:(NSInteger )end {
    return [str substringWithRange:NSMakeRange(begin, end)];
}

@end
