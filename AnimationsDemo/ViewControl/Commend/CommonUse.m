//
//  CommonUse.m
//  RongTianShi
//
//  Created by mac on 16/4/14.
//  Copyright © 2016年 youshixiu. All rights reserved.
//

#import "CommonUse.h"
#import <AudioToolbox/AudioToolbox.h>
#import <SystemConfiguration/SystemConfiguration.h>

@implementation CommonUse
//添加动画
+(void)addAnimationView:(UIView *)view type:(NSString *)type subType:(NSString *)subType
{
    // 立方体、吸收、翻转、波纹、翻页、反翻页、镜头开、镜头关
    CATransition *transition = [CATransition animation];
    transition.duration = 1.5f;
    transition.type = type;
    transition.subtype = subType;
    [view.layer addAnimation:transition forKey:@"animation"];
    
    //        transition.type = @"cube";//立方体
    //        transition.type = @"suckEffect";//没什么效果 吸收
    //        transition.type = @"oglFlip";//  翻转 不管subType is "fromLeft" or "fromRight",official只有一种效果
    
    //                          @"rippleEffect";// 波纹
    //        transition.type = @"pageCurl"; // 翻页
    //        transition.type = @"pageUnCurl"; // 反翻页
    //        transition.type = @"cameraIrisHollowOpen "; // 镜头开
    //        transition.type = @"cameraIrisHollowClose "; // 镜头关
    
    
    //    transition.type 的类型可以有
    //    淡化、推挤、揭开、覆盖
    //    NSString * const kCATransitionFade;//交叉淡化过渡
    //    NSString * const kCATransitionMoveIn;//新视图移到旧视图上面
    //    NSString * const kCATransitionPush;//新视图把旧视图推出去
    //    NSString * const kCATransitionReveal;//将旧视图移开,显示下面的新视图
    //    这四种，
    //    transition.subtype
    //    也有四种
    //    NSString * const kCATransitionFromRight;
    //    NSString * const kCATransitionFromLeft;
    //    NSString * const kCATransitionFromTop;
    //    NSString * const kCATransitionFromBottom;
}

//暂停 layer 层的动画
+ (void)pauseLayer:(CALayer*)layer
{
    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    layer.speed = 0.0;
    layer.timeOffset = pausedTime;
}

//继续layer上面的动画
+ (void)resumeLayer:(CALayer*)layer
{
    CFTimeInterval pausedTime = [layer timeOffset];
    layer.speed = 1.0;
    layer.timeOffset = 0.0;
    layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    layer.beginTime = timeSincePause;
}
@end
