//
//  AnimationModel.m
//  ZhongQiuHui
//
//  Created by zqh on 2017/12/7.
//  Copyright © 2017年 WeiEr. All rights reserved.
//

#import "AnimationModel.h"

@implementation AnimationModel
- (NSDictionary *)getGiftInfo
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    switch (self.animationType)
    {
        case AnimationTypeQiuYi:
        {
            [dict setObject:@"球衣" forKey:@"GiftName"];
            [dict setObject:@"an_qiuyi" forKey:@"GiftImageName"];
        }
            break;
        case AnimationTypeShouMi:
        {
            [dict setObject:@"收米" forKey:@"GiftName"];
            [dict setObject:@"an_shoumi" forKey:@"GiftImageName"];
        }
            break;
        case AnimationTypeZhaTa:
        {
            [dict setObject:@"炸他" forKey:@"GiftName"];
            [dict setObject:@"an_zhata" forKey:@"GiftImageName"];
        }
            break;
            
        default:
            break;
    }
    return dict;
}
@end
