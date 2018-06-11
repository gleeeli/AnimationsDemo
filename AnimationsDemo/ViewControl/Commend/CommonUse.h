//
//  CommonUse.h
//  RongTianShi
//
//  Created by mac on 16/4/14.
//  Copyright © 2016年 youshixiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface CommonUse : NSObject

//添加动画
+(void)addAnimationView:(UIView *)view type:(NSString *)type subType:(NSString *)subType;
//暂停 layer 层的动画
+ (void)pauseLayer:(CALayer*)layer;
//继续layer上面的动画
+ (void)resumeLayer:(CALayer*)layer;
@end
