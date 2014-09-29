//
//  UserSqlite.m
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-9-29.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "UserSqlite.h"
#import "SqliteHelper.h"
#import "UserModel.h"
@implementation UserSqlite
+(void)opensql{
    sqlite3 *zpzchinaMobileDB;
    char *errorMsg;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    NSString *database_path = [documents stringByAppendingPathComponent:DataBaseName];
    //  NSLog(@"%@,=========%@",paths,database_path);
    if (sqlite3_open([database_path UTF8String], &zpzchinaMobileDB)==SQLITE_OK) {
        NSLog(@"打开数据库成功!");
        NSString *createSQL = @"CREATE TABLE IF NOT EXISTS User (userToken Text ,userID Text,isFaceRegisted Text,faceCount Text,department Text,company Text,city Text,leaderLevel Text,office Text,province Text,region Text,street Text,supervisor Text,cellphone Text); ";
        
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
        
        NSString *createSQL = @"DROP TABLE User";
        
        if (sqlite3_exec(zpzchinaMobileDB, [createSQL UTF8String], NULL, NULL, &errorMsg) != SQLITE_OK) {
            sqlite3_close(zpzchinaMobileDB);
            NSAssert(0, @"删除数据库表错误: %s", errorMsg);
        }else{
            NSLog(@"User删除成功");
        }
        
    }
}

+(void)delAll{
    SqliteHelper *sqlite = [[SqliteHelper alloc] init];
	if ([sqlite open:DataBaseName]) {
        [sqlite executeQuery:[NSString stringWithFormat:@"delete from User"]];
	}
}

//新建数据
+(void)InsertData:(NSDictionary *)dic{
    //NSLog(@"==>%@",dic);
    SqliteHelper *sqlite = [[SqliteHelper alloc] init];
	if ([sqlite open:DataBaseName]) {
        [sqlite executeQuery:@"INSERT INTO User(userToken,userID,isFaceRegisted,faceCount,department,company,city,leaderLevel,office,province,region ,street,supervisor,cellphone) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?);",
         dic[@"userToken"],dic[@"userID"],dic[@"isFaceRegisted"],dic[@"faceCount"],dic[@"department"],dic[@"company"],dic[@"city"],dic[@"leaderLevel"],dic[@"office"],dic[@"province"],dic[@"region"],dic[@"street"],dic[@"supervisor"],dic[@"cellphone"]];
	}
}

+(NSMutableArray *)loadList{
    NSMutableArray *list = [[NSMutableArray alloc] init];
    SqliteHelper *sqlite = [[SqliteHelper alloc] init];
	if ([sqlite open:DataBaseName]) {
        NSArray *results = [sqlite executeQuery:[NSString stringWithFormat:@"SELECT * FROM User"]];
        for (NSDictionary * dict in results) {
            UserModel *model = [[UserModel alloc]init];
            [model loadWithDB:dict];
            [list addObject:model];
        }
	}
    return list;
}

+(void)updataIsFaceRegisted:(NSString *)str{
    SqliteHelper *sqlite = [[SqliteHelper alloc] init];
	if ([sqlite open:DataBaseName]) {
        [sqlite executeQuery:@"UPDATE User SET isFaceRegisted=?",str];
	}
}

+(void)updataFaceCount:(NSString *)str{
    SqliteHelper *sqlite = [[SqliteHelper alloc] init];
	if ([sqlite open:DataBaseName]) {
        [sqlite executeQuery:@"UPDATE User SET faceCount=?",str];
	}
}
@end
