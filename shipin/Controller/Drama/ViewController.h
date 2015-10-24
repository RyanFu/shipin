//
//  ViewController.h
//  shipin
//
//  Created by Mapollo27 on 15/7/17.
//  Copyright (c) 2015年 dust.zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExUINavigationBar.h"
#import "DramaModel.h"
#import "EGORefreshTableHeaderView.h"
#import "MJRefreshFooterView.h"
#import "imageClickDelegate.h"
#import "UIViewSearch.h"
#import "DramaTags.h"

@interface ViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,EGORefreshTableHeaderDelegate,imageClickDelegate,pushSearchViewDelegate,UIGestureRecognizerDelegate>
{
    UITableView         *_findTableView;
    UIButton            *btnAll;
    UIButton            *btnGood;
    BOOL                bIsColl;
    UIButton            *btnSpreadOut;
    int                             _currentPage;
    BOOL                            _reloading;
    MJRefreshFooterView             *_pullUpRefresh;
    EGORefreshTableHeaderView       *_refreshHeaderView;
    
    DramaModel                  *dramaLeft;
    DramaModel                  *dramaRight;
    NSString                    *strBtnClick;
    UIViewSearch                *viewSearch;
    NSURL                       *_urlUser;
    UIButton                    *_btnLogin;
    UIButton                    *_lableNewLine;
    
    NSMutableArray              *_arraySearch;
    NSString                    *strTop;
}

@property (nonatomic,strong)    ExUINavigationBar       *_navigationBar;
@property (nonatomic,strong)    NSMutableArray          *_arrayVideo;
@property (nonatomic,strong)    NSMutableArray          *_arrayNewVideo;

@end
