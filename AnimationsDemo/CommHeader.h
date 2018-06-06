//
//  CommHeader.h
//  ZhongQiuHui
//
//  Created by zqh on 2017/10/19.
//  Copyright © 2017年 WeiEr. All rights reserved.
//

#ifndef CommHeader_h
#define CommHeader_h

#define LastVersionKey @"LastVersionKey"

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000 // 当前Xcode支持iOS8及以上

#define SCREEN_WIDTH ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?[UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale:[UIScreen mainScreen].bounds.size.width)
#define SCREENH_HEIGHT ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?[UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale:[UIScreen mainScreen].bounds.size.height)
#define SCREEN_SIZE ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?CGSizeMake([UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale,[UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale):[UIScreen mainScreen].bounds.size)
#else
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENH_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_SIZE [UIScreen mainScreen].bounds.size
#endif

#define KNotificationCenter [NSNotificationCenter defaultCenter]

#define KWeakSelf(type)  __weak typeof(type) weak##type = type;
#define KStrongSelf(type)  __strong typeof(type) type = weak##type;

// 系统版本
#define IOS_SYSTEM_STRING [[UIDevice currentDevice] systemVersion]

//获取temp
#define kPathTemp NSTemporaryDirectory()

//获取沙盒 Document
#define kPathDocument [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]

//获取沙盒 Cache
#define kPathCache [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

#define KUserDefault [NSUserDefaults standardUserDefaults]
// 灰色背景
#define GrayBackGroundColorStr @"#f1f2f3"
#define CellHilightColorStr @"#e0e1e2" //@"#e0e1e2" @"#b4b4b4"

#define AuthorizationKey @"Authorization_key"

#define ErrorResponseKey @"com.alamofire.serialization.response.error.data"
#define UnderlyingError @"NSUnderlyingError"

//日志
//#ifdef DEBUG
//#define DebugLog( s, ... ) NSLog( @"Error:<%p:%@>:第%d行  %@", self, [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
//#else
//#define DebugLog( s, ... )
//#endif

#ifdef DEBUG
#define LRString [NSString stringWithFormat:@"%s", __FILE__].lastPathComponent
#define DebugLog(...) printf("%s: %s 第%d行: %s\n\n",[[NSString lr_stringDate] UTF8String], [LRString UTF8String] ,__LINE__, [[NSString stringWithFormat:__VA_ARGS__] UTF8String]);

#else
#define DebugLog(...)
#endif

// 除以2
#define kHalfFloat(f) (f)*0.5
// 相对iphone6的比咧
#define ScaleOnIphone6 (SCREENH_HEIGHT / 667.0)
// 给约束适配
#define ScaleConstantOnIphone6(x) x.constant = x.constant *ScaleOnIphone6
// 给字体适配
#define ScaleLabelFontOnIphone6(x) x.font = [UIFont systemFontOfSize:x.font.pointSize * ScaleOnIphone6]

//先除以2再乘以相对iphone6的倍数 f：为在iphone6上的数值
#define kHalfSCaleOnIphone6(f) ((f)*0.5*ScaleOnIphone6)

// 获取window
#define KeyWindow [UIApplication sharedApplication].keyWindow
// 顶层window
#define  TopWindow [[UIApplication sharedApplication].windows lastObject]

#define DefaultHeaderImageName @"default_head_man"

#define FillNUllStrObject(x) x = [CommTools isNUllObject:x] ? @"":x;

#define ErrorDomainZQH @"com.zhucaiapp.ios"

#define ErrorCodeService 6666

#define LiveCloseStatusForService 11

#endif /* CommHeader_h */
