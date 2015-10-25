//
//  AddPublishViewController.m
//  shipin
//
//  Created by Mapollo27 on 15/8/15.
//  Copyright (c) 2015年 dust.zhang. All rights reserved.
//

#import "AddPublishViewController.h"
#import "NetWorkState.h"
#import "WifiViewController.h"
#import "NoWifiViewController.h"
#import "UIWebViewLoad.h"


@interface AddPublishViewController ()

@end

@implementation AddPublishViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[UIApplication  sharedApplication] setStatusBarHidden:NO];
     _arrayPublish = [[NSMutableArray alloc ] initWithCapacity:0];
    
    [self initViewCtrl];
}

-(void) initViewCtrl
{
    ExUINavigationBar *navigationBar = [[ExUINavigationBar alloc ] initWithFrameRect:CGRectMake(0, 0, SCREEN_WIDTH, TABBAR_HEIGHT) BGImage:@"navigationbar" StrTitle:@"添加剧目" ];
    [self.view addSubview:navigationBar];
    
    UIButton *btnBack = [[UIButton alloc ] initWithFrame:backButtonFram];
    [btnBack setImage:[UIImage imageNamed:@"btn_back.png"] forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(onButtonBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnBack];
   
    _tableView = [[UITableView alloc ] initWithFrame:CGRectMake(0, TABBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-TABBAR_HEIGHT) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorColor = [UIColor clearColor] ;
    [_tableView setBackgroundColor:RGBA(238, 238, 238, 1)];
    [self.view addSubview:_tableView];
    
    [self loadNetWorkData];
}

//初始化数据
-(void) loadNetWorkData
{
    AddPublishTypeModle *addModle = [[AddPublishTypeModle alloc ] init];
    addModle.pImage = @"image_computer.png";
    addModle.pTypename = @"电脑发布";
    addModle.p1 = @"1. 在电脑浏览器中输入网址www.sadeness.com";
    addModle.p2 = @"2. 点击“PC发布”";
    addModle.p3 = @"3. 扫描网页中的二维码";
    addModle.p4 = @"4. 手机确认登录，开始使用电脑发布";
    [_arrayPublish addObject:addModle];
    
    AddPublishTypeModle *addModle1 = [[AddPublishTypeModle alloc ] init];
    addModle1.pImage = @"image_mobile.png";
    addModle1.pTypename = @"手机发布";
    addModle1.p1 = @"1. 使用手机发布需要消耗一定的流量";
    addModle1.p2 = @"2. 建议您在WIFI环境下使用";
    addModle1.p3 = @"3. 无WIFI环境将自动进入省流量模式编辑";
    addModle1.p4 = @"";
    [_arrayPublish addObject:addModle1];

    [_tableView reloadData];
}
-(void) onButtonBack
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark tableview function
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddPublishTypeModle *addModle = [[AddPublishTypeModle alloc ] init];
    
    static NSString *CellIdentifier = @"AttentionPeoperTableViewCell";
    AddPublishTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[AddPublishTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    addModle = [_arrayPublish objectAtIndex:indexPath.row];
    
    [cell setItemText:addModle];
    
    return cell;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (SCREEN_HEIGHT-TABBAR_HEIGHT)/2-30;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //电脑发布
    if (indexPath.row == 0 )
    {
        [UserService makePublishPage:^(NSString *url) {

            UIWebViewLoad  *computerView = [[UIWebViewLoad alloc ] init];
            computerView._url = url;
            [self.navigationController pushViewController:computerView animated:YES];
//            __url=url;
        } failure:^(NSDictionary *error) {
            [Tool showWarningTip:@"服务器错误!" view:self.view time:2];
        }];

    }
    //手机发布
    if (indexPath.row == 1 )
    {
        //wifi
//        if ([NetWorkState getNetWorkState] == ReachableViaWiFi )
//        {
//            WifiViewController *wifiView = [[WifiViewController alloc ] init];
//            [self.navigationController pushViewController:wifiView animated:YES];
//        }
        if ([NetWorkState getNetWorkState] == ReachableViaWiFi )
        {
            NoWifiViewController *noWifiView = [[NoWifiViewController alloc ] init];
            [self.navigationController pushViewController:noWifiView animated:YES];
        }
        else
        {
            [Tool showWarningTip:@"没有网络，请重试" view:self.view time:2];
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
