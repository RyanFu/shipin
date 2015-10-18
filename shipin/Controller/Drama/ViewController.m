//
//  ViewController.m
//  shipin
//
//  Created by Mapollo27 on 15/7/17.
//  Copyright (c) 2015年 dust.zhang. All rights reserved.
//

#import <SDWebImage/SDWebImageCompat.h>
#import "ViewController.h"
#import "FindTableViewCell.h"
#import "AllTableViewCell.h"
#import "SetViewController.h"
#import "SetViewController.h"
#import "LoginViewController.h"
#import "DramaDetialViewController.h"
#import "SearchViewController.h"
#import "LKDBHelper.h"
#import "Drama.h"
#import "FVCustomAlertView.h"
#import "UIButton+WebCache.h"


@protocol Drama;

@interface ViewController ()

@end

@implementation ViewController

-(void) viewDidAppear:(BOOL)animated
{
    if([[Config getUpdateUserHeadImage] isEqualToString:@"YES"])
    {
        [self loadUserInfo ];
        [Config setUpdateUserHeadImage:@"NO"];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[UIApplication  sharedApplication] setStatusBarHidden:NO];
    [self.view setBackgroundColor:RGB(221, 221, 221)];
    strBtnClick = @"btnGood";
    bIsColl = FALSE;
    _currentPage = 1;

    [self initViewCtrl];
    [self createSpreadOutButton];
    //加载视频数据1代表最新
    [self loadFindGoodDrama:1];

    if (![[Config getLoginFlag ] isEqualToString:@"YES"])
    {
        LoginViewController *loginView = [[LoginViewController alloc ] init];
        [self.navigationController pushViewController:loginView animated:YES];
    }

    [self loadUserInfo ];

    //获取所有tags
    [DramaServices getDramaTags];
    
    [[NSNotificationCenter defaultCenter ] addObserver:self selector:@selector(SearchDrama:) name:@"notification_tags" object:nil];

}

-(void) SearchDrama: notification
{
    _arraySearch =[notification object];
    
//    [DramaServices searchDrama:1 keyWorld:nil tids:array success:^(NSArray *array)
//    {
//        self._arrayVideo =[[NSMutableArray alloc ] initWithArray:array];
//        [_findTableView reloadData];
//        
//    } failure:^(NSDictionary *error) {
//        
//    }];
    
    
}



#pragma mark push searchViewController
-(void) pushToSearcheView
{
    bIsColl = TRUE;
    [self onButtonSpreadOut];
    SearchViewController *searchView = [[SearchViewController alloc ] init];
    NSArray *searchIds = [NSArray arrayWithArray:[_arraySearch subarrayWithRange:NSMakeRange(0, 3)]];
    searchView._searchNo = searchIds; //[NSString stringWithFormat:@"%@,%@,%@,%@",_arraySearch[0],_arraySearch[1],_arraySearch[2],_arraySearch[3]];
    searchView._searchName =[NSString stringWithFormat:@"%@,%@,%@,%@",_arraySearch[4],_arraySearch[5],_arraySearch[6],_arraySearch[7]];
    [self.navigationController pushViewController:searchView animated:YES ];
    
}

