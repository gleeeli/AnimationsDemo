//
//  UIImage+ClipImage.m
//  ZhongQiuHui
//
//  Created by zqh on 2017/11/6.
//  Copyright © 2017年 WeiEr. All rights reserved.
//

#import "UIImage+ClipImage.h"

@implementation UIImage (ClipImage)

/**
 *根据给定的size的宽高比自动缩放原图片、自动判断截取位置,进行图片截取
 * UIImage image 原始的图片
 * CGSize size 截取图片的size
 */
-(UIImage *)clipImageToRect:(CGSize)size
{
    
    //被切图片宽比例比高比例小 或者相等，以图片宽进行放大
    if (self.size.width*size.height <= self.size.height*size.width)
    {
        
        //以被剪裁图片的宽度为基准，得到剪切范围的大小
        CGFloat width  = self.size.width;
        CGFloat height = self.size.width * size.height / size.width;
        
        // 调用剪切方法
        // 这里是以中心位置剪切，也可以通过改变rect的x、y值调整剪切位置
        return [self imageFromImage:self inRect:CGRectMake(0, (self.size.height -height)/2, width, height)];
        
    }else{ //被切图片宽比例比高比例大，以图片高进行剪裁
        
        // 以被剪切图片的高度为基准，得到剪切范围的大小
        CGFloat width  = self.size.height * size.width / size.height;
        CGFloat height = self.size.height;
        
        // 调用剪切方法
        // 这里是以中心位置剪切，也可以通过改变rect的x、y值调整剪切位置
        return [self imageFromImage:self inRect:CGRectMake((self.size.width -width)/2, 0, width, height)];
    }
    return nil;
}

/**
 *从图片中按指定的位置大小截取图片的一部分
 * UIImage image 原始的图片
 * CGRect rect 要截取的区域
 */
- (UIImage *)imageFromImage:(UIImage *)image inRect:(CGRect)rect
{
    
    //将UIImage转换成CGImageRef
    CGImageRef sourceImageRef = [image CGImage];
    
    //按照给定的矩形区域进行剪裁
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);
    
    //将CGImageRef转换成UIImage
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    
    //返回剪裁后的图片
    return newImage;
}

/**
 用颜色生成图片

 @param color 颜色
 */
+ (UIImage*)imageWithColor:(UIColor*)color
{
    
    CGRect rect = CGRectMake(0.0f,0.0f,1.0f,1.0f);
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

/**
 缩放图片到指定大小
 */
- (UIImage *)reSizeImageToSize:(CGSize)reSize
{
    if([[UIScreen mainScreen] scale] == 2.0) // @2x
    {
        UIGraphicsBeginImageContextWithOptions(reSize, NO, 2.0);
    }
    else if([[UIScreen mainScreen] scale] == 3.0)// @3x ( iPhone 6plus 、iPhone 6s plus)
    {
        UIGraphicsBeginImageContextWithOptions(reSize, NO, 3.0);
    }
    else
    {
        UIGraphicsBeginImageContext(reSize);
    }
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}
@end
