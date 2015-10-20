//
//  DetialHeadTableViewCell.m
//  shipin
//
//  Created by Mapollo27 on 15/8/16.
//  Copyright (c) 2015年 dust.zhang. All rights reserved.
//

#import "DetialHeadTableViewCell.h"

@implementation DetialHeadTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _imageViewHead = [[UIImageView alloc ] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH-106)];
        _imageViewHead.layer.masksToBounds = YES;
        [_imageViewHead setContentMode:UIViewContentModeScaleAspectFill];
        [self addSubview:_imageViewHead];
        
        _imageViewUserHead = [[UIImageView alloc ] initWithFrame:CGRectMake(10, _imageViewHead.frame.origin.y+_imageViewHead.frame.size.height+10, 20, 20)];
        _imageViewUserHead.layer.masksToBounds = YES;
        _imageViewUserHead.layer.cornerRadius=20/2;
        [self addSubview:_imageViewUserHead];
        
        //发布人名字
        UILabel *labelUser = [[UILabel alloc ] initWithFrame:CGRectMake(_imageViewUserHead.frame.origin.x+_imageViewUserHead.frame.size.width+10, _imageViewUserHead.frame.origin.y, 50, 20)];
        [labelUser setBackgroundColor:[UIColor clearColor] ];
        [labelUser setFont:[UIFont systemFontOfSize:14] ];
        [labelUser setTextColor:RGB(153, 153, 153)];
        [labelUser setText:@"发布人:"];
        [self addSubview:labelUser];
        
        _labelUserName = [[UILabel alloc ] initWithFrame:CGRectMake(labelUser.frame.origin.x+labelUser.frame.size.width+10, _imageViewUserHead.frame.origin.y, 70, 20)];
        [_labelUserName setBackgroundColor:[UIColor clearColor] ];
        [_labelUserName setFont:[UIFont systemFontOfSize:14] ];
        [_labelUserName setTextColor:yellowRgb];
        [_labelUserName setTextAlignment:NSTextAlignmentLeft];
        [self addSubview:_labelUserName];
        
        _labelReadCount = [[UILabel alloc ] initWithFrame:CGRectMake(SCREEN_WIDTH-105, _imageViewUserHead.frame.origin.y, 70, 20)];
        [_labelReadCount setBackgroundColor:[UIColor clearColor] ];
        [_labelReadCount setFont:[UIFont systemFontOfSize:12] ];
        [_labelReadCount setTextColor:yellowRgb];
        [_labelReadCount setTextAlignment:NSTextAlignmentRight];
        [self addSubview:_labelReadCount];

        UILabel *labelRead = [[UILabel alloc ] initWithFrame:CGRectMake(SCREEN_WIDTH-30, _imageViewUserHead.frame.origin.y, 30, 20)];
        [labelRead setBackgroundColor:[UIColor clearColor] ];
        [labelRead setFont:[UIFont systemFontOfSize:12] ];
        [labelRead setTextColor:RGB(153, 153, 153)];
        [labelRead setTextAlignment:NSTextAlignmentLeft];
        [labelRead setText:@"阅读"];
        [self addSubview:labelRead];
        
        //推荐语
        _labelRecommend = [[UILabel alloc] initWithFrame:CGRectMake(_imageViewUserHead.frame.origin.x,_imageViewUserHead.frame.origin.y+_imageViewUserHead.frame.size.height+5, SCREEN_WIDTH-20, 24)];
        [_labelRecommend setTextColor:RGB(153, 153, 153)];
        [_labelRecommend setBackgroundColor:[UIColor clearColor]];
        [_labelRecommend setFont:[UIFont systemFontOfSize:12]];
        [_labelRecommend setTextAlignment:NSTextAlignmentLeft];
        _labelRecommend.numberOfLines = 0;
        [_labelRecommend setLineBreakMode:NSLineBreakByCharWrapping];
        [self addSubview:_labelRecommend];

        UILabel *labelLine = [[UILabel alloc ] initWithFrame:CGRectMake(0, _labelRecommend.frame.origin.y+_labelRecommend.frame.size.height+5, SCREEN_WIDTH, 1)];
        [labelLine setBackgroundColor:RGB(221, 221, 221)];
        [self addSubview:labelLine];
    }
    return self;
}

-(void) setCtrlText:(DramaModel*) dramaModle
{
    NSURL *url;
    if([dramaModle.posters count] > 0 )
    {
        DramaPostersModel *posterModle =dramaModle.posters[0];
        url =[Tool stringMerge:posterModle.poster];
        [_imageViewHead sd_setImageWithURL:url placeholderImage:DefaultImage];
    }
   
    //头像图
    url = [Tool stringMerge:dramaModle.avatar];
    [_imageViewUserHead sd_setImageWithURL:[Tool stringMerge:dramaModle.avatar] placeholderImage:DefaultImage];
    //发布人名
    [_labelUserName setText: [Tool isNull:dramaModle.username] ];
    //阅读数量
    DramaOpModel  *countModle =dramaModle.dramaOp;
    [_labelReadCount setText:[countModle.clicks stringValue]];
    //推荐语
    [_labelRecommend setText:dramaModle.recommend];
//    [Tool setLabelSpacing:_labelRecommend spacing:4 alignment:NSTextAlignmentLeft];

}

@end