//加载用户头像
-(void)loadUserInfo
{
    [FVCustomAlertView showDefaultLoadingAlertOnView:self.view withTitle:@"加载中..." withBlur:NO allowTap:YES];
    if([Config getUserId]!=nil && ![[Config getUserId] isEqualToString:@""])
    {
        LKDBHelper *helper = [LKDBHelper getUsingLKDBHelper];
        NSString *where = [NSString stringWithFormat:@"id=%@", @([[Config getUserId] intValue])];
        UserModel *   userModel = [helper searchSingle:[UserModel class] where:where orderBy:nil];
        if(userModel!= nil)
        {
            if ([userModel.avatar length] == 0 || userModel.avatar==nil)
                [_btnLogin setImage:[UIImage imageNamed:@"image_defaulthead.png"] forState:UIControlStateNormal];
            else
                [_btnLogin sd_setImageWithURL:[Tool stringMerge:userModel.avatar] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"image_defaulthead.png"]];
            //[_btnLogin setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[Tool stringMerge:userModel.avatar]]] forState:UIControlStateNormal];
        }
        [FVCustomAlertView hideAlertFromView:self.view fading:YES];
    }
    else
    {
        [UserService getUserDetail:0 success:^(UserModel *userModel)
        {
            if ([userModel.avatar length] == 0 || userModel.avatar==nil)
                [_btnLogin setImage:[UIImage imageNamed:@"image_defaulthead.png"] forState:UIControlStateNormal];
            else
                [_btnLogin sd_setImageWithURL:[Tool stringMerge:userModel.avatar] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"image_defaulthead.png"]];
               // [_btnLogin setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[Tool stringMerge:userModel.avatar]]] forState:UIControlStateNormal];
            [FVCustomAlertView hideAlertFromView:self.view fading:YES];
        } failure:^(NSDictionary *error)
        {
            [FVCustomAlertView hideAlertFromView:self.view fading:YES];
        }];
    }
}

-(void)createSearcheView
{
    viewSearch = [[UIViewSearch alloc] initWithFrame:CGRectMake(0, _findTableView.frame.origin.y, SCREEN_WIDTH, SCREEN_HEIGHT-_findTableView.frame.origin.y)];
    viewSearch.delegate = self;
    [self.view addSubview:viewSearch];
}

-(void) viewWillAppear:(BOOL)animated
{
    if ([ [Config getIsLogin] isEqualToString:@"YES"])
    {
        [Config saveIsLogin:@"NO"];
        [self loadFindGoodDrama:1];
        [self loadUserInfo];
    }
}

#pragma mark Data Source Loading / Reloading Methods
- (void)reloadTableViewDataSource
{
    _reloading = YES;
    [self loadFindGoodDrama:_currentPage ];
}
- (void)doneLoadingTableViewData
{
    //  model should call this when its done loading
    _reloading = NO;
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:_findTableView];
}

#pragma mark 上下滑动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    CGFloat height = _findTableView.frame.size.height;
//    CGFloat distanceFromButton = _findTableView.contentSize.height - _findTableView.contentOffset.y;
//    if (distanceFromButton == height)
//    {
//        NSLog(@"=====滑动到底了");
//    }
//    
//    if (_findTableView.contentOffset.y == 0)
//    {
//        NSLog(@"=====滑动到顶了");
//    }
    if([strBtnClick isEqualToString: @"btnAll" ])
    {
        if(scrollView.contentOffset.y < 0)
        {
            [UIView animateWithDuration:.3f animations:^{
                btnGood.alpha=1;
                btnAll.alpha=1;
                _findTableView.frame = CGRectMake(0, btnGood.frame.origin.y+btnGood.frame.size.height+40, SCREEN_WIDTH, SCREEN_HEIGHT-TABBAR_HEIGHT-80);
                _lableNewLine.frame = CGRectMake(0, btnGood.frame.size.height+btnGood.frame.origin.y, SCREEN_WIDTH, 40);
                btnSpreadOut.frame = CGRectMake(SCREEN_WIDTH-50, btnGood.frame.size.height+btnGood.frame.origin.y, 40, 30);
            }];
        }
        else if(scrollView.contentOffset.y > 0)
        {
            [UIView animateWithDuration:.3f animations:^{
                btnGood.alpha=0;
                btnAll.alpha=0;
               _findTableView.frame = CGRectMake(0, btnGood.frame.origin.y+btnGood.frame.size.height, SCREEN_WIDTH, SCREEN_HEIGHT-TABBAR_HEIGHT-40);
                _lableNewLine.frame = CGRectMake(0, TABBAR_HEIGHT, SCREEN_WIDTH, 40);
                btnSpreadOut.frame = CGRectMake(SCREEN_WIDTH-50, TABBAR_HEIGHT, 40, 30);
            }];
        }

    }
    else
    {
        if(scrollView.contentOffset.y < 0)
        {
            [UIView animateWithDuration:.3f animations:^{
                btnGood.alpha=1;
                btnAll.alpha=1;
                _findTableView.frame = CGRectMake(0, btnGood.frame.origin.y+btnGood.frame.size.height, SCREEN_WIDTH, SCREEN_HEIGHT-TABBAR_HEIGHT-40);
            }];
        }
        else if(scrollView.contentOffset.y > 0)
        {
            [UIView animateWithDuration:.3f animations:^{
                btnGood.alpha=0;
                btnAll.alpha=0;
                _findTableView.frame = CGRectMake(0, TABBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-TABBAR_HEIGHT);
            }];
        }

    }
    [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}

