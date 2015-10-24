//
//  LoginViewController.h
//  shipin
//
//  Created by zhangjingfei on 9/8/15.
//  Copyright (c) 2015年 dust.zhang. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LoginViewController : UIViewController
{
    UITextField     *textTel;
    UITextField     *textIdentifyingCode;
    UIButton        *btnGetICode;
    NSInteger       seconds;
    NSTimer         *timer;
    NSString        *_strCode;
    
}
@end
