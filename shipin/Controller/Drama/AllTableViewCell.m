//
//  AllTableViewCell.m
//  shipin
//
//  Created by Mapollo27 on 15/7/26.
//  Copyright (c) 2015年 dust.zhang. All rights reserved.
//

#import "AllTableViewCell.h"

@implementation AllTableViewCell
@synthesize delegate;


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self setBackgroundColor:[UIColor whiteColor]]; //RGB(238, 238, 238)
        
        _labelbgLeft = [[UILabel alloc ] initWithFrame:CGRectMake(10, 10, (SCREEN_WIDTH-30)/2, 160)];
        [_labelbgLeft setBackgroundColor:RGB(250, 250, 250)];
        [_labelbgLeft setUserInteractionEnabled:YES];
        [self addSubview:_labelbgLeft];
        
        _imageViewLeft = [[UIImageView alloc ] initWithFrame:CGRectMake(10, 10, (SCREEN_WIDTH-30)/2, (SCREEN_WIDTH-30)/2-40)];
        [_imageViewLeft setBackgroundColor:[UIColor grayColor]];
        _imageViewLeft.layer.masksToBounds = YES;
        [_imageViewLeft setUserInteractionEnabled:YES];
        [_imageViewLeft setContentMode:UIViewContentModeScaleAspectFill];
        [self addSubview:_imageViewLeft];
        
        UILabel *labelbgLeft = [[UILabel alloc ] initWithFrame:CGRectMake(10, _imageViewLeft.frame.origin.y+_imageViewLeft.frame.size.height, _imageViewLeft.frame.size.width, 40)];
        [labelbgLeft setUserInteractionEnabled:YES];
        [labelbgLeft setBackgroundColor:RGB(255, 255, 255)];
        [self addSubview:labelbgLeft];
        
        //电影名
        _labelFilmNameLeft = [[UILabel alloc ] initWithFrame:CGRectMake(15, _imageViewLeft.frame.size.height+_imageViewLeft.frame.origin.y+5, _imageViewLeft.frame.size.width-10, 15)];
        [_labelFilmNameLeft setBackgroundColor:[UIColor clearColor]];
        [_labelFilmNameLeft setTextColor:RGB(34, 34, 34)];
        [_labelFilmNameLeft setFont:BoldfontSize];
         [_labelFilmNameLeft setUserInteractionEnabled:YES];
        [self addSubview:_labelFilmNameLeft];
        //介绍
        _labelFilmContentLeft = [[UILabel alloc ] initWithFrame:CGRectMake(15, _labelFilmNameLeft.frame.size.height+_labelFilmNameLeft.frame.origin.y+5, _imageViewLeft.frame.size.width-10, 12)];
        [_labelFilmContentLeft setBackgroundColor:[UIColor clearColor]];
        [_labelFilmContentLeft setTextColor:RGB(153, 153, 153)];
        [_labelFilmContentLeft setFont:[UIFont systemFontOfSize:smallFontSize]];
         [_labelFilmContentLeft setUserInteractionEnabled:YES];
        [self addSubview:_labelFilmContentLeft];
        //阅读数量
        _labelReadCountLeft= [[UILabel alloc ] initWithFrame:CGRectMake(45, labelbgLeft.frame.size.height+labelbgLeft.frame.origin.y+2, 40, 12)];
        [_labelReadCountLeft setBackgroundColor:[UIColor clearColor]];
        [_labelReadCountLeft setTextColor:yellowRgb];
        [_labelReadCountLeft setFont:[UIFont systemFontOfSize:10]];
        [_labelReadCountLeft setTextAlignment:NSTextAlignmentLeft];
         [_labelReadCountLeft setUserInteractionEnabled:YES];
        [self addSubview:_labelReadCountLeft];
        
        UILabel *labelReadNameLeft= [[UILabel alloc ] initWithFrame:CGRectMake(15, labelbgLeft.frame.size.height+labelbgLeft.frame.origin.y+2, 30, 12)];
        [labelReadNameLeft setBackgroundColor:[UIColor clearColor]];
        [labelReadNameLeft setTextColor:RGB(153, 153, 153)];
        [labelReadNameLeft setFont:[UIFont systemFontOfSize:10]];
        [labelReadNameLeft setTextAlignment:NSTextAlignmentLeft];
         [labelReadNameLeft setUserInteractionEnabled:YES];
        [labelReadNameLeft setText:@"阅读："];
        [self addSubview:labelReadNameLeft];
        
