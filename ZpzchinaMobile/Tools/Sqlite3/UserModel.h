//
//  UserModel.h
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-9-29.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject
@property (nonatomic,strong) NSString *a_userToken;
@property (nonatomic,strong) NSString *a_userID;
@property (nonatomic,strong) NSString *a_supervisor;
@property (nonatomic,strong) NSString *a_street;
@property (nonatomic,strong) NSString *a_region;
@property (nonatomic,strong) NSString *a_province;
@property (nonatomic,strong) NSString *a_office;
@property (nonatomic,strong) NSString *a_leaderLevel;
@property (nonatomic,strong) NSString *a_isFaceRegisted;
@property (nonatomic,strong) NSString *a_faceCount;
@property (nonatomic,strong) NSString *a_department;
@property (nonatomic,strong) NSString *a_company;
@property (nonatomic,strong) NSString *a_city;
@property (nonatomic,strong) NSString *a_cellphone;
@property (nonatomic,strong) NSString *a_district;
@property (nonatomic,strong) NSString *a_realName;

-(void)loadWithDictionary:(NSDictionary*)dic;
-(void)loadWithDB:(NSDictionary*)dic;
@end
