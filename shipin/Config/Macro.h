//
//  Macroh
//  movikr
//
//  Created by Mapollo27 on 15/5/29.
//  Copyright (c) 2015年 movikr. All rights reserved.
//


#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(320, 640), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size)) : NO)

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone6plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO)
//获取屏幕宽度
#define     SCREEN_WIDTH  [[UIScreen mainScreen] bounds].size.width
//获取屏幕高度
#define     SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

#define     IS_IOS7                     [[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0
#define     TABBAR_HEIGHT               (IS_IOS7?54:44)
#define     STATUSBAR_HEIGHT            (IS_IOS7?20:0)

#define     NOTIFITION_SELECTCURDATE                    @"notifition_date"
//颜色转换
#define RGB(r,g,b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1]
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define yellowRgb   RGB(239, 190, 0)
//#define grayRgb   RGB(246, 246, 246)
#define grayRgb   RGB(220, 220, 220)
#define FontSize    14
#define smallFontSize    12
#define BoldfontSize  [UIFont boldSystemFontOfSize:14]

//返回按钮宽高
#define backButtonFram  CGRectMake(10, 25, 45, 22)
#define netWorkUrl                      @"image_defaulthead.png"
//无网络加载默认图片
#define     DefaultImage                [UIImage imageNamed:@"picture_default.png"]

//分享相关
//微信
#define weixinAppId                    @"wx74cfb2a735ee43aa"
#define weixinAppSecret                @"2e3a3e0434fce84879f8f03cca4b89f6"
#define kRedirectURI                   @"http://tvpstore.com"
//微博
#define weiboAppId                      @"weibo20682885"
#define weiboAppKey                     @"20682885"
#define weiboAppSecret                  @"bff0b7ac8f061e3325cef7cecd3ac96c"

#define ShareToWeiboOfAccount       @"(来自@剧库官微)"
#define shareImageToWeixinDefaultImageTitle @"剧库"
