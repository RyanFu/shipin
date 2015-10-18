//
//  ShareViewController.m
//  movikr
//
//  Created by Mapollo25 on 15/6/1.
//  Copyright (c) 2015年 movikr. All rights reserved.
//

#import "ShareView.h"
#import "UIERealTimeBlurView.h"
#import "WeiboSDK.h"

//调用分享后，超过多长时间没有回调就算是分享成功
#define waitShareConfirmTimeLength  120
#define WeiBoScenceValue    1000
#define QQScenceValue    1001
#define QzoneScenceValue    1002
#define ButtonShareWeiboTag    4
#define MaxShareToWeiboTextLength    60

static ShareView *GlobalShareView;

@implementation ShareView
{
    ///图标的高度
    CGFloat logoWidth;
    ///图标的宽度
    CGFloat logoHeight;
    //文字的高度
    CGFloat labelHeight;
    ///图标相对文字的间距
    CGFloat logoToLabelHeight;
    ///图片之间的间距
    CGFloat logoToLogoHeight;
    NSInteger currScence;
    NSTimer *shareConfirmTimer;
}

+(ShareView*)getShareInstance
{
    if(!GlobalShareView)
    {
        GlobalShareView = [[ShareView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    }
    return GlobalShareView;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if(self)
    {
        logoHeight=45;
        logoWidth=60;
        labelHeight=15;
        logoToLabelHeight=14;
        logoToLogoHeight=28;
        [self initShareCtrl];
    }
    return self;
}

-(void)initShareCtrl
{
    CGFloat basePositionX=30;
    CGFloat lineSpacing=28;
    //CGFloat basePositionY=(SCREEN_HEIGHT/2)-(logoToLogoHeight/2)-labelHeight-logoToLabelHeight-logoHeight;
    CGFloat basePositionY=(SCREEN_HEIGHT/2)-(labelHeight+logoToLabelHeight+logoHeight)-(lineSpacing/2);
    CGFloat logoSeq=(SCREEN_WIDTH-(basePositionX*2)-(logoWidth*3))/2;
    
    //毛玻璃背景
    UIERealTimeBlurView *viewBlue=[[UIERealTimeBlurView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT+10)];
    viewBlue.renderStatic=YES;
    [self addSubview:viewBlue];
    
    //微信
    UIButton *buttonWeiChat=[[UIButton alloc]initWithFrame:CGRectMake(basePositionX, basePositionY, logoWidth, logoHeight)];
    [buttonWeiChat setImage:[UIImage imageNamed:@"button_share_weichat.png"] forState:UIControlStateNormal];
    buttonWeiChat.backgroundColor=[UIColor clearColor];
    [buttonWeiChat.imageView setContentMode:UIViewContentModeScaleAspectFit];
    [buttonWeiChat addTarget:self action:@selector(touchUpShareToWeiChat:) forControlEvents:UIControlEventTouchUpInside];
    buttonWeiChat.tag=1;
    [self addSubview:buttonWeiChat];
    
    //微信文本
    UILabel *labelWeiChat=[[UILabel alloc]initWithFrame:CGRectMake(basePositionX,
                                                                   buttonWeiChat.frame.origin.y+buttonWeiChat.frame.size.height+logoToLabelHeight,
                                                                   buttonWeiChat.frame.size.width,
                                                                   labelHeight)];
    [labelWeiChat setText:@"微信"];
    [labelWeiChat setTextAlignment:NSTextAlignmentCenter];
    [labelWeiChat setFont:[UIFont systemFontOfSize:13]];
    [self addSubview:labelWeiChat];
    
    //微信朋友圈
    UIButton *buttonWeiChatFriend=[[UIButton alloc]initWithFrame:CGRectMake(buttonWeiChat.frame.origin.x+buttonWeiChat.frame.size.width+logoSeq, basePositionY, logoWidth, logoHeight)];
    [buttonWeiChatFriend setImage:[UIImage imageNamed:@"button_share_weichat_friend.png"] forState:UIControlStateNormal];
    buttonWeiChatFriend.backgroundColor=[UIColor clearColor];
    [buttonWeiChatFriend.imageView setContentMode:UIViewContentModeScaleAspectFit];
    [buttonWeiChatFriend addTarget:self action:@selector(touchUpShareToFriend:) forControlEvents:UIControlEventTouchUpInside];
    buttonWeiChatFriend.tag=2;
    [self addSubview:buttonWeiChatFriend];
    
    //微信朋友圈文本
    UILabel *labelWeiChatFriend=[[UILabel alloc]initWithFrame:CGRectMake(buttonWeiChatFriend.frame.origin.x,
                                                                         labelWeiChat.frame.origin.y,
                                                                         buttonWeiChatFriend.frame.size.width,
                                                                         labelHeight)];
    [labelWeiChatFriend setText:@"朋友圈"];
    [labelWeiChatFriend setTextAlignment:NSTextAlignmentCenter];
    [labelWeiChatFriend setFont:[UIFont systemFontOfSize:13]];
    [self addSubview:labelWeiChatFriend];
    
    //新浪微博
    UIButton *buttonWeiBo=[[UIButton alloc]initWithFrame:CGRectMake(buttonWeiChatFriend.frame.origin.x+buttonWeiChatFriend.frame.size.width+logoSeq, basePositionY, logoWidth, logoHeight)];
    [buttonWeiBo setImage:[UIImage imageNamed:@"button_share_weibo.png"] forState:UIControlStateNormal];
    buttonWeiBo.backgroundColor=[UIColor clearColor];
    [buttonWeiBo.imageView setContentMode:UIViewContentModeScaleAspectFit];
    [buttonWeiBo addTarget:self action:@selector(touchUpShareToWeibo:) forControlEvents:UIControlEventTouchUpInside];
    buttonWeiBo.tag=4;
    [self addSubview:buttonWeiBo];
    
    //新浪微博文本
    UILabel *labelWeiBo=[[UILabel alloc]initWithFrame:CGRectMake(buttonWeiBo.frame.origin.x,
                                                                 buttonWeiBo.frame.origin.y+ buttonWeiBo.frame.size.height +logoToLabelHeight,
                                                                 buttonWeiBo.frame.size.width,
                                                                 labelHeight)];
    [labelWeiBo setText:@"新浪微博"];
    [labelWeiBo setTextAlignment:NSTextAlignmentCenter];
    [labelWeiBo setFont:[UIFont systemFontOfSize:13]];
    [self addSubview:labelWeiBo];
    
//    //QQ好友
//    UIButton *buttonQQ=[[UIButton alloc]initWithFrame:CGRectMake(buttonWeiChat.frame.origin.x, labelWeiChat.frame.origin.y+labelWeiChat.frame.size.height+lineSpacing, logoWidth, logoHeight)];
//    [buttonQQ setImage:[UIImage imageNamed:@"button_share_qq_friend.png"] forState:UIControlStateNormal];
//    buttonQQ.backgroundColor=[UIColor clearColor];
//    [buttonQQ.imageView setContentMode:UIViewContentModeScaleAspectFit];
//    [buttonQQ addTarget:self action:@selector(touchUpShareToQQ:) forControlEvents:UIControlEventTouchUpInside];
//    buttonQQ.tag=6;
//    [self addSubview:buttonQQ];
//    
//    //QQ好友文本
//    UILabel *labelQQ=[[UILabel alloc]initWithFrame:CGRectMake(buttonQQ.frame.origin.x,
//                                                              buttonQQ.frame.origin.y+ buttonQQ.frame.size.height +logoToLabelHeight,
//                                                              buttonQQ.frame.size.width,
//                                                              labelHeight)];
//    [labelQQ setText:@"QQ"];
//    [labelQQ setTextAlignment:NSTextAlignmentCenter];
//    [labelQQ setFont:[UIFont systemFontOfSize:13]];
//    [self addSubview:labelQQ];
//    
//    //QQ空间
//    UIButton *buttonQQZone=[[UIButton alloc]initWithFrame:CGRectMake(buttonWeiChat.frame.origin.x+buttonWeiChat.frame.size.width+logoSeq, labelWeiChat.frame.origin.y+labelWeiChat.frame.size.height+lineSpacing, logoWidth, logoHeight)];
//    [buttonQQZone setImage:[UIImage imageNamed:@"button_share_qzone.png"] forState:UIControlStateNormal];
//    buttonQQZone.backgroundColor=[UIColor clearColor];
//    [buttonQQZone.imageView setContentMode:UIViewContentModeScaleAspectFit];
//    [buttonQQZone addTarget:self action:@selector(touchUpShareToQQZone:) forControlEvents:UIControlEventTouchUpInside];
//    buttonQQZone.tag=7;
//    [self addSubview:buttonQQZone];
//    
//    //QQ空间文本
//    UILabel *labelQQZone=[[UILabel alloc]initWithFrame:CGRectMake(buttonQQZone.frame.origin.x,
//                                                                  buttonQQZone.frame.origin.y+ buttonQQZone.frame.size.height +logoToLabelHeight,
//                                                                  buttonQQZone.frame.size.width,
//                                                                  labelHeight)];
//    [labelQQZone setText:@"QQ空间"];
//    [labelQQZone setTextAlignment:NSTextAlignmentCenter];
//    [labelQQZone setFont:[UIFont systemFontOfSize:13]];
//    [self addSubview:labelQQZone];
//    
//    //复制
//    UIButton *buttonCopy=[[UIButton alloc]initWithFrame:CGRectMake(buttonWeiChatFriend.frame.origin.x+buttonWeiChatFriend.frame.size.width+logoSeq, labelWeiChat.frame.origin.y+labelWeiChat.frame.size.height+lineSpacing, logoWidth, logoHeight)];
//    [buttonCopy setImage:[UIImage imageNamed:@"button_share_copy.png"] forState:UIControlStateNormal];
//    buttonCopy.backgroundColor=[UIColor clearColor];
//    [buttonCopy.imageView setContentMode:UIViewContentModeScaleAspectFit];
//    [buttonCopy addTarget:self action:@selector(touchUpCopy:) forControlEvents:UIControlEventTouchUpInside];
//    buttonCopy.tag=5;
//    [self addSubview:buttonCopy];
//    
//    //复制文本
//    UILabel *labelCopy=[[UILabel alloc]initWithFrame:CGRectMake(buttonCopy.frame.origin.x,
//                                                                buttonCopy.frame.origin.y+ buttonCopy.frame.size.height +logoToLabelHeight,
//                                                                buttonCopy.frame.size.width,
//                                                                labelHeight)];
//    [labelCopy setText:@"复制链接"];
//    [labelCopy setTextAlignment:NSTextAlignmentCenter];
//    [labelCopy setFont:[UIFont systemFontOfSize:13]];
//    [self addSubview:labelCopy];
    
    //返回按钮(左下角)
    UIButton *buttonClose = [[UIButton alloc] init];
    [buttonClose setImage:[UIImage imageNamed:@"btn_close.png"] forState:UIControlStateNormal];
    [buttonClose setImage:[UIImage imageNamed:@"btn_close_selected.png"] forState:UIControlStateHighlighted];
    [buttonClose addTarget:self action:@selector(toucheUpClose) forControlEvents:UIControlEventTouchUpInside];
    CGSize userBtnsize = CGSizeMake(53, 53);
    CGFloat userBtnY = SCREEN_HEIGHT - userBtnsize.height - 10;
    [buttonClose setFrame:CGRectMake(10, userBtnY, userBtnsize.width, userBtnsize.height)];
    buttonClose.backgroundColor=[UIColor clearColor];
    [self addSubview:buttonClose];
    
}

-(BOOL)checkIsInstallWX{
    if(![WXApi isWXAppInstalled])
    {
        [Tool showWarningTip:@"未安装微信客户端" view:self time:1];
        return NO;
    }
    return YES;
}

-(BOOL)checkIsInstallWeiBo{
    if(![WeiboSDK isWeiboAppInstalled])
    {
         [Tool showWarningTip:@"未安装新浪微博客户端" view:self time:1];
        return NO;
    }
    return YES;
}


-(void)touchUpShareToWeiChat:(UIButton *)sender
{
    if(![self checkIsInstallWX])
    {
        return;
    }
    sender.enabled=NO;
    currScence=WXSceneSession;
    if(self.shareContentType==WeiChatShareContentTypeImage)
    {
        [self sendShareToWeiChatOfImage:WXSceneSession];
    }
    else
    {
        [self sendShareToWeiChatOfNew:WXSceneSession];
    }
    
    sender.enabled=YES;
}

-(void)touchUpShareToFriend:(UIButton *)sender
{
    if(![self checkIsInstallWX])
    {
        return;
    }
    sender.enabled=NO;
    currScence=WXSceneTimeline;
    if(self.shareContentType==WeiChatShareContentTypeImage)
    {
        [self sendShareToWeiChatOfImage:WXSceneTimeline];
    } else {
        [self sendShareToWeiChatOfNew:WXSceneTimeline];
    }
    
    sender.enabled=YES;
}

-(void)touchUpShareToWeibo:(UIButton*)sender
{
    if(![self checkIsInstallWeiBo])
    {
        return;
    }
    sender.enabled=NO;
    currScence=WeiBoScenceValue;
    [self messageToShare];
}

-(void)shareToWeibo:(WBMessageObject *) message{
    WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
    authRequest.redirectURI = kRedirectURI;
    authRequest.scope = @"all";
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message authInfo:authRequest access_token:nil];
    [WeiboSDK sendRequest:request];
    
    [self autoCloseView];
    UIButton *sender =(UIButton*)[self viewWithTag:ButtonShareWeiboTag];
    if(sender){
        sender.enabled=YES;
    }
}

///构建分享到微浪微博的对象
- (void)messageToShare
{
    WBMessageObject *message = [WBMessageObject message];
    self.shareTitle=[Tool clearSpaceAndNewline:self.shareTitle];
    self.shareDescription=[Tool clearSpaceAndNewline:self.shareDescription];
    if (self.shareTitle && self.shareTitle.length > 0 && self.shareDescription && self.shareDescription.length>0)
    {
        message.text = [NSString stringWithFormat:@"「%@」%@",self.shareTitle,self.shareDescription];
    }else if(self.shareTitle && self.shareTitle.length > 0){
        message.text = [NSString stringWithFormat:@"「%@」",self.shareTitle];
    }else if(self.shareDescription && self.shareDescription.length>0){
        message.text = [NSString stringWithFormat:@"%@",self.shareDescription];
    }
    NSInteger textLength = [Tool convertToInt:message.text];
    if(textLength>MaxShareToWeiboTextLength){
        NSLog(@"开始之前：%@",message.text);
        message.text =[NSString stringWithFormat:@"%@...",[message.text substringToIndex:MaxShareToWeiboTextLength]];
        NSLog(@"截取之后：%@",message.text);
    }
    
    if(!message.text){
        message.text=@"";
    }
    
    if(self.shareUrl&&self.shareUrl.length>0){
        message.text=[NSString stringWithFormat:@"%@ 戳：%@ ",message.text,self.shareUrl];
    }
    
    message.text=[NSString stringWithFormat:@"%@%@",message.text, ShareToWeiboOfAccount];
    
    if(self.shareContentType==WeiChatShareContentTypeImage){
        WBImageObject *image = [WBImageObject object];
        image.imageData = UIImagePNGRepresentation(self.shareImage);
        message.imageObject = image;
        [self shareToWeibo:message];
    }else if(self.shareContentType==WeiChatShareContentTypeNews&&self.shareImgUrl&&self.shareImgUrl.length>0){
        WBImageObject *shareImage = [WBImageObject object];
        
        [SDWebImageDownloader.sharedDownloader downloadImageWithURL:[NSURL URLWithString:self.shareImgUrl]
                                                            options:0
                                                           progress:^(NSInteger receivedSize, NSInteger expectedSize)
         {
             // progression tracking code
         }
                                                          completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished)
         {
             if (image && finished)
             {
                 shareImage.imageData = UIImageJPEGRepresentation(image, 1.0);
                 message.imageObject = shareImage;
                 [self shareToWeibo:message];
             }
         }];
    }else{
        [self shareToWeibo:message];
    }
}

