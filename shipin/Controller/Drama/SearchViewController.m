//
//  SearchViewController.m
//  shipin
//
//  Created by Mapollo27 on 15/8/23.
//  Copyright (c) 2015年 dust.zhang. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchTableViewCell.h"
#import "DramaDetialViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
      [[UIApplication  sharedApplication] setStatusBarHidden:NO];
    // Do any additional setup after loading the view.
    
    UIView *viewNav = [[ExUINavigationBar alloc ] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, TABBAR_HEIGHT) ];
    [viewNav setBackgroundColor:RGB(238, 238, 238)];
    [self.view addSubview:viewNav];

    _searchBar = [[UISearchBar alloc ] initWithFrame:CGRectMake(10, viewNav.frame.size.height-35, SCREEN_WIDTH-60, 30)];
    [_searchBar setPlaceholder:@"请输入剧名、导演或主演"];
    _searchBar.delegate = self;
    _searchBar.clearsContextBeforeDrawing = NO;
    [self.view addSubview:_searchBar];
    
    [_searchBar setText:self._searchName];
    
    UIButton *btnCanel = [[UIButton alloc ] initWithFrame:CGRectMake(SCREEN_WIDTH-60, _searchBar.frame.origin.y, 60, _searchBar.frame.size.height)];
    [btnCanel setTitle:@"取消" forState:UIControlStateNormal];
    btnCanel.titleLabel.font = [UIFont systemFontOfSize:13];
    [btnCanel setTitleColor:RGB(102, 102, 102) forState:UIControlStateNormal];
    [btnCanel addTarget:self action:@selector(onButtonCancel) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnCanel];
    
    _tableViewSearch = [[UITableView alloc ] initWithFrame:CGRectMake(0, TABBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-TABBAR_HEIGHT) style:UITableViewStylePlain];
    _tableViewSearch.dataSource = self;
    _tableViewSearch.delegate = self;
    _tableViewSearch.separatorColor = [UIColor clearColor];
    [_tableViewSearch setBackgroundColor:RGBA(238, 238, 238, 1)];
    [self.view addSubview:_tableViewSearch];
    
    [self loadHotSearchData];

}

#pragma mark 热门搜索
-(void) loadHotSearchData
{
    //关键字搜索
    [DramaServices searchDrama:1 keyWorld:nil tids:self._searchNo success:^(NSArray *array)
     {
         if ([array count] == 0 )
         {
             [Tool showWarningTip:@"没有相关电影" view:self.view time:1];
             return ;
         }
         _arraySearch = [[NSMutableArray alloc ] initWithArray:array];
         [_tableViewSearch reloadData];
         
     } failure:^(NSDictionary *error) {
         [Tool showWarningTip:@"搜索失败" view:self.view time:1];
     }];

}

-(void) onButtonCancel
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark tableview function
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  [_arraySearch count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SearchTableViewCell";
    SearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[SearchTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    _dramaModle = [_arraySearch objectAtIndex:indexPath.row];
    [cell setCtrlData:_dramaModle];
    
    return cell;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 122;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _dramaModle = [_arraySearch objectAtIndex:indexPath.row];
    
    DramaDetialViewController *dramaDetialView = [[DramaDetialViewController alloc ] init];
    dramaDetialView.nId = [ [_dramaModle.id stringValue ] intValue];
    [self.navigationController pushViewController:dramaDetialView animated:YES];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [_searchBar resignFirstResponder];
    //关键字搜索
    [DramaServices searchDrama:1 keyWorld:searchBar.text tids:nil success:^(NSArray *array)
    {
        if ([array count] == 0 )
        {
            [Tool showWarningTip:@"没有相关电影" view:self.view time:1];
            return ;
        }
        _arraySearch = [[NSMutableArray alloc ] initWithArray:array];
        [_tableViewSearch reloadData];
        
    } failure:^(NSDictionary *error) {
        [Tool showWarningTip:@"搜索失败" view:self.view time:1];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
