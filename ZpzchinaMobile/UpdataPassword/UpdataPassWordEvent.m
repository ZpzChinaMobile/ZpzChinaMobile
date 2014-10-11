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
+ (void)PutUserWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dataDic:(NSMutableDictionary *)dataDic{
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"PUT" URLString:[NSString stringWithFormat:@"%s/Users/",serverAddress] parameters:dataDic error:nil];
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSLog(@"JSON: %@", responseObject);
        NSNumber *statusCode = [[[responseObject objectForKey:@"d"] objectForKey:@"status"] objectForKey:@"statusCode"];
        if([[NSString stringWithFormat:@"%@",statusCode] isEqualToString:@"200"]){
            if (block) {
                block([NSMutableArray arrayWithArray:[[responseObject objectForKey:@"d"] objectForKey:@"data"]], nil);
            }
        }else{
            NSLog(@"失败了");
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
