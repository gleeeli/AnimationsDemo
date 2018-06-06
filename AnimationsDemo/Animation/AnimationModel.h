//
//  AnimationModel.h
//  ZhongQiuHui
//
//  Created by zqh on 2017/12/7.
//  Copyright © 2017年 WeiEr. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum : NSUInteger {
    AnimationTypeShouMi = 0,
    AnimationTypeQiuYi,
    AnimationTypeZhaTa,
} AnimationType;

@interface AnimationModel : NSObject
@property (copy, nonatomic) NSString *contentTxt;
@property (copy, nonatomic) NSString *nickName;
@property (assign, nonatomic) AnimationType animationType;

- (NSDictionary *)getGiftInfo;
@end
