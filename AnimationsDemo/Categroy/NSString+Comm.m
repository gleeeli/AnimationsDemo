//
//  NSString+Comm.m
//  ZhongQiuHui
//
//  Created by zqh on 2017/11/7.
//  Copyright © 2017年 WeiEr. All rights reserved.
//

#import "NSString+Comm.h"

@implementation NSString (Comm)
+ (NSString *)lr_stringDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    return dateString;
}

@end
