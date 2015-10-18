
#import "DramaServices.h"
#import "HttpProtocol.h"
#import "HttpManager.h"
#import "DramaModel.h"
#import "LKDBHelper.h"
#import "Drama.h"
#import "DramaDetail.h"
#import "DramaTags.h"


@protocol NSDictionary;

@implementation DramaServices

IMP_SINGLETON(DramaServices)


+ (void)pullDramaGoodData:(int)pageNum success:(void (^)(NSArray *array))success failure:(void (^)(NSDictionary *error))failure
{
    NSMutableArray *dramaArray= [[NSMutableArray alloc] init];
    NSDictionary* paramDict = @{@"page":@(pageNum)};

    HttpProtocol *httpProtocol = [[HttpProtocol alloc] init];
    httpProtocol.requestUrl=[NSString stringWithFormat:@"%@",URL_GOODDRAMA];
    httpProtocol.param=paramDict;
    httpProtocol.method=@"get";
    //FIXME 替换token变量
    httpProtocol.token=[Config getToken];

    [[HttpManager sharedInstance] httpWithRequest:httpProtocol success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        if([responseObject isKindOfClass:[NSDictionary class]])
        {
            NSArray<NSDictionary> *datum = [responseObject objectForKey:@"datum"];
            if(datum!=nil && [datum count]>0)
            {
                for (NSDictionary *drama in datum)
                {

                    //插入数据库
                    Drama *dramaEntity = [[Drama alloc] init];
                    dramaEntity.id =  drama[@"id"];
                    dramaEntity.uid= drama[@"uid"];
                    dramaEntity.content=[drama JSONString];
                    dramaEntity.type= drama[@"type"];

                    [[LKDBHelper getUsingLKDBHelper] insertToDB:dramaEntity];
                    NSLog(@"dramaJson=%@", [drama JSONString]);
                    NSError* err = nil;
                    DramaModel *dramaModel = [[DramaModel alloc] initWithString:[drama JSONString] error:&err];
                    if(err!=nil)
                    {
                        NSLog(@"%@",err );
                    }
                    [dramaArray addObject:dramaModel];
                }

            }
            if(success)
                success(dramaArray);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        failure(@{@"result":error});
    }];
}

+ (void)getDramaDetail:(int)dId success:(void (^)(id dramaModel))success
                                failure:(void (^)( NSDictionary *error))failure{

    @try{

        NSDictionary* paramDict = @{@"did":@(dId)};
        HttpProtocol *httpProtocol = [[HttpProtocol alloc] init];
        httpProtocol.method=@"get";
        httpProtocol.token=[Config getToken];
        httpProtocol.param=paramDict;
        httpProtocol.requestUrl=[NSString stringWithFormat:@"%@",URL_DETIAL];
        [[HttpManager sharedInstance] httpWithRequest:httpProtocol success:^(AFHTTPRequestOperation *operation, id responseObject)
        {
            if([responseObject isKindOfClass:[NSDictionary class]])
            {
                NSLog(@"%@", [responseObject JSONString]);
                //插入数据库
                DramaDetail *dramaDetail = [[DramaDetail alloc] init];
                dramaDetail.id = responseObject[@"id"];
                dramaDetail.content=[responseObject JSONString];

                [[LKDBHelper getUsingLKDBHelper] insertToDB:dramaDetail];


                NSError* err = nil;
                DramaModel *dramaModel = [[DramaModel alloc] initWithString:[responseObject JSONString] error:&err];

                if(err!=nil)
                {
                    NSLog(@"%@",err );

                } else{

                    if(success)
                    {
                        success(dramaModel);
                    }
                }
            }

        } failure:^(AFHTTPRequestOperation *operation, NSError *error){

            if (failure)
                failure(@{@"result":error});

        }];


    }@catch (NSException *exception) {

        NSLog(@"initFromServer error:%@", [exception description]);
    }

}


