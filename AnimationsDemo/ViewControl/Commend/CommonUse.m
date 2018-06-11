//
//  CommonUse.m
//  RongTianShi
//
//  Created by mac on 16/4/14.
//  Copyright © 2016年 youshixiu. All rights reserved.
//

#import "CommonUse.h"
#import <AudioToolbox/AudioToolbox.h>
#import <SystemConfiguration/SystemConfiguration.h>

@implementation CommonUse
/**
 *  强制改变设备的方向
 *
 *  @param interfaceOrientation 指定的方向
 */
+ (void)changeInterfaceOrientaion:(UIInterfaceOrientation)interfaceOrientation {
    
    
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        
        SEL selector = NSSelectorFromString(@"setOrientation:");
        
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        
        [invocation setSelector:selector];
        
        [invocation setTarget:[UIDevice currentDevice]];
        
        int val = interfaceOrientation;
        
        [invocation setArgument:&val atIndex:2];
        
        [invocation invoke];
        
    }
}

/**
 *  网络可用
 *
 *  @param
 */

+(BOOL)isConnectionAvailable
{
    SCNetworkReachabilityFlags flags;
    BOOL receivedFlags;
    
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithName(CFAllocatorGetDefault(), [@"www.apple.com" UTF8String]);
    receivedFlags = SCNetworkReachabilityGetFlags(reachability, &flags);
    CFRelease(reachability);
    
    if (!receivedFlags || (flags == 0) )
    {
        return FALSE;
    } else {
        return TRUE;
    }
}

// 检测输入的是否为手机号码
+(BOOL)checkIsPhoneNumber:(NSString *)phoneNumber
{
    return YES;
//    if ([NSString isNull:phoneNumber]){
////        [iToast alertWithTitle:@"手机号不能为空"];
//        return NO;
//    }else if (![phoneNumber isMobile]){
////        [iToast alertWithTitle:@"请输入正确的手机号码"];
//        return NO;
//    }else{
//        return YES;
//    }
}

//获取当前屏幕显示的viewcontroller
+(UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}
//color转UIImage
+(UIImage*)createImageWithColor:(UIColor*)color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

/**
 *  写入txt
 *
 *  @param string   写入的字符串
 *  @param homePath 写入的文件路径
 */
+ (void)writefile:(NSString *)string
{
  NSString *filePath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:LLSpeciaLogPath];

    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if(![fileManager fileExistsAtPath:filePath]) //如果不存在
    {
        [string writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
        
    }
    else
    {
        NSFileHandle *fileHandle = [NSFileHandle fileHandleForUpdatingAtPath:filePath];
        [fileHandle synchronizeFile];
        [fileHandle seekToEndOfFile];  //将节点跳到文件的末尾
        //文件过大清除前面一部分
        unsigned long long fileSize = [fileHandle offsetInFile];
        if (fileSize > (1024 * 1024 * 2)) {
            [fileHandle seekToFileOffset:(fileSize / 100 * 95)];
            NSData *data = [fileHandle readDataToEndOfFile];
            [fileHandle truncateFileAtOffset:0];//清空
            [fileHandle writeData:data];
        }
        NSData* stringData  = [string dataUsingEncoding:NSUTF8StringEncoding];
        [fileHandle writeData:stringData]; //追加写入数据
        
        [fileHandle closeFile];
    }
    
}

+(BOOL)isContainCapitalStirng:(NSString *)string
{
    for (int i=0; i<string.length; i++) {
        unichar c = [string characterAtIndex:i];
        if (c>='A' && c <='Z') {
            return YES;
        }
    }
    return NO;
}
//播放系统声音
+(void)playSystemSound
{
//     SystemSoundID soundID = kSystemSoundID_Vibrate;//只有震动
    //获取路径
//    NSString *input_str= [NSString stringWithFormat:@"resource.bundle/%@",@"qingcuiyinyue.mp3"];
//    NSString *input_nsstr=[[[NSBundle mainBundle]resourcePath] stringByAppendingPathComponent:input_str];
//
//    NSString *path ;//= [[NSBundle mainBundle] pathForResource:@"candoNotifySound" ofType:@"mp3"];
//    path = input_nsstr;
    //定义一个带振动的SystemSoundID
    SystemSoundID soundID = 1000;
    //判断路径是否存在
//    if (path) {
//        //创建一个音频文件的播放系统声音服务器
//        OSStatus error = AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)([NSURL fileURLWithPath:path]), &soundID);
//        //判断是否有错误
//        if (error != kAudioServicesNoError) {
//            NSLog(@"%d",(int)error);
//        }
//    }
    //只播放声音，没振动
    AudioServicesPlaySystemSound(soundID);//直接播放系统声音可以填1000-2000
    
}
//计算文本的宽高
+(CGSize)calculationTextSize:(NSString *)textString cgSize:(CGSize)size font:(CGFloat)font
{
    NSMutableParagraphStyle *contentParagraphStyle = [[NSMutableParagraphStyle alloc] init];
    contentParagraphStyle.lineSpacing = 10.f;
    //计算内容size
    NSDictionary *contentAttribute = @{NSFontAttributeName:[UIFont systemFontOfSize:font],
                                       NSParagraphStyleAttributeName:contentParagraphStyle,
                                       NSKernAttributeName:@(1)};
    
    
    CGSize contentSize = [textString boundingRectWithSize:size
                                                    options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin
                                                 attributes:contentAttribute
                                                    context:nil].size;
    
    return contentSize;
    
   
    
}