//        _labelGzCountLeft= [[UILabel alloc ] initWithFrame:CGRectMake(SCREEN_WIDTH/2-40, labelbgLeft.frame.size.height+labelbgLeft.frame.origin.y+2, 15, 12)];
//        [_labelGzCountLeft setBackgroundColor:[UIColor clearColor]];
//        [_labelGzCountLeft setTextColor:yellowRgb];
//        [_labelGzCountLeft setFont:[UIFont systemFontOfSize:7]];
//        [_labelGzCountLeft setTextAlignment:NSTextAlignmentRight];
//         [_labelGzCountLeft setUserInteractionEnabled:YES];
//        [self addSubview:_labelGzCountLeft];
//        
//        UILabel *labelGzNameLeft= [[UILabel alloc ] initWithFrame:CGRectMake(_labelGzCountLeft.frame.origin.x+_labelGzCountLeft.frame.size.width+3, labelbgLeft.frame.size.height+labelbgLeft.frame.origin.y+2, 30, 12)];
//        [labelGzNameLeft setBackgroundColor:[UIColor clearColor]];
//        [labelGzNameLeft setTextColor:RGB(153, 153, 153)];
//        [labelGzNameLeft setFont:[UIFont systemFontOfSize:7]];
//        [labelGzNameLeft setTextAlignment:NSTextAlignmentLeft];
//         [labelGzNameLeft setUserInteractionEnabled:YES];
//        [labelGzNameLeft setText:@"关注"];
//        [self addSubview:labelGzNameLeft];
        
        _labelStateLeft = [[UILabel alloc ] initWithFrame:CGRectMake(_labelReadCountLeft.frame.origin.x+_labelReadCountLeft.frame.size.width+20, labelbgLeft.frame.size.height+labelbgLeft.frame.origin.y+2, SCREEN_WIDTH/4, 12)];
        [_labelStateLeft setBackgroundColor:[UIColor clearColor]];
        [_labelStateLeft setTextColor:RGB(153, 153, 153)];
        [_labelStateLeft setFont:[UIFont systemFontOfSize:7]];
        [_labelStateLeft setTextAlignment:NSTextAlignmentCenter];
        [_labelStateLeft setText:@"审核"];
        [_labelStateLeft setHidden:YES];
        [self addSubview:_labelStateLeft];
        
