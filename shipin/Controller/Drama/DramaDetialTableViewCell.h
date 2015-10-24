//
//  DramaDetialTableViewCell.h
//  shipin
//
//  Created by Mapollo27 on 15/8/16.
//  Copyright (c) 2015年 dust.zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DramaModel.h"
#import "DramaRelativesModel.h"
#import "SimilaritiesModel.h"
#import "DramaPostersModel.h"

@interface DramaDetialTableViewCell : UITableViewCell
{
    UILabel     *_labelDir;
    UILabel     *_labelDirectorName;

    UILabel     *_labelProducer;
    UILabel     *_labelProducerName;

    UILabel     *_labelZy;
    UILabel     *_labelZyName;
    
    UILabel     *_labelPlace;
    UILabel     *_labelPlaceName;
    
    UILabel     *_labelCount;
    UILabel     *_labelCountName;
    
    UILabel     *_labelProduced;
    UILabel     *_labelProducedName;
    
    UILabel     *_labelZpdw;
    UILabel     *_labelZpdwName;
    
    UILabel     *_labelKjDate;
    UILabel     *_labelKjDateName;
    
    UILabel     *_labelSqDate;
    UILabel     *_labelSqDateName;
  
//    相关资料
    UILabel     *_labelTitle;
    UILabel     *_labelContent;
    UILabel     *_labelLine;
    
    DramaPostersModel   *dramaPosters;//发布的图片
    DramaModel          *_dramaModel;
    
    
    UILabel *labelTop;
    UIImageView     *_imageViewPlaybBtn;
    
}
@property (nonatomic ,strong) UILabel       *_labelText;
@property (nonatomic ,strong) UIImageView   *_imageView;


-(void)setIntroductionText:(NSString*)text  headImage:(NSURL*)imageUrl imageHeight:(float)height;
-(void)setProjectInfo:(DramaModel*)dramaModel;
-(void)setRelatedData:(DramaRelativesModel*)dramaModel;
//初始化cell类
-(id)initWithReuseIdentifier:(NSString*)reuseIdentifier;


@end
