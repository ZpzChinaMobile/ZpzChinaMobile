//
//  ProjectLogModel.m
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-7-3.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "ProjectLogModel.h"

@implementation ProjectLogModel
//本地数据库
-(void)loadWithDB:(NSDictionary*)dic
{
    self.a_id = [dic valueForKey:@"id"];
    self.a_baseLogID = [dic valueForKey:@"baseLogID"];
    self.a_projectID = [dic valueForKey:@"projectID"];
    self.a_projectFieldName = [dic valueForKey:@"projectFieldName"];
    self.a_oldValue = [dic valueForKey:@"oldValue"];
    self.a_newValue = [dic valueForKey:@"newValue"];
    self.a_updataTime = [dic valueForKey:@"updataTime"];
    self.a_userID = [dic valueForKey:@"userID"];
}

//服务器数据
-(void)loadWithDictionary:(NSDictionary*)dic
{
    self.a_id = [dic valueForKey:@"id"];
    self.a_baseLogID = [dic valueForKey:@"baseLogID"];
    self.a_projectID = [dic valueForKey:@"projectID"];
    self.a_projectFieldName = [dic valueForKey:@"projectFieldName"];
    self.a_oldValue = [dic valueForKey:@"oldValue"];
    self.a_newValue = [dic valueForKey:@"newValue"];
    self.a_updataTime = [dic valueForKey:@"updataTime"];
    self.a_userID = [dic valueForKey:@"userID"];
}
@end
