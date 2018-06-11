//
//  DrageBadgeViewController.m
//  AnimationsDemo
//
//  Created by zqh on 2018/6/11.
//  Copyright © 2018年 WeiEr. All rights reserved.
//

#import "DrageBadgeViewController.h"
#import "PPDragDropBadgeView.h"
#import "Masonry.h"

@interface DrageBadgeViewController ()
@property (nonatomic, strong) PPDragDropBadgeView* badgeView;
@property (nonatomic, strong) PPDragDropBadgeView* badgeView2;
@end

@implementation DrageBadgeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.badgeView = [[PPDragDropBadgeView alloc] initWithFrame:CGRectMake(100, 90, 100, 100) dragdropCompletion:^{
        NSLog(@"TableViewCell drag done.");
    }];
    
    //self.badgeView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    self.badgeView.text = @"999999";
    [self.view addSubview:self.badgeView];
    
    CGRect rect = self.badgeView.frame;
    rect.size.width = 100;
    self.badgeView.frame = rect;
    
    [self createBadgeMasonry];
}

- (void)createBadgeMasonry
{
    self.badgeView2 = [[PPDragDropBadgeView alloc] initWithDragdropCompletion:^{
        NSLog(@"TableViewCell drag done.");
    }];
    
    //self.badgeView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    self.badgeView2.text = @"我是masonry布局";
    [self.view addSubview:self.badgeView2];
    [self.badgeView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.top.equalTo(self.badgeView.mas_bottom).offset(80);
        make.center.equalTo(self.view);
        make.width.height.mas_equalTo(150);
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
