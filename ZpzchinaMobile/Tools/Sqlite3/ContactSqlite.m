//
//  ContactSqlite.m
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-26.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "ContactSqlite.h"
#import "SqliteHelper.h"
#import "ContactModel.h"
@implementation ContactSqlite
+(void)opensql{
    sqlite3 *zpzchinaMobileDB;
    char *errorMsg;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    NSString *database_path = [documents stringByAppendingPathComponent:DataBaseName];
    //  NSLog(@"%@,=========%@",paths,database_path);
    if (sqlite3_open([database_path UTF8String], &zpzchinaMobileDB)==SQLITE_OK) {
        NSLog(@"打开数据库成功!");
        NSString *createSQL = @"CREATE TABLE IF NOT EXISTS Contact (id Text ,contactName Text ,mobilePhone Text,accountName TEXT,accountAddress Text,projectId Text,projectName Text,localProjectId Text,baseContactID Text,duties Text,category Text,status Text); ";
        
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
        
        NSString *createSQL = @"DROP TABLE Contact";
        
        if (sqlite3_exec(zpzchinaMobileDB, [createSQL UTF8String], NULL, NULL, &errorMsg) != SQLITE_OK) {
            sqlite3_close(zpzchinaMobileDB);
            NSAssert(0, @"删除数据库表错误: %s", errorMsg);
        }else{
            NSLog(@"Project删除成功");
        }
        
    }
}

+(void)delAll{
    SqliteHelper *sqlite = [[SqliteHelper alloc] init];
	if ([sqlite open:DataBaseName]) {
        [sqlite executeQuery:[NSString stringWithFormat:@"delete from Contact"]];
	}
}

//获取所有数据
+(NSMutableArray *)loadList{
    NSMutableArray *list = [[NSMutableArray alloc] init];
    SqliteHelper *sqlite = [[SqliteHelper alloc] init];
	if ([sqlite open:DataBaseName]) {
        NSArray *results = [sqlite executeQuery:[NSString stringWithFormat:@"SELECT * FROM Contact WHERE  status <>'1'"]];
        for (NSDictionary * dict in results) {
            ContactModel *model = [[ContactModel alloc]init];
            [model loadWithDB:dict];
            [list addObject:model];
        }
	}
    return list;
}

//获取单条数据
+(NSMutableArray *)loadList:(NSString *)aid{
    NSMutableArray *list = [[NSMutableArray alloc] init];
    SqliteHelper *sqlite = [[SqliteHelper alloc] init];
	if ([sqlite open:DataBaseName]) {
        NSArray *results = [sqlite executeQuery:[NSString stringWithFormat:@"SELECT * FROM Contact WHERE localProjectId = '%@' AND status <>'1'",aid]];
        for (NSDictionary * dict in results) {
            ContactModel *model = [[ContactModel alloc]init];
            [model loadWithDB:dict];
            [list addObject:model];
        }
	}
    return list;
}

+(NSMutableArray *)loadListWithProject:(NSString *)aid{
    NSMutableArray *list = [[NSMutableArray alloc] init];
    SqliteHelper *sqlite = [[SqliteHelper alloc] init];
	if ([sqlite open:DataBaseName]) {
        NSArray *results = [sqlite executeQuery:[NSString stringWithFormat:@"SELECT * FROM Contact WHERE id = '%@' AND status <>'1'",aid]];
        for (NSDictionary * dict in results) {
            ContactModel *model = [[ContactModel alloc]init];
            [model loadWithDB:dict];
            [list addObject:model];
        }
	}
    return list;
}

+(NSMutableArray *)loadInsertData{
    NSMutableArray *list = [[NSMutableArray alloc] init];
    SqliteHelper *sqlite = [[SqliteHelper alloc] init];
	if ([sqlite open:DataBaseName]) {
        NSArray *results = [sqlite executeQuery:[NSString stringWithFormat:@"SELECT * FROM Contact WHERE status =='2'"]];
        for (NSDictionary * dict in results) {
            ContactModel *model = [[ContactModel alloc]init];
            [model loadWithDB:dict];
            [list addObject:model];
        }
	}
    return list;
}

+(NSMutableArray *)loadUpdataData{
    NSMutableArray *list = [[NSMutableArray alloc] init];
    SqliteHelper *sqlite = [[SqliteHelper alloc] init];
	if ([sqlite open:DataBaseName]) {
        NSArray *results = [sqlite executeQuery:[NSString stringWithFormat:@"SELECT * FROM Contact WHERE status =='3'"]];
        for (NSDictionary * dict in results) {
            ContactModel *model = [[ContactModel alloc]init];
            [model loadWithDB:dict];
            [list addObject:model];
        }
	}
    return list;
}