-(void)touchUpCopy:(UIButton *)sender{
    UIPasteboard *pastboard=[UIPasteboard generalPasteboard];
    pastboard.string=(self.shareUrl&&self.shareUrl.length>0)?self.shareUrl:@"";
    [self toucheUpClose];
}


-(UIImage *) changeImageSize:(UIImage *)image  scaleToSize:(CGSize)size
{
    //size 为CGSize类型，即你所需要的图片尺寸
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

/**
 *  获取分享到微信的对象
 *
 *  @return 分享的内容可能是包含图片或者纯文本的，所以返回的是基类
 */
-(void)sendShareToWeiChatOfNew:(int) scence
{
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.scene=scence;
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = self.shareTitle;
    message.description = self.shareDescription;
    
    //判断是否分享包含图片
    if(self.shareImgUrl.length>0)
    {
        [SDWebImageDownloader.sharedDownloader downloadImageWithURL:[NSURL URLWithString:self.shareImgUrl] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize){
         }completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished)
         {
             if (image && finished)
             {
                 UIImage *newImage = [self changeImageSize:image scaleToSize:CGSizeMake(180, 180)];
                 [message setThumbImage:newImage];
                 
                 WXWebpageObject *ext=[WXWebpageObject object];
                 ext.webpageUrl=self.shareUrl;
                 message.mediaObject=ext;
                 
                 req.message=message;
                 req.bText=NO;
                 [WXApi sendReq:req];
                 [self autoCloseView];
                 
             }
         }];
        
    }
    else
    {
        UIImage *image=[UIImage imageNamed:@"180.png"];
        [message  setThumbImage:image];
        
        WXWebpageObject *ext=[WXWebpageObject object];
        ext.webpageUrl=@"https://itunes.apple.com/cn/app/ju-ku/id1035193061?l=en&mt=8";
        message.mediaObject=ext;
        req.message=message;
        req.bText=NO;
        [WXApi sendReq:req];
        [self autoCloseView];
    }
}

