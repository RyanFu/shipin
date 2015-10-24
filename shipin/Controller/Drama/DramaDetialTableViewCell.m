//
//  DramaDetialTableViewCell.m
//  shipin
//
//  Created by Mapollo27 on 15/8/16.
//  Copyright (c) 2015年 dust.zhang. All rights reserved.
//

#import "DramaDetialTableViewCell.h"


@implementation DramaDetialTableViewCell

-(id)initWithReuseIdentifier:(NSString*)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self initLayuot];
    }
    return self;
}

- (void)initLayuot
{
    //图片
    self._imageView = [[UIImageView alloc ] initWithFrame:CGRectZero];
    self._imageView.layer.masksToBounds = YES;
    [self._imageView setContentMode:UIViewContentModeScaleAspectFill];
    [self addSubview:self._imageView];
    
    //内容
    self._labelText = [[UILabel alloc ] initWithFrame:CGRectZero];
    [self._labelText setTextColor:RGB(153, 153,153) ];
    //设置label的最大行数
    self._labelText.numberOfLines = 0;
    [self._labelText setLineBreakMode:NSLineBreakByCharWrapping];
    [self._labelText setFont:[ UIFont systemFontOfSize:FontSize]];
    [self._labelText setBackgroundColor:[UIColor clearColor]];
    [self addSubview:self._labelText];
    
//    导演
    _labelDir = [[UILabel alloc ] initWithFrame:CGRectZero];
    [_labelDir setText:@"导演:"];
    [_labelDir setBackgroundColor:[UIColor clearColor]];
    [_labelDir setFont:[UIFont boldSystemFontOfSize:13]];
    [self addSubview:_labelDir];
    
    _labelDirectorName = [[UILabel alloc ] initWithFrame:CGRectZero];
    _labelDirectorName.numberOfLines = 0;
    [_labelDirectorName setLineBreakMode:NSLineBreakByCharWrapping];
    [_labelDirectorName setBackgroundColor:[UIColor clearColor]];
    [_labelDirectorName setFont:[UIFont systemFontOfSize:13]];
    [_labelDirectorName setTextColor:RGB(102, 102, 102)];
    [self addSubview:_labelDirectorName];
    
    //制片
    _labelProducer = [[UILabel alloc ] initWithFrame:CGRectZero];
    [_labelProducer setText:@"制片:"];
    [_labelProducer setBackgroundColor:[UIColor clearColor]];
    [_labelProducer setFont:[UIFont boldSystemFontOfSize:13]];
    [self addSubview:_labelProducer];
    
    _labelProducerName = [[UILabel alloc ] initWithFrame:CGRectZero];
    _labelProducerName.numberOfLines = 0;
    [_labelProducerName setLineBreakMode:NSLineBreakByCharWrapping];
    [_labelProducerName setBackgroundColor:[UIColor clearColor]];
    [_labelProducerName setFont:[UIFont systemFontOfSize:13]];
    [_labelProducerName setTextColor:RGB(102, 102, 102)];
    [self addSubview:_labelProducerName];
    
    // 主演
    _labelZy = [[UILabel alloc ] initWithFrame:CGRectZero];
    
    [_labelZy setText:@"主演:"];
    [_labelZy setBackgroundColor:[UIColor clearColor]];
    [_labelZy setFont:[UIFont boldSystemFontOfSize:13]];
    [self addSubview:_labelZy];
    
    _labelZyName = [[UILabel alloc ] initWithFrame:CGRectZero];
    _labelZyName.numberOfLines = 0;
    [_labelZyName setLineBreakMode:NSLineBreakByCharWrapping];
    [_labelZyName setBackgroundColor:[UIColor clearColor]];
    [_labelZyName setFont:[UIFont systemFontOfSize:13]];
    [_labelZyName setTextColor:RGB(102, 102, 102)];
    [self addSubview:_labelZyName];

    
    //    地区
    _labelPlace = [[UILabel alloc ] initWithFrame:CGRectZero];
    [_labelPlace setText:@"地区:"];
    [_labelPlace setBackgroundColor:[UIColor clearColor]];
    [_labelPlace setFont:[UIFont boldSystemFontOfSize:13]];
    [self addSubview:_labelPlace];
    
    _labelPlaceName = [[UILabel alloc ] initWithFrame:CGRectZero];
    [_labelPlaceName setBackgroundColor:[UIColor clearColor]];
    [_labelPlaceName setFont:[UIFont systemFontOfSize:13]];
    [_labelPlaceName setTextColor:RGB(102, 102, 102)];
    [self addSubview:_labelPlaceName];
 
    //集数
    _labelCount = [[UILabel alloc ] initWithFrame:CGRectZero];
    [_labelCount setText:@"集数:"];
    [_labelCount setBackgroundColor:[UIColor clearColor]];
    [_labelCount setFont:[UIFont boldSystemFontOfSize:13]];
    [self addSubview:_labelCount];
    
    _labelCountName = [[UILabel alloc ] initWithFrame:CGRectZero];
    [_labelCountName setBackgroundColor:[UIColor clearColor]];
    [_labelCountName setFont:[UIFont systemFontOfSize:13]];
    [_labelCountName setTextColor:RGB(102, 102, 102)];
    [self addSubview:_labelCountName];
    
    //
    _labelProduced = [[UILabel alloc ] initWithFrame:CGRectZero];
    [_labelProduced setText:@"出品单位:"];
    [_labelProduced setBackgroundColor:[UIColor clearColor]];
    [_labelProduced setFont:[UIFont boldSystemFontOfSize:13]];
    [self addSubview:_labelProduced];
    
    _labelProducedName = [[UILabel alloc ] initWithFrame:CGRectZero];
    _labelProducedName.numberOfLines = 0;
    [_labelProducedName setLineBreakMode:NSLineBreakByCharWrapping];
    [_labelProducedName setBackgroundColor:[UIColor clearColor]];
    [_labelProducedName setFont:[UIFont systemFontOfSize:13]];
    [_labelProducedName setTextColor:RGB(102, 102, 102)];
    [self addSubview:_labelProducedName];
    
    //制片单位
    _labelZpdw = [[UILabel alloc ] initWithFrame:CGRectZero];
    [_labelZpdw setText:@"制片单位:"];
    [_labelZpdw setBackgroundColor:[UIColor clearColor]];
    [_labelZpdw setFont:[UIFont boldSystemFontOfSize:13]];
    [self addSubview:_labelZpdw];
    
    _labelZpdwName = [[UILabel alloc ] initWithFrame:CGRectZero];
    _labelZpdwName.numberOfLines = 0;
    [_labelZpdwName setLineBreakMode:NSLineBreakByCharWrapping];
    [_labelZpdwName setBackgroundColor:[UIColor clearColor]];
    [_labelZpdwName setFont:[UIFont systemFontOfSize:13]];
    [_labelZpdwName setTextColor:RGB(102, 102, 102)];
    [self addSubview:_labelZpdwName];
    
    //开机时间
    _labelKjDate = [[UILabel alloc ] initWithFrame:CGRectZero];
    [_labelKjDate setText:@"开机时间:"];
    [_labelKjDate setBackgroundColor:[UIColor clearColor]];
    [_labelKjDate setFont:[UIFont boldSystemFontOfSize:13]];
    [self addSubview:_labelKjDate];
    
    _labelKjDateName = [[UILabel alloc ] initWithFrame:CGRectZero];
    [_labelKjDateName setBackgroundColor:[UIColor clearColor]];
    [_labelKjDateName setFont:[UIFont systemFontOfSize:13]];
    [_labelKjDateName setTextColor:RGB(102, 102, 102)];
    [self addSubview:_labelKjDateName];
    
    //杀青时间
    _labelSqDate = [[UILabel alloc ] initWithFrame:CGRectZero];
    [_labelSqDate setText:@"杀青时间:"];
    [_labelSqDate setBackgroundColor:[UIColor clearColor]];
    [_labelSqDate setFont:[UIFont boldSystemFontOfSize:13]];
    [self addSubview:_labelSqDate];
    
    _labelSqDateName = [[UILabel alloc ] initWithFrame:CGRectZero];
    [_labelSqDateName setBackgroundColor:[UIColor clearColor]];
    [_labelSqDateName setFont:[UIFont systemFontOfSize:13]];
    [_labelSqDateName setTextColor:RGB(102, 102, 102)];
    [self addSubview:_labelSqDateName];

        
//    相关资料
    _labelTitle = [[UILabel alloc ] initWithFrame:CGRectZero];
    [_labelTitle setBackgroundColor:[UIColor clearColor]];
    [_labelTitle setFont:[UIFont systemFontOfSize:13]];
    [_labelTitle setTextColor:RGB(34, 34, 34)];
    [self addSubview:_labelTitle];

    _labelContent = [[UILabel alloc ] initWithFrame:CGRectZero];
    [_labelContent setBackgroundColor:[UIColor clearColor]];
    [_labelContent setFont:[UIFont systemFontOfSize:10]];
    [_labelContent setTextColor:RGB(153, 153, 153)];
    [self addSubview:_labelContent];
    
    _labelLine = [[UILabel alloc ] initWithFrame:CGRectZero];
    [_labelLine setBackgroundColor:RGB(221, 221, 221)];
    [self addSubview:_labelLine];

    
    labelTop = [[UILabel alloc ] initWithFrame: CGRectMake(-5, -5, 10, 10)];
    [labelTop setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:labelTop];
    
    
    _imageViewPlaybBtn = [[UIImageView alloc ] initWithFrame: CGRectZero];
    [_imageViewPlaybBtn setImage:[UIImage imageNamed:@"btn_play.png"]];
    [self addSubview:_imageViewPlaybBtn];

    
}

