//
//  CameraModel.m
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-7-1.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "CameraModel.h"
#import "CameraSqlite.h"
@implementation CameraModel
//本地数据库
-(void)loadWithDB:(NSDictionary*)dic
{
    self.a_id = [dic valueForKey:@"id"];
    self.a_baseCameraID = [dic valueForKey:@"baseCameraID"];
    self.a_body = [dic valueForKey:@"body"];
    self.a_type = [dic valueForKey:@"type"];
    self.a_name = [dic valueForKey:@"name"];
    self.a_projectName = [dic valueForKey:@"projectName"];
    self.a_projectID = [dic valueForKey:@"projectID"];
    self.a_localProjectId = [dic valueForKey:@"localProjectId"];
    self.a_device = [dic valueForKey:@"device"];
}

//服务器数据
-(void)loadWithDictionary:(NSDictionary*)dic
{
    self.a_baseCameraID = [dic valueForKey:@"imgID"];
    self.a_body = [dic valueForKey:@"imgContent"];
    self.a_type = [dic valueForKey:@"category"];
    self.a_name = [dic valueForKey:@"imgName"];
    self.a_projectName = [dic valueForKey:@"projectName"];
    self.a_projectID = [dic valueForKey:@"projectID"];
    self.a_device = [dic valueForKey:@"device"];
    self.a_imgCompressionContent = [dic valueForKey:@"imgCompressionContent"];
    self.imageHeight=[dic[@"Height"] floatValue];
    self.imageWidth=[dic[@"Width"] floatValue];
}

-(BOOL)isNewImage{
    return [self.a_device isEqualToString:@"localios"];
}

+(void)globalPostWithBlock:(void (^)(NSMutableArray *, NSError *))block parameters:(NSMutableDictionary *)parameters aid:(NSString *)aid{
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:[NSString stringWithFormat:@"%s/ProjectImgs/",serverAddress] parameters:parameters error:nil];
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        NSNumber *statusCode = [[[responseObject objectForKey:@"d"] objectForKey:@"status"] objectForKey:@"statusCode"];
        if([[NSString stringWithFormat:@"%@",statusCode] isEqualToString:@"200"]){
            [CameraSqlite delData:aid];
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
