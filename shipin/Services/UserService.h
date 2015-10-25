#import <Foundation/Foundation.h>
#import "HttpManager.h"
#import "UserModel.h"
#import "DramaModel.h"
//@class UserModel;
//@class DramaModel;


@interface UserService : NSObject
DEF_SINGLETON(UserService)
//根据uId获取用户信息，uId=0获取自己的信息
+(void) getUserDetail:(int)uId success:(void (^)(UserModel * userModel))success
        failure:(void (^)( NSDictionary *error))failure;


//编辑用户基本信息接口
+(void) updateUserDetail:(UserModel *)userModel success:(void (^)(Boolean * boolean))success
            failure:(void (^)( NSString *error))failure;

//我的发布
+(void) getPublishes: (void (^)(NSArray * dramaArray))success
              failure:(void (^)( NSDictionary *error))failure;

//我的收藏
+(void) getCollections: (void (^)(NSArray * dramaArray))success
             failure:(void (^)( NSDictionary *error))failure;

//系统消息
+(void) getMessages: (void (^)(NSArray * messageArray))success
               failure:(void (^)( NSDictionary *error))failure;


//发布剧目
+(void) sendPublish:(DramaModel *)dramaModel success:(void (^)(Boolean * boolean))success
            failure:(void (^)( NSString *error))failure;


//添加收藏
+(void) addCollection:(int )dramaId success:(void (^)(Boolean * boolean))success
            failure:(void (^)( NSString *error))failure;

//添加关注
+(void) addFollow:(int )userId success:(void (^)(Boolean * boolean))success
              failure:(void (^)( NSString *error))failure;

//我的关注
+(void) getFollows: (void (^)(NSArray * followArray))success
            failure:(void (^)( NSDictionary *error))failure;

//用户反馈
+(void) opinion:(NSString *)content success:(void (^)(Boolean * boolean))success
                 failure:(void (^)( NSString *error))failure;

//电脑发布生成
+(void) makePublishPage: (void (^)(NSString * url))success
            failure:(void (^)( NSDictionary *error))failure;
@end