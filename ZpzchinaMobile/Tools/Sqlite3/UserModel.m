//
//  UserModel.m
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-9-29.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel
//本地数据库
-(void)loadWithDB:(NSDictionary*)dic
{
    self.a_userToken = [dic valueForKey:@"userToken"];
    self.a_userID = [dic valueForKey:@"userID"];
    self.a_supervisor = [dic valueForKey:@"supervisor"];
    self.a_street = [dic valueForKey:@"street"];
    self.a_region = [dic valueForKey:@"region"];
    self.a_province = [dic valueForKey:@"province"];
    self.a_office = [dic valueForKey:@"office"];
    self.a_leaderLevel = [dic valueForKey:@"leaderLevel"];
    self.a_isFaceRegisted = [dic valueForKey:@"isFaceRegisted"];
    self.a_faceCount = [dic valueForKey:@"faceCount"];
    self.a_department = [dic valueForKey:@"department"];
    self.a_company = [dic valueForKey:@"company"];
    self.a_city = [dic valueForKey:@"city"];
    self.a_cellphone = [dic valueForKey:@"cellphone"];
}

//服务器数据
-(void)loadWithDictionary:(NSDictionary*)dic
{
    self.a_userToken = [dic valueForKey:@"userToken"];
    self.a_userID = [dic valueForKey:@"userID"];
    self.a_supervisor = [dic valueForKey:@"supervisor"];
    self.a_street = [dic valueForKey:@"street"];
    self.a_region = [dic valueForKey:@"region"];
    self.a_province = [dic valueForKey:@"province"];
    self.a_office = [dic valueForKey:@"office"];
    self.a_leaderLevel = [dic valueForKey:@"leaderLevel"];
    self.a_isFaceRegisted = [dic valueForKey:@"isFaceRegisted"];
    self.a_faceCount = [dic valueForKey:@"faceCount"];
    self.a_department = [dic valueForKey:@"department"];
    self.a_company = [dic valueForKey:@"company"];
    self.a_city = [dic valueForKey:@"city"];
    self.a_cellphone = [dic valueForKey:@"cellphone"];
}
@end