#pragma mark EGORefreshTableHeaderDelegate Methods
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view
{
    [self reloadTableViewDataSource];
    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view
{
    return _reloading; // should return if data source model is reloading
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view
{
    return [NSDate date]; // should return date data source was last changed
}

#pragma mark -上拉加载更多
-(void)addFooter
{
    __unsafe_unretained ViewController *vc = self;
    MJRefreshFooterView * footer = [MJRefreshFooterView footer];
    footer.scrollView = _findTableView;
    footer.beginRefreshingBlock = ^(MJRefreshBaseView* refreshView)
    {
        _currentPage = _currentPage +1;
        //加载更多数据
        if( _currentPage == 1 )
            [self loadFindGoodDrama:1];
        else
            [self loadFindGoodDrama:_currentPage ];
        [vc performSelector:@selector(doneWithView:) withObject:refreshView afterDelay:2.0];
    };
    _pullUpRefresh = footer;
}

-(void)doneWithView:(MJRefreshBaseView*)refreshView
{
    [_findTableView reloadData];
    [refreshView endRefreshing];
}

-(void) initViewCtrl
{
    self._navigationBar = [[ExUINavigationBar alloc ] initWithFrameRect:CGRectMake(0, 0, SCREEN_WIDTH, TABBAR_HEIGHT) BGImage:@"navigationbar.png" StrTitle:@"剧库" ];
    [self.view addSubview:self._navigationBar];
    
    _btnLogin = [[UIButton alloc ] initWithFrame:CGRectMake(10, 20, 30, 30)];
    [_btnLogin addTarget:self action:@selector(onButtonPersonalCenter) forControlEvents:UIControlEventTouchUpInside];
    _btnLogin.layer.masksToBounds = YES;
    _btnLogin.layer.cornerRadius = _btnLogin.frame.size.width/2;
    [_btnLogin setImage:[UIImage imageNamed:@"image_defaulthead.png"] forState:UIControlStateNormal];
    [self.view addSubview:_btnLogin];
    
    btnGood = [[UIButton alloc ] initWithFrame:CGRectMake(0, TABBAR_HEIGHT, SCREEN_WIDTH/2, 40)];
    [btnGood setBackgroundColor:[UIColor blackColor]];
    [btnGood setTitle:@"热剧" forState:UIControlStateNormal];
    [btnGood setTitleColor:yellowRgb forState:UIControlStateNormal];
    btnGood.titleLabel.font = [UIFont systemFontOfSize:14];
    btnGood.tag = 100;
    [btnGood addTarget:self action:@selector(onButtonSelect:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: btnGood];
    
    btnAll = [[UIButton alloc ] initWithFrame:CGRectMake(SCREEN_WIDTH/2, TABBAR_HEIGHT, SCREEN_WIDTH/2, 40)];
    [btnAll setBackgroundColor:[UIColor blackColor]];
    [btnAll setTitle:@"发现" forState:UIControlStateNormal];
    [btnAll setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnAll addTarget:self action:@selector(onButtonSelect:) forControlEvents:UIControlEventTouchUpInside];
    btnAll.tag = 101;
    btnAll.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview: btnAll];
    
    //创建tableview
    _findTableView = [[UITableView alloc ] initWithFrame:CGRectMake(0, btnGood.frame.origin.y+btnGood.frame.size.height, SCREEN_WIDTH, SCREEN_HEIGHT-TABBAR_HEIGHT-40) style:UITableViewStylePlain];
    _findTableView.delegate = self;
    _findTableView.dataSource = self;
    _findTableView.scrollEnabled = YES;
    _findTableView.separatorColor = [UIColor clearColor];
    [self.view addSubview:_findTableView];

    //上拉刷新
    [self addFooter];
    //下拉刷新
    if (_refreshHeaderView == nil)
    {
        EGORefreshTableHeaderView *headRefreshTableview = [[EGORefreshTableHeaderView alloc]
                                                           initWithFrame:CGRectMake(0.0f, 0.0f - _findTableView.bounds.size.height,  _findTableView.frame.size.width, _findTableView.bounds.size.height)];
        headRefreshTableview.delegate = self;
        [_findTableView addSubview:headRefreshTableview];
        _refreshHeaderView = headRefreshTableview;
    }
    [_refreshHeaderView refreshLastUpdatedDate];
    
}


#pragma mark  创建展开收起按钮
-(void) createSpreadOutButton
{
    _lableNewLine = [[UILabel alloc ] initWithFrame:CGRectMake(0, btnGood.frame.size.height+btnGood.frame.origin.y, SCREEN_WIDTH, 40)];
    [_lableNewLine setText:@"搜索更多"];
    [_lableNewLine setBackgroundColor:[UIColor clearColor]];
    [_lableNewLine setFont:[UIFont systemFontOfSize:14]];
    [_lableNewLine setTextAlignment:NSTextAlignmentCenter];
    [_lableNewLine setTextColor:RGB(153, 153, 153)];
    [self.view addSubview:_lableNewLine];
    [_lableNewLine setHidden:YES];
    
    btnSpreadOut = [[UIButton alloc ] initWithFrame:CGRectMake(SCREEN_WIDTH-50, btnGood.frame.size.height+btnGood.frame.origin.y, 40, 30)];
    [btnSpreadOut setBackgroundImage:[UIImage imageNamed:@"ico-up-arrow.png"] forState:UIControlStateNormal];
    [self.view addSubview:btnSpreadOut];
    [btnSpreadOut addTarget:self action:@selector(onButtonSpreadOut) forControlEvents:UIControlEventTouchUpInside];
    [btnSpreadOut setHidden:YES];
}

-(void)onButtonSpreadOut
{
    if (bIsColl)
    {
        [btnSpreadOut setBackgroundImage:[UIImage imageNamed:@"ico-up-arrow.png"] forState:UIControlStateNormal];
        [viewSearch removeFromSuperview];
        bIsColl = FALSE;
    }
    else
    {
        [self createSearcheView];
        [btnSpreadOut setBackgroundImage:[UIImage imageNamed:@"ico-down-arrow.png"] forState:UIControlStateNormal];
        bIsColl = TRUE;
    }
}

-(void) onButtonPersonalCenter
{
    SetViewController *setView = [[SetViewController alloc ] init];
    [self.navigationController pushViewController:setView animated:YES];
}


//剧目类型选择
-(void) onButtonSelect:(UIButton*) sender
{
    //发现好剧
    if ( sender.tag == 100 )
    {
        [_lableNewLine setHidden:YES];
         bIsColl = TRUE;
        [self onButtonSpreadOut];
        _findTableView.frame = CGRectMake(0, btnGood.frame.origin.y+btnGood.frame.size.height, SCREEN_WIDTH, SCREEN_HEIGHT-TABBAR_HEIGHT-40);
        strBtnClick = @"btnGood";
        [btnGood setTitleColor:yellowRgb forState:UIControlStateNormal];
        [btnAll setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnSpreadOut setHidden:YES];
        //加载发现好剧数据
        [self loadFindGoodDrama:1];
    }
    //全部剧目
    if ( sender.tag == 101 )
    {
        [_lableNewLine setHidden:NO];
         _findTableView.frame = CGRectMake(0, btnGood.frame.origin.y+btnGood.frame.size.height+40, SCREEN_WIDTH, SCREEN_HEIGHT-TABBAR_HEIGHT-80);
        strBtnClick = @"btnAll";
        [btnGood setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnAll setTitleColor:yellowRgb forState:UIControlStateNormal];
        [btnSpreadOut setHidden:NO];
        [self loadFindGoodDrama:1];
    }
}

#pragma mark 加载好剧数据
-(void) loadFindGoodDrama:(int )pageNumber
{
//    [FVCustomAlertView showDefaultLoadingAlertOnView:self.view withTitle:@"加载中..." withBlur:NO allowTap:YES];

    [FVCustomAlertView showAlertOnView:self.view withTitle:@"加载中..." titleColor:[UIColor whiteColor] width:90.0 height:90.9 blur:YES backgroundImage:nil backgroundColor:[UIColor blackColor] cornerRadius:15.0 shadowAlpha:0.1 alpha:0.9 contentView:nil type:FVAlertTypeLoading allowTap:YES];

    if([ strBtnClick isEqualToString: @"btnAll"])
    {
        if ([NetWorkState getNetWorkState] == NotReachable )
        {
            //获取本地数据
            NSMutableArray *dramaArray = [self getOldData:@(pageNumber) type:@""];
            if([dramaArray count]>0){
                
                self._arrayVideo = dramaArray;
                [_findTableView reloadData];
            }
            [FVCustomAlertView hideAlertFromView:self.view fading:YES];
        }
        else
        {
            [DramaServices pullAllDramaList:pageNumber  success:^(NSArray *array)
             {
                 self._arrayNewVideo =[[NSMutableArray alloc ] initWithArray:array];
                 if (pageNumber  == 1 )
                 {
                     self._arrayVideo = [[NSMutableArray alloc]initWithArray:self._arrayNewVideo];
                     [_findTableView reloadData];
                 }
                 else
                 {
                     if (self._arrayNewVideo.count == 0)
                     {
                         [Tool showWarningTip:@"没有更多数据!" view:self.view time:1];
                     }
                     if (self._arrayNewVideo.count != 0)
                     {
                         [self._arrayVideo addObjectsFromArray:self._arrayNewVideo];
                         [_findTableView reloadData];
                     }
                 }
                [FVCustomAlertView hideAlertFromView:self.view fading:YES];
             } failure:^(NSDictionary *error)
             {
                 [FVCustomAlertView hideAlertFromView:self.view fading:YES];
                 [Tool showWarningTip:@"请求数据失败" view:self.view time:2];
             }];
        }
    }
    else
    {
        if ([NetWorkState getNetWorkState] == NotReachable )
        {
            //获取本地数据
            NSMutableArray *dramaArray = [self getOldData:@(pageNumber) type:@"1"];
            if([dramaArray count]>0)
            {
                self._arrayVideo = dramaArray;
                [_findTableView reloadData];
            }
            [FVCustomAlertView hideAlertFromView:self.view fading:YES];
        }
        else
        {
            [DramaServices pullDramaGoodData:pageNumber  success:^(NSArray *array)
             {
                 self._arrayNewVideo =[[NSMutableArray alloc ] initWithArray:array];
                 
                 if (pageNumber  == 1 )
                 {
                     self._arrayVideo = [[NSMutableArray alloc]initWithArray:self._arrayNewVideo];
                     [_findTableView reloadData];
                 }
                 else
                 {
                     if (self._arrayNewVideo.count == 0)
                     {
                         [Tool showWarningTip:@"没有更多数据!" view:self.view time:1];
                     }
                     if (self._arrayNewVideo.count != 0)
                     {
                         [self._arrayVideo addObjectsFromArray:self._arrayNewVideo];
                         [_findTableView reloadData];
                     }
                 }
                 [FVCustomAlertView hideAlertFromView:self.view fading:YES];
             } failure:^(NSDictionary *error)
             {
                 [FVCustomAlertView hideAlertFromView:self.view fading:YES];
                 [Tool showWarningTip:@"请求数据失败" view:self.view time:2];
             }];
        }
    }
}

//获取本地数据
-(NSMutableArray *)getOldData:(NSNumber *)number type:(NSString *)type{

    LKDBHelper *helper = [LKDBHelper getUsingLKDBHelper];
    NSString *orderBy = @"CAST(id as integer) desc";
    NSString *where = [NSString stringWithFormat:@"type=%@", @"1"];
    NSMutableArray *dramaArray;
    if([type isEqualToString:@"1"]){
        dramaArray = [helper search:[Drama class] where:where orderBy:orderBy offset:0 count:10];

    } else{

         dramaArray = [helper search:[Drama class] where:nil orderBy:orderBy offset:0 count:10];

    }

    if([dramaArray count]>0){

        NSMutableArray* array = [[NSMutableArray alloc] init];
        for(Drama *drama in dramaArray){

            NSLog(@"dramaContent::%@",drama.content);

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

#pragma mark tableview function
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([strBtnClick isEqualToString:@"btnGood" ])
    {
         return [self._arrayVideo count];
    }
    if ([ strBtnClick isEqualToString:@"btnAll" ])
    {
        if([self._arrayVideo count]%2 == 0)
            return [self._arrayVideo count]/2;
        else
            return [self._arrayVideo count]/2+[self._arrayVideo count]%2;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"] ;;
    
    if ([strBtnClick isEqualToString:@"btnGood" ])
    {
        DramaModel *itemData = [[DramaModel alloc ] init];
        itemData = self._arrayVideo[indexPath.row];
        
        FindTableViewCell *cell = [[FindTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FindTableViewCell"];

        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setControlData:itemData];
        return cell;
    }
    //全部剧目
    if ([ strBtnClick isEqualToString:@"btnAll" ])
    {
        AllTableViewCell *allCell  = [[AllTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: @"AllTableViewCell"];
            allCell.selectionStyle = UITableViewCellSelectionStyleNone;

        
        if([self._arrayVideo count]%2 == 0)
        {
            dramaLeft  =[self._arrayVideo objectAtIndex:(indexPath.row*2)];
            dramaRight=[self._arrayVideo objectAtIndex:(indexPath.row*2+1)];
        }
        else
        {
            dramaLeft  =[self._arrayVideo objectAtIndex:(indexPath.row*2)];
            if ( ((indexPath.row*2)+1) < [self._arrayVideo count] )
            {
                dramaRight=[self._arrayVideo objectAtIndex:(indexPath.row*2+1)];
            }
            else
                dramaRight =nil;
            
        }

        allCell.delegate = self;
        [allCell setControlLeftData:dramaLeft rightData:dramaRight type:@""];
        return allCell;
    }
    return cell;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([strBtnClick isEqualToString:@"btnGood" ])
    {
        return 135;
    }
    if ([ strBtnClick isEqualToString:@"btnAll" ])
    {
        return 170;
    }
    return 0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:_findTableView])
    {
        DramaModel *itemData = [[DramaModel alloc ] init];
        itemData = self._arrayVideo[indexPath.row];

        DramaDetialViewController *dramaDetialView = [[DramaDetialViewController alloc ] init];
        dramaDetialView.nId = [[itemData.id stringValue] intValue];
        [self.navigationController pushViewController:dramaDetialView animated:YES];
    }

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

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
