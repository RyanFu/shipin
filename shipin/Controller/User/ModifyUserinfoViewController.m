//
//  ModifyUserinfoViewController.m
//  shipin
//
//  Created by Mapollo27 on 15/8/15.
//  Copyright (c) 2015年 dust.zhang. All rights reserved.
//

#import "ModifyUserinfoViewController.h"

@interface ModifyUserinfoViewController ()

@end

@implementation ModifyUserinfoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
      [[UIApplication  sharedApplication] setStatusBarHidden:NO];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:RGB(238, 238, 238)];
    
    ExUINavigationBar *navigationBar = [[ExUINavigationBar alloc ] initWithFrameRect:CGRectMake(0, 0, SCREEN_WIDTH, TABBAR_HEIGHT) BGImage:@"navigationbar" StrTitle:[NSString stringWithFormat:@"修改%@",self.selModle.strLeftName]];
    [self.view addSubview:navigationBar];
    
    UIButton *btnBack = [[UIButton alloc ] initWithFrame:backButtonFram];
    [btnBack setImage:[UIImage imageNamed:@"btn_back.png"] forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(onButtonBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnBack];
    
    _labelName = [[UILabel alloc ] initWithFrame:CGRectMake(0, TABBAR_HEIGHT+20, 75, 30)];
    [_labelName setBackgroundColor:[UIColor clearColor]];
    [_labelName setFont:[UIFont systemFontOfSize:14]];
    [_labelName setTextAlignment:NSTextAlignmentRight];
    [self.view addSubview:_labelName];
    [_labelName setText:[NSString stringWithFormat:@"%@:",self.selModle.strLeftName]];
    
    self._textContent = [[UITextView alloc ] initWithFrame:CGRectMake(80, TABBAR_HEIGHT+20, SCREEN_WIDTH-100, 30)];
    self._textContent.layer.masksToBounds = YES;
    self._textContent.layer.cornerRadius = 3;
    [self._textContent setBackgroundColor:[UIColor whiteColor] ];
    [ self._textContent setFont:[UIFont systemFontOfSize:14]];
    [self.view addSubview:self._textContent];
    if([self.selModle.strLeftName isEqualToString:@"个人简介"])
         self._textContent.frame = CGRectMake(20, TABBAR_HEIGHT+50, SCREEN_WIDTH-40, 100);
    
    UIButton *btnSave = [[UIButton alloc ] initWithFrame:CGRectMake(20, self._textContent.frame.size.height+self._textContent.frame.origin.y+30, SCREEN_WIDTH-40, 40)];
    [btnSave setTitle:@"修改" forState:UIControlStateNormal];
    btnSave.titleLabel.font = [UIFont systemFontOfSize:14];
    [btnSave  setBackgroundColor:yellowRgb];
    btnSave.layer.masksToBounds = YES;
    btnSave.layer.cornerRadius = 3;
    [btnSave addTarget:self action:@selector(onButtonModifyUserInfo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnSave];
}

-(void) viewDidAppear:(BOOL)animated
{
     if(![self.selModle.strRightName  isEqualToString:@"尚未完善资料"])
     {
         self._textContent.text = [Tool isNull:self.selModle.strRightName] ;
     }
}


//保存用户修改的用户信息
-(void) onButtonModifyUserInfo
{
    if ([self.selModle.strLeftName isEqualToString:@"姓名"])
    {
        if([self._textContent.text length ] >9)
        {
            [Tool showWarningTip:@"名字不能超过9个字符" view:self.view time:1];
            return;
        }
    }
    curSelModle = [[TextModel alloc ] init];
    
    curSelModle.strLeftName =self.selModle.strLeftName;
    curSelModle.strRightName =self._textContent.text;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"nof_UpdateuserModle" object:curSelModle];
    
    [self.navigationController popViewControllerAnimated:YES];

}

-(void) onButtonBack
{
    [self onButtonModifyUserInfo];
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self._textContent resignFirstResponder ];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
