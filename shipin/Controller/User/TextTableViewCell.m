//
//  TextTableViewCell.m
//  shipin
//
//  Created by Mapollo27 on 15/8/13.
//  Copyright (c) 2015年 dust.zhang. All rights reserved.
//

#import "TextTableViewCell.h"

@implementation TextTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    self.leftLable = [[UILabel alloc ] initWithFrame:CGRectMake(15, 0, 200, 40)];
    [self.leftLable setBackgroundColor:[UIColor clearColor]];
    [self.leftLable setFont:[UIFont systemFontOfSize:13]];
    [self.leftLable setTextColor:RGB(34, 34, 34)];
    [self.contentView addSubview:self.leftLable];
    
    self.rightLable = [[UILabel alloc ] initWithFrame:CGRectZero];
    [self.rightLable setBackgroundColor:[UIColor clearColor]];
    [self.rightLable setFont:[UIFont systemFontOfSize:13]];
    [self.rightLable  setTextAlignment:NSTextAlignmentRight];
    [self.rightLable setTextColor:RGB(34, 34, 34)];
    [self.contentView addSubview:self.rightLable];
    
    _lableLine = [[UILabel alloc ] initWithFrame:CGRectZero];
    [_lableLine setBackgroundColor:RGBA(221, 221, 221, 1)];
    [self addSubview:_lableLine];
    
//    头像
    _imageviewHead = [[UIImageView alloc ] initWithFrame:CGRectMake(SCREEN_WIDTH-90, 10, 50, 50)];
    _imageviewHead.layer.cornerRadius =_imageviewHead.frame.size.width/2;
    _imageviewHead.layer.masksToBounds = YES;
    [_imageviewHead setContentMode:UIViewContentModeScaleAspectFill];
    [_imageviewHead setBackgroundColor:[UIColor clearColor]];
    [self addSubview:_imageviewHead];
    return self;
}

-(void) setLableText:(TextModel*)tModle viewName:(NSString *)viewname cellHegith:(float)hegith;
{
    if ([viewname isEqualToString:@"EditPersonViewController" ] )
    {
        self.leftLable.frame = CGRectMake(15, 0, 200, hegith);
        self.rightLable.frame = CGRectMake(100, 0, SCREEN_WIDTH-135, hegith);
       
        [self.rightLable setTextColor:RGB(153, 153, 153)];
        _lableLine.frame = CGRectMake(0, hegith, SCREEN_WIDTH, 1);
        
//        赋值
        [self.leftLable  setText:tModle.strLeftName];
        //第一行显示头像
        if (hegith == 70)
        {
            [_imageviewHead sd_setImageWithURL:[Tool stringMerge:tModle.strRightName] placeholderImage:DefaultImage];
            [self.rightLable  setHidden:YES];
        }
        else
        {
            [self.rightLable  setHidden:NO];
            [_imageviewHead setHidden:YES];
            [self.rightLable  setText:[Tool isNull:tModle.strRightName] ];
            if ([tModle.strRightName isEqualToString:@"尚未完善资料"])
            {
                [self.rightLable setTextColor:[UIColor redColor]];
            }
        }
    }
    else
    {
        [_imageviewHead setHidden:YES];
        self.rightLable.frame = CGRectMake(100, 0, SCREEN_WIDTH-115, hegith);
        [self.leftLable  setText:tModle.strLeftName];
        [self.rightLable  setText:[Tool isNull:tModle.strRightName] ];
        if ([tModle.strRightName isEqualToString:@"尚未完善资料"])
        {
            [self.rightLable setTextColor:[UIColor redColor]];
        }
    }
    
  
}

@end
