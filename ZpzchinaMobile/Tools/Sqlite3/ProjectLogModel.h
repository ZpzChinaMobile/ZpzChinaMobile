//
//  ProjectLogModel.h
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-7-3.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProjectLogModel : NSObject
@property (nonatomic,strong) NSString *a_id;
@property (nonatomic,strong) NSString *a_baseLogID;
@property (nonatomic,strong) NSString *a_projectID;
@property (nonatomic,strong) NSString *a_projectFieldName;
@property (nonatomic,strong) NSString *a_oldValue;
@property (nonatomic,strong) NSString *a_newValue;
@property (nonatomic,strong) NSString *a_updataTime;
@property (nonatomic,strong) NSString *a_userID;
-(void)loadWithDictionary:(NSDictionary*)dic;
-(void)loadWithDB:(NSDictionary*)dic;
@end 
