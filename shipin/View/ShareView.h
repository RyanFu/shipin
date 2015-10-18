//
//  ShareViewController.h
//  movikr
//
//  Created by Mapollo25 on 15/6/1.
//  Copyright (c) 2015年 movikr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShareDelegate.h"

typedef enum{
    WeiChatShareContentTypeNews,
    WeiChatShareContentTypeImage
}WeiChatShareContentType;

typedef enum{
    ShareContentTypeOfArticle,
    ShareContentTypeOfActivity,
    ShareContentTypeOfTopicImage
}ShareContentType;

@interface ShareView : UIView

+(ShareView*)getShareInstance;
@property (nonatomic) NSInteger shareObjectId;
@property (nonatomic) ShareContentType shareObjectType;
@property (nonatomic,weak) id<ShareDelegate> shareDelegate;
@property (nonatomic,copy) NSString *shareUrl;
@property (nonatomic,copy) NSString *shareTitle;
@property (nonatomic,copy) NSString *imageTitle;
@property (nonatomic,copy) NSString *shareDescription;
@property (nonatomic,copy) NSString *shareImgUrl;
@property (nonatomic) WeiChatShareContentType shareContentType;
@property (nonatomic,strong) UIImage *shareImage;

@end
