//
//  ProjectModel.m
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-25.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "ProjectModel.h"
#import "AFAppDotNetAPIClient.h"
#import "ContactSqlite.h"
#import "CameraSqlite.h"
#import "ProjectSqlite.h"
#import "LoginSqlite.h"
@implementation ProjectModel
//本地数据库
-(void)loadWithDB:(NSDictionary*)dic
{
    self.a_id = [dic valueForKey:@"id"];
    self.a_projectId = [dic valueForKey:@"projectId"];
    self.a_projectCode = [dic valueForKey:@"projectCode"];
    self.a_projectVersion = [dic valueForKey:@"projectVersion"];
    self.a_landName = [dic valueForKey:@"landName"];
    self.a_district = [dic valueForKey:@"district"];
    self.a_province = [dic valueForKey:@"province"];
    self.a_city = [dic valueForKey:@"city"];
    self.a_landAddress = [dic valueForKey:@"landAddress"];
    self.a_area = [dic valueForKey:@"area"];
    self.a_plotRatio = [dic valueForKey:@"plotRatio"];
    self.a_usage = [dic valueForKey:@"usage"];
    self.a_auctionUnit = [dic valueForKey:@"auctionUnit"];
    self.a_projectName = [dic valueForKey:@"projectName"];
    self.a_description = [dic valueForKey:@"description"];
    self.a_owner = [dic valueForKey:@"owner"];
    self.a_expectedStartTime = [dic valueForKey:@"expectedStartTime"];
    self.a_expectedFinishTime = [dic valueForKey:@"expectedFinishTime"];
    self.a_investment = [dic valueForKey:@"investment"];
    self.a_areaOfStructure = [dic valueForKey:@"areaOfStructure"];
    self.a_storeyHeight = [dic valueForKey:@"storeyHeight"];
    self.a_foreignInvestment = [dic valueForKey:@"foreignInvestment"];
    self.a_ownerType = [dic valueForKey:@"ownerType"];
    self.a_longitude = [dic valueForKey:@"longitude"];
    self.a_latitude = [dic valueForKey:@"latitude"];
    self.a_mainDesignStage = [dic valueForKey:@"mainDesignStage"];
    self.a_propertyElevator = [dic valueForKey:@"propertyElevator"];
    self.a_propertyAirCondition = [dic valueForKey:@"propertyAirCondition"];
    self.a_propertyHeating = [dic valueForKey:@"propertyHeating"];
    self.a_propertyExternalWallMeterial = [dic valueForKey:@"propertyExternalWallMeterial"];
    self.a_propertyStealStructure = [dic valueForKey:@"propertyStealStructure"];
    self.a_actualStartTime = [dic valueForKey:@"actualStartTime"];
    self.a_fireControl = [dic valueForKey:@"fireControl"];
    self.a_green = [dic valueForKey:@"green"];
    self.a_electroweakInstallation = [dic valueForKey:@"electroweakInstallation"];
    self.a_decorationSituation = [dic valueForKey:@"decorationSituation"];
    self.a_decorationProgress = [dic valueForKey:@"decorationProgress"];
    self.a_stage = [dic valueForKey:@"projectStage"];
}

