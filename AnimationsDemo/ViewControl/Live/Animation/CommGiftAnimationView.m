//
//  CommGiftAnimationView.m
//  AnimationsDemo
//
//  Created by zqh on 2017/12/8.
//  Copyright © 2017年 WeiEr. All rights reserved.
//

#import "CommGiftAnimationView.h"

@implementation CommGiftAnimationView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self createBaseView];
    }
    return self;
}

- (void)createBaseView
{
    UILabel *labelTop = [[UILabel alloc] init];
    self.labelTop = labelTop;
    labelTop.font = [UIFont systemFontOfSize:kHalfSCaleOnIphone6(28)];
    labelTop.textColor = [UIColor whiteColor];
    [self addSubview:labelTop];
    [labelTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(kHalfSCaleOnIphone6(12)-2);
        make.leading.equalTo(self).offset(kHalfSCaleOnIphone6(24));
    }];
    
    UILabel *labelBottom = [[UILabel alloc] init];
    self.labelBottom = labelBottom;
    labelBottom.font = [UIFont systemFontOfSize:kHalfSCaleOnIphone6(22)];
    labelBottom.textColor = [UIColor whiteColor];//colorWithHexString:@"#ffdaoc"
    [self addSubview:labelBottom];
    [labelBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(labelTop.mas_bottom).offset((kHalfSCaleOnIphone6(10)-2));
        make.leading.equalTo(labelTop);
    }];
    
    CGFloat percentnum = 450.0/293.0;//求出左边坐标占中点的百分比
    UILabel *numLabel= [[UILabel alloc] init];
    self.numLabel = numLabel;
    //numLabel.backgroundColor = [UIColor blueColor];
    numLabel.font = [UIFont systemFontOfSize:kHalfSCaleOnIphone6(36)];
    numLabel.textColor = [UIColor colorWithHexString:@"#ff5512"];//
    [self setNumLabelText:1];
    [self addSubview:numLabel];
    [numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.mas_centerX).multipliedBy(percentnum);
        make.centerY.equalTo(self);
    }];
    
    CGFloat giftWidth = kHalfSCaleOnIphone6(126);
    //CGFloat percentgift = 307.0/293.0;//求出左边坐标占中点的百分比
    UIImageView *giftImageView = [[UIImageView alloc] init];
    self.giftImageView = giftImageView;
    [self addSubview:giftImageView];
    [giftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
//        make.leading.equalTo(self.mas_centerX).multipliedBy(percentgift);
        make.trailing.equalTo(self.mas_leading);
        make.width.mas_equalTo(giftWidth);
        make.height.mas_equalTo(kHalfSCaleOnIphone6(83));
    }];
    
}

/**
 设置底部小说明
 
 @param content 比如：收米，球衣
 */
- (void)setBottomLabelText:(NSString *)content
{
    NSString *allStr = [NSString stringWithFormat:@"送出 %@",content];
    NSRange range = [allStr rangeOfString:content];
    NSMutableAttributedString *muStr = [[NSMutableAttributedString alloc] initWithString:allStr];
    // content
    [muStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#ffda0c"] range:range];
    [muStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:kHalfSCaleOnIphone6(24)] range:range];
    self.labelBottom.attributedText = muStr;
}

/**
 设置礼物个数

 @param num 个数
 */
- (void)setNumLabelText:(NSInteger)num
{
    NSString *nums = [NSString stringWithFormat:@"%ld",num];
    NSString *allStr = [NSString stringWithFormat:@"x %@ ",nums];
    NSRange range = [allStr rangeOfString:nums];
    NSMutableAttributedString *muStr = [[NSMutableAttributedString alloc] initWithString:allStr];
    [muStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:kHalfSCaleOnIphone6(36)] range:NSMakeRange(0, 1)];
    [muStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:kHalfSCaleOnIphone6(5)] range:NSMakeRange(1, 1)];
    // num
    [muStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:kHalfSCaleOnIphone6(51)] range:range];
    [muStr addAttribute:NSObliquenessAttributeName value:[NSNumber numberWithFloat:0.3] range:range];
    
    self.numLabel.attributedText = muStr;
    
    [self startNumAnimation];
}


- (void)startGiftAnimation
{
    CGFloat giftWidth = kHalfSCaleOnIphone6(126);
    CGFloat percentgift = 307.0/293.0;//求出左边坐标占中点的百分比
    [UIView animateWithDuration:0.3 delay:0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self.giftImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.leading.equalTo(self.mas_centerX).multipliedBy(percentgift);
            make.width.mas_equalTo(giftWidth);
            make.height.mas_equalTo(kHalfSCaleOnIphone6(83));
        }];
        [self.giftImageView.superview layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
}

- (void)startNumAnimation
{
    CGFloat kAnimationDuration = 0.3f;
    CAGradientLayer *contentLayer = (CAGradientLayer *)self.numLabel.layer;
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)];
    scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.3, 1.3, 1)];
    scaleAnimation.duration = kAnimationDuration;
    scaleAnimation.cumulative = NO;
    scaleAnimation.repeatCount = 1;
    [scaleAnimation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    [contentLayer addAnimation: scaleAnimation forKey:@"myScale"];
}
@end