//        右侧数据
         _labelbgRight = [[UILabel alloc ] initWithFrame:CGRectMake(_labelbgLeft.frame.size.width+_labelbgLeft.frame.origin.x+10, 10, (SCREEN_WIDTH-30)/2, 160)];
        [_labelbgRight setBackgroundColor:RGB(250, 250, 250)];
                [_labelbgRight setUserInteractionEnabled:YES];
        [self addSubview:_labelbgRight];
        
        _imageViewRight = [[UIImageView alloc ] initWithFrame:CGRectMake(_imageViewLeft.frame.origin.x+_imageViewLeft.frame.size.width+10, 10, _imageViewLeft.frame.size.width, _imageViewLeft.frame.size.height)];
        [_imageViewRight setBackgroundColor:[UIColor grayColor]];
        _imageViewRight.layer.masksToBounds = YES;
        [_imageViewRight setUserInteractionEnabled:YES];
        [_imageViewRight setContentMode:UIViewContentModeScaleAspectFill];
        _imageViewRight.layer.cornerRadius = 3;
        [self addSubview:_imageViewRight];
        
         _labelbgDowmRight = [[UILabel alloc ] initWithFrame:CGRectMake(_imageViewRight.frame.origin.x, _imageViewRight.frame.origin.y+_imageViewLeft.frame.size.height, _imageViewLeft.frame.size.width, 40)];
        [_labelbgDowmRight setUserInteractionEnabled:YES];
        [_labelbgDowmRight setBackgroundColor:RGB(255, 255, 255)];
        [self addSubview:_labelbgDowmRight];

        
        _labelFilmNameRight = [[UILabel alloc ] initWithFrame:CGRectMake(_imageViewRight.frame.origin.x+5, _imageViewRight.frame.size.height+_imageViewRight.frame.origin.y+5, _imageViewRight.frame.size.width-10, 15)];
        [_labelFilmNameRight setBackgroundColor:[UIColor clearColor]];
        [_labelFilmNameRight setTextColor:RGB(34, 34, 34)];
        [_labelFilmNameRight setFont:BoldfontSize];
        [self addSubview:_labelFilmNameRight];
        
        _labelFilmContentRight = [[UILabel alloc ] initWithFrame:CGRectMake(_labelFilmNameRight.frame.origin.x, _labelFilmNameRight.frame.size.height+_labelFilmNameRight.frame.origin.y+5, _imageViewLeft.frame.size.width-10, 12)];
        [_labelFilmContentRight setBackgroundColor:[UIColor clearColor]];
        [_labelFilmContentRight setTextColor:RGB(153, 153, 153)];
        [_labelFilmContentRight setFont:[UIFont systemFontOfSize:smallFontSize]];
        [self addSubview:_labelFilmContentRight];
        
        _labelReadNameRight= [[UILabel alloc ] initWithFrame:CGRectMake(_labelbgDowmRight.frame.origin.x+5, _labelbgDowmRight.frame.size.height+_labelbgDowmRight.frame.origin.y+2, 30, 12)];
        [_labelReadNameRight setBackgroundColor:[UIColor clearColor]];
        [_labelReadNameRight setTextColor:RGB(153, 153, 153)];
        [_labelReadNameRight setFont:[UIFont systemFontOfSize:10]];
        [_labelReadNameRight setTextAlignment:NSTextAlignmentLeft];
        [_labelReadNameRight setText:@"阅读："];
        [self addSubview:_labelReadNameRight];

        //阅读数量
        _labelReadCountRight= [[UILabel alloc ] initWithFrame:CGRectMake(_labelReadNameRight.frame.origin.x+30, labelbgLeft.frame.size.height+labelbgLeft.frame.origin.y+2, 15, 12)];
        [_labelReadCountRight setBackgroundColor:[UIColor clearColor]];
        [_labelReadCountRight setTextColor:yellowRgb];
        [_labelReadCountRight setFont:[UIFont systemFontOfSize:10]];
        [_labelReadCountRight setTextAlignment:NSTextAlignmentLeft];
        [self addSubview:_labelReadCountRight];
        
        