//服务器数据
-(void)loadWithDictionary:(NSDictionary*)dic
{
    self.a_projectId = [dic valueForKey:@"projectID"];
    self.a_projectCode = [dic valueForKey:@"projectCode"];
    self.a_projectVersion = [dic valueForKey:@"projectVersion"];
    self.a_landName = [dic valueForKey:@"landName"];
    self.a_district = [dic valueForKey:@"district"];
    self.a_province = [dic valueForKey:@"province"];
    self.a_city = [dic valueForKey:@"city"];
    self.a_landAddress = [dic valueForKey:@"landAddress"];
    self.a_area = [dic valueForKey:@"area"];
    self.a_plotRatio = [dic valueForKey:@"plotRatio"];
    self.a_usage = [dic valueForKey:@"usage"];
    self.a_auctionUnit = [dic valueForKey:@"auctionUnit"];
    self.a_projectName = [dic valueForKey:@"projectName"];
    self.a_description = [dic valueForKey:@"description"];
    self.a_owner = [dic valueForKey:@"owner"];
    self.a_expectedStartTime = [dic valueForKey:@"expectedStartTime"];
    self.a_expectedFinishTime = [dic valueForKey:@"expectedFinishTime"];
    self.a_investment = [dic valueForKey:@"investment"];
    self.a_areaOfStructure = [dic valueForKey:@"areaOfStructure"];
    self.a_storeyHeight = [dic valueForKey:@"storeyHeight"];
    self.a_foreignInvestment = [dic valueForKey:@"foreignInvestment"];
    self.a_ownerType = [dic valueForKey:@"ownerType"];
    self.a_longitude = [dic valueForKey:@"longitude"];
    self.a_latitude = [dic valueForKey:@"latitude"];
    self.a_mainDesignStage = [dic valueForKey:@"mainDesignStage"];
    self.a_propertyElevator = [dic valueForKey:@"propertyElevator"];
    self.a_propertyAirCondition = [dic valueForKey:@"propertyAirCondition"];
    self.a_propertyHeating = [dic valueForKey:@"propertyHeating"];
    self.a_propertyExternalWallMeterial = [dic valueForKey:@"propertyExternalWallMeterial"];
    self.a_propertyStealStructure = [dic valueForKey:@"propertyStealStructure"];
    self.a_actualStartTime = [dic valueForKey:@"actualStartTime"];
    self.a_fireControl = [dic valueForKey:@"fireControl"];
    self.a_green = [dic valueForKey:@"green"];
    self.a_electroweakInstallation = [dic valueForKey:@"electroweakInstallation"];
    self.a_decorationSituation = [dic valueForKey:@"decorationSituation"];
    self.a_decorationProgress = [dic valueForKey:@"decorationProgress"];
    self.a_url = [dic valueForKey:@"url"];
    self.a_stage = [dic valueForKey:@"projectStage"];
}

+ (NSURLSessionDataTask *)globalSearchWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block str:(NSString *)str index:(int)index{
    NSString *urlStr = [NSString stringWithFormat:@"/ZPZChina.svc/projects/%@?keywords=%@&startIndex=%d&pageSize=5",[LoginSqlite getdata:@"UserToken" defaultdata:@""],str,index];
    
    NSLog(@"%@",urlStr);
    NSString * encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)urlStr, NULL, NULL,  kCFStringEncodingUTF8 ));
    return [[AFAppDotNetAPIClient sharedClient] GET:encodedString parameters:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSLog(@"JSON===>%@",JSON);
        NSArray *postsFromResponse = [[JSON valueForKeyPath:@"d"] valueForKeyPath:@"data"];
        NSMutableArray *mutablePosts = [NSMutableArray arrayWithCapacity:[postsFromResponse count]];
        NSNumber *statusCode = [[[JSON objectForKey:@"d"] objectForKey:@"status"] objectForKey:@"statusCode"];
        if([[NSString stringWithFormat:@"%@",statusCode] isEqualToString:@"200"]){
            for (NSDictionary *attributes in postsFromResponse) {
                ProjectModel *model = [[ProjectModel alloc] init];
                [model loadWithDictionary:attributes];
                [mutablePosts addObject:model];
            }
        }else{
            NSLog(@"%@",[[[JSON objectForKey:@"d"] objectForKey:@"status"] objectForKey:@"errors"]);
            if([[[[JSON objectForKey:@"d"] objectForKey:@"status"] objectForKey:@"errors"] isEqualToString:@"No results in database"]){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                message:@"没有找到项目"
                                                               delegate:self
                                                      cancelButtonTitle:@"确定"
                                                      otherButtonTitles:nil,nil];
                [alert show];
            }else if([[NSString stringWithFormat:@"%@",[[[JSON objectForKey:@"d"] objectForKey:@"status"] objectForKey:@"statusCode"]] isEqualToString:@"1312"]){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                message:@"在其他设备中登录，请退出重新登录"
                                                               delegate:self
                                                      cancelButtonTitle:@"确定"
                                                      otherButtonTitles:nil,nil];
                [alert show];
            }
        }
        
        if (block) {
            block([NSMutableArray arrayWithArray:mutablePosts], nil);
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        if (block) {
            block([NSMutableArray array], error);
        }
    }];
}