+ (void)pullAllDramaList:(int)pageNum success:(void (^)(NSArray *array))success failure:(void (^)(NSDictionary *error))failure
{
    NSDictionary* paramDict = @{@"page":@(pageNum)};
    HttpProtocol *httpProtocol = [[HttpProtocol alloc] init];
    httpProtocol.requestUrl=[NSString stringWithFormat:@"%@",URL_ALLDRAMA];
    httpProtocol.param=paramDict;
    httpProtocol.method=@"get";
    httpProtocol.token=[Config getToken];

    [[HttpManager sharedInstance] httpWithRequest:httpProtocol success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSMutableArray *dramaArray= [[NSMutableArray alloc] init];
        NSLog(@"dramaJson=%@", [responseObject JSONString]);
        if([responseObject isKindOfClass:[NSDictionary class]])
        {
            NSArray<NSDictionary> *datum = [responseObject objectForKey:@"datum"];
            if(datum!=nil && [datum count]>0)
            {
                for (NSDictionary *drama in datum)
                {
                    NSLog(@"dramaJson=%@", [drama JSONString]);


                    //插入数据库
                    Drama *dramaEntity = [[Drama alloc] init];
                    dramaEntity.id = drama[@"id"];
                    dramaEntity.uid= drama[@"uid"];
                    dramaEntity.content=[drama JSONString];
                    dramaEntity.type= drama[@"type"];
                    [[LKDBHelper getUsingLKDBHelper] insertToDB:dramaEntity];

                    NSError* err = nil;
                    DramaModel *dramaModel = [[DramaModel alloc] initWithString:[drama JSONString] error:&err];

                    if(err!=nil)
                    {
                        NSLog(@"%@",err );
                    }
                    [dramaArray addObject:dramaModel];
                }

            }
        }
        if(success)
            success(dramaArray);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        if(failure)
            failure(@{@"result":error});
    }];
}

+ (void)getDramaTags {

    HttpProtocol *httpProtocol = [[HttpProtocol alloc] init];
    httpProtocol.requestUrl=[NSString stringWithFormat:@"%@",URL_DRAMA_TAGS];
    httpProtocol.param=nil;
    httpProtocol.method=@"get";
    httpProtocol.token=@"g4TD4B9vO7z8GR3yKYlVwg==";
   // httpProtocol.token=[Config getToken];

    [[HttpManager sharedInstance] httpWithRequest:httpProtocol success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSLog(@"getDramaTags=%@", [responseObject JSONString]);
        if([responseObject isKindOfClass:[NSArray class]])
        {
            if(responseObject!=nil && [responseObject count]>0)
            {
                for (NSDictionary *drama in responseObject)
                {
                    NSLog(@"getDramaTags=%@", [drama JSONString]);


                    //插入数据库
                    NSError* err = nil;
                    DramaTags *dramaModel = [[DramaTags alloc] initWithString:[drama JSONString] error:&err];

                    if(err!=nil)
                    {
                        NSLog(@"%@",err );
                    }
                    [[LKDBHelper getUsingLKDBHelper] insertToDB:dramaModel];

                }
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){

    }];

}


+ (void)searchDrama:(int)pageNum keyWorld:(NSString *)keyWorld tids:(NSArray *)tids success:(void (^)(NSArray *array))success failure:(void (^)(NSDictionary *error))failure
{
    NSMutableDictionary *paramDict = [[NSMutableDictionary alloc] init];
    if(pageNum!=0)
    {
        paramDict[@"page"] = @(pageNum);
    }
    if(keyWorld!=nil)
    {
        paramDict[@"keyword"] = keyWorld;
    }
    if(tids!=nil)
    {
        paramDict[@"tids"] = [tids componentsJoinedByString:@","];
    }
    NSLog(@"%@",paramDict);
    HttpProtocol *httpProtocol = [[HttpProtocol alloc] init];
    httpProtocol.requestUrl=[NSString stringWithFormat:@"%@",URL_SEARCH];
    httpProtocol.param=paramDict;
    httpProtocol.method=@"get";
    httpProtocol.token=[Config getToken];

    [[HttpManager sharedInstance] httpWithRequest:httpProtocol success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSLog(@"responseObject=%@", [responseObject JSONString]);
//        NSLog(@"dramaJson=%@", [responseObject JSONString]);
        if([responseObject isKindOfClass:[NSDictionary class]])
        {
            NSArray<NSDictionary> *datum = [responseObject objectForKey:@"datum"];
             NSMutableArray *dramaArray= [[NSMutableArray alloc] init];
            if(datum!=nil && [datum count]>0)
            {
//                NSLog(@"dramaCount=%lu", (unsigned long)[datum count]);
                for (NSDictionary *drama in datum)
                {

//                    NSLog(@"dramaJson=%@", [drama JSONString]);

                    NSError* err = nil;
                    DramaModel *dramaModel = [[DramaModel alloc] initWithString:[drama JSONString] error:&err];

                    if(err!=nil)
                    {
                        NSLog(@"%@",err );
                    }
                    [dramaArray addObject:dramaModel];
                }
                if(success)
                    success(dramaArray);
            }
            else
                if(success)
                    success(dramaArray);

        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        if(failure)
            failure(@{@"result":error});
    }];
}

@end