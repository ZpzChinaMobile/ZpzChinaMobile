//
//  ContactModel.h
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-26.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContactModel : NSObject
@property (nonatomic,strong) NSString *a_id;
@property (nonatomic,strong) NSString *a_baseContactID;
//联系人
@property (nonatomic,strong) NSString *a_contactName;
//电话
@property (nonatomic,strong) NSString *a_mobilePhone;
//拍卖单位
@property (nonatomic,strong) NSString *a_accountName;
//单位地址
@property (nonatomic,strong) NSString *a_accountAddress;
//项目ID
@property (nonatomic,strong) NSString *a_projectId;
//项目名称
@property (nonatomic,strong) NSString *a_projectName;
//本地项目ID
@property (nonatomic,strong) NSString *a_localProjectId;
//岗位
@property (nonatomic,strong) NSString *a_duties;
//类别
@property (nonatomic,strong) NSString *a_category;
//url
@property (nonatomic,strong) NSString *a_url;
-(void)loadWithDictionary:(NSDictionary*)dic;
-(void)loadWithDB:(NSDictionary*)dic;
+ (void)globalPostWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block parameters:(NSMutableDictionary *)parameters aid:(NSString *)aid;
@end