//剧情简介
-(void)setIntroductionText:(NSString*)text  headImage:(NSURL*)imageUrl imageHeight:(float)height
{
       //获得当前cell高度
    CGRect frame = [self frame];
    //文本赋值
    if([text isEqualToString:@"0"])
    {
        _imageViewPlaybBtn.frame =CGRectMake(SCREEN_WIDTH/2-(256/8), height/2-(256/8), 256/4, 256/4);
    }
    else
    {
        self._labelText.text = text;
    }
    float textHeight =[Tool CalcString:self._labelText.text fontSize:[UIFont systemFontOfSize:FontSize] andWidth:SCREEN_WIDTH-20].height;
    self._labelText.frame = CGRectMake(20, 0, SCREEN_WIDTH-40,textHeight+20 );
    self._imageView.frame = CGRectMake(20, 0, SCREEN_WIDTH-40,height );
    [self._imageView sd_setImageWithURL:imageUrl placeholderImage:DefaultImage];
    //计算出自适应的高度
    frame.size.height = textHeight+20 +height;
    self.frame = frame;
}

//电影信息
-(void)setProjectInfo:(DramaModel*)dramaModel
{
    
    [_labelDirectorName setText:dramaModel.director];
    
    [_labelProducerName setText:dramaModel.distribution];
    
    [_labelZyName setText:dramaModel.staring];
    
    [_labelPlaceName setText:dramaModel.district];
    
    [_labelCountName setText:dramaModel.episodes];
    
    [_labelProducedName setText:dramaModel.presentation];
    
    [_labelZpdwName setText:dramaModel.distribution];
    
    [_labelKjDateName setText:dramaModel.boot];
    
    [_labelSqDateName setText:dramaModel.wrap];
//    设置坐标
    _labelDir.frame  = CGRectMake(20, 20, 40, [Tool getTextHeight:_labelDir]);
    _labelDirectorName.frame  = CGRectMake(60, 20, SCREEN_WIDTH-80, [Tool getTextHeight:_labelDirectorName]);
    
    _labelProducer.frame  = CGRectMake(20, _labelDirectorName.frame.origin.y+_labelDirectorName.frame.size.height+10, 60, [Tool getTextHeight:_labelDirectorName]);
    _labelProducerName.frame  = CGRectMake(60, _labelDirectorName.frame.origin.y+_labelDirectorName.frame.size.height+10, SCREEN_WIDTH-80, [Tool getTextHeight:_labelDirectorName]);
    
    _labelZy.frame  = CGRectMake(20, _labelProducerName.frame.origin.y+_labelProducerName.frame.size.height+10, 60, [Tool getTextHeight:_labelZyName]);
    _labelZyName.frame  = CGRectMake(60, _labelProducerName.frame.origin.y+_labelProducerName.frame.size.height+10, SCREEN_WIDTH-80, [Tool getTextHeight:_labelZyName]);
    
    _labelPlace.frame  = CGRectMake(20, _labelZyName.frame.origin.y+_labelZyName.frame.size.height+10, 60, [Tool getTextHeight:_labelPlace]);
    _labelPlaceName.frame  = CGRectMake(60, _labelZyName.frame.origin.y+_labelZyName.frame.size.height+10, SCREEN_WIDTH-80, [Tool getTextHeight:_labelPlaceName]);
    
    _labelCount.frame  = CGRectMake(20, _labelPlaceName.frame.origin.y+_labelPlaceName.frame.size.height+10, 60, [Tool getTextHeight:_labelPlaceName]);
    _labelCountName.frame  = CGRectMake(60, _labelPlaceName.frame.origin.y+_labelPlaceName.frame.size.height+10, SCREEN_WIDTH-80, [Tool getTextHeight:_labelPlaceName]);
   
    _labelProduced.frame  = CGRectMake(20, _labelCountName.frame.origin.y+_labelCountName.frame.size.height+10, 60, [Tool getTextHeight:_labelCountName]);
    _labelProducedName.frame  = CGRectMake(85, _labelCountName.frame.origin.y+_labelCountName.frame.size.height+10, SCREEN_WIDTH-80, [Tool getTextHeight:_labelCountName]);
   
    _labelZpdw.frame  = CGRectMake(20, _labelProducedName.frame.origin.y+_labelProducedName.frame.size.height+10, 60, [Tool getTextHeight:_labelProducedName]);
    _labelZpdwName.frame  = CGRectMake(85, _labelProducedName.frame.origin.y+_labelProducedName.frame.size.height+10, SCREEN_WIDTH-80, [Tool getTextHeight:_labelProducedName]);
   
    _labelKjDate.frame  = CGRectMake(20, _labelZpdwName.frame.origin.y+_labelZpdwName.frame.size.height+10, 60, [Tool getTextHeight:_labelZpdwName]);
    _labelKjDateName.frame  = CGRectMake(85, _labelZpdwName.frame.origin.y+_labelZpdwName.frame.size.height+10, SCREEN_WIDTH-80, [Tool getTextHeight:_labelZpdwName]);
    
    _labelSqDate.frame  = CGRectMake(20, _labelKjDateName.frame.origin.y+_labelKjDateName.frame.size.height+10, 60, [Tool getTextHeight:_labelKjDateName]);
    _labelSqDateName.frame  = CGRectMake(85, _labelKjDateName.frame.origin.y+_labelKjDateName.frame.size.height+10, SCREEN_WIDTH-80, [Tool getTextHeight:_labelKjDateName]);
    
    _labelLine.frame  = CGRectMake(10, _labelSqDateName.frame.origin.y+_labelSqDateName.frame.size.height+20, SCREEN_WIDTH-20, 1);
    
    [_labelLine setBackgroundColor:RGB(238, 238, 238)];
    
     if([dramaModel.similarities count] > 0 )
     {
         _labelTitle.frame  = CGRectMake(20, _labelLine.frame.origin.y+_labelLine.frame.size.height, SCREEN_WIDTH-40, 30);
         [_labelTitle setText:@"相似剧集"];
     }
//    _labelZyName.frame  = CGRectMake(60, _labelProducerName.frame.origin.y+_labelProducerName.frame.size.height+10, SCREEN_WIDTH-80, [Tool getTextHeight:_labelZyName]);

}

-(void)setRelatedData:(DramaRelativesModel*)dramaRelativesModel
{
    //    设置坐标
    _labelTitle.frame  = CGRectMake(20, 10, SCREEN_WIDTH-40, 15);
    _labelContent.frame  = CGRectMake(20, 30, SCREEN_WIDTH-40, 10);
    _labelLine.frame  = CGRectMake(0, _labelContent.frame.size.height+_labelContent.frame.origin.y+8, SCREEN_WIDTH, 1);
    
    [_labelTitle setText:dramaRelativesModel.text];
    [_labelContent setText:dramaRelativesModel.from];
}


@end
