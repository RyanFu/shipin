//
//  FeedBackViewController.h
//  shipin
//
//  Created by Mapollo27 on 15/8/15.
//  Copyright (c) 2015年 dust.zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HPGrowingTextView.h"

@interface FeedBackViewController : BaseViewController<HPGrowingTextViewDelegate>
{
    UITextField     *_textFieldName;
    UITextField     *_textFieldTel;
    UITextField     *_textFieldEmail;
//    UITextView      *_textView;
    
    HPGrowingTextView *hpTextView;
}
@end
