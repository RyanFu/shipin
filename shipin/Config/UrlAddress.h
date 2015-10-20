//
//  UrlAddress.h
//  movikr
//
//  Created by Mapollo27 on 15/5/29.
//  Copyright (c) 2015年 movikr. All rights reserved.
//


#define     URL_SERVERURL   @"http://www.17quannei.com/upfiles" //@"http://182.92.102.39"

#define      URL_SERVER_H5  @"http://www.17quannei.com/drama"

#define     URL_SERVERADDRESS   @"http://121.199.49.164" //  //@"http://182.92.102.39:8080"

//#define     URL_SERVERURL   @"http://182.92.102.39" //@"http://182.92.102.39"
//
//#define     URL_SERVERADDRESS   @"http://182.92.102.39:8080" //  //@"http://182.92.102.39:8080"
//获取验证码
#define     URL_VERIFYCODE  [URL_SERVERADDRESS stringByAppendingString:@"/user/verifyCode"]
//登录
#define     URL_LOGIN  [URL_SERVERADDRESS stringByAppendingString:@"/user/login"]
//全部剧目
#define     URL_ALLDRAMA  [URL_SERVERADDRESS stringByAppendingString:@"/drama/"]
//发现好剧
#define     URL_GOODDRAMA  [URL_SERVERADDRESS stringByAppendingString:@"/drama/good"]
//剧目详情
#define     URL_DETIAL  [URL_SERVERADDRESS stringByAppendingString:@"/drama/detail"]
//我的发布
#define     URL_MEPUBLISH  [URL_SERVERADDRESS stringByAppendingString:@"/drama/publishes"]
//发布剧集
#define     URL_PUBLISHDRAMA  [URL_SERVERADDRESS stringByAppendingString:@"/drama/publish"]
//我的收藏
#define     URL_COLLECTION  [URL_SERVERADDRESS stringByAppendingString:@"/user/collections"]
//系统消息
#define     URL_SYSYTEMMESSAGE  [URL_SERVERADDRESS stringByAppendingString:@"/system/messages"]
//用户详情
#define     URL_USER_DETAIL  [URL_SERVERADDRESS stringByAppendingString:@"/user/detail"]
//添加收藏
#define     URL_ADD_COLLECTION  [URL_SERVERADDRESS stringByAppendingString:@"/user/collection"]
//添加关注
#define     URL_ADD_FOLLOW  [URL_SERVERADDRESS stringByAppendingString:@"/user/follow"]
//我关注的人
#define     URL_USER_FOLLOWS  [URL_SERVERADDRESS stringByAppendingString:@"/user/follows"]
//编辑个人资料
#define     URL_USER_UPDATE  [URL_SERVERADDRESS stringByAppendingString:@"/user/update"]
//标签获取
#define     URL_DRAMA_TAGS  [URL_SERVERADDRESS stringByAppendingString:@"/drama/tags"]
//搜素
#define     URL_SEARCH  [URL_SERVERADDRESS stringByAppendingString:@"/drama/search"]

//反馈
#define     URL_OPINION  [URL_SERVERADDRESS stringByAppendingString:@"/opinion"]
