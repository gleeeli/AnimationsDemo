//
//  BaseGiftAnimationView.h
//  AnimationsDemo
//
//  Created by zqh on 2017/12/8.
//  Copyright © 2017年 WeiEr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "CommHeader.h"
#import "UIColor+ColorConvert.h"
#import "AnimationModel.h"

@interface BaseGiftAnimationView : UIView
@property (strong, nonatomic) UIImageView *giftImageView;
- (void)startGiftAnimation;

/**
 设置礼物个数
 
 @param num 个数
 */
- (void)setNumLabelText:(NSInteger)num;
@end
