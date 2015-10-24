//
//  UIWebView.h
//  shipin
//
//  Created by Mapollo27 on 15/8/18.
//  Copyright (c) 2015年 dust.zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DramaRelativesModel.h"

@interface UIWebViewLoad : UIViewController<UIWebViewDelegate>

@property (nonatomic ,strong) DramaRelativesModel *dramaRelativesModel;

@property (nonatomic ,strong) NSString *_url;

@end
