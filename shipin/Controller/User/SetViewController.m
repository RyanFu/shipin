//
//  SetViewController.m
//  shipin
//
//  Created by Mapollo27 on 15/7/26.
//  Copyright (c) 2015年 dust.zhang. All rights reserved.
//

#import "SetViewController.h"
#import "SetViewHeadTableViewCell.h"
#import "PersonInfoViewController.h"
#import "AttentionPeoperViewController.h"
#import "SystemMsgViewController.h"
#import "AboutViewController.h"
#import "FeedBackViewController.h"
#import "UseHelpViewController.h"
#import "MyPublishViewController.h"
#import "BrowseViewController.h"
#import "LKDBHelper.h"
#import "FVCustomAlertView.h"

@interface SetViewController ()

@end

@implementation SetViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
      [[UIApplication  sharedApplication] setStatusBarHidden:NO];
    // Do any additional setup after loading the view.
//    [self loadUserInfo ];
}

-(void) viewWillAppear:(BOOL)animated
{
//    if([[Config getUpdateUserHeadImage] isEqualToString:@"YES"])
        [self loadUserInfo ];
}

-(void) loadUserInfo
{
    [FVCustomAlertView showDefaultLoadingAlertOnView:self.view withTitle:nil withBlur:NO allowTap:YES];
    
    if ([NetWorkState getNetWorkState] == NotReachable )
    {
        LKDBHelper *helper = [LKDBHelper getUsingLKDBHelper];
        NSString *where = [NSString stringWithFormat:@"id=%@", @([[Config getUserId] intValue])];
        UserModel *   userModel = [helper searchSingle:[UserModel class] where:where orderBy:nil];
        self.userModel = userModel;
        [self createTable];
        [FVCustomAlertView hideAlertFromView:self.view fading:YES];
    }
    else
    {
        [UserService getUserDetail:0 success:^(UserModel *userModel)
         {
             self.userModel =userModel;
             [self createTable];
             [FVCustomAlertView hideAlertFromView:self.view fading:YES];

         } failure:^(NSDictionary *error)
         {
             [FVCustomAlertView hideAlertFromView:self.view fading:YES];
             [Tool showWarningTip:@"获取用户信息失败" view:self.view time:1];
         }];
    }
}

