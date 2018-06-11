//
//  WaterProgressView.m
//  Wi-Fi_Disk
//
//  Created by dsw on 16/12/28.
//  Copyright © 2016年 LiuMaoWen. All rights reserved.
//
#define PI 3.14159265358979323846
#import "WaterProgressView.h"
//#import "YYWeakProxy.h"

#define LXDefaultFirstWaveColor [UIColor colorWithRed:34/255.0 green:116/255.0 blue:210/255.0 alpha:1]
#define LXDefaultSecondWaveColor [UIColor colorWithRed:34/255.0 green:116/255.0 blue:210/255.0 alpha:0.3]

@interface WaterProgressView ()
@property (nonatomic,assign)CGFloat yHeight;
@property (nonatomic,assign)CGFloat offset;
@property (nonatomic,strong)CADisplayLink * timer;
@property (nonatomic,strong)CAShapeLayer * firstWaveLayer;
@property (nonatomic,strong)CAShapeLayer * secondWaveLayer;

@end

@implementation WaterProgressView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self baseFrame:CGSizeMake(MIN(frame.size.width, frame.size.height), MIN(frame.size.width, frame.size.height))];
    }
    return self;
}


- (void)baseFrame:(CGSize)frameSize
{
    //[super setFrame:frame];
    
    self.bounds = CGRectMake(0, 0, MIN(frameSize.width, frameSize.height), MIN(frameSize.width, frameSize.height));
    self.layer.cornerRadius = MIN(frameSize.width, frameSize.height) * 0.5;
    self.layer.masksToBounds = YES;
    self.layer.borderColor = [UIColor clearColor].CGColor;
    self.layer.borderWidth = 5.0f;
    
    self.waveHeight = 5.0;
    self.firstWaveColor = LXDefaultFirstWaveColor;
    self.secondWaveColor = LXDefaultSecondWaveColor;
    self.yHeight = self.bounds.size.height;
    self.speed=1.0;
    
    [self.layer addSublayer:self.firstWaveLayer];
    if (!self.isShowSingleWave) {
        [self.layer addSublayer:self.secondWaveLayer];
    }
    
    //[self addSubview:self.progressLabel];
}


-(void)setProgress:(CGFloat)progress
{
    _progress = progress;
    _progressLabel.text = [NSString stringWithFormat:@"%ld%%",(long)[[NSNumber numberWithFloat:progress * 100] integerValue]];
    _progressLabel.textColor=[UIColor colorWithWhite:progress*1.8 alpha:1];
    self.yHeight = self.bounds.size.height * (1 - progress);
    
    [self stopWaveAnimation];
    [self startWaveAnimation];
}


#pragma mark -- 开始波动动画
- (void)startWaveAnimation
{
    self.timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(waveAnimation)];
    [self.timer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    
}


#pragma mark -- 停止波动动画
- (void)stopWaveAnimation
{
    
    [self.timer invalidate];
    self.timer = nil;
}

