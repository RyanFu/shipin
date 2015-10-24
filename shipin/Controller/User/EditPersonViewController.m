//
//  EditPersonViewController.m
//  shipin
//
//  Created by Mapollo27 on 15/8/13.
//  Copyright (c) 2015年 dust.zhang. All rights reserved.
//

#import "EditPersonViewController.h"
#import "TextTableViewCell.h"
#import "ModifyUserinfoViewController.h"

@interface EditPersonViewController ()

@end

@implementation EditPersonViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
      [[UIApplication  sharedApplication] setStatusBarHidden:NO];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor] ];
    mutableArray = [[NSMutableArray alloc ] initWithCapacity:0];
    isSelectImage = FALSE;
    
    [self loadUserInfo];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(UpdateuserModle:) name:@"nof_UpdateuserModle" object:nil];
}

-(void)UpdateuserModle:(NSNotification *)notification 
{
    TextModel *updateItem = [[TextModel alloc ] init];
    updateItem = [notification object];
    
    if ([updateItem.strLeftName isEqualToString:@"姓名"])
    {
        [mutableArray removeObjectAtIndex:1];
        [mutableArray insertObject:updateItem atIndex:1];
    }
   
    for (int i=0; i< [mutableArray count]; i++)
    {
        TextModel *temp = [[TextModel alloc ] init];
        temp = mutableArray[i];
        if ([updateItem.strLeftName isEqualToString:temp.strLeftName ])
        {
            [mutableArray removeObjectAtIndex:i];
            [mutableArray insertObject:updateItem atIndex:i];
        }
    }
    
    [tableViewPersonInfo reloadData];
}

-(void) loadUserInfo
{
    [UserService getUserDetail:self._uId success:^(UserModel *userModel)
     {
         self._userModel =userModel;
         
         NSArray *arrLeft = [NSArray arrayWithObjects:@"头像",@"姓名",@"个人简介",@"公司名称",@"公司职位",@"公司邮箱",@"联系电话", nil];
         NSArray *arrRight = [NSArray arrayWithObjects:
                              [NSString stringWithFormat:@"%@",self._userModel.avatar],
                              [NSString stringWithFormat:@"%@",self._userModel.name],
                              [NSString stringWithFormat:@"%@",self._userModel.brief],
                              [NSString stringWithFormat:@"%@",self._userModel.corporation],
                              [NSString stringWithFormat:@"%@",self._userModel.position],
                              [NSString stringWithFormat:@"%@",self._userModel.email],
                              [NSString stringWithFormat:@"%@",self._userModel.mobile], nil];
         
         for(int i = 0 ; i < [arrLeft count]; i++)
         {
             TextModel * tModle = [[TextModel alloc ] init];
             tModle.strLeftName = [arrLeft objectAtIndex:i];
             tModle.strRightName = [arrRight objectAtIndex:i];
             
             [mutableArray addObject:tModle];
         }
         
         [self initViewCtrl];
         
     } failure:^(NSDictionary *error)
     {
         [Tool showWarningTip:@"获取用户信息失败" view:self.view time:1];
     }];
}


