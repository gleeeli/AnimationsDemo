//
//  CommonUse.h
//  RongTianShi
//
//  Created by mac on 16/4/14.
//  Copyright © 2016年 youshixiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#define LLSpeciaLogPath @"YSXSpeciallog.txt"

@interface CommonUse : NSObject

/**
 *  强制改变设备的方向
 *
 *  @param interfaceOrientation 指定的方向
 */
+ (void)changeInterfaceOrientaion:(UIInterfaceOrientation)interfaceOrientation;

/**
 *  网络可用
 *
 *  @param
 */

+(BOOL)isConnectionAvailable;

// 检测输入的是否为手机号码
+(BOOL)checkIsPhoneNumber:(NSString *)phoneNumber;
/**
 *  获取当前VC
 */
+(UIViewController *)getCurrentVC;

//color转UIImage
+(UIImage*)createImageWithColor:(UIColor*)color;
/**
 *  写入txt
 *
 *  @param string   写入的字符串
 *  @param homePath 写入的文件路径
 */
+ (void)writefile:(NSString *)string;
//是否包含大写字符
+(BOOL)isContainCapitalStirng:(NSString *)string;
//播放系统声音
+(void)playSystemSound;

//计算文本的宽高
+(CGSize)calculationTextSize:(NSString *)textString cgSize:(CGSize)size font:(CGFloat)font;
+(UIViewController *)storyboadName:(NSString *)storyboadName vcId:(NSString *)vcId;
//添加动画
+(void)addAnimationView:(UIView *)view type:(NSString *)type subType:(NSString *)subType;
+(NSString *)convertToJsonData:(NSDictionary *)dict;
//暂停 layer 层的动画
+ (void)pauseLayer:(CALayer*)layer;
//继续layer上面的动画
+ (void)resumeLayer:(CALayer*)layer;
//UIRectCornerTopLeft UIRectCornerBottomLeft 添加圆角
+(void)addRectLayer:(CALayer *)layer
             corner:(UIRectCorner)corner
             radius:(CGFloat )radius
             bounds:(CGRect)bounds;
+(NSMutableData *)addArmData;
@end
