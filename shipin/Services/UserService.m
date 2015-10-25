#import "HttpProtocol.h"
#import "MessageModel.h"
#import "LKDBHelper.h"
#import "MyDrama.h"
#import "MyCollection.h"


@protocol NSDictionary;

@implementation UserService {

}

IMP_SINGLETON(UserService)

+ (void)getUserDetail:(int)uId success:(void (^)(UserModel *userModel))success failure:(void (^)(NSDictionary *error))failure {

    NSDictionary *paramDict = @{@"uid" : @(uId)};
    HttpProtocol *httpProtocol = [[HttpProtocol alloc] init];
    httpProtocol.method = @"get";
    httpProtocol.token = [Config getToken];

    if (uId == 0) {
        httpProtocol.param = nil;
    } else {
        httpProtocol.param = paramDict;
    }

    httpProtocol.requestUrl = [NSString stringWithFormat:@"%@", URL_USER_DETAIL];
    [[HttpManager sharedInstance] httpWithRequest:httpProtocol success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        if ([responseObject isKindOfClass:[NSDictionary class]])
        {
            NSLog(@"%@", [responseObject JSONString]);
            NSError *err = nil;
            UserModel *userModel = [[UserModel alloc] initWithString:[responseObject JSONString] error:&err];
            userModel.toUid=userModel.id;

            if ([[Config getUserName] isEqualToString:userModel.mobile]) {


                [Config saveUserId:[userModel.id stringValue]];
            }
            //插入数据库
            [[LKDBHelper getUsingLKDBHelper] insertToDB:userModel];
            if (err != nil) {
                NSLog(@"%@", err);
                if (failure)
                    failure(@{@"result" : err});
            } else {

                if (success) {
                    success(userModel);
                }
            }
        }

    }                                     failure:^(AFHTTPRequestOperation *operation, NSError *error) {

        if (failure)
            failure(@{@"result" : error});

    }];

}


+ (void)updateUserDetail:(UserModel *)userModel success:(void (^)(Boolean *boolean))success failure:(void (^)(NSString *error))failure {
    NSDictionary *paramDict = @{@"name" : userModel.name,
                                @"brief" : userModel.brief,
                                @"corporation" : userModel.corporation,
                                @"position" : userModel.position,
                                @"email" : userModel.email
    };

    HttpProtocol *httpProtocol = [[HttpProtocol alloc] init];
    httpProtocol.requestUrl = [NSString stringWithFormat:@"%@", URL_USER_UPDATE];
    httpProtocol.param = paramDict;
    httpProtocol.method = @"post";

    httpProtocol.token = [Config getToken];

    if (userModel.hImage == nil) {
        [[HttpManager sharedInstance] addHttpRequest:httpProtocol success:^(AFHTTPRequestOperation *operation, Boolean *boolean) {

            if (success)
                success(boolean);

        }                                    failure:^(AFHTTPRequestOperation *operation, NSString *error) {
            if (failure)
                failure(error);
        }];

    }
    else {

        [[HttpManager sharedInstance] imageHttpRequest:httpProtocol imageData:userModel.hImage success:^(AFHTTPRequestOperation *operation, Boolean *boolean) {

            if (success)
                success(boolean);

        }                                      failure:^(AFHTTPRequestOperation *operation, NSString *error) {
            if (failure)
                failure(error);
        }];
    }


}


+ (void)getPublishes:(void (^)(NSArray *dramaArray))success failure:(void (^)(NSDictionary *error))failure {
    HttpProtocol *httpProtocol = [[HttpProtocol alloc] init];
    httpProtocol.requestUrl = [NSString stringWithFormat:@"%@", URL_MEPUBLISH];
    httpProtocol.param = nil;
    httpProtocol.method = @"get";
    //FIXME 替换token变量
    httpProtocol.token = [Config getToken];


    [[HttpManager sharedInstance] httpWithRequest:httpProtocol success:^(AFHTTPRequestOperation *operation, id responseObject) {

        NSMutableArray *dramaArray = [[NSMutableArray alloc] init];
        if ([responseObject isKindOfClass:[NSDictionary class]]) {

            NSArray <NSDictionary> *datum = [responseObject objectForKey:@"datum"];
            if (datum != nil && [datum count] > 0) {
                for (NSDictionary *drama in datum) {
                    //插入数据库
                    MyDrama *dramaEntity = [[MyDrama alloc] init];
                    dramaEntity.id = drama[@"id"];
                    dramaEntity.content = [drama JSONString];
                    [[LKDBHelper getUsingLKDBHelper] insertToDB:dramaEntity];

                    NSLog(@"dramaJson=%@", [drama JSONString]);
                    NSError *err = nil;
                    DramaModel *dramaModel = [[DramaModel alloc] initWithString:[drama JSONString] error:&err];

                    if (err != nil) {
                        NSLog(@"%@", err);
                    }
                    [dramaArray addObject:dramaModel];
                }

            }

        }
        if (success)
            success(dramaArray);
    }                                     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure)
            failure(@{@"result" : error});
    }];

}

