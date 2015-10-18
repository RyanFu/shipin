//
//  MyPublishViewController.h
//  shipin
//
//  Created by Mapollo27 on 15/8/15.
//  Copyright (c) 2015年 dust.zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyPublishModle.h"
#import "imageClickDelegate.h"

@interface MyPublishViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,imageClickDelegate>
{
    NSMutableArray      *_arrayPublish;
    UITableView         *_tableView;
    
    DramaModel *dramaLeft;
    DramaModel *dramaRight;

}


@end