+(UIViewController *)storyboadName:(NSString *)storyboadName vcId:(NSString *)vcId
{
    return  [[UIStoryboard storyboardWithName:storyboadName bundle:nil]instantiateViewControllerWithIdentifier:vcId];
}



+(NSString *)convertToJsonData:(NSDictionary *)dict
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    if (!jsonData) {
        NSLog(@"%@",error);
    }else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range = {0,jsonString.length};
    //去掉字符串中的空格
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    //去掉字符串中的换行符
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}

//添加动画
+(void)addAnimationView:(UIView *)view type:(NSString *)type subType:(NSString *)subType
{
    // 立方体、吸收、翻转、波纹、翻页、反翻页、镜头开、镜头关
    CATransition *transition = [CATransition animation];
    transition.duration = 1.5f;
    transition.type = type;
    transition.subtype = subType;
    [view.layer addAnimation:transition forKey:@"animation"];
    
    //        transition.type = @"cube";//立方体
    //        transition.type = @"suckEffect";//没什么效果 吸收
    //        transition.type = @"oglFlip";//  翻转 不管subType is "fromLeft" or "fromRight",official只有一种效果
    
    //                          @"rippleEffect";// 波纹
    //        transition.type = @"pageCurl"; // 翻页
    //        transition.type = @"pageUnCurl"; // 反翻页
    //        transition.type = @"cameraIrisHollowOpen "; // 镜头开
    //        transition.type = @"cameraIrisHollowClose "; // 镜头关
    
    
    //    transition.type 的类型可以有
    //    淡化、推挤、揭开、覆盖
    //    NSString * const kCATransitionFade;//交叉淡化过渡
    //    NSString * const kCATransitionMoveIn;//新视图移到旧视图上面
    //    NSString * const kCATransitionPush;//新视图把旧视图推出去
    //    NSString * const kCATransitionReveal;//将旧视图移开,显示下面的新视图
    //    这四种，
    //    transition.subtype
    //    也有四种
    //    NSString * const kCATransitionFromRight;
    //    NSString * const kCATransitionFromLeft;
    //    NSString * const kCATransitionFromTop;
    //    NSString * const kCATransitionFromBottom;
}

//暂停 layer 层的动画
+ (void)pauseLayer:(CALayer*)layer
{
    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    layer.speed = 0.0;
    layer.timeOffset = pausedTime;
}

//继续layer上面的动画
+ (void)resumeLayer:(CALayer*)layer
{
    CFTimeInterval pausedTime = [layer timeOffset];
    layer.speed = 1.0;
    layer.timeOffset = 0.0;
    layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    layer.beginTime = timeSincePause;
}

//UIRectCornerTopLeft UIRectCornerBottomLeft
+(void)addRectLayer:(CALayer *)layer
             corner:(UIRectCorner)corner
             radius:(CGFloat )radius
               bounds:(CGRect)bounds
{
    CGSize radio = CGSizeMake(radius, radius);//圆角尺寸
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:bounds byRoundingCorners:corner cornerRadii:radio];
    CAShapeLayer *masklayer = [[CAShapeLayer alloc]init];//创建shapelayer
    masklayer.frame =bounds;
    masklayer.path = path.CGPath;//设置路径
    
   layer.mask = masklayer;
    
}

#define BBAMR_MAGIC_NUMBER "#!AMR\n"
+(NSMutableData *)addArmData
{
    NSMutableData* outData = [[NSMutableData alloc]init];
    [outData appendBytes:BBAMR_MAGIC_NUMBER length:strlen(BBAMR_MAGIC_NUMBER)];
    return outData;
}


@end
