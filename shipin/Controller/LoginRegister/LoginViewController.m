//
//  LoginViewController.m
//  shipin
//
//  Created by zhangjingfei on 9/8/15.
//  Copyright (c) 2015年 dust.zhang. All rights reserved.
//

#import "LoginViewController.h"
#import "ViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    seconds = 60;
    // Do any additional setup after loading the view.
    UIImageView *imageViewBg = [[UIImageView alloc ] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [imageViewBg setImage:[UIImage imageNamed:@"image_loginbg.png"] ];
    [self.view addSubview:imageViewBg];
    
    UIImageView *imageViewLogo = [[UIImageView alloc ] initWithFrame:CGRectMake(SCREEN_WIDTH-220, 120, 110, 60)];
    [imageViewLogo setImage:[UIImage imageNamed:@"image_loginlogo.png"] ];
    [self.view addSubview:imageViewLogo];
    
    UILabel *labelName = [[UILabel alloc ] initWithFrame:CGRectMake(0, imageViewLogo.frame.size.height+imageViewLogo.frame.origin.y+10, SCREEN_WIDTH, 20)];
    [labelName setText:@"电视剧采购人购片神器"];
    [labelName setBackgroundColor:[UIColor clearColor]];
    [labelName setFont:[UIFont boldSystemFontOfSize:14]];
    [labelName setTextAlignment:NSTextAlignmentCenter];
    [labelName setTextColor:[UIColor whiteColor]];
    [self.view addSubview:labelName];
//    手机号
    textTel = [[UITextField alloc ] initWithFrame:CGRectMake(25, labelName.frame.size.height+labelName.frame.origin.y+80, 180, 37)];
    [textTel setPlaceholder:@"  请输入您的手机号码"];
    [textTel setFont:[UIFont systemFontOfSize:12]];
    [textTel setBackgroundColor:[UIColor whiteColor]];
    textTel.layer.masksToBounds = YES;
    textTel.layer.cornerRadius = 3;
    textTel.keyboardType = UIKeyboardTypePhonePad;
    [textTel setText:[Config getUserName]];
    [self.view addSubview:textTel];
//    获取验证码
    btnGetICode = [[UIButton alloc ] initWithFrame:CGRectMake(textTel.frame.size.width+textTel.frame.origin.x+10, textTel.frame.origin.y, 80, textTel.frame.size.height)];
    [btnGetICode setBackgroundColor:yellowRgb];
    btnGetICode.layer.masksToBounds = YES;
    btnGetICode.layer.cornerRadius = 3;
    [btnGetICode setTitle:@"获取验证码" forState:UIControlStateNormal];
    [btnGetICode.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [btnGetICode addTarget:self action:@selector(onButtonGetICode) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnGetICode];
//    验证码
    textIdentifyingCode = [[UITextField alloc ] initWithFrame:CGRectMake(25, textTel.frame.size.height+textTel.frame.origin.y+10, SCREEN_WIDTH-50, 37)];
    [textIdentifyingCode setPlaceholder:@"  请输入验证码"];
    textIdentifyingCode.keyboardType = UIKeyboardTypePhonePad;
    [textIdentifyingCode setFont:[UIFont systemFontOfSize:12]];
    [textIdentifyingCode setBackgroundColor:[UIColor whiteColor]];
    textIdentifyingCode.layer.masksToBounds = YES;
    textIdentifyingCode.layer.cornerRadius = 3;
    [self.view addSubview:textIdentifyingCode];

//    是否同意协议
    UIButton *btnAgree = [[UIButton alloc ] initWithFrame:CGRectMake(25, textIdentifyingCode.frame.size.height+textIdentifyingCode.frame.origin.y+10, 15, 15)];
    [btnAgree setBackgroundImage:[UIImage imageNamed:@"uncheckawardblack.png"] forState:UIControlStateNormal];
    [btnAgree addTarget:self action:@selector(onButtonCheck) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnAgree];
    
    UILabel *labelAgreement = [[UILabel alloc ] initWithFrame:CGRectMake(btnAgree.frame.origin.x +25, btnAgree.frame.origin.y, SCREEN_WIDTH-100, 15)];
    [labelAgreement setText:@"我已阅读并同意《剧库用户协议》"];
    [labelAgreement setBackgroundColor:[UIColor clearColor]];
    [labelAgreement setTextColor:[UIColor whiteColor]];
    [labelAgreement setFont:[UIFont systemFontOfSize:12]];
    [self.view addSubview:labelAgreement];
    
//    登陆
    UIButton *btnLogin = [[UIButton alloc ] initWithFrame:CGRectMake(25, labelAgreement.frame.size.height+labelAgreement.frame.origin.y+10, textIdentifyingCode.frame.size.width,textIdentifyingCode.frame.size.height)];
    [btnLogin setBackgroundColor:yellowRgb];
    btnLogin.layer.masksToBounds = YES;
    btnLogin.layer.cornerRadius = 3;
    btnLogin.titleLabel.font = [UIFont systemFontOfSize:14];
    [btnLogin setTitle:@"登录" forState:UIControlStateNormal];
    [btnLogin addTarget:self action:@selector(onButtonLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnLogin];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(changeContentViewPosition:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(changeContentViewPosition:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
}

- (void) changeContentViewPosition:(NSNotification *)notification
{
    
    NSDictionary *userInfo = [notification userInfo];
    NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGFloat keyBoardEndY = value.CGRectValue.origin.y;
    
    NSNumber *duration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    [UIView animateWithDuration:duration.doubleValue animations:^{
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationCurve:[curve intValue]];
        self.view.center = CGPointMake(self.view.center.x, keyBoardEndY  - self.view.bounds.size.height/2.0);
    }];
}


//同意协议
-(void) onButtonCheck
{
    
}

//获取验证码
-(void) onButtonGetICode
{
    if([textTel.text length] <= 0 )
    {
        [Tool showWarningTip:@"请输入手机号" view:self.view time:1];
        return;
    }
    [self hideKeyborad];
    [Config saveUserName:textTel.text];
    
    AFHTTPRequestOperationManager *httpManager = [AFHTTPRequestOperationManager manager];
    NSString *strUrl = [NSString stringWithFormat:@"%@?mobile=%@",URL_VERIFYCODE,textTel.text];
    
    [httpManager POST:strUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSDictionary *d = responseObject;
        if([[d objectForKey:@"code"] integerValue]== 0 )
        {
//            textIdentifyingCode.text = [d objectForKey:@"data"] ;
            [self Countdown60];
        }
        else
        {
            [Tool showWarningTip:@"请求验证码失败." view:self.view time:1.0f];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        [Tool showWarningTip:@"请求验证码失败." view:self.view time:1.0f];
    }];
}

-(void) Countdown60
{
    [btnGetICode setEnabled:NO];
    [btnGetICode setTitle:@"60秒后重发" forState:UIControlStateNormal];
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
}


-(void)timerFireMethod:(NSTimer *)theTimer
{
    if (seconds == 1)
    {
        [theTimer invalidate];
        [btnGetICode setEnabled:YES];
        seconds = 60;
    }
    else
    {
        seconds--;
        NSString *title = [NSString stringWithFormat:@"%ld",(long)seconds];
        [btnGetICode setTitle:title forState:UIControlStateNormal];
        [btnGetICode setEnabled:NO];
    }
}


//登陆
-(void)onButtonLogin
{
    if([textTel.text length] <= 0 )
    {
        [Tool showWarningTip:@"请输入手机号" view:self.view time:1];
        return;
    }
    if([textIdentifyingCode.text length] <= 0 )
    {
        [Tool showWarningTip:@"请输入验证码" view:self.view time:1];
        return;
    }
    AFHTTPRequestOperationManager *httpManager = [AFHTTPRequestOperationManager manager];
    NSString *strUrl = [NSString stringWithFormat:@"%@?mobile=%@&smsCode=%@",URL_LOGIN,textTel.text,textIdentifyingCode.text];
    
    [httpManager POST: strUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSDictionary *d = responseObject;
         if([[d objectForKey:@"code"] integerValue]== 0 )
         {
             //  保存token
            [Config saveToken: [d objectForKey:@"data"]];
             //保存登陆状态
             [Config saveLoginFlag:@"YES"];
             [Config saveIsLogin:@"YES"];
             
             if( [[Config getToken] length] > 0  )
             {
                 if(![[Config getFirstLoginState] isEqualToString:@"YES"])
                 {
                        [Config saveFirstLogin:@"YES"];
                        ViewController *mainView = [[ViewController alloc ] init];
                        [self.navigationController pushViewController:mainView animated:YES];
                 }
                 else
                 {
                        [self.navigationController popViewControllerAnimated:YES];
                 }
             }
             else
             {
                  [Config saveToken: [d objectForKey:@"data"]];
             }
         }
         else
         {
             [Tool showWarningTip:@"登陆失败." view:self.view time:1.0f];
         }
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         [Tool showWarningTip:@"登陆失败." view:self.view time:1.0f];
     }];
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self hideKeyborad];
}

-(void) hideKeyborad
{
    [textTel resignFirstResponder];
    [textIdentifyingCode resignFirstResponder];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