#pragma mark -- 波动动画实现
- (void)waveAnimation
{
    CGFloat waveHeight = self.waveHeight;
    if (self.progress == 0.0f || self.progress == 1.0f) {
        waveHeight = 0.f;
    }
    
    self.offset += self.speed;
    //第一个波纹
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGFloat startOffY = waveHeight * sinf(self.offset * M_PI * 2 / self.bounds.size.width);
    CGFloat orignOffY = 0.0;
    CGPathMoveToPoint(pathRef, NULL, 0, startOffY);
    for (CGFloat i = 0.f; i <= self.bounds.size.width; i++) {
        orignOffY = waveHeight * sinf(2 * M_PI / self.bounds.size.width * i + self.offset * M_PI * 2 / self.bounds.size.width) + self.yHeight;
        CGPathAddLineToPoint(pathRef, NULL, i, orignOffY);
    }
    
    CGPathAddLineToPoint(pathRef, NULL, self.bounds.size.width, orignOffY);
    CGPathAddLineToPoint(pathRef, NULL, self.bounds.size.width, self.bounds.size.height);
    CGPathAddLineToPoint(pathRef, NULL, 0, self.bounds.size.height);
    CGPathAddLineToPoint(pathRef, NULL, 0, startOffY);
    CGPathCloseSubpath(pathRef);
    self.firstWaveLayer.path = pathRef;
    self.firstWaveLayer.fillColor = self.firstWaveColor.CGColor;
    CGPathRelease(pathRef);
    
    //第二个波纹
    if (!self.isShowSingleWave) {
        CGMutablePathRef pathRef1 = CGPathCreateMutable();
        CGFloat startOffY1 = waveHeight * sinf(self.offset * M_PI * 2 / self.bounds.size.width);
        CGFloat orignOffY1 = 0.0;
        CGPathMoveToPoint(pathRef1, NULL, 0, startOffY1);
        for (CGFloat i = 0.f; i <= self.bounds.size.width; i++) {
            orignOffY1 = waveHeight * cosf(2 * M_PI / self.bounds.size.width * i + self.offset * M_PI * 2 / self.bounds.size.width) + self.yHeight;
            CGPathAddLineToPoint(pathRef1, NULL, i, orignOffY1);
        }
        
        CGPathAddLineToPoint(pathRef1, NULL, self.bounds.size.width, orignOffY1);
        CGPathAddLineToPoint(pathRef1, NULL, self.bounds.size.width, self.bounds.size.height);
        CGPathAddLineToPoint(pathRef1, NULL, 0, self.bounds.size.height);
        CGPathAddLineToPoint(pathRef1, NULL, 0, startOffY1);
        CGPathCloseSubpath(pathRef1);
        self.secondWaveLayer.path = pathRef1;
        self.secondWaveLayer.fillColor = self.secondWaveColor.CGColor;
        
        CGPathRelease(pathRef1);
    }
    
}

#pragma mark ----- INITUI ----
-(CAShapeLayer *)firstWaveLayer{
    if (!_firstWaveLayer) {
        _firstWaveLayer = [CAShapeLayer layer];
        _firstWaveLayer.frame = self.bounds;
        _firstWaveLayer.fillColor = _firstWaveColor.CGColor;
    }
    return _firstWaveLayer;
}

-(CAShapeLayer *)secondWaveLayer{
    if (!_secondWaveLayer) {
        _secondWaveLayer = [CAShapeLayer layer];
        _secondWaveLayer.frame = self.bounds;
        _secondWaveLayer.fillColor = _secondWaveColor.CGColor;
    }
    return _secondWaveLayer;
}

-(UILabel *)progressLabel{
    if (!_progressLabel) {
        _progressLabel=[[UILabel alloc] init];
        _progressLabel.text=@"0%";
        _progressLabel.frame=CGRectMake(0, 0, self.bounds.size.width, 30);
        _progressLabel.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
        _progressLabel.font=[UIFont systemFontOfSize:20];
        _progressLabel.textColor=[UIColor colorWithWhite:0 alpha:1];
        _progressLabel.textAlignment=1;
    }
    return _progressLabel;
}



-(void)dealloc
{
    [self.timer invalidate];
    self.timer = nil;
    
    if (_firstWaveLayer) {
        [_firstWaveLayer removeFromSuperlayer];
        _firstWaveLayer = nil;
    }
    
    if (_secondWaveLayer) {
        [_secondWaveLayer removeFromSuperlayer];
        _secondWaveLayer = nil;
    }
}


//- (void)drawRect:(CGRect)rect
//{
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSaveGState(context);//画完后,先保存图形上下文的状态
//    CGPoint center = CGPointMake(rect.size.width * 0.5, rect.size.height * 0.5);
//    CGFloat radius = rect.size.width * 0.5 - 2;
//    //画圆
//    CGContextRef context1 = UIGraphicsGetCurrentContext();
//    
//    CGContextSetRGBStrokeColor(context1,255/255.0,255/255.0,255/255.0,1.0);//画笔线的颜色
//    CGContextSetLineWidth(context1, 1.0);//线的宽度
//    CGContextAddArc(context1, center.x, center.y, radius, 0, 2 * PI, 0); //添加一个圆
//    CGContextDrawPath(context1, kCGPathStroke); //绘制路径
//}


@end