+ (NSURLSessionDataTask *)globalMyProjectWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block index:(int)index{
    return [[AFAppDotNetAPIClient sharedClient] GET:[NSString stringWithFormat:@"/ZPZChina.svc/projects/%@?myProjects=true&pageSize=5&startIndex=%d",[LoginSqlite getdata:@"UserToken" defaultdata:@""],index] parameters:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
        //NSLog(@"JSON==>%d",index);
        NSArray *postsFromResponse = [[JSON valueForKeyPath:@"d"] valueForKeyPath:@"data"];
        NSMutableArray *mutablePosts = [NSMutableArray arrayWithCapacity:[postsFromResponse count]];
        NSNumber *statusCode = [[[JSON objectForKey:@"d"] objectForKey:@"status"] objectForKey:@"statusCode"];
        if([[NSString stringWithFormat:@"%@",statusCode] isEqualToString:@"200"]){
            for (NSDictionary *attributes in postsFromResponse) {
                ProjectModel *model = [[ProjectModel alloc] init];
                [model loadWithDictionary:attributes];
                [mutablePosts addObject:model];
            }
        }else{
            NSLog(@"%@",[[[JSON objectForKey:@"d"] objectForKey:@"status"] objectForKey:@"errors"]);
            if([[[[JSON objectForKey:@"d"] objectForKey:@"status"] objectForKey:@"errors"] isEqualToString:@"No results in database"]){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                message:@"没有找到项目"
                                                               delegate:self
                                                      cancelButtonTitle:@"确定"
                                                      otherButtonTitles:nil,nil];
                [alert show];
            }else if([[NSString stringWithFormat:@"%@",[[[JSON objectForKey:@"d"] objectForKey:@"status"] objectForKey:@"statusCode"]] isEqualToString:@"1312"]){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                message:@"在其他设备中登录，请退出重新登录"
                                                               delegate:self
                                                      cancelButtonTitle:@"确定"
                                                      otherButtonTitles:nil,nil];
                [alert show];
            }
        }
        
        if (block) {
            block([NSMutableArray arrayWithArray:mutablePosts], nil);
        }

    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        NSLog(@"Error: %@", error);
        if (block) {
            block([NSMutableArray array], error);
        }
    }];
}

+ (NSURLSessionDataTask *)globalProjectValueWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block url:(NSString *)url{
    return [[AFAppDotNetAPIClient sharedClient] GET:[NSString stringWithFormat:@"/ZPZChina.svc/%@",url] parameters:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSArray *postsFromResponse = [[JSON valueForKeyPath:@"d"] valueForKeyPath:@"data"];
        NSMutableArray *mutablePosts = [NSMutableArray arrayWithCapacity:[postsFromResponse count]];
        NSNumber *statusCode = [[[JSON objectForKey:@"d"] objectForKey:@"status"] objectForKey:@"statusCode"];
        if([[NSString stringWithFormat:@"%@",statusCode] isEqualToString:@"200"]){
            for (NSDictionary *attributes in postsFromResponse) {
                ProjectModel *model = [[ProjectModel alloc] init];
                [model loadWithDictionary:attributes];
                [mutablePosts addObject:model];
            }
        }else{
            NSLog(@"%@",[[[JSON objectForKey:@"d"] objectForKey:@"status"] objectForKey:@"errors"]);
            if([[[[JSON objectForKey:@"d"] objectForKey:@"status"] objectForKey:@"errors"] isEqualToString:@"No results in database"]){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                message:@"没有找到项目"
                                                               delegate:self
                                                      cancelButtonTitle:@"确定"
                                                      otherButtonTitles:nil,nil];
                [alert show];
            }else if([[NSString stringWithFormat:@"%@",[[[JSON objectForKey:@"d"] objectForKey:@"status"] objectForKey:@"statusCode"]] isEqualToString:@"1312"]){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                message:@"在其他设备中登录，请退出重新登录"
                                                               delegate:self
                                                      cancelButtonTitle:@"确定"
                                                      otherButtonTitles:nil,nil];
                [alert show];
            }
        }
        
        if (block) {
            block([NSMutableArray arrayWithArray:mutablePosts], nil);
        }
        
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        NSLog(@"Error: %@", error);
        if (block) {
            block([NSMutableArray array], error);
        }
    }];
}

