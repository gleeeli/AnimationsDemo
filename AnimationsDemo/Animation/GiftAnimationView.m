//
//  GiftAnimationView.m
//  AnimationsDemo
//
//  Created by zqh on 2017/12/8.
//  Copyright © 2017年 WeiEr. All rights reserved.
//

#import "GiftAnimationView.h"
#import "Masonry.h"
#import "CommHeader.h"
#import "UIColor+ColorConvert.h"
#import "CommGiftAnimationView.h"
#import "ZhaTaGiftAnimationView.h"

@interface GiftAnimationView()
@property (strong, nonatomic) BaseGiftAnimationView *contentView;
@property (strong, nonatomic) AnimationModel *curModel;
@end

@implementation GiftAnimationView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self createBaseView];
    }
    return self;
}

- (void)setContentWithModel:(AnimationModel *)model
{
    self.curModel = model;
    
    switch (model.animationType)
    {
        case AnimationTypeZhaTa:
            {
                if (self.contentView)
                {
                    [self.contentView removeFromSuperview];
                    ZhaTaGiftAnimationView *zhaTaView = [[ZhaTaGiftAnimationView alloc] init];
                    self.contentView = zhaTaView;
                    zhaTaView.labelCenterYLeft.text = model.nickName;
                    zhaTaView.labelCenterYRight.text = model.contentTxt;
                    [self addSubview:zhaTaView];
                    [zhaTaView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.height.mas_equalTo(kHalfSCaleOnIphone6(83));
                        make.centerY.equalTo(self);
                        make.leading.equalTo(self);
                        make.trailing.equalTo(self);
                    }];
                }
            }
            break;
            
        default:
        {
            if (self.contentView)
            {
                [self.contentView removeFromSuperview];
                NSDictionary *dict = [model getGiftInfo];
                NSString *giftname = [NSString stringWithFormat:@"%@",[dict objectForKey:@"GiftName"]];
                NSString *imagename = [NSString stringWithFormat:@"%@",[dict objectForKey:@"GiftImageName"]];
                
                CommGiftAnimationView *commView = [[CommGiftAnimationView alloc] init];
                self.contentView = commView;
                // 顶部文字
                commView.labelTop.text = model.nickName;
                [commView setBottomLabelText:giftname];
                // 礼物图片
                commView.giftImageView.image = [UIImage imageNamed:imagename];
                
                [self addSubview:commView];
                [commView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.height.mas_equalTo(kHalfSCaleOnIphone6(83));
                    make.centerY.equalTo(self);
                    make.leading.equalTo(self);
                    make.trailing.equalTo(self);
                }];
            }
        }
            break;
    }
}

/**
 设置礼物个数
 
 @param num 个数
 */
- (void)setNumLabelText:(NSInteger)num
{
    [self.contentView setNumLabelText:num];
}

/**
 开始动画
 */
- (void)startAnimation
{
    [self.contentView startGiftAnimation];
}

#pragma mark - 内部方法
- (void)createBaseView
{
    UIImageView *backImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"an_bg"]];
    [self addSubview:backImageView];
    
    [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.bottom.trailing.equalTo(self);
    }];
    
    BaseGiftAnimationView *contentView = [[BaseGiftAnimationView alloc] init];
    self.contentView = contentView;
    [self addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kHalfSCaleOnIphone6(83));
        make.centerY.equalTo(self);
        make.leading.equalTo(self);
        make.trailing.equalTo(self);
    }];
}

@end
