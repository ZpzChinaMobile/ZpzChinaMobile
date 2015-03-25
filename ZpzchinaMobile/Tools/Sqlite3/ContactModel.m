//
//  ContactModel.m
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-26.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "ContactModel.h"
#import "ContactSqlite.h"
@implementation ContactModel
//本地数据库
-(void)loadWithDB:(NSDictionary*)dic
{
    self.a_id = [dic valueForKey:@"id"];
    self.a_baseContactID = [dic valueForKey:@"baseContactID"];
    self.a_contactName = [dic valueForKey:@"contactName"];
    self.a_mobilePhone = [dic valueForKey:@"mobilePhone"];
    self.a_accountName = [dic valueForKey:@"accountName"];
    self.a_accountAddress = [dic valueForKey:@"accountAddress"];
    self.a_projectId = [dic valueForKey:@"projectId"];
    self.a_projectName = [dic valueForKey:@"projectName"];
    self.a_duties = [dic valueForKey:@"duties"];
    self.a_category = [dic valueForKey:@"category"];
}

//服务器数据
-(void)loadWithDictionary:(NSDictionary*)dic
{
    self.a_id = [dic valueForKey:@"id"];
    self.a_baseContactID = [dic valueForKey:@"baseContactID"];
    self.a_contactName = [dic valueForKey:@"name"];
    self.a_mobilePhone = [dic valueForKey:@"telephone"];
    self.a_accountName = [dic valueForKey:@"workAt"];
    self.a_accountAddress = [dic valueForKey:@"workAddress"];
    self.a_projectId = [dic valueForKey:@"projectID"];
    self.a_projectName = [dic valueForKey:@"project"];
    self.a_duties = [dic valueForKey:@"duties"];
    self.a_category = [dic valueForKey:@"category"];
    self.a_url = [dic valueForKey:@"url"];
}

+(void)globalPostWithBlock:(void (^)(NSMutableArray *, NSError *))block parameters:(NSMutableDictionary *)parameters aid:(NSString *)aid{
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:[NSString stringWithFormat:@"%s/BaseContacts/",serverAddress] parameters:parameters error:nil];
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        NSNumber *statusCode = [[[responseObject objectForKey:@"d"] objectForKey:@"status"] objectForKey:@"statusCode"];
        if([[NSString stringWithFormat:@"%@",statusCode] isEqualToString:@"200"]){
            //[ContactSqlite delData:aid];
            if (block) {
                block([NSMutableArray arrayWithArray:[[responseObject objectForKey:@"d"] objectForKey:@"data"]], nil);
            }
        }else{
            NSError *aError = [NSError errorWithDomain:@"aaa" code:999 userInfo:nil];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"上传失败"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil,nil];
            [alert show];
            if (block) {
                block([NSMutableArray array], aError);
            }
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
