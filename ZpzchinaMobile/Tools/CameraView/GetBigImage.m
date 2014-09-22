//
//  GetBigImage.m
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-7-15.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "GetBigImage.h"
#import "CameraSqlite.h"
@implementation GetBigImage
+(void)getbigimage:(NSString *)url{
    NSLog(@"*****%@",url);
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"GET" URLString:[NSString stringWithFormat:@"%s/%@",serverAddress,url] parameters:nil error:nil];
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSLog(@"JSON: %@", responseObject);
        NSArray *a = [[responseObject objectForKey:@"d"] objectForKey:@"data"];
        for (NSMutableDictionary *item in a) {
            [dic setValue:[item objectForKey:@"imgName"] forKey:@"name"];
            [dic setValue:[item objectForKey:@"category"] forKey:@"type"];
            [dic setValue:[item objectForKey:@"imgID"] forKey:@"baseCameraID"];
            [dic setValue:[item objectForKey:@"projectName"] forKey:@"projectName"];
            [dic setValue:[item objectForKey:@"projectID"] forKey:@"projectID"];
            int value = (arc4random() % 9999999) + 1000000;
            [dic setValue:[NSString stringWithFormat:@"%d",value] forKey:@"id"];
            [dic setValue:[item objectForKey:@"projectID"] forKey:@"localProjectId"];
            [dic setValue:@"localios" forKey:@"device"];
            [dic setValue:[item objectForKey:@"imgContent"] forKey:@"body"];
        }
        //NSLog(@"dic ==> %@",dic);
        [CameraSqlite InsertData:dic];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"bigImage" object:nil];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [[NSNotificationCenter defaultCenter]postNotificationName:@"bigImage" object:nil];
    }];
    [[NSOperationQueue mainQueue] addOperation:op];
}
@end