-(void) initViewCtrl
{
    self._navigationBar = [[ExUINavigationBar alloc ] initWithFrameRect:CGRectMake(0, 0, SCREEN_WIDTH, TABBAR_HEIGHT) BGImage:@"navigationbar" StrTitle:@"个人信息" ];
    [self.view addSubview:self._navigationBar];
    
    UIButton *btnBack = [[UIButton alloc ] initWithFrame:backButtonFram];
    [btnBack setImage:[UIImage imageNamed:@"btn_back.png"] forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(onButtonBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnBack];
    
    tableViewPersonInfo = [[UITableView alloc ] initWithFrame:CGRectMake(0, TABBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-TABBAR_HEIGHT) style:UITableViewStylePlain];
    tableViewPersonInfo.dataSource = self;
    tableViewPersonInfo.delegate = self;
    tableViewPersonInfo.separatorColor = [UIColor clearColor];
    [tableViewPersonInfo setBackgroundColor:RGBA(238, 238, 238, 1)];
    [self.view addSubview:tableViewPersonInfo];
    
    
    UIButton *btnSave = [[UIButton alloc ] initWithFrame:CGRectMake(20, SCREEN_HEIGHT-60, SCREEN_WIDTH-40, 40)];
    [btnSave setTitle:@"保存填写" forState:UIControlStateNormal];
    btnSave.titleLabel.font = [UIFont systemFontOfSize:14];
    [btnSave  setBackgroundColor:yellowRgb];
    btnSave.layer.masksToBounds = YES;
    btnSave.layer.cornerRadius = 3;
    [btnSave addTarget:self action:@selector(saveUserInfo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnSave];
}

//保存用户修改的用户信息
-(void) saveUserInfo
{
    UserModel *uModle = [[UserModel alloc ] init];
    
    TextModel *updateItem = [[TextModel alloc ] init];
    updateItem = mutableArray[1];
    uModle.name =updateItem.strRightName;//姓名
    
    updateItem = mutableArray[2];
    uModle.brief =updateItem.strRightName;//简介

    updateItem = mutableArray[3];
    uModle.corporation =updateItem.strRightName;//公司

    updateItem = mutableArray[4];
    uModle.position =updateItem.strRightName;//职位

    updateItem = mutableArray[5];
    uModle.email =updateItem.strRightName;//邮箱

    updateItem = mutableArray[6];
    uModle.mobile =updateItem.strRightName;//电话
    
    if (isSelectImage)
    {
        uModle.hImage =UIImageJPEGRepresentation(imageviewHead.image, 1);
    }
    else
    {
        uModle.hImage=nil;
    }

    [UserService updateUserDetail:uModle success:^(Boolean *boolean)
    {
        [Config setUpdateUserHeadImage:@"YES"];
        [Tool showWarningTip:@"更新成功" view:self.view time:0.5f];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSString *error)
    {
        [Tool showWarningTip:error view:self.view time:1];
    }];
}

#pragma mark tableview function
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TextTableViewCell";
    TextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[TextTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    //有头像
    if (indexPath.row == 0)
    {
        TextModel * tModle = [[TextModel alloc ] init];
        tModle =  mutableArray[indexPath.row];
        [cell setLableText:tModle viewName:@"EditPersonViewController" cellHegith:70];
        
        //    头像
        imageviewHead = [[UIImageView alloc ] initWithFrame:CGRectMake(SCREEN_WIDTH-90, 10, 50, 50)];
        imageviewHead.layer.cornerRadius =imageviewHead.frame.size.width/2;
        imageviewHead.layer.masksToBounds = YES;
        [imageviewHead setContentMode:UIViewContentModeScaleAspectFill];
        [imageviewHead setBackgroundColor:[UIColor clearColor]];
        [cell addSubview:imageviewHead];
        
        return cell;
    }
    else
    {
        if (indexPath.row < [mutableArray count])
        {
            TextModel * tModle = [[TextModel alloc ] init];
            tModle =  mutableArray[indexPath.row];
            if([tModle.strRightName length] <= 0)
                tModle.strRightName = @"尚未完善资料";
            [cell setLableText:tModle viewName:@"EditPersonViewController" cellHegith:40];
            return cell;
        }
    }
    
    return cell;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
        return 70;
    else
        return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //头像
    if (indexPath.row == 0)
    {
        FSMediaPicker *mediaPicker = [[FSMediaPicker alloc] init];
        mediaPicker.mediaType = 0;
        mediaPicker.editMode = 0;
        mediaPicker.delegate = self;
        [mediaPicker showFromView:self.view];
    }
    else if (indexPath.row != 6)
    {
        TextModel * tModle = [[TextModel alloc ] init];
        tModle =  mutableArray[indexPath.row];
        
        ModifyUserinfoViewController * modifyUserinfoView = [[ModifyUserinfoViewController alloc ] init];
        modifyUserinfoView.selModle = tModle;
        //        modifyUserinfoView._strSelItem = tModle.strLeftName;
        [self.navigationController pushViewController:modifyUserinfoView animated:YES];
    }
}


#pragma mark - FSMediaPicker Delegate Methods
-(void)mediaPickerCameraAuth{
    if (!_MediaAlert)
    {
        _MediaAlert = [[UIAlertView alloc]
                       initWithTitle:@"提示"
                       message:@"请在[系统设置]中打开相机服务"
                       delegate:self
                       cancelButtonTitle:@"取消"
                       otherButtonTitles:@"确定", nil];
    }
    [_MediaAlert show];
}

- (void)mediaPicker:(FSMediaPicker *)mediaPicker didFinishWithMediaInfo:(NSDictionary *)mediaInfo
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    if (mediaPicker.editMode == FSEditModeNone)
    {
        [imageviewHead setImage:mediaInfo.originalImage ];
    }
    else
    {
        UIImage *img = mediaPicker.editMode == FSEditModeCircular? mediaInfo.circularEditedImage:mediaInfo.editedImage;
        [imageviewHead setImage:img ];
        isSelectImage = TRUE;

    }
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