//地图搜索 精度,维度
+ (NSURLSessionDataTask *)GetMapSearchWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block longitude:(NSString*)longitude latitude:(NSString*)latitude{
    NSString *urlStr = [NSString stringWithFormat:@"/ZPZChina.svc/projects/%@/mapSearch&latitude=%@&longitude=%@&radius=1000",[LoginSqlite getdata:@"UserToken" defaultdata:@""],latitude,longitude];
    
    NSLog(@"%@",urlStr);
    //NSString * encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)urlStr, NULL, NULL,  kCFStringEncodingUTF8 ));
    return [[AFAppDotNetAPIClient sharedClient] GET:urlStr parameters:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
        //NSLog(@"JSON===>%@",JSON);
        NSArray *postsFromResponse = [[JSON valueForKeyPath:@"d"] valueForKeyPath:@"data"];
        NSMutableArray *mutablePosts = [NSMutableArray arrayWithCapacity:[postsFromResponse count]];
        NSNumber *statusCode = [[[JSON objectForKey:@"d"] objectForKey:@"status"] objectForKey:@"statusCode"];
        if([[NSString stringWithFormat:@"%@",statusCode] isEqualToString:@"200"]){
            for (NSDictionary *attributes in postsFromResponse) {
                ProjectModel *model = [[ProjectModel alloc] init];
                [model loadWithDictionary:attributes];
                [mutablePosts addObject:model];
            }
        }else{
            NSLog(@"%@",[[[JSON objectForKey:@"d"] objectForKey:@"status"] objectForKey:@"errors"]);
            if([[[[JSON objectForKey:@"d"] objectForKey:@"status"] objectForKey:@"errors"] isEqualToString:@"No results in database"]){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                message:@"没有找到项目"
                                                               delegate:self
                                                      cancelButtonTitle:@"确定"
                                                      otherButtonTitles:nil,nil];
                [alert show];
            }else if([[NSString stringWithFormat:@"%@",[[[JSON objectForKey:@"d"] objectForKey:@"status"] objectForKey:@"statusCode"]] isEqualToString:@"1312"]){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                message:@"在其他设备中登录，请退出重新登录"
                                                               delegate:self
                                                      cancelButtonTitle:@"确定"
                                                      otherButtonTitles:nil,nil];
                [alert show];
            }
        }
        
        if (block) {
            block([NSMutableArray arrayWithArray:mutablePosts], nil);
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        if (block) {
            block([NSMutableArray array], error);
        }
    }];
}

+(void)globalPostWithBlock:(void (^)(NSMutableArray *, NSError *))block parameters:(NSMutableDictionary *)parameters aid:(NSString *)aid{
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:[NSString stringWithFormat:@"%s/projects/",serverAddress] parameters:parameters error:nil];
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        NSString *projectId = nil;
        NSString *projectName = nil;
        NSNumber *statusCode = [[[responseObject objectForKey:@"d"] objectForKey:@"status"] objectForKey:@"statusCode"];
        if([[NSString stringWithFormat:@"%@",statusCode] isEqualToString:@"200"]){
            NSArray *a = [[responseObject objectForKey:@"d"] objectForKey:@"data"];
            for(NSDictionary *item in a){
                NSLog(@"%@",[item objectForKey:@"projectCode"]);
                NSLog(@"%@",[item objectForKey:@"projectID"]);
                projectId = [item objectForKey:@"projectID"];
                projectName = [item objectForKey:@"projectName"];
                [ContactSqlite UpdataProjectId:projectId aid:aid projectName:projectName];
                [CameraSqlite UpdataProjectId:projectId aid:aid projectName:projectName];
                [ProjectSqlite delData:aid];
            }
            if (block) {
                block([NSMutableArray arrayWithArray:[[responseObject objectForKey:@"d"] objectForKey:@"data"]], nil);
            }
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"上传失败"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil,nil];
            [alert show];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        if (block) {
            block([NSMutableArray array], error);
        }
    }];
    [[NSOperationQueue mainQueue] addOperation:op];
}

+ (void)globalPutWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block parameters:(NSMutableDictionary *)parameters aid:(NSString *)aid{
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"PUT" URLString:[NSString stringWithFormat:@"%s/projects/",serverAddress] parameters:parameters error:nil];
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        NSNumber *statusCode = [[[responseObject objectForKey:@"d"] objectForKey:@"status"] objectForKey:@"statusCode"];
        if([[NSString stringWithFormat:@"%@",statusCode] isEqualToString:@"200"]){
            [ProjectSqlite delData:aid];
            if (block) {
                block([NSMutableArray arrayWithArray:[[responseObject objectForKey:@"d"] objectForKey:@"data"]], nil);
            }
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"上传失败"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil,nil];
            [alert show];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        if (block) {
            block([NSMutableArray array], error);
        }
    }];
    [[NSOperationQueue mainQueue] addOperation:op];
}
@end
