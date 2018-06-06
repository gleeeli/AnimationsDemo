//
//  UIImage+ClipImage.h
//  ZhongQiuHui
//
//  Created by zqh on 2017/11/6.
//  Copyright © 2017年 WeiEr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ClipImage)
/**
 *根据给定的size的宽高比自动缩放原图片、自动判断截取位置,进行图片截取,有时候裁剪有点问题
 * UIImage image 原始的图片
 * CGSize size 截取图片的size
 */
- (UIImage *)clipImageToRect:(CGSize)size;

/**
 用颜色生成图片
 
 @param color 颜色
 */
+ (UIImage*)imageWithColor:(UIColor*)color;

/**
 缩放图片到指定大小
 */
- (UIImage *)reSizeImageToSize:(CGSize)reSize;
@end
