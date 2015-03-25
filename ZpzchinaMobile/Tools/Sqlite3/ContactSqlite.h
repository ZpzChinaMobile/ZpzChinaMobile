//
//  ContactSqlite.h
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-26.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContactSqlite : NSObject
+(void)opensql;
+(void)dropTable;
+(void)delAll;

+(NSMutableArray *)loadList;
+(NSMutableArray *)loadList:(NSString *)aid;
+(NSMutableArray *)loadListWithProject:(NSString *)aid;
+(NSMutableArray *)loadInsertData;
+(NSMutableArray *)loadUpdataData;
+(void)InsertData:(NSDictionary *)dic;
+(void)UpdataData:(NSDictionary *)dic;
+(NSMutableArray *)loadDataStatus:(NSString *)aid;
+(void)UpdataDataStatus3:(NSDictionary *)dic;
+(void)UpdataDataStatus2:(NSDictionary *)dic;
+(void)delData:(NSString *)aid;
+(void)delAllData:(NSString *)projectId;
+(void)UpdataProjectId:(NSString *)projectId aid:(NSString *)aid projectName:(NSString *)projectName;
+(void)UpdataBaseId:(NSString *)baseContactID aid:(NSString *)aid;
+(void)InsertUpdataServerData:(NSDictionary *)dic;

+(NSMutableArray *)loadServeWithProject:(NSString*)aid;
@end
