//
//  GetProject.m
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-27.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "GetProject.h"
#import "LoginSqlite.h"
#import "ProjectModel.h"
#import "ProjectSqlite.h"
@implementation GetProject
-(void)loadServer{
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"GET" URLString:[NSString stringWithFormat:@"%s/projects/GetProject/%@",serverAddress,[LoginSqlite getdata:@"UserToken" defaultdata:@"UserToken"]] parameters:nil error:nil];
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        NSMutableArray *resultArr = [[NSMutableArray alloc]init];
        NSArray *a = [responseObject objectForKey:@"d"];
        for (NSDictionary *item in a) {
            ProjectModel *model = [[ProjectModel alloc] init];
            //NSLog(@"%@",[item objectForKey:@"landName"]);
            [model loadWithDictionary:item];
            [resultArr addObject:model];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    [[NSOperationQueue mainQueue] addOperation:op];
}
@end
