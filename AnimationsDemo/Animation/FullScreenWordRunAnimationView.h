//
//  FullScreenWordRunAnimationView.h
//  ZhongQiuHui
//
//  Created by zqh on 2017/12/7.
//  Copyright © 2017年 WeiEr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnimationModel.h"
#import "CommHeader.h"

typedef void(^AllFullTAnimationComplete)(void);
@interface FullScreenWordRunAnimationView : UIView

@property (copy, nonatomic) AllFullTAnimationComplete allComplete;

/**
 添加一个动画内容
 */
- (void)addContent:(AnimationModel *)model;

/**
 停止动画
 */
- (void)stopAnimation;
@end
