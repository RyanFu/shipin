//
//  ModifyUserinfoViewController.h
//  shipin
//
//  Created by Mapollo27 on 15/8/15.
//  Copyright (c) 2015年 dust.zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FilmModel.h"

@interface ModifyUserinfoViewController : BaseViewController
{
    TextModel *curSelModle;
}
@property (nonatomic ,strong) TextModel *selModle;
//@property (nonatomic ,strong) NSString *_strSelItem;

@property (nonatomic ,strong) UITextView *_textContent;

@end