//        _labelGzCountRight= [[UILabel alloc ] initWithFrame:CGRectMake(SCREEN_WIDTH-45, labelbgLeft.frame.size.height+labelbgLeft.frame.origin.y+2, 15, 12)];
//        [_labelGzCountRight setBackgroundColor:[UIColor clearColor]];
//        [_labelGzCountRight setTextColor:yellowRgb];
//        [_labelGzCountRight setFont:[UIFont systemFontOfSize:7]];
//        [_labelGzCountRight setTextAlignment:NSTextAlignmentRight];
//        [self addSubview:_labelGzCountRight];
//        
//        _labelGzNameRight= [[UILabel alloc ] initWithFrame:CGRectMake(_labelGzCountRight.frame.origin.x+_labelGzCountRight.frame.size.width+3, labelbgLeft.frame.size.height+labelbgLeft.frame.origin.y+2, 30, 12)];
//        [_labelGzNameRight setBackgroundColor:[UIColor clearColor]];
//        [_labelGzNameRight setTextColor:RGB(153, 153, 153)];
//        [_labelGzNameRight setFont:[UIFont systemFontOfSize:7]];
//        [_labelGzNameRight setTextAlignment:NSTextAlignmentLeft];
//        [_labelGzNameRight setText:@"关注"];
//        [self addSubview:_labelGzNameRight];
        
        
        //用户头像
        _imageViewUserLeft= [[UIImageView alloc ] initWithFrame:CGRectMake(_imageViewLeft.frame.origin.x+_imageViewLeft.frame.size.width-30, _imageViewLeft.frame.origin.x+_imageViewLeft.frame.size.width-52, 22, 22)];
        [_imageViewUserLeft setBackgroundColor:[UIColor clearColor]];
        _imageViewUserLeft.layer.masksToBounds = YES;
        _imageViewUserLeft.layer.cornerRadius = _imageViewUserLeft.frame.size.width/2;
        [_imageViewUserLeft setContentMode:UIViewContentModeScaleAspectFill];
        [_imageViewUserLeft setUserInteractionEnabled:YES];
        [self addSubview:_imageViewUserLeft];

        //用户头像
        _imageViewUserRight= [[UIImageView alloc ] initWithFrame:CGRectMake(_imageViewLeft.frame.origin.x+_imageViewLeft.frame.size.width+125, _imageViewLeft.frame.origin.x+_imageViewLeft.frame.size.width-52, 22, 22)];
        [_imageViewUserRight setBackgroundColor:[UIColor clearColor]];
        _imageViewUserRight.layer.masksToBounds = YES;
        _imageViewUserRight.layer.cornerRadius = _imageViewUserLeft.frame.size.width/2;
        [_imageViewUserRight setContentMode:UIViewContentModeScaleAspectFill];
        [_imageViewUserRight setUserInteractionEnabled:YES];
        [self addSubview:_imageViewUserRight];
        
        _labelStateRight = [[UILabel alloc ] initWithFrame:CGRectMake(_labelReadCountRight.frame.origin.x+_labelReadCountRight.frame.size.width+20, _labelbgDowmRight.frame.size.height+_labelbgDowmRight.frame.origin.y+2, SCREEN_WIDTH/4, 12)];
        [_labelStateRight setBackgroundColor:[UIColor clearColor]];
        [_labelStateRight setTextColor:RGB(153, 153, 153)];
        [_labelStateRight setFont:[UIFont systemFontOfSize:7]];
        [_labelStateRight setTextAlignment:NSTextAlignmentCenter];
        [_labelStateRight setText:@"审核"];
        [_labelStateRight setHidden:YES];
        [self addSubview:_labelStateRight];

        
    }
    return self;
}

-(void) showHideRightCtrl:(BOOL) SH
{
    [_labelbgRight setHidden:SH];
    [_imageViewRight  setHidden:SH];
    [_labelFilmNameRight  setHidden:SH];
    [_labelFilmContentRight setHidden:SH];
    [_labelReadCountRight setHidden:SH];
    [_labelGzCountRight  setHidden:SH];
    [_imageViewUserRight  setHidden:SH];
    [_labelReadNameRight setHidden:SH];
    [_labelGzNameRight setHidden:SH];
    [_labelbgDowmRight setHidden:SH];
}

