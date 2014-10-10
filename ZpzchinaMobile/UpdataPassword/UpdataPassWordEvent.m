//
//  UpdataPassWordEvent.m
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-10-10.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "UpdataPassWordEvent.h"
#import "AFAppDotNetAPIClient.h"
@implementation UpdataPassWordEvent
+ (NSURLSessionDataTask *)PutUserWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dataDic:(NSMutableDictionary *)dataDic{
    NSLog(@"%@",dataDic);
    NSString *urlStr = [NSString stringWithFormat:@"/ZPZChina.svc/Users/"];
    return [[AFAppDotNetAPIClient sharedClient] PUT:urlStr parameters:dataDic success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSLog(@"JSON=publish==>%@",JSON);

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error ==> %@",error);
        if (block) {
            block([NSMutableArray array], error);
        }
        
    }];
}
@end
