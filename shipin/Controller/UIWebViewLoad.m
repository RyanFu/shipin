//
//  UIWebView.m
//  shipin
//
//  Created by Mapollo27 on 15/8/18.
//  Copyright (c) 2015年 dust.zhang. All rights reserved.
//

#import "UIWebViewLoad.h"

@interface UIWebViewLoad ()

@end

@implementation UIWebViewLoad


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self initViewCtrl];
}

-(void) initViewCtrl
{
    ExUINavigationBar *navigationBar = [[ExUINavigationBar alloc ] initWithFrameRect:CGRectMake(0, 0, SCREEN_WIDTH, TABBAR_HEIGHT) BGImage:@"navigationbar" StrTitle:@"" ];
    [self.view addSubview:navigationBar];
    //返回
    UIButton *btnBack = [[UIButton alloc ] initWithFrame:backButtonFram];
    [btnBack setImage:[UIImage imageNamed:@"btn_back.png"] forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(onButtonBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnBack];
    
    if ([self._url length] > 0)
    {
        UITextField * textUrl = [[UITextField alloc ] initWithFrame:CGRectMake(10,  TABBAR_HEIGHT+20, SCREEN_WIDTH-20,50)];
        [textUrl setText:self._url];
        [textUrl setFont:[UIFont systemFontOfSize:14]];
        textUrl.layer.borderColor = [UIColor grayColor].CGColor;
        textUrl.layer.borderWidth = 1;
        [self.view addSubview:textUrl];

    }
    else
    {
        UIWebView* webView = [[UIWebView alloc ] initWithFrame:CGRectMake(0, TABBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-TABBAR_HEIGHT)];
        webView.delegate = self;
        [webView setBackgroundColor:[UIColor whiteColor] ];
        [webView setScalesPageToFit:YES];
        [self.view addSubview:webView];
        [webView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.dramaRelativesModel.url] ]];
    }
    
}


//响应webview连接跳转
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType
{
    return TRUE;
}

#pragma mark - webview
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [FVCustomAlertView hideAlertFromView:self.view fading:YES];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [FVCustomAlertView hideAlertFromView:self.view fading:YES];
}


- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [FVCustomAlertView showDefaultLoadingAlertOnView:self.view withTitle:nil withBlur:NO allowTap:YES];
}

-(void) onButtonBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
