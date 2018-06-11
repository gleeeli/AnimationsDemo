//
//  CommGiftAnimationView.h
//  AnimationsDemo
//
//  Created by zqh on 2017/12/8.
//  Copyright © 2017年 WeiEr. All rights reserved.
//

#import "BaseGiftAnimationView.h"

@interface CommGiftAnimationView : BaseGiftAnimationView
@property (strong, nonatomic) UILabel *labelTop;
@property (strong, nonatomic) UILabel *labelBottom;
@property (strong, nonatomic) UILabel *numLabel;//个数
@property (assign, nonatomic) AnimationType anType;


/**
 设置底部小说明
 
 @param content 比如：收米，球衣
 */
- (void)setBottomLabelText:(NSString *)content;

/**
 设置礼物个数
 
 @param num 个数
 */
- (void)setNumLabelText:(NSInteger)num;
@end
