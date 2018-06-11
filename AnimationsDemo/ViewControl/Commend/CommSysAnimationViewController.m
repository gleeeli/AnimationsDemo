//
//  CommSysAnimationViewController.m
//  AnimationsDemo
//
//  Created by zqh on 2018/6/11.
//  Copyright © 2018年 WeiEr. All rights reserved.
//

#import "CommSysAnimationViewController.h"
#import "CommonUse.h"
#import "Masonry.h"

@interface CommSysAnimationViewController ()

@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (strong, nonatomic) NSMutableArray *muarray;
@property (assign, nonatomic) NSInteger curNum;
@property (weak, nonatomic) IBOutlet UILabel *animationInfoLabel;
@property (weak, nonatomic) IBOutlet UIImageView *fishImageView;
@property (weak, nonatomic) IBOutlet UIButton *transtitionBtn;
@property(copy) NSString *subType;

@end

@implementation CommSysAnimationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.muarray = [[NSMutableArray alloc] initWithObjects:@"cube",@"suckEffect",@"oglFlip",@"rippleEffect",@"pageCurl",@"pageUnCurl",@"cameraIrisHollowOpen",@"cameraIrisHollowClose", nil];
    self.subType = kCATransitionFromLeft;
//    NSLog(@"输出结果cur:%d,count:%ld",self.curNum,[self.muarray count]);
}

- (void)setCurNum:(NSInteger)curNum
{
//    NSLog(@"cur:%d,count:%ld",curNum,[self.muarray count]);
    if (curNum > 0 && curNum >= [_muarray count])
    {
        curNum = 0;
    }
    _curNum = curNum;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (IBAction)startBtnClick:(id)sender
{
    UIButton *btn = sender;
    if (!btn.selected)
    {
        self.curNum = -1;
    }
    
    btn.selected = YES;
    
    self.curNum ++;
    
    NSString *animationType = self.muarray[self.curNum];
    self.animationInfoLabel.text = [self getCurInfoWithType:animationType];
    [CommonUse addAnimationView:self.fishImageView type:animationType subType:self.subType];
    
}

- (IBAction)continuePlayer:(id)sender
{
    [self.fishImageView.layer removeAllAnimations];
    NSString *animationType = self.muarray[self.curNum];
    [CommonUse addAnimationView:self.fishImageView type:animationType subType:self.subType];
}

- (IBAction)selTransitonType:(id)sender
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"选择过渡类型" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"交叉淡化过渡" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.subType = kCATransitionFade;
        [self.transtitionBtn setTitle:@"交叉淡化过渡" forState:UIControlStateNormal];
        [self continuePlayer:nil];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"新视图移到旧视图上面" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.subType = kCATransitionMoveIn;
        [self.transtitionBtn setTitle:@"新视图移到旧视图上面" forState:UIControlStateNormal];
        [self continuePlayer:nil];
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"新视图把旧视图推出去" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.subType = kCATransitionPush;
        [self.transtitionBtn setTitle:@"新视图把旧视图推出去" forState:UIControlStateNormal];
        [self continuePlayer:nil];
    }];
    UIAlertAction *action4 = [UIAlertAction actionWithTitle:@"将旧视图移开,显示下面的新视图" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.subType = kCATransitionReveal;
        [self.transtitionBtn setTitle:@"将旧视图移开,显示下面的新视图" forState:UIControlStateNormal];
        [self continuePlayer:nil];
    }];
    
    UIAlertAction *action5 = [UIAlertAction actionWithTitle:@"从右开始" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.subType = kCATransitionFromRight;
        [self.transtitionBtn setTitle:@"从右开始" forState:UIControlStateNormal];
        [self continuePlayer:nil];
    }];
    UIAlertAction *action6 = [UIAlertAction actionWithTitle:@"从左开始" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.subType = kCATransitionFromLeft;
        [self.transtitionBtn setTitle:@"从左开始" forState:UIControlStateNormal];
        [self continuePlayer:nil];
    }];
    UIAlertAction *action7 = [UIAlertAction actionWithTitle:@"从上开始" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.subType = kCATransitionFromTop;
        [self.transtitionBtn setTitle:@"从上开始" forState:UIControlStateNormal];
        [self continuePlayer:nil];
    }];
    UIAlertAction *action8 = [UIAlertAction actionWithTitle:@"从下开始" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.subType = kCATransitionFromBottom;
        [self.transtitionBtn setTitle:@"将旧视图移开,显示下面的新视图" forState:UIControlStateNormal];
        [self continuePlayer:nil];
    }];
    [alertVC addAction:action1];
    [alertVC addAction:action2];
    [alertVC addAction:action3];
    [alertVC addAction:action4];
    
    [alertVC addAction:action5];
    [alertVC addAction:action6];
    [alertVC addAction:action7];
    [alertVC addAction:action8];
    
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (NSString *)getCurInfoWithType:(NSString *)type
{
    NSString *message = @"";
    if ([type isEqualToString:@"cube"])
    {
        message = [NSString stringWithFormat:@"立方体动画 参数：%@",type];
    }
    else if ([type isEqualToString:@"suckEffect"])
    {
        message = [NSString stringWithFormat:@"吸收动画 参数：%@",type];
    }
    else if ([type isEqualToString:@"oglFlip"])
    {
        message = [NSString stringWithFormat:@"翻转动画 参数：%@",type];
    }
    else if ([type isEqualToString:@"rippleEffect"])
    {
        message = [NSString stringWithFormat:@"波纹动画 参数：%@",type];
    }else if ([type isEqualToString:@"pageCurl"])
    {
        message = [NSString stringWithFormat:@"翻页动画 参数：%@",type];
    }
    else if ([type isEqualToString:@"pageUnCurl"])
    {
        message = [NSString stringWithFormat:@"反翻页动画 参数：%@",type];
    }
    else if ([type isEqualToString:@"cameraIrisHollowOpen"])
    {
        message = [NSString stringWithFormat:@"镜头开动画 参数：%@",type];
    }
    else if ([type isEqualToString:@"cameraIrisHollowClose"])
    {
        message = [NSString stringWithFormat:@"镜头关动画 参数：%@",type];
    }
    
    return message;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