-(void) createTable
{
    if (_tableView)
    {
        [_tableView removeFromSuperview];
    }
    _tableView = [[UITableView alloc ] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorColor = RGB(221,221,221);
    _tableView.scrollEnabled = YES;
    [_tableView setBackgroundColor:RGB(238,238,238)];
    [self.view addSubview:_tableView];
    
    UIButton *btnBack = [[UIButton alloc ] initWithFrame:backButtonFram];
    [btnBack setImage:[UIImage imageNamed:@"btn_back.png"] forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(onButtonBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnBack];

}

-(void) onButtonBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark tableview function
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 3;
    }
    else
    {
       return 4;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont systemFontOfSize:12];
        [cell.textLabel setTextColor:RGB(34, 34, 34)];
        switch (indexPath.section)
        {
            case 0:
                if(indexPath.row == 0)
                {
                    static NSString *showCell = @"SetViewHeadTableViewCell";
                    SetViewHeadTableViewCell* cell = [[SetViewHeadTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:showCell ];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    
                    UIButton *btnHead =[[UIButton alloc ] initWithFrame:CGRectMake(20, 60, 80, 80)];
                    [btnHead  addTarget:self action:@selector(onButtonHead) forControlEvents:UIControlEventTouchUpInside];
                    [btnHead setBackgroundColor:[UIColor clearColor]];
                    [cell addSubview:btnHead];
                    
                    
                    //我的收藏
                    UIButton *btnCollection =[[UIButton alloc ] initWithFrame:CGRectMake(0, 170-14, SCREEN_WIDTH/2, 34)];
                    [btnCollection setTitle:@"           我的收藏" forState:UIControlStateNormal];
                    btnCollection.titleLabel.font = [UIFont systemFontOfSize:12];
                    [btnCollection setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
                    [btnCollection  addTarget:self action:@selector(onButtonCollection) forControlEvents:UIControlEventTouchUpInside];
                    [cell addSubview:btnCollection];
                    
                    UIImageView *imageView = [[UIImageView alloc ] initWithFrame:CGRectMake(20, 10, 14, 14)];
                    [imageView setImage:[UIImage imageNamed:@"image_collection.png"]];
                    [btnCollection addSubview:imageView];
                    
                    //我的关注的人
                    UIButton *btnFollow =[[UIButton alloc ] initWithFrame:CGRectMake(SCREEN_WIDTH/2, 170-14, SCREEN_WIDTH/2, 34)];
                    [btnFollow setTitle:@"           我关注的人" forState:UIControlStateNormal];
                    btnFollow.titleLabel.font = [UIFont systemFontOfSize:12];
                    [btnFollow setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
                    [btnFollow  addTarget:self action:@selector(onButtonFollow) forControlEvents:UIControlEventTouchUpInside];
                    [cell addSubview:btnFollow];
                    
                    imageView = [[UIImageView alloc ] initWithFrame:CGRectMake(20, 10, 14, 14)];
                    [imageView setImage:[UIImage imageNamed:@"image_heart.png"]];
                    [btnFollow addSubview:imageView];
                    
                    [cell setHeadCellData:self.userModel cellName:@"setview"];
                    return cell;
                }
                if(indexPath.row == 1)
                {
                    cell.textLabel.text =  @"我的发布";
                }
                if(indexPath.row == 2)
                {
                    cell.textLabel.text =  @"系统消息";
                }
                
                break;
            case 1:
                if(indexPath.row == 0)
                {
                    cell.textLabel.text =  @"分享给好友";
                }
                if(indexPath.row == 1)
                {
                    cell.textLabel.text =  @"意见反馈";
                }
//                if(indexPath.row == 2)
//                {
//                    cell.textLabel.text =  @"使用帮助";
//                }
                if(indexPath.row == 2)
                {
                    cell.textLabel.text =  @"去给应用评分";
                }
                if(indexPath.row == 3)
                {
                    cell.textLabel.text =  @"关于我们";
                }

                break;
            default:
                break;
        }
  
        return cell;
    }
     return cell;
}

#pragma mark 收藏
-(void) onButtonCollection
{
    BrowseViewController *browseView = [[BrowseViewController alloc ] init];
    browseView.strViewName = @"我的收藏";
    [self.navigationController pushViewController:browseView animated:YES];
}

#pragma mark 关注的人
-(void) onButtonFollow
{
    AttentionPeoperViewController *attentionPeoperView = [[AttentionPeoperViewController alloc ] init];
    [self.navigationController pushViewController:attentionPeoperView animated:YES];
}

-(void)onButtonHead
{
    PersonInfoViewController *personInfoView = [[PersonInfoViewController alloc ] init];
    personInfoView._uId = [[Config getUserId] intValue];
    [self.navigationController pushViewController:personInfoView animated:YES];
}

#pragma mark tableview
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
        return 0.01f;
    else
        return 5;
}
//section底部间距
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 7;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        if (indexPath.row == 0)
            return 190;
        else
            return 40;
    }
    else
        return 40;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section)
    {
        case 0:
            //个人信息
            if (indexPath.row == 0)
            {
//                PersonInfoViewController *personInfoView = [[PersonInfoViewController alloc ] init];
//                personInfoView._uId = [[Config getUserId] intValue];
//                [self.navigationController pushViewController:personInfoView animated:YES];
            }
            if (indexPath.row == 1)//我的发布
            {
                MyPublishViewController *myPublishView = [[MyPublishViewController alloc ] init];
                [self.navigationController pushViewController:myPublishView animated:YES];
            }
            if (indexPath.row == 2)//系统消息
            {
                SystemMsgViewController *systemMsgView = [[SystemMsgViewController alloc ] init];
                [self.navigationController pushViewController:systemMsgView animated:YES];
            }
            break;
        case 1:
            if (indexPath.row == 0)//分享
            {
                [self showShareView];
            }
            if (indexPath.row == 1)//意见反馈
            {
                FeedBackViewController *feedBackView = [[FeedBackViewController alloc ] init];
                [self.navigationController pushViewController:feedBackView animated:YES];
            }
//            if (indexPath.row == 2)//使用帮助
//            {
//                UseHelpViewController *useHelpView = [[UseHelpViewController alloc ] init];
//                [self.navigationController pushViewController:useHelpView animated:YES];
//            }
            if (indexPath.row == 2)//去给应用评分
            {
                [[UIApplication sharedApplication ] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/ju-ku/id1035193061?l=en&mt=8"]];
                
            }
            if (indexPath.row == 3)//关于我们
            {
                AboutViewController *aboutView = [[AboutViewController alloc ] init];
                [self.navigationController pushViewController:aboutView animated:YES];
            }
            break;
        default:
            break;
    }

}

-(void) showShareView
{
    if(!_shareView)
    {
        _shareView=[ShareView getShareInstance];
        _shareView.backgroundColor = [UIColor clearColor];
        _shareView.hidden=YES;
        _shareView.alpha = 0;
        _shareView.transform = CGAffineTransformMakeScale(1.2, 1.2);
        
    }
    _shareView.shareDelegate=self;
    [self.view addSubview:_shareView];
    
//    //设置分享的数据
    _shareView.shareUrl=@"https://itunes.apple.com/cn/app/ju-ku/id1035193061?l=en&mt=8";
    _shareView.shareTitle=@"剧库";
//    _shareView.shareDescription=self._itemContent.summary;
//    if(self._itemContent.imageList&&self._itemContent.imageList.count>0)
//    {
//        ArticleImageInfo *articleImageInfo =self._itemContent.imageList[0];
//        _shareView.shareImgUrl=articleImageInfo.imageUrl;
//    }
//    else if(self._itemContent.coverUrl&&self._itemContent.coverUrl.length>0)
//    {
//        _shareView.shareImgUrl=self._itemContent.coverUrl;
//    }
//    else
//    {
//        _shareView.shareImgUrl=@"";
//    }
    
    _shareView.shareContentType=WeiChatShareContentTypeNews;
//    _shareView.shareObjectId=self._itemContent.articleId;
    _shareView.shareObjectType=ShareContentTypeOfArticle;
    
    [UIView animateWithDuration:0.2
                     animations:^{
                         _shareView.transform = CGAffineTransformMakeScale(1, 1);
                         _shareView.hidden=NO;
                         _shareView.alpha=1;
                     }completion:^(BOOL finish){
                     }];
}

-(void)touchUpCloseShare
{
    [_shareView removeFromSuperview];
    [UIView animateWithDuration:0.3
                     animations:^{
                         _shareView.transform = CGAffineTransformMakeScale(1.3, 1.3);
                         _shareView.alpha=0;
                     }completion:^(BOOL finish){
                         _shareView.hidden=YES;
                     }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
