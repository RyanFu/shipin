//
//  DramaDetialViewController.h
//  shipin
//
//  Created by Mapollo27 on 15/8/16.
//  Copyright (c) 2015年 dust.zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DramaModel.h"
#import "DetialHeadTableViewCell.h"
#import "DramaDetialTableViewCell.h"
#import "DramaRelativesModel.h"
#import "SimilaritiesModel.h"

@interface DramaDetialViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray      *_arrayDramaDetial;
    UITableView         *_tableView;
    
    UIButton            *btnIntroduction;
    UIButton            *btnProjectInfo;
    UIButton            *btnConnect;
    int                 clickIndex;
    
    DramaModel          *dramaModle;
}

@property (nonatomic,assign) int   nId;

@end