//新建数据
+(void)InsertData:(NSDictionary *)dic{
    NSLog(@"===>%@",dic);
    SqliteHelper *sqlite = [[SqliteHelper alloc] init];
	if ([sqlite open:DataBaseName]) {
        [sqlite executeQuery:@"INSERT INTO Contact(id, contactName,mobilePhone,accountName,accountAddress,projectId,projectName,localProjectId,baseContactID,duties,category,status) VALUES (?,?,?,?,?,?,?,?,?,?,?,'2');",
         [dic objectForKey:@"id"],[dic objectForKey:@"contactName"],[dic objectForKey:@"mobilePhone"],[dic objectForKey:@"accountName"],[dic objectForKey:@"accountAddress"],[dic objectForKey:@"projectID"],[dic objectForKey:@"projectName"],[dic objectForKey:@"localProjectId"],[dic objectForKey:@"baseContactID"],[dic objectForKey:@"duties"],[dic objectForKey:@"category"]];
	}
}

//修改在线数据
+(void)InsertUpdataServerData:(NSDictionary *)dic{
    //NSLog(@"dic ===>%@",dic);
    NSArray *tempArr = [ContactSqlite loadServerDataStatus:[dic objectForKey:@"id"]];
    //NSLog(@"count == > %d",tempArr.count);
    if(tempArr.count != 0){
        [ContactSqlite UpdataDataStatus2:dic];
    }else{
        [ContactSqlite InsertData:dic];
    }
}

+(NSArray *)loadServerDataStatus:(NSString *)aid{
    NSMutableArray *list = [[NSMutableArray alloc] init];
    SqliteHelper *sqlite = [[SqliteHelper alloc] init];
	if ([sqlite open:DataBaseName]) {
        NSArray *results = [sqlite executeQuery:[NSString stringWithFormat:@"SELECT * FROM Contact WHERE id = '%@';",aid]];
        for (NSDictionary * dict in results) {
            ContactModel *model = [[ContactModel alloc]init];
            [model loadWithDB:dict];
            [list addObject:model];
        }
	}
    return list;
}

//更新数据
+(void)UpdataData:(NSDictionary *)dic{
    NSArray *tempArr = [ContactSqlite loadDataStatus:[dic objectForKey:@"id"]];
    if(tempArr.count != 0){
        [ContactSqlite UpdataDataStatus2:dic];
    }else{
        
    }
}

//获取数据状态
+(NSMutableArray *)loadDataStatus:(NSString *)aid{
    NSMutableArray *list = [[NSMutableArray alloc] init];
    SqliteHelper *sqlite = [[SqliteHelper alloc] init];
	if ([sqlite open:DataBaseName]) {
        NSArray *results = [sqlite executeQuery:[NSString stringWithFormat:@"SELECT * FROM Contact WHERE id = '%@' AND status = '2';",aid]];
        for (NSDictionary * dict in results) {
            ContactModel *model = [[ContactModel alloc]init];
            [model loadWithDB:dict];
            [list addObject:model];
        }
	}
    return list;
}


//更新本地创建数据
+(void)UpdataDataStatus2:(NSDictionary *)dic{
    SqliteHelper *sqlite = [[SqliteHelper alloc] init];
	if ([sqlite open:DataBaseName]) {
        [sqlite executeQuery:@"UPDATE Contact SET contactName=?,mobilePhone=?,accountName=?,accountAddress=?,duties=?,category=? WHERE id=?",
         [dic objectForKey:@"contactName"],[dic objectForKey:@"mobilePhone"],[dic objectForKey:@"accountName"],[dic objectForKey:@"accountAddress"],[dic objectForKey:@"duties"],[dic objectForKey:@"category"],[dic objectForKey:@"id"]];
	}
}

//更新服务器下载数据
+(void)UpdataDataStatus3:(NSDictionary *)dic{
    SqliteHelper *sqlite = [[SqliteHelper alloc] init];
	if ([sqlite open:DataBaseName]) {
        [sqlite executeQuery:@"UPDATE Contact SET contactName=?,mobilePhone=?,accountName=?,accountAddress=?,duties=?,category=?,status='3' WHERE id=?",
         [dic objectForKey:@"contactName"],[dic objectForKey:@"mobilePhone"],[dic objectForKey:@"accountName"],[dic objectForKey:@"accountAddress"],[dic objectForKey:@"duties"],[dic objectForKey:@"category"],[dic objectForKey:@"id"]];
	}
}

//删除数据
+(void)delData:(NSString *)aid{
    SqliteHelper *sqlite = [[SqliteHelper alloc] init];
	if ([sqlite open:DataBaseName]) {
        [sqlite executeQuery:[NSString stringWithFormat:@"DELETE FROM Contact WHERE id = '%@'",aid]];
	}
}

+(void)UpdataProjectId:(NSString *)projectId aid:(NSString *)aid projectName:(NSString *)projectName{
    SqliteHelper *sqlite = [[SqliteHelper alloc] init];
	if ([sqlite open:DataBaseName]) {
        [sqlite executeQuery:[NSString stringWithFormat:@"UPDATE Contact SET projectId='%@',projectName='%@'  WHERE localProjectId ='%@'",projectId,projectName,aid]];
	}
}

+(void)UpdataBaseId:(NSString *)baseContactID aid:(NSString *)aid{
    SqliteHelper *sqlite = [[SqliteHelper alloc] init];
	if ([sqlite open:DataBaseName]) {
        [sqlite executeQuery:[NSString stringWithFormat:@"UPDATE Contact SET baseContactID='%@',status='0'  WHERE id ='%@'",baseContactID,aid]];
	}
}
@end
