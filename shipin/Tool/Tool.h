//
//  Tool.h
//  shipin
//
//  Created by Mapollo27 on 15/7/25.
//  Copyright (c) 2015年 dust.zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FVCustomAlertView.h"

@interface Tool : NSObject


+(void) showWarningTip:(NSString *) message view:(UIView*)view time:(float) delayTime;
///成功提示
+(void) showSuccessTip:(NSString *) message view:(UIView*)view time:(float) delayTime;
//设置uilable行高
+(void) setLabelSpacing:(UILabel*)label spacing:(float)spacing alignment:(NSTextAlignment)alignment;
//拼接图片url
+(NSURL *) stringMerge:(NSString *)imageUrl;
///计算文字高度
+ (CGSize) CalcString:(NSString *)value fontSize:(UIFont *)fontSize andWidth:(float)width;
+ (CGSize)boundingRectWithSize:(NSString *)text textFont:(UIFont *)font textSize:(CGSize)size;
//数量统计，如果为空则=0
+(NSString *) getCount:(NSString *)count;
//判断字符串是否为空
+(NSString *)isNull:(NSString *)sourceString;

+(NSString*)clearSpaceAndNewline:(NSString*)oldStr;
+(int)convertToInt:(NSString*)strtemp;

+(CGFloat) getTextHeight:(UILabel *)label;

@end
