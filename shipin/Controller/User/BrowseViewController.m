//
//  BrowseViewController.m
//  shipin
//
//  Created by Mapollo27 on 15/8/18.
//  Copyright (c) 2015年 dust.zhang. All rights reserved.
//

#import "BrowseViewController.h"
#import "DramaDetialViewController.h"
#import "LKDBHelper.h"
#import "MyCollection.h"

@interface BrowseViewController ()

@end

@implementation BrowseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
      [[UIApplication  sharedApplication] setStatusBarHidden:NO];
    // Do any additional setup after loading the view.
    _arrayBrowse = [[NSMutableArray alloc ] initWithCapacity:0];
    
    [self initViewCtrl];
}

-(void) initViewCtrl
{
    ExUINavigationBar *navigationBar = [[ExUINavigationBar alloc ] initWithFrameRect:CGRectMake(0, 0, SCREEN_WIDTH, TABBAR_HEIGHT) BGImage:@"navigationbar" StrTitle:self.strViewName  ];
    [self.view addSubview:navigationBar];
    
    UIButton *btnBack = [[UIButton alloc ] initWithFrame:backButtonFram];
    [btnBack setImage:[UIImage imageNamed:@"btn_back.png"] forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(onButtonBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnBack];
    
    _tableViewBrowse = [[UITableView alloc ] initWithFrame:CGRectMake(0, TABBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-TABBAR_HEIGHT) style:UITableViewStylePlain];
    _tableViewBrowse.dataSource = self;
    _tableViewBrowse.delegate = self;
    _tableViewBrowse.separatorColor = RGB(221, 221, 221);
    [_tableViewBrowse setBackgroundColor:RGBA(238, 238, 238, 1)];
    [self.view addSubview:_tableViewBrowse];
    
    [self loadNetWorkData];
}


-(void) loadNetWorkData
{
    if ([NetWorkState getNetWorkState] == NotReachable )
    {
        LKDBHelper *helper = [LKDBHelper getUsingLKDBHelper];
        NSString *orderBy = @"CAST(id as integer) desc";
        NSMutableArray * dramaArray = [helper search:[MyCollection class] where:nil orderBy:orderBy offset:0 count:10];
        
        if(dramaArray!=nil && [dramaArray count]>0)
        {
            NSMutableArray* array = [[NSMutableArray alloc] init];
            for(MyCollection *drama in dramaArray)
            {
                NSError* err = nil;
                DramaModel *dramaModel = [[DramaModel alloc] initWithString:drama.content error:&err];
                
                if(err!=nil)
                {
                    NSLog(@"getOldDatasERROR:::%@",err );
                }
                [array addObject:dramaModel];
            }
            _arrayBrowse=array;
            [_tableViewBrowse reloadData];
        }
    }
    else
    {
        [UserService getCollections:^(NSArray *dramaArray)
         {
             _arrayBrowse =[[NSMutableArray alloc ] initWithArray:dramaArray];
             
             [_tableViewBrowse reloadData];
         } failure:^(NSDictionary *error)
         {
             [Tool showWarningTip:@"请求我的收藏数据失败" view:self.view time:2];
         }];
    }
}
-(void) onButtonBack
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark tableview function
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    NSLog(@"%ld",[_arrayBrowse count]/2+[_arrayBrowse count]%2);
    if([_arrayBrowse count]%2 == 0)
        return [_arrayBrowse count]/2;
    else
        return [_arrayBrowse count]/2+[_arrayBrowse count]%2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *showCell = @"AllTableViewCell";
    AllTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:showCell] ;
    if (cell == nil)
    {
        cell = [[AllTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:showCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if([_arrayBrowse count]%2 == 0)
    {
        dramaLeft  =[_arrayBrowse objectAtIndex:(indexPath.row*2)];
        dramaRight=[_arrayBrowse objectAtIndex:(indexPath.row*2+1)];
    }
    else
    {
        NSLog(@"%ld",(indexPath.row*2));
        NSLog(@"%ld",(indexPath.row*2)+1);
        dramaLeft  =[_arrayBrowse objectAtIndex:(indexPath.row*2)];
        if ( ((indexPath.row*2)+1) < [_arrayBrowse count] )
        {
            dramaRight=[_arrayBrowse objectAtIndex:(indexPath.row*2+1)];
        }
        else
            dramaRight =nil;
        
    }
    
    cell.delegate = self;
    [cell setControlLeftData:dramaLeft rightData:dramaRight type:@""];

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
