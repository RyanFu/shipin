//
//  PersonInfoViewController.m
//  shipin
//
//  Created by Mapollo27 on 15/8/13.
//  Copyright (c) 2015年 dust.zhang. All rights reserved.
//

#import "PersonInfoViewController.h"
#import "TextTableViewCell.h"
#import "EditPersonViewController.h"
#import "SetViewHeadTableViewCell.h"
#import "DramaDetialTableViewCell.h"
#import "LKDBHelper.h"
#import "CommentHeaderScrollTableView.h"
#import "FVCustomAlertView.h"
#import "Drama.h"

@interface PersonInfoViewController (){
    UIColor *btnColor;
    NSString *btnText;
}

@end

@implementation PersonInfoViewController

-(void) viewDidAppear:(BOOL)animated
{
    [self loadUserInfo];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    _myDramaArray= [[NSMutableArray alloc ] initWithCapacity:0];
    mutableArray = [[NSMutableArray alloc ] initWithCapacity:0];
    [self initViewCtrl];
   
//    [self loadUserInfo];
}


-(void)initViewCtrl
{
    if(_tableView)
    {
        [_tableView removeFromSuperview];
    }
    _tableView = [[UITableView alloc ] initWithFrame:CGRectMake(0, -20, SCREEN_WIDTH, SCREEN_HEIGHT+20) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorColor = RGB(221, 221, 221);
    [_tableView setBackgroundColor:RGB(238, 238, 238)];
    [self.view addSubview:_tableView];
    //back button
    UIButton *btnLogin = [[UIButton alloc ] initWithFrame:backButtonFram];
    [btnLogin setImage:[UIImage imageNamed:@"btn_back.png"] forState:UIControlStateNormal];
    [btnLogin addTarget:self action:@selector(onButtonBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnLogin];

}

-(void) loadUserInfo
{

    [self checkFollow:__uId];
    if ([NetWorkState getNetWorkState] == NotReachable ) {
        LKDBHelper *helper = [LKDBHelper getUsingLKDBHelper];
        NSString *where = [NSString stringWithFormat:@"id=%@", @(self._uId)];
        UserModel *userModel = [helper searchSingle:[UserModel class] where:where orderBy:nil];

        if (userModel != nil && ![userModel.id isEqualToNumber:@([[Config getUserId] intValue])]) {
            self.userModel = userModel;
            if (self._uId == [[Config getUserId] intValue])
                _mobile = self.userModel.mobile;
            else
                _mobile = @"***";
            NSArray *arrLeft = [NSArray arrayWithObjects:@"个人简介", @"公司名称", @"公司职位", @"公司邮箱", @"联系电话", nil];
            NSArray *arrRight = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%@", self.userModel.brief],
                                                          [NSString stringWithFormat:@"%@", self.userModel.corporation],
                                                          [NSString stringWithFormat:@"%@", self.userModel.position],
                                                          [NSString stringWithFormat:@"%@", self.userModel.email],
                                                          [NSString stringWithFormat:@"%@", _mobile], nil];//,self.userModel.mobile

            for (int i = 0; i < [arrLeft count]; i++) {
                TextModel *tModle = [[TextModel alloc] init];
                tModle.strLeftName = [arrLeft objectAtIndex:i];
                tModle.strRightName = [arrRight objectAtIndex:i];
                [mutableArray addObject:tModle];
            }
        }
    }
        else
        {

            [UserService getUserDetail:self._uId success:^(UserModel *userModel)
            {
                self.userModel =userModel;
                if (self._uId == [[Config getUserId] intValue] )
                    _mobile = self.userModel.mobile;
                else
                    _mobile = @"***";
                NSArray *arrLeft = [NSArray arrayWithObjects:@"个人简介",@"公司名称",@"公司职位",@"公司邮箱",@"联系电话", nil];
                NSArray *arrRight = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%@",self.userModel.brief],
                                                              [NSString stringWithFormat:@"%@",self.userModel.corporation],
                                                              [NSString stringWithFormat:@"%@",self.userModel.position],
                                                              [NSString stringWithFormat:@"%@",self.userModel.email],
                                                              [NSString stringWithFormat:@"%@",_mobile], nil];

                for(int i = 0 ; i < [arrLeft count]; i++)
                {
                    TextModel * tModle = [[TextModel alloc ] init];
                    tModle.strLeftName = [arrLeft objectAtIndex:i];
                    tModle.strRightName = [arrRight objectAtIndex:i];

                    [mutableArray addObject:tModle];
                }

                if(__uId==0 || __uId==[[Config getUserId] intValue]){

                    //获取我的发布信息
                    [UserService getPublishes:^(NSArray *dramaArray)
                    {
                        _myDramaArray = [NSMutableArray arrayWithArray:dramaArray];
//                  [self initViewCtrl];
                        [_tableView reloadData];

                        [FVCustomAlertView hideAlertFromView:self.view fading:YES];
                    } failure:^(NSDictionary *error){
                        [FVCustomAlertView hideAlertFromView:self.view fading:YES];
                    }];
                } else{

                    _myDramaArray = [self getOldData:@(__uId)];
                    [_tableView reloadData];

                    [FVCustomAlertView hideAlertFromView:self.view fading:YES];

                }


            } failure:^(NSDictionary *error)
            {
                [FVCustomAlertView hideAlertFromView:self.view fading:YES];
                [Tool showWarningTip:@"获取用户信息失败" view:self.view time:1];
            }];
        }
//    }
//    else
//    {
//        [FVCustomAlertView showDefaultLoadingAlertOnView:self.view withTitle:nil withBlur:NO allowTap:YES];
//    }


}

