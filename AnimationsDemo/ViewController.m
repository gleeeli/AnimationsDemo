//
//  ViewController.m
//  AnimationsDemo
//
//  Created by zqh on 2017/12/7.
//  Copyright © 2017年 WeiEr. All rights reserved.
//

#import "ViewController.h"
#import "LiveAnimationViewController.h"
#import "CommSysAnimationViewController.h"
#import "WaterProgressViewController.h"
#import "DrageBadgeViewController.h"


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray *muArray;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"动画选择";
    self.muArray = [[NSMutableArray alloc] initWithObjects:@"直播间全屏喇叭或发送礼物",@"常见系统动画",@"水波进度动画",@"泡泡拖拽效果", nil];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.muArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *title = self.muArray[indexPath.row];
    if ([title isEqualToString:@"直播间全屏喇叭或发送礼物"])
    {
        UIStoryboard *storyboar = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LiveAnimationViewController *myDetailVC = [storyboar instantiateViewControllerWithIdentifier:@"LiveAnimationViewController"];
        myDetailVC.title = title;
        [self.navigationController pushViewController:myDetailVC animated:YES];
    }
    else if ([title isEqualToString:@"常见系统动画"])
    {
        UIStoryboard *storyboar = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        CommSysAnimationViewController *myDetailVC = [storyboar instantiateViewControllerWithIdentifier:@"CommSysAnimationViewController"];
        myDetailVC.title = title;
        [self.navigationController pushViewController:myDetailVC animated:YES];
    }
    else if ([title isEqualToString:@"水波进度动画"])
    {
        UIStoryboard *storyboar = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        WaterProgressViewController *myDetailVC = [storyboar instantiateViewControllerWithIdentifier:@"WaterProgressViewController"];
        myDetailVC.title = title;
        [self.navigationController pushViewController:myDetailVC animated:YES];
    }
    else if ([title isEqualToString:@"泡泡拖拽效果"])
    {
        DrageBadgeViewController *myDetailVC = [[DrageBadgeViewController alloc] init];
        myDetailVC.title = title;
        [self.navigationController pushViewController:myDetailVC animated:YES];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SystemIdentifier"];
    cell.textLabel.text = self.muArray[indexPath.row];
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}


@end
