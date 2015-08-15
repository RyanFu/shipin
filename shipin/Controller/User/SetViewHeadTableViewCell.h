//
//  HeadTableViewCell.h
//  shipin
//
//  Created by Mapollo27 on 15/7/26.
//  Copyright (c) 2015年 dust.zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FXLabel.h"


@interface SetViewHeadTableViewCell : UITableViewCell
{
    UIImageView *_imageViewBg ;
    UIImageView *_imageViewHead;
    FXLabel     *_labelName;
    UILabel     *_labelTransparentLayer;
}


-(void) setHeadCellData:(NSString *)imageHeadUrl name:(NSString *)name cellName:(NSString *)cellname;


@end