+(UIImage *) changeImageSize:(UIImage *)image  scaleToSize:(CGSize)size
{
    //size 为CGSize类型，即你所需要的图片尺寸
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}


/**
 *  图片分享到微信
 *
 *  @param scence
 */
-(void)sendShareToWeiChatOfImage:(int)scence{
    WXMediaMessage *message = [WXMediaMessage message];
    UIImage *thumbImage=[UIImage imageWithData:UIImagePNGRepresentation(self.shareImage)];
    if(thumbImage.size.width>300){
        thumbImage=[self changeImageSize:thumbImage scaleToSize:CGSizeMake(300,thumbImage.size.height/thumbImage.size.width*300)];
    }
    if(self.imageTitle&&self.imageTitle.length>0){
        message.title=self.imageTitle;
    }else{
        message.title=shareImageToWeixinDefaultImageTitle;
    }
    
    [message setThumbImage:thumbImage];
    WXImageObject *ext = [WXImageObject object];
    ext.imageData = UIImagePNGRepresentation(self.shareImage);
    message.mediaObject = ext;
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = scence;
    
    [WXApi sendReq:req];
    
    [self autoCloseView];
    
}

-(void)autoCloseView{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self toucheUpClose];
    });
}

-(void)toucheUpClose
{
    [self.shareDelegate touchUpCloseShare];
}


#pragma mark 新浪微博回调
- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    if ([response isKindOfClass:WBSendMessageToWeiboResponse.class])
    {
        if((int)response.statusCode==WeiboSDKResponseStatusCodeUserCancel)
        {
            NSLog(@"用户取消了分享");
        }
        else
        {
            NSString *message = [NSString stringWithFormat:@"%@: %d\n%@: %@\n%@: %@", NSLocalizedString(@"响应状态", nil), (int)response.statusCode, NSLocalizedString(@"响应UserInfo数据", nil), response.userInfo, NSLocalizedString(@"原请求UserInfo数据", nil),response.requestUserInfo];
            NSLog(@"%@",message);
        }
    }
}

@end
