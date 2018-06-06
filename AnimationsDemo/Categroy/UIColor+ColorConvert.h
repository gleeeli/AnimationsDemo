//
//  UIColor+ColorConvert.h
//  ZhongQiuHui
//
//  Created by zqh on 2017/10/19.
//  Copyright © 2017年 WeiEr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (ColorConvert)

// 颜色转换：iOS中（以#开头）十六进制的颜色转换为UIColor(RGB)
+ (UIColor *) colorWithHexString: (NSString *)color;

@end
