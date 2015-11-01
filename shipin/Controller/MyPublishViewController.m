//
//  MyPublishViewController.m
//  shipin
//
//  Created by Mapollo27 on 15/8/15.
//  Copyright (c) 2015年 dust.zhang. All rights reserved.
//

#import "MyPublishViewController.h"
#import "AddPublishViewController.h"
#import "AllTableViewCell.h"
#import "DramaDetialViewController.h"
#import "LKDBHelper.h"
#import "MyDrama.h"
#import "EditPersonViewController.h"

@interface MyPublishViewController ()

@end

@implementation MyPublishViewController

-(void) viewDidAppear:(BOOL)animated
{
      [self loadNetWorkData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[UIApplication  sharedApplication] setStatusBarHidden:NO];
    _arrayPublish = [[NSMutableArray alloc ] initWithCapacity:0];
    
    [self initViewCtrl];
     [self loadNetWorkData];
}

-(void) initViewCtrl
{
    ExUINavigationBar *navigationBar = [[ExUINavigationBar alloc ] initWithFrameRect:CGRectMake(0, 0, SCREEN_WIDTH, TABBAR_HEIGHT) BGImage:@"navigationbar" StrTitle:@"我的发布" ];
    [self.view addSubview:navigationBar];
    
    UIButton *btnBack = [[UIButton alloc ] initWithFrame:backButtonFram];
    [btnBack setImage:[UIImage imageNamed:@"btn_back.png"] forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(onButtonBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnBack];
    
    UIButton *btnAdd = [[UIButton alloc ] initWithFrame:CGRectMake(SCREEN_WIDTH-60, 25, 45, 22)];
    [btnAdd setImage:[UIImage imageNamed:@"btn_addpublish.png"] forState:UIControlStateNormal];
    [btnAdd addTarget:self action:@selector(onButtonAddDrama) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnAdd];
    
    UILabel *labelTip = [[UILabel alloc ] initWithFrame:CGRectMake(0, SCREEN_HEIGHT/3, SCREEN_WIDTH, 30)];
    [labelTip setText:@"开始发布您的第一步剧吧"];
    [labelTip setBackgroundColor:[UIColor clearColor] ];
    [labelTip setTextColor:RGB(102, 102, 102)];
    [labelTip setFont:[UIFont systemFontOfSize:14]];
    [labelTip setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:labelTip];
    
    UIButton *btnAddDrama = [[UIButton alloc ] initWithFrame:CGRectMake(SCREEN_WIDTH/4, labelTip.frame.origin.y+labelTip.frame.size.height+20, SCREEN_WIDTH/2, 40)];
    btnAddDrama.layer.masksToBounds = YES;
    btnAddDrama.layer.cornerRadius = 3;
    [btnAddDrama setBackgroundColor:yellowRgb];
    btnAddDrama.titleLabel.font = [UIFont systemFontOfSize:14];
    [btnAddDrama setTitle:@"添加剧目" forState:UIControlStateNormal];
    [btnAddDrama addTarget:self action:@selector(onButtonAddDrama) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnAddDrama];
    
    
    _tableView = [[UITableView alloc ] initWithFrame:CGRectMake(0, TABBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-TABBAR_HEIGHT) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorColor = RGB(221, 221, 221);
    [_tableView setBackgroundColor:[UIColor whiteColor]]; //RGBA(238, 238, 238, 1)
    [self.view addSubview:_tableView];
    [_tableView setHidden:YES];
}

-(void) loadNetWorkData
{
    LKDBHelper *helper = [LKDBHelper getUsingLKDBHelper];
    NSString *orderBy = @"CAST(id as integer) desc";
    NSMutableArray * dramaArray = [helper search:[MyDrama class] where:nil orderBy:orderBy offset:0 count:10];

    if(dramaArray!=nil && [dramaArray count]>0)
    {
        NSMutableArray* array = [[NSMutableArray alloc] init];
        for(MyDrama *drama in dramaArray){

            NSError* err = nil;
            DramaModel *dramaModel = [[DramaModel alloc] initWithString:drama.content error:&err];

            if(err!=nil)
            {
                NSLog(@"getOldDatasERROR:::%@",err );
            }
            [array addObject:dramaModel];

        }

        _arrayPublish=array;
        [_tableView reloadData];
    }

        [UserService getPublishes:^(NSArray *dramaArray)
        {
            _arrayPublish= [[NSMutableArray alloc ] initWithArray:dramaArray];
            if ([_arrayPublish count] > 0 )
            {
                   [_tableView setHidden:NO];
            }
            //如果我的发布为空
            if ([_arrayPublish count] <= 0)
            {
                [_tableView setHidden:YES];
            }

            [_tableView reloadData];

        } failure:^(NSDictionary *error)
        {
            [Tool showWarningTip:@"加载我的发布失败" view:self.view time:1];
        }];



}

//添加发布内容
- (void)onButtonAddDrama
{

    [UserService getUserDetail:0 success:^(UserModel *userModel)
    {
        if(![userModel.name isEqualToString:@"(null)"] && userModel.name!=nil){

            AddPublishViewController *addPublishView = [[AddPublishViewController alloc ] init];
            [self.navigationController pushViewController:addPublishView animated:YES];
        } else{

            [Tool showWarningTip:@"请补全用户信息" view:self.view time:1];
            [self performSelector:@selector(onButtonEdit) withObject:nil afterDelay:1.0f];
        }


    } failure:^(NSDictionary *error)
    {
//        [FVCustomAlertView hideAlertFromView:self.view fading:YES];
        [Tool showWarningTip:@"获取用户信息失败" view:self.view time:1];
    }];

}
-(void) onButtonEdit
{
    EditPersonViewController *editPersonView = [[EditPersonViewController alloc ] init];
    editPersonView._uId = 0;
    [self.navigationController pushViewController:editPersonView animated:YES];
}
//返回
- (void)onButtonBack
{
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark tableview function
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([_arrayPublish count]%2 == 0)
        return [_arrayPublish count]/2;
    else
        return [_arrayPublish count]/2+[_arrayPublish count]%2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *showCell = @"AllTableViewCell";
    AllTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:showCell] ;
    if (cell == nil)
    {
        cell = [[AllTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:showCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if([_arrayPublish count]%2 == 0)
    {
        dramaLeft  =[_arrayPublish objectAtIndex:(indexPath.row*2)];
        dramaRight=[_arrayPublish objectAtIndex:(indexPath.row*2+1)];
    }
    else
    {
//        NSLog(@"%ld",(indexPath.row*2));
//        NSLog(@"%ld",(indexPath.row*2)+1);
        dramaLeft  =[_arrayPublish objectAtIndex:(indexPath.row*2)];
        if ( ((indexPath.row*2)+1) < [_arrayPublish count] )
        {
            dramaRight=[_arrayPublish objectAtIndex:(indexPath.row*2+1)];
        }
        else
            dramaRight =nil;
        
    }
    
    cell.delegate = self;
    [cell setControlLeftData:dramaLeft rightData:dramaRight type:@"publish"];

    return cell;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 195;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(void)mViewControllerShouldPush:(DramaModel *)itemData
{
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
    
    DramaDetialViewController *dramaDetialView = [[DramaDetialViewController alloc ] init];
    dramaDetialView.nId = [[itemData.id stringValue] intValue];
    [self.navigationController pushViewController:dramaDetialView animated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