-(void) setControlLeftData:(DramaModel *)leftData rightData:(DramaModel *)rightData type:(NSString *) type
{
    _leftData =leftData;
    _rightData =rightData;
    //    左面数据
    DramaPostersModel *posterModle;
    if ([leftData.posters count] > 0)
    {
        posterModle =leftData.posters[0];
        [_imageViewLeft sd_setImageWithURL:[Tool stringMerge:posterModle.poster] placeholderImage:DefaultImage];
        [_imageViewUserLeft sd_setImageWithURL:[Tool stringMerge:leftData.avatar] placeholderImage:[UIImage imageNamed:@"image_defaulthead.png"]];
        [_labelFilmNameLeft setText:leftData.name];
        [_labelFilmContentLeft setText:leftData.brief];
        
        DramaOpModel *countItem=leftData.dramaOp;
        NSLog(@"%@", [countItem.clicks stringValue]);
        [_labelReadCountLeft setText:[Tool getCount:[leftData.dramaOp.clicks stringValue]] ];
        [_labelGzCountLeft setText:[Tool getCount:[leftData.dramaOp.collects stringValue]] ];
        if ([type isEqualToString:@"publish"])
        {
            [_labelStateLeft setHidden:NO];
            if ([[leftData.status stringValue] intValue] == 1)
                [_labelStateLeft setText:@"未审核"];
            else
               [_labelStateLeft setText:@"审核通过"];
        }
    }
    else
    {
        [_imageViewLeft sd_setImageWithURL:[Tool stringMerge:posterModle.poster] placeholderImage:DefaultImage];
        [_imageViewUserLeft sd_setImageWithURL:[Tool stringMerge:leftData.avatar] placeholderImage:[UIImage imageNamed:@"image_defaulthead.png"]];
        [_labelFilmNameLeft setText:leftData.name];
        [_labelFilmContentLeft setText:leftData.brief];

        DramaOpModel *countItem=leftData.dramaOp;
        NSLog(@"%@", [countItem.clicks stringValue]);
        [_labelReadCountLeft setText:[Tool getCount:[leftData.dramaOp.clicks stringValue]] ];
        [_labelGzCountLeft setText:[Tool getCount:[leftData.dramaOp.collects stringValue]] ];
        if ([type isEqualToString:@"publish"])
        {
            [_labelStateLeft setHidden:NO];
            if ([[leftData.status stringValue] intValue] == 1)
                [_labelStateLeft setText:@"未审核"];
            else
                [_labelStateLeft setText:@"审核通过"];
        }
    }
    if (rightData != nil)
    {
        //    右面数据
        if ([rightData.posters count] > 0)
        {
            posterModle =rightData.posters[0];
            [_imageViewRight sd_setImageWithURL:[Tool stringMerge:posterModle.poster] placeholderImage:DefaultImage];
            [_imageViewUserRight sd_setImageWithURL:[Tool stringMerge:rightData.avatar] placeholderImage:[UIImage imageNamed:@"image_defaulthead.png"]];
            [_labelFilmNameRight setText:rightData.name];
            [_labelFilmContentRight setText:rightData.brief];
            
            [_labelReadCountRight setText:[Tool getCount:[rightData.dramaOp.clicks stringValue]] ];
            [_labelGzCountRight setText:[Tool getCount:[rightData.dramaOp.collects stringValue]] ];
            if ([type isEqualToString:@"publish"])
            {
                [_labelStateRight setHidden:NO];
                if ([[rightData.status stringValue] intValue] == 1)
                    [_labelStateRight setText:@"未审核"];
                else
                    [_labelStateRight setText:@"审核通过"];
            }
        }
        else
        {
            
            [_imageViewRight sd_setImageWithURL:[Tool stringMerge:posterModle.poster] placeholderImage:DefaultImage];
            [_imageViewUserRight sd_setImageWithURL:[Tool stringMerge:rightData.avatar] placeholderImage:[UIImage imageNamed:@"image_defaulthead.png"]];
            [_labelFilmNameRight setText:rightData.name];
            [_labelFilmContentRight setText:rightData.brief];
            
            [_labelReadCountRight setText:[Tool getCount:[rightData.dramaOp.clicks stringValue]] ];
            [_labelGzCountRight setText:[Tool getCount:[rightData.dramaOp.collects stringValue]] ];
            if ([type isEqualToString:@"publish"])
            {
                [_labelStateRight setHidden:NO];
                if ([[rightData.status stringValue] intValue] == 1)
                    [_labelStateRight setText:@"未审核"];
                else
                    [_labelStateRight setText:@"审核通过"];
            }
        }
    }
    else
        [self showHideRightCtrl:YES ];
        
//        给图片添加点击事件
    _labelbgLeft.tag=[[_leftData.id stringValue] intValue];
    if(!gestureLeft)
    {
        gestureLeft=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageClick:)];
        gestureLeft.numberOfTapsRequired=1;
        [_labelbgLeft addGestureRecognizer:gestureLeft];
    }
    
    _labelbgRight.tag=[[_rightData.id stringValue] intValue];
    if(!gestureRight)
    {
        gestureRight=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageClick:)];
        gestureRight.numberOfTapsRequired=1;
        [_labelbgRight addGestureRecognizer:gestureRight];
    }
}

-(void )imageClick:(UITapGestureRecognizer *)gesture
{
    if (gesture.view.tag == [[_leftData.id stringValue] intValue] )
    {
        [delegate mViewControllerShouldPush:_leftData  ];
    }
    if (gesture.view.tag == [[_rightData.id stringValue] intValue] )
    {
        [delegate mViewControllerShouldPush:_rightData ];
    }
    
}


@end
