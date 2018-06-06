//
//  NSString+Extension.h
//  PabeiProject
//
//  Created by siping ruan on 16/11/8.
//  Copyright © 2016年 Rasping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

/**
 检测手机号
 */
- (BOOL)examinePhoneNumber;

/**
 格式化手机号(138-xxxx-xxxx)
 */
- (NSString *)formatPhoneNumber;
/**
 车牌号校验
 */
- (BOOL)examineNumberPlate;
/**
 校验账号
 */
- (BOOL)examineAcount;
/**
 校验密码
 */
- (BOOL)examinePassword;
/**
 校验验证码
 */
- (BOOL)examineVerifyCode;
/**
 格式化时间(2017-10-10 13:13:00)
 */
- (NSString *)formatterTime;
/**
 字符串中插入空格(a b c)
 */
- (NSString *)insertSpaceString;
/**
 校验是否为数字
 */
- (BOOL)examineNumber;
/**
 判断字符串是否为汉字字符串
 */
- (BOOL)isChinese;
/**
 判断字符串是否包含汉字
 */
- (BOOL)includeChinese;
/**
 查询js函数中的函数名
 */
- (NSString *)searchJSFunctionName;
//判断字符串是否为空
+(BOOL)isNull:(id)object;
/**
 转换金额单位
 */
- (NSString *)convertMoneyUnit;

/**
   四舍五入保留两位小数
 */
+(float)roundFloat:(NSString *)price;

/**
 在字符串中搜索数字
 */
- (NSInteger)searchIntWithString;

@end
