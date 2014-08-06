//
//  ProjectLogSqlite.m
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-7-3.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "ProjectLogSqlite.h"
#import "SqliteHelper.h"
@implementation ProjectLogSqlite
+(void)opensql{
    sqlite3 *zpzchinaMobileDB;
    char *errorMsg;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    NSString *database_path = [documents stringByAppendingPathComponent:DataBaseName];
    //  NSLog(@"%@,=========%@",paths,database_path);
    if (sqlite3_open([database_path UTF8String], &zpzchinaMobileDB)==SQLITE_OK) {
        NSLog(@"打开数据库成功!");
        NSString *createSQL = @"CREATE TABLE IF NOT EXISTS ProjectLog (id Text ,baseLogID Text ,projectID Text,projectFieldName TEXT,oldValue Text,newValue Text,updataTime Text,userID Text,status Text); ";
        
        if (sqlite3_exec(zpzchinaMobileDB, [createSQL UTF8String], NULL, NULL, &errorMsg) != SQLITE_OK) {
            sqlite3_close(zpzchinaMobileDB);
            NSAssert(0, @"创建数据库表错误: %s", errorMsg);
        }
        
    }
    else
    {
        NSLog(@"打开数据库失败！");
        
    }
    if(sqlite3_close(zpzchinaMobileDB)==SQLITE_OK)
    { // NSLog(@"关闭数据库成功!");
    }
    
}

+(void)dropTable{
    sqlite3 *zpzchinaMobileDB;
    char *errorMsg;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    NSString *database_path = [documents stringByAppendingPathComponent:DataBaseName];
    //  NSLog(@"%@,=========%@",paths,database_path);
    if (sqlite3_open([database_path UTF8String], &zpzchinaMobileDB)==SQLITE_OK) {
        
        NSString *createSQL = @"DROP TABLE ProjectLog";
        
        if (sqlite3_exec(zpzchinaMobileDB, [createSQL UTF8String], NULL, NULL, &errorMsg) != SQLITE_OK) {
            sqlite3_close(zpzchinaMobileDB);
            NSAssert(0, @"删除数据库表错误: %s", errorMsg);
        }else{
            NSLog(@"ProjectLog删除成功");
        }
        
    }
}

+(void)delAll{
    SqliteHelper *sqlite = [[SqliteHelper alloc] init];
	if ([sqlite open:DataBaseName]) {
        [sqlite executeQuery:[NSString stringWithFormat:@"delete from ProjectLog"]];
	}
}
@end