+ (void)getCollections:(void (^)(NSArray *dramaArray))success failure:(void (^)(NSDictionary *error))failure {


    HttpProtocol *httpProtocol = [[HttpProtocol alloc] init];
    httpProtocol.requestUrl = [NSString stringWithFormat:@"%@", URL_COLLECTION];
    httpProtocol.param = nil;
    httpProtocol.method = @"get";
    //FIXME 替换token变量
    httpProtocol.token = [Config getToken];

    [[HttpManager sharedInstance] httpWithRequest:httpProtocol success:^(AFHTTPRequestOperation *operation, id responseObject) {

        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSMutableArray *msgArray = [[NSMutableArray alloc] init];
            NSArray <NSDictionary> *datum = [responseObject objectForKey:@"datum"];
            if (datum != nil && [datum count] > 0) {

                for (NSDictionary *msg in datum) {
                    NSDictionary *dram = [msg objectForKey:@"drama"];
                    NSLog(@"msgJson=%@", [dram JSONString]);

                    //插入数据库
                    MyCollection *dramaEntity = [[MyCollection alloc] init];
                    dramaEntity.id = dram[@"id"];
                    dramaEntity.content = [dram JSONString];
                    [[LKDBHelper getUsingLKDBHelper] insertToDB:dramaEntity];

                    NSError *err = nil;
                    DramaModel *msgModel = [[DramaModel alloc] initWithString:[dram JSONString] error:&err];

                    if (err != nil) {
                        if (failure)
                            failure(@{@"result" : err});
                        NSLog(@"%@", err);
                    }
                    [msgArray addObject:msgModel];
                }


            }

            if (success)
                success(msgArray);

        }

    }                                     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure)
            failure(@{@"result" : error});
    }];

}

+ (void)getMessages:(void (^)(NSArray *messageArray))success failure:(void (^)(NSDictionary *error))failure {


    HttpProtocol *httpProtocol = [[HttpProtocol alloc] init];
    httpProtocol.requestUrl = [NSString stringWithFormat:@"%@", URL_SYSYTEMMESSAGE];
    httpProtocol.param = nil;
    httpProtocol.method = @"get";
    //FIXME 替换token变量
    httpProtocol.token = [Config getToken];

    [[HttpManager sharedInstance] httpWithRequest:httpProtocol success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableArray *msgArray = [[NSMutableArray alloc] init];
        if ([responseObject isKindOfClass:[NSArray class]]) {

            NSArray <NSDictionary> *datum = responseObject;
            if (datum != nil && [datum count] > 0) {

                for (NSDictionary *msg in datum) {
                    NSLog(@"msgJson=%@", [msg JSONString]);
                    NSError *err = nil;
                    MessageModel *msgModel = [[MessageModel alloc] initWithString:[msg JSONString] error:&err];


                    [[LKDBHelper getUsingLKDBHelper] insertToDB:msgModel];

                    if (err != nil) {
                        if (failure)
                            failure(@{@"result" : err});
                        NSLog(@"%@", err);
                    }
                    [msgArray addObject:msgModel];
                }


            }

        }

        if (success)
            success(msgArray);

    }                                     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure)
            failure(@{@"result" : error});
    }];

}


+ (void)sendPublish:(DramaModel *)dramaModel success:(void (^)(Boolean *boolean))success failure:(void (^)(NSString *error))failure {

    NSDictionary *paramDict = @{@"name" : dramaModel.name!=nil?dramaModel.name:@"",
            @"brief" : dramaModel.brief!=nil?dramaModel.brief:@"",
            @"staring" : dramaModel.staring!=nil?dramaModel.staring:@"",
            @"district" : dramaModel.district!=nil?dramaModel.district:@"",
            @"language" : dramaModel.language!=nil?dramaModel.language:@"",
            @"premiere" : dramaModel.premiere!=nil?dramaModel.premiere:@"",
            @"recommend" : dramaModel.recommend!=nil?dramaModel.recommend:@"",
            @"distribution" : dramaModel.distribution!=nil?dramaModel.distribution:@"",
            @"present" : dramaModel.presentation!=nil?dramaModel.presentation:@"",
            @"boot" : dramaModel.boot!=nil?dramaModel.boot:@"",
            @"wrap" : dramaModel.wrap!=nil?dramaModel.wrap:@"",
            @"episodes" : dramaModel.episodes!=nil?dramaModel.episodes:@"",

    };

    HttpProtocol *httpProtocol = [[HttpProtocol alloc] init];
    httpProtocol.requestUrl = [NSString stringWithFormat:@"%@", URL_PUBLISHDRAMA];
    httpProtocol.param = paramDict;
    httpProtocol.method = @"post";
    //FIXME 替换token变量
    httpProtocol.token = [Config getToken];

    [[HttpManager sharedInstance] addHttpRequest:httpProtocol success:^(AFHTTPRequestOperation *operation, Boolean *boolean) {

        if (success)
            success(boolean);

    }                                    failure:^(AFHTTPRequestOperation *operation, NSString *error) {
        if (failure)
            failure(error);
    }];
}

