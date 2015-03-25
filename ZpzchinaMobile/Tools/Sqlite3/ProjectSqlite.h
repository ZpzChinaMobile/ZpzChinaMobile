//
//  ProjectSqlite.h
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-25.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import <Foundation/Foundation.h>
//satus 0正常 1删除 2新建 3更新
@interface ProjectSqlite : NSObject
+(void)opensql;
+(void)dropTable;
+(void)delAll;
+(NSMutableArray *)loadList;
+(NSMutableArray *)loadList:(NSString *)aid;
+(NSMutableArray *)loadInsertData;
+(NSMutableArray *)loadUpdataData;
+(void)InsertData:(NSDictionary *)dic;
+(void)UpdataData:(NSDictionary *)dic;
+(NSMutableArray *)loadDataStatus:(NSString *)aid;
+(NSMutableArray *)loadUpdataDataStatus:(NSString *)aid;
+(void)UpdataDataStatus3:(NSDictionary *)dic;
+(void)UpdataDataStatus2:(NSDictionary *)dic;
+(void)delData:(NSString *)aid;
+(void)UpdataProjectId:(NSString *)projectId aid:(NSString *)aid projectCode:(NSString *)projectCode;
+(void)UpdataServeProjectId:(NSString *)projectId aid:(NSString *)aid;
+(void)InsertUpdataServerData:(NSDictionary *)dic;
@end
