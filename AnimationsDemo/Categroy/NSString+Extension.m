//
//  NSString+Extension.m
//  PabeiProject
//
//  Created by siping ruan on 16/11/8.
//  Copyright © 2016年 Rasping. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

- (BOOL)examinePhoneNumber
{
    NSString *pattern = @"^1[3|4|5|7|8][0-9]\\d{8}$";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSInteger number = [regex numberOfMatchesInString:self options:NSMatchingReportProgress range:NSMakeRange(0, self.length)];
    if (number == 0) {
        return NO;
    }else {
        return YES;
    }
}

- (BOOL)examineNumber
{
    NSString *pattern = @"^[0-9]*$";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSInteger number = [regex numberOfMatchesInString:self options:NSMatchingReportProgress range:NSMakeRange(0, self.length)];
    if (!number) {
        return NO;
    }else {
        return YES;
    }
}

- (NSString *)formatPhoneNumber
{
    
    NSMutableString *result = [NSMutableString stringWithString:self];
    [result insertString:@"-" atIndex:3];
    [result insertString:@"-" atIndex:8];
    return result;
}

- (BOOL)examineNumberPlate
{
    NSString *pattern = @"^[京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领A-Z]{1}[A-Z]{1}[A-Z0-9]{4}[A-Z0-9挂学警港澳]{1}$";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSInteger number = [regex numberOfMatchesInString:self options:NSMatchingReportProgress range:NSMakeRange(0, self.length)];
    if (number == 0) {
        return NO;
    }else {
        return YES;
    }
}

//4到16个英文字母或数字
- (BOOL)examineAcount
{
    NSString *pattern = @"^[a-zA-Z0-9]{4,16}$";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSInteger number = [regex numberOfMatchesInString:self options:NSMatchingReportProgress range:NSMakeRange(0, self.length)];
    if (number == 0) {
        return NO;
    }else {
        return YES;
    }
}

- (BOOL)examinePassword
{
    NSString *pattern = @"^[a-zA-Z0-9]{6,18}$";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSInteger number = [regex numberOfMatchesInString:self options:NSMatchingReportProgress range:NSMakeRange(0, self.length)];
    if (number == 0) {
        return NO;
    }else {
        return YES;
    }
}

- (BOOL)examineVerifyCode
{
    NSString *pattern = @"^[a-zA-Z0-9]{6,6}$";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSInteger number = [regex numberOfMatchesInString:self options:NSMatchingReportProgress range:NSMakeRange(0, self.length)];
    if (number == 0) {
        return NO;
    }else {
        return YES;
    }
}

- (NSString *)formatterTime
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // （@"YYYY-MM-dd hh:mm:ss"）----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[self doubleValue]/1000.0];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;
}

- (NSString *)insertSpaceString
{
//    NSMutableString *string = [NSMutableString string];
//    for (NSInteger index = 0; index < self.length; index++) {
//        unichar character = [self characterAtIndex:index];
//        if (index == self.length - 1) {
//            [string appendFormat:@"%c", character];
//        }else {
//           [string appendFormat:@"%c ", character];
//        }
//    }
    NSMutableString *string = [NSMutableString stringWithString:self];
    [string replaceOccurrencesOfString:@"," withString:@" " options:NSLiteralSearch range:NSMakeRange(0, self.length)];
    return string;
}

- (BOOL)isChinese
{
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:self];
}

- (BOOL)includeChinese
{
    for(int i=0; i< [self length];i++)
    {
        int a =[self characterAtIndex:i];
        if( a >0x4e00&& a <0x9fff){
            return YES;
        }
    }
    return NO;
}

- (NSString *)searchJSFunctionName
{
    NSRange range = [self rangeOfString:@"("];
    return [self substringWithRange:NSMakeRange(9, range.location - 9)];
}

+(BOOL)isNull:(id)object
{
    // 判断是否为空串
    if ([object isEqual:[NSNull null]]) {
        return NO;
    }
    else if ([object isKindOfClass:[NSNull class]])
    {
        return NO;
    }
    else if (object==nil){
        return NO;
    }
    return YES;
}

- (NSString *)convertMoneyUnit
{
    float money = [self floatValue];
    if (money >= 10000) {
        NSInteger value = (NSInteger)(money / 10000);
        return [NSString stringWithFormat:@"%ld万", value];
    }
    return [NSString stringWithFormat:@"%.2f", money];
}
+(float)roundFloat:(NSString *)price{
    
    
    return (floorf([price floatValue]*100 + 0.5))/100;
    
}

- (NSInteger)searchIntWithString
{
    NSScanner *scanner = [NSScanner scannerWithString:self];
    [scanner scanUpToCharactersFromSet:[NSCharacterSet decimalDigitCharacterSet] intoString:nil];
    NSInteger number;
    [scanner scanInteger:&number];
    return number;
}

@end