+ (void)addCollection:(int)dramaId success:(void (^)(Boolean *boolean))success failure:(void (^)(NSString *error))failure {
    NSDictionary *paramDict = @{@"did" : @(dramaId)};
    HttpProtocol *httpProtocol = [[HttpProtocol alloc] init];
    httpProtocol.requestUrl = [NSString stringWithFormat:@"%@", URL_ADD_COLLECTION];
    httpProtocol.param = paramDict;
    httpProtocol.method = @"post";
    //FIXME 替换token变量
    httpProtocol.token = [Config getToken];

    [[HttpManager sharedInstance] addHttpRequest:httpProtocol success:^(AFHTTPRequestOperation *operation, Boolean *boolean) {

        if (success)
            success(boolean);

    }                                    failure:^(AFHTTPRequestOperation *operation, NSString *error) {
        if (failure)
            failure(error);
    }];
}

+ (void)addFollow:(int)userId success:(void (^)(Boolean *boolean))success failure:(void (^)(NSString *error))failure {

    NSDictionary *paramDict = @{@"toUid" : @(userId)};

    HttpProtocol *httpProtocol = [[HttpProtocol alloc] init];
    httpProtocol.requestUrl = [NSString stringWithFormat:@"%@", URL_ADD_FOLLOW];
    httpProtocol.param = paramDict;
    httpProtocol.method = @"post";
    //FIXME 替换token变量
    httpProtocol.token = [Config getToken];

    [[HttpManager sharedInstance] addHttpRequest:httpProtocol success:^(AFHTTPRequestOperation *operation, Boolean *boolean) {

        if (success)
            success(boolean);

    }                                    failure:^(AFHTTPRequestOperation *operation, NSString *error) {
        if (failure)
            failure(error);
    }];

}

+ (void)getFollows:(void (^)(NSArray *followArray))success failure:(void (^)(NSDictionary *error))failure {


    HttpProtocol *httpProtocol = [[HttpProtocol alloc] init];
    httpProtocol.requestUrl = [NSString stringWithFormat:@"%@", URL_USER_FOLLOWS];
    httpProtocol.param = nil;
    httpProtocol.method = @"get";
    //FIXME 替换token变量
    httpProtocol.token = [Config getToken];

    [[HttpManager sharedInstance] httpWithRequest:httpProtocol success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableArray *msgArray = [[NSMutableArray alloc] init];
        if ([responseObject isKindOfClass:[NSArray class]]) {
            if (responseObject != nil && [responseObject count] > 0) {

                for (NSDictionary *msg in responseObject) {
                    NSLog(@"msgJson=%@", [msg JSONString]);
                    NSError *err = nil;
                    UserModel *msgModel = [[UserModel alloc] initWithString:[msg JSONString] error:&err];

//                     [[LKDBHelper getUsingLKDBHelper] insertToDB:msgModel];

                    if (err != nil) {
                        if (failure)
                            failure(@{@"result" : err});
                        NSLog(@"%@", err);
                    }
                    [msgArray addObject:msgModel];
                }


            }

        }
        if (success)
            success(msgArray);

    }                                     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure)
            failure(@{@"result" : error});
    }];
}

+ (void)opinion:(NSString *)content success:(void (^)(Boolean *boolean))success failure:(void (^)(NSString *error))failure {
    NSDictionary *paramDict = @{@"opinion" : content
    };

    HttpProtocol *httpProtocol = [[HttpProtocol alloc] init];
    httpProtocol.requestUrl = [NSString stringWithFormat:@"%@", URL_OPINION];
    httpProtocol.param = paramDict;
    httpProtocol.method = @"post";

    httpProtocol.token = [Config getToken];

        [[HttpManager sharedInstance] addHttpRequest:httpProtocol success:^(AFHTTPRequestOperation *operation, Boolean *boolean) {

            if (success)
                success(boolean);

        }                                    failure:^(AFHTTPRequestOperation *operation, NSString *error) {
            if (failure)
                failure(error);
        }];




}
+ (void)makePublishPage:(void (^)(NSString *url))success failure:(void (^)(NSDictionary *error))failure {


    HttpProtocol *httpProtocol = [[HttpProtocol alloc] init];
    httpProtocol.requestUrl = [NSString stringWithFormat:@"%@", URL_WEB_PUBLISH];
    httpProtocol.param = nil;
    httpProtocol.method = @"get";
    //FIXME 替换token变量
    httpProtocol.token = [Config getToken];

    [[HttpManager sharedInstance] httpWithRequest:httpProtocol success:^(AFHTTPRequestOperation *operation, id responseObject) {

        if ([responseObject isKindOfClass:[NSString class]]) {


            if (success)
                success(responseObject);
            else{
                if (failure)
                    failure(@{@"result" : responseObject});
            }

        }



    }                                     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure)
            failure(@{@"result" : error});
    }];

}
@end