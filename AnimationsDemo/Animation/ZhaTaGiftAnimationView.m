//
//  ZhaTaGiftAnimationView.m
//  AnimationsDemo
//
//  Created by zqh on 2017/12/8.
//  Copyright © 2017年 WeiEr. All rights reserved.
//

#import "ZhaTaGiftAnimationView.h"

@implementation ZhaTaGiftAnimationView
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
    UILabel *labelCenterYLeft = [[UILabel alloc] init];
    self.labelCenterYLeft = labelCenterYLeft;
    labelCenterYLeft.font = [UIFont systemFontOfSize:kHalfSCaleOnIphone6(28)];
    labelCenterYLeft.textColor = [UIColor whiteColor];//colorWithHexString:@"#ffdaoc"
    [self addSubview:labelCenterYLeft];
    [labelCenterYLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.leading.equalTo(self).offset(kHalfSCaleOnIphone6(24));
    }];
    
    UILabel *labelCenterYRight = [[UILabel alloc] init];
    //labelCenterYRight.backgroundColor = [UIColor greenColor];
    self.labelCenterYRight = labelCenterYRight;
    labelCenterYRight.font = [UIFont systemFontOfSize:kHalfSCaleOnIphone6(28)];
    labelCenterYRight.textColor = [UIColor whiteColor];//colorWithHexString:@"#ffdaoc"
    labelCenterYRight.textAlignment = NSTextAlignmentRight;
    
    [self addSubview:labelCenterYRight];
    [labelCenterYRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(kHalfSCaleOnIphone6(-80));
    }];
    
    CGFloat giftWidth = kHalfSCaleOnIphone6(66);
    UIImageView *giftImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"an_zhata"]];
    self.giftImageView = giftImageView;
    [self addSubview:giftImageView];
    [giftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.centerX.equalTo(self.mas_leading).offset(-giftWidth * 0.5);
        make.width.mas_equalTo(giftWidth);
        make.height.mas_equalTo(kHalfSCaleOnIphone6(76));
    }];
    
}

- (void)startGiftAnimation
{
    CGFloat giftWidth = kHalfSCaleOnIphone6(66);
    [UIView animateWithDuration:0.3 delay:0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self.giftImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.width.mas_equalTo(giftWidth);
            make.height.mas_equalTo(kHalfSCaleOnIphone6(76));
        }];
        
        [self.giftImageView.superview layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
    
    //[self.giftImageView layoutIfNeeded];
}

@end
