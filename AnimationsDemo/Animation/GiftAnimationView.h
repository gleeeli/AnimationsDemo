//
//  GiftAnimationView.h
//  AnimationsDemo
//
//  Created by zqh on 2017/12/8.
//  Copyright © 2017年 WeiEr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnimationModel.h"

@interface GiftAnimationView : UIView
- (void)setContentWithModel:(AnimationModel *)model;

/**
 开始动画
 */
- (void)startAnimation;

/**
 设置礼物个数
 
 @param num 个数
 */
- (void)setNumLabelText:(NSInteger)num;
@end
