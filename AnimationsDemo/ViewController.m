//
//  ViewController.m
//  AnimationsDemo
//
//  Created by zqh on 2017/12/7.
//  Copyright © 2017年 WeiEr. All rights reserved.
//

#import "ViewController.h"
#import "FullScreenWordRunAnimationView.h"
#import "AnimationModel.h"
#import "GiftAnimationView.h"
#import "Masonry.h"
#import "UIColor+ColorConvert.h"

@interface ViewController ()
@property (strong, nonatomic) FullScreenWordRunAnimationView *animationView;
@property (strong, nonatomic) GiftAnimationView *giftView;
//@property (strong, nonatomic) GiftAnimationView *giftView2;
@property (assign, nonatomic) NSInteger num;
@property (strong, nonatomic) UIView *trumpetView;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.num = 0;
    CGFloat trumpetHeight = kHalfSCaleOnIphone6(52);
    UIView *trumpetView = [[UIView alloc] init];
    self.trumpetView = trumpetView;
    trumpetView.backgroundColor = [UIColor colorWithHexString:@"#ff9c6c"];
    [self.view addSubview:trumpetView];
    [trumpetView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo (self.view).offset(kHalfSCaleOnIphone6(695));
        make.height.mas_equalTo(trumpetHeight);
        make.leading.equalTo(self.view);
        make.trailing.equalTo(self.view);
    }];
    
    CGFloat imageViewWidth = kHalfSCaleOnIphone6(37);
    CGFloat leftVWidth = kHalfSCaleOnIphone6(24) + imageViewWidth + kHalfSCaleOnIphone6(24);
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, leftVWidth, trumpetHeight)];
    leftView.backgroundColor = [UIColor colorWithHexString:@"#ff9c6c"];
    [trumpetView addSubview:leftView];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kHalfSCaleOnIphone6(24), 0, imageViewWidth, trumpetHeight)];
    imageView.image = [UIImage imageNamed:@"an_trumpet"];
    [leftView addSubview:imageView];
    
    CGFloat anFullX = CGRectGetMaxX(leftView.frame);
    CGFloat anFullWidth = SCREEN_WIDTH - anFullX - kHalfSCaleOnIphone6(24);
    FullScreenWordRunAnimationView *animationView = [[FullScreenWordRunAnimationView alloc] initWithFrame:CGRectMake(anFullX, 0, anFullWidth, trumpetHeight)];
    self.animationView = animationView;
    animationView.layer.masksToBounds = YES;
    animationView.allComplete = ^{
        trumpetView.hidden = YES;
    };
    [trumpetView addSubview:animationView];
    
//    for (int i = 0; i < 2; i++)
//    {
//        AnimationModel *model = [[AnimationModel alloc] init];
//        model.contentTxt = [NSString stringWithFormat:@"---内容%d内容----",i];
//        model.nickName = @"无名氏";
//        [animationView addContent:model];
//    }
    
    CGFloat giftWidth = kHalfSCaleOnIphone6(586);
    GiftAnimationView *giftView = [[GiftAnimationView alloc] init];
    self.giftView = giftView;
    [self.view addSubview:giftView];
    [giftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kHalfSCaleOnIphone6(747));
        make.leading.equalTo(self.view).offset(-giftWidth);
        make.width.mas_equalTo(giftWidth);
        make.height.mas_equalTo(kHalfSCaleOnIphone6(137));
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (IBAction)giftBtnClick:(id)sender
{
    //[self startGif2AnimationWithView:self.giftView type:AnimationTypeZhaTa];
    
    [self startGif2AnimationWithView:self.giftView type:AnimationTypeShouMi];
}

- (IBAction)fullScreenBtnClick:(id)sender
{
    [self fullScreenTrumpet];
}

- (void)fullScreenTrumpet
{
    self.trumpetView.hidden = NO;
    // 全屏喇叭
    AnimationModel *model = [[AnimationModel alloc] init];
    model.contentTxt = [NSString stringWithFormat:@"---内容%@内容----",@"点击"];
    model.nickName = @"无名氏";
    
    [self.animationView addContent:model];
}

- (void)startGif2AnimationWithView:(GiftAnimationView *)anView type:(AnimationType)type
{
    AnimationModel *anmodel = [[AnimationModel alloc] init];
    anmodel.animationType = type;
    anmodel.nickName = @"有一种球叫绝对";
    anmodel.contentTxt = @"一路荆棘";
    [anView setContentWithModel:anmodel];
    
    [UIView animateWithDuration:0.3 animations:^{
        [anView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.view).offset(0);
        }];
        [anView.superview layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
    [anView startAnimation];
}

- (IBAction)plusBtnClick:(id)sender
{
    self.num ++;
    [self.giftView setNumLabelText:self.num];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}


@end