//获取本地数据
-(NSMutableArray *)getOldData:(NSNumber *)uId{

    LKDBHelper *helper = [LKDBHelper getUsingLKDBHelper];
    NSString *orderBy = @"CAST(id as integer) desc";
    NSString *where = [NSString stringWithFormat:@"uid=%@", uId];
    NSMutableArray *dramaArray= [helper search:[Drama class] where:where orderBy:orderBy offset:0 count:10];

    if([dramaArray count]>0){

        NSMutableArray* array = [[NSMutableArray alloc] init];
        for(Drama *drama in dramaArray){
            NSError* err = nil;
            DramaModel *dramaModel = [[DramaModel alloc] initWithString:drama.content error:&err];

            if(err!=nil)
            {
                NSLog(@"getOldDatasERROR:::%@",err );
            }
            [array addObject:dramaModel];

        }
        return array;
    }
    return [[NSMutableArray alloc] init];
}

-(void)checkFollow:(int)dId{

    btnText=@"关注";
    btnColor= yellowRgb;

    [UserService getFollows:^(NSArray *userArray)
    {

        if ([userArray count]>0){

            for(int i=0;i< [userArray count];i++){

                UserModel *userModel= userArray[i];
                if(userModel.toUid!=nil){

                    if([userModel.toUid intValue]==dId){
                        btnText=@"取消关注";
                        btnColor= grayRgb;
                        break;
                    }

                } else{

                    if([userModel.id intValue]==dId){
                        btnText=@"取消关注";
                        btnColor= grayRgb;
                        break;
                    }
                }

            }
        }


    } failure:^(NSDictionary *error)
    {
    }];
}
#pragma mark tableview function
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self._uId != [[Config getUserId] intValue])//如果是查看自己的资料则可以编辑
    {
        return 11;
    }
    else
    {
        return 10;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell;
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    if (indexPath.row == 0)
    {
        SetViewHeadTableViewCell* cell = [[SetViewHeadTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SetViewHeadTableViewCell" ];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setBackgroundColor:RGB(238, 238, 238)];
        [cell setHeadCellData:self.userModel cellName:@"personinfo"];
        if (self._uId != [[Config getUserId] intValue])//如果是查看自己的资料则可以编辑
        {
            UIButton *btnFollow = [[UIButton alloc ] initWithFrame:CGRectMake(SCREEN_WIDTH/2.2f, 224, 40, 25)];
            [btnFollow setTitle:btnText forState:UIControlStateNormal];
            [btnFollow setTitleColor:btnColor forState:UIControlStateNormal];
            btnFollow.titleLabel.font = [UIFont systemFontOfSize:12];
            [btnFollow addTarget:self action:@selector(onButtonFollow) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:btnFollow];
       
            UIButton *btnFollowImage = [[UIButton alloc ] initWithFrame:CGRectMake(btnFollow.frame.origin.x-10, 230, 12, 12)];
            [btnFollowImage setImage:[UIImage imageNamed:@"btn_floow.png"] forState:UIControlStateNormal];
            [btnFollowImage addTarget:self action:@selector(onButtonFollow) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:btnFollowImage];
        }
        
        return cell;
    }
    //add edit button
    if (indexPath.row == 1)
    {
        NSLog(@"%@",[Config getUserId]);
        if (self._uId == [[Config getUserId] intValue])//如果是查看自己的资料则可以编辑
        {
            UIButton *btnEdit = [[UIButton alloc ] initWithFrame:CGRectMake(SCREEN_WIDTH-60, 0, 60, 30)];
            [btnEdit setTitle:@"编辑" forState:UIControlStateNormal];
            [btnEdit setTitleColor:yellowRgb forState:UIControlStateNormal];
            btnEdit.titleLabel.font = [UIFont systemFontOfSize:12];
            [btnEdit addTarget:self action:@selector(onButtonEdit) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:btnEdit];
        }
      
        cell.textLabel.text = @"基本信息";
        [cell.textLabel setFont:[UIFont systemFontOfSize:12]];
        [cell.textLabel setTextColor:RGB(153, 153, 153)];
        return cell;
    }
    else if(indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 5 || indexPath.row == 6 )
    {
        TextModel * tModle = [[TextModel alloc ] init];
        if ([mutableArray count] > indexPath.row-2)
            tModle =  mutableArray[indexPath.row-2];
        
        static NSString *showCell = @"TextTableViewCell";
        TextTableViewCell * cell = [[TextTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:showCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setLableText:tModle viewName:@"PersonInfoViewController" cellHegith:40];
        return cell;
    }
    else if (indexPath.row == 7)
    {
         [cell setBackgroundColor:RGB(238, 238, 238)];
    }
    else if (indexPath.row == 8)
    {
        if([_myDramaArray count]!=0){
//            cell.textLabel.text = @"";
            cell.textLabel.text = @"发布的剧目";
            [cell.textLabel setFont:[UIFont systemFontOfSize:12]];
            [cell.textLabel setTextColor:RGB(153, 153, 153)];
            return cell;
        }


    }
    else if(indexPath.row == 9)
    {
        if([_myDramaArray count]!=0){

            NSMutableArray *array =[[NSMutableArray alloc ] initWithCapacity:0];
            for (int i = 0; i < [_myDramaArray count]; i++ )
            {
                dramaModle =_myDramaArray[i];
                SimilaritiesModel *similarities = [[SimilaritiesModel alloc ] init];

                similarities.sdid =dramaModle.id;
                if([dramaModle.posters count] > 0 )
                {
                    DramaPostersModel *imageItem = [[DramaPostersModel alloc ] init];
                    if ([dramaModle.posters count] >0)
                        imageItem = dramaModle.posters[0];
                    similarities.cover =imageItem.poster;
                }

                similarities.name =dramaModle.name;
                [array addObject:similarities];
            }

            UIView *userLogoList=[[CommentHeaderScrollTableView alloc]
                    initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 200)
                       viewerList:array
                       navigation:self.navigationController];
            [cell addSubview:userLogoList];
            return cell;
        }

        

    }
    else if (indexPath.row == 10)
    {
        if (self._uId != [[Config getUserId] intValue])//如果是查看自己的资料则可以编辑
        {
            UIButton *btnSave = [[UIButton alloc ] initWithFrame:CGRectMake(20, 20, SCREEN_WIDTH-40, 40)];
            [btnSave setTitle:@"联系发布者" forState:UIControlStateNormal];
            btnSave.titleLabel.font = [UIFont systemFontOfSize:14];
            [btnSave  setBackgroundColor:yellowRgb];
            btnSave.layer.masksToBounds = YES;
            btnSave.layer.cornerRadius = 3;
            [btnSave addTarget:self action:@selector(onButtonTel) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:btnSave];
            return cell;
        }
    }
    
    return cell;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
        return 250;
    else if (indexPath.row == 1)
        return 30;
    else if (indexPath.row == 7)
        return 13;
    else if (indexPath.row == 8)
        return 30;
    else if (indexPath.row == 9)
    {
        if ([_myDramaArray count] > 0 )
             return 170;
        else
             return 0;
    }
    else if (indexPath.row == 10)
        return 80;
    else
        return 40;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


-(void)onButtonTel
{
    if ([self.userModel.mobile length]> 0)
    {
        NSString *phoneNum = self.userModel.mobile;// 电话号码
        NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",phoneNum]];
        if ( !phoneCallWebView )
        {
            phoneCallWebView = [[UIWebView alloc] initWithFrame:CGRectZero];
        }
        [phoneCallWebView loadRequest:[NSURLRequest requestWithURL:phoneURL]];
    }
}


#pragma  mark  关注
-(void)onButtonFollow
{
    [UserService addFollow:[[self.userModel.id stringValue ] intValue] success:^(Boolean *boolean) {



        [Tool showWarningTip:@"操作成功" view:self.view time:1];

        if([btnText isEqualToString:@"关注"]){

            btnText=@"取消关注";
            btnColor= grayRgb;
        }else{
            btnText=@"关注";
            btnColor= yellowRgb;
        }
        [_tableView reloadData];
    } failure:^(NSString *error) {
        [Tool showWarningTip:@"操作失败" view:self.view time:1];
    }];
}


-(void) onButtonEdit
{
    EditPersonViewController *editPersonView = [[EditPersonViewController alloc ] init];
    editPersonView._uId = [[self.userModel.id stringValue] intValue];
    [self.navigationController pushViewController:editPersonView animated:YES];
}

-(void)onButtonBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
