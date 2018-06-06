//
//  FullScreenWordRunAnimationView.m
//  ZhongQiuHui
//
//  Created by zqh on 2017/12/7.
//  Copyright © 2017年 WeiEr. All rights reserved.
//

#import "FullScreenWordRunAnimationView.h"
#import "UIColor+ColorConvert.h"

@interface FullScreenWordRunAnimationView()<CAAnimationDelegate>
@property (strong, nonatomic) NSMutableArray *modelsMuArray;
@property (strong, nonatomic) NSMutableArray *animationViewsMuArray;
@property (strong, nonatomic) UILabel *lastLabel;
@property (assign, nonatomic) CGFloat speed;
//@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) CADisplayLink *displayLink;
@end

@implementation FullScreenWordRunAnimationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.speed = SCREEN_WIDTH / 5.0;
        self.modelsMuArray = [[NSMutableArray alloc] init];
        self.animationViewsMuArray = [[NSMutableArray alloc] init];
        //NSLog(@"速度：%f",self.speed);
//        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(scrollLabel) userInfo:nil repeats:YES];
        
        self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(scrollLabel)];
        [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        
        self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}

/**
 添加一个动画内容
 */
- (void)addContent:(AnimationModel *)model
{
    // 如果当前
    if ([self.modelsMuArray count] == 0)
    {
        [self.modelsMuArray addObject:model];
        [self startNextLabelAnimationFirstWithInterval:0];
    }
    else
    {
        [self.modelsMuArray addObject:model];
    }
}

- (void)scrollLabel
{
    if ([self.animationViewsMuArray count] > 0)
    {
        //全部结束的label需要移除
        UILabel *needRemoveLabel = nil;
        for (UILabel *label in self.animationViewsMuArray)
        {
            //UILabel *label = [self.animationViewsMuArray lastObject];
            CGRect rect = label.frame;
            rect.origin.x = rect.origin.x - self.speed * 1.0/60.0;
            label.frame = rect;
            
            CGFloat startX = self.frame.size.width;
            CGFloat firstX = startX - rect.size.width;
            CGFloat nowX = label.frame.origin.x;
            
            CGFloat endX = - rect.size.width;
            if (nowX <= firstX && label.tag == 111)//第一阶段动画完成
            {
                label.tag = 222;
                [self.modelsMuArray removeObjectAtIndex:0];
                [self startNextLabelAnimationFirstWithInterval:kHalfSCaleOnIphone6(56)];
            }
            if (nowX <= endX)// 全部结束
            {
                needRemoveLabel = label;
            }
        }
        
        if (needRemoveLabel)
        {
            // 删除完成的label
            [self.animationViewsMuArray removeObject:needRemoveLabel];
            
            if ([self.animationViewsMuArray count] == 0)
            {
                [self allAnimationComplete];
            }
        }
    }
    else
    {
    }
}

/**
 下一个label开始第一阶段动画
 */
- (void)startNextLabelAnimationFirstWithInterval:(CGFloat)interval
{
    if ([self.modelsMuArray count] > 0)
    {
        AnimationModel *model = [self.modelsMuArray firstObject];
        
        NSLog(@"开始第一阶段动画：%@的",model.contentTxt);
        UILabel *label = [self getStartLabelWithModel:model interval:interval];
        
        [self.animationViewsMuArray addObject:label];
    }
}

- (void)allAnimationComplete
{
    NSLog(@"---全屏喇叭所有动画完成----");
    if (self.allComplete)
    {
        self.allComplete();
    }
}

#pragma mark 内部方法
- (void)animationLabel:(UIView *)view
{
    CABasicAnimation *anim = [CABasicAnimation animation];
    
    anim.keyPath = @"position";
    
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(250, 500)];
    
    // 必须设置代理
    anim.delegate = self;
    
    // 取消反弹
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    
    [view.layer addAnimation:anim forKey:nil];
}

- (UILabel *)getStartLabelWithModel:(AnimationModel *)model interval:(CGFloat)interval
{
    NSString *context = [NSString stringWithFormat:@"“%@” 说 %@",model.nickName,model.contentTxt];
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:kHalfFloat(24)];
    label.textColor = [UIColor colorWithHexString:@"#ffe855"];
    label.text = context;
    label.tag = 111;
    
    CGFloat labelX = self.frame.size.width + interval;
    CGFloat labelHeight = self.frame.size.height;
    CGRect labelRect = [self getTextRect:label.text font:label.font];
    CGFloat labelWidth = labelRect.size.width + kHalfFloat(10);
    
    label.frame = CGRectMake(labelX, 0, labelWidth, labelHeight);
    [self addSubview:label];
    
    return label;
}

#pragma mark <CAAnimationDelegate>

- (void)animationDidStart:(CAAnimation *)anim
{
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    NSLog(@"当前flag：%d的",flag);
}

- (CGRect)getTextRect:(NSString *)text font:(UIFont *)font
{
    // 获取文字尺寸
    CGRect titleBounds = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    
    return titleBounds;
}

/**
 停止动画
 */
- (void)stopAnimation
{
//    if (self.timer)
//    {
//        if ([self.timer isValid])
//        {
//            [self.timer invalidate];
//        }
//        self.timer = nil;
//    }
    
    if (self.displayLink)
    {
        [self.displayLink invalidate];
        self.displayLink = nil;
    }
}

- (void)dealloc
{
    [self stopAnimation];
}

@end
