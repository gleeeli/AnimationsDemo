//
//  WaterProgressViewController.m
//  AnimationsDemo
//
//  Created by zqh on 2018/6/11.
//  Copyright © 2018年 WeiEr. All rights reserved.
//

#import "WaterProgressViewController.h"
#import "WaterProgressView.h"
#import "Masonry.h"

@interface WaterProgressViewController ()
@property (weak, nonatomic) IBOutlet UISlider *slider;

@property (strong, nonatomic) WaterProgressView *progressView;
@end

@implementation WaterProgressViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.slider.value = 0.5;
    
    // 渐变色
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithRed:93/255.0 green:205/255.0 blue:150/255.0 alpha:1].CGColor,
                             (__bridge id)[UIColor colorWithRed:63/255.0 green:200/255.0 blue:164/255.0 alpha:1].CGColor];
    gradientLayer.locations = @[@0.0,@1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
//    [self.view.layer addSublayer:gradientLayer];
    [self.view.layer insertSublayer:gradientLayer below:self.slider.layer];
    
    
    CGFloat width = 200;
    self.progressView = [[WaterProgressView alloc] init];
    
    float realRadius = width;
    [self.progressView baseFrame:CGSizeMake(realRadius, realRadius)];
    self.progressView.layer.cornerRadius = width * 0.5;
    self.progressView.layer.borderColor = [UIColor colorWithRed:137/255.0 green:219/255.0 blue:189/255.0 alpha:1].CGColor;
    self.progressView.layer.borderWidth = 1.0;
    self.progressView.progress = 0.5;
    self.progressView.waveHeight = 5;
    self.progressView.speed = 0.5;
    self.progressView.firstWaveColor = [UIColor colorWithRed:193/255.0 green:237/255.0 blue:221/255.0 alpha:1];
    self.progressView.secondWaveColor = [UIColor colorWithRed:193/255.0 green:237/255.0 blue:221/255.0 alpha:0.5];
//    self.progressView.alpha = 0.5;
    
    [self.view addSubview:self.progressView];
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.height.mas_offset(width);
    }];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
   
}
- (IBAction)sliderValueChange:(id)sender
{
    self.progressView.progress = self.slider.value;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
