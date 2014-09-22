//
//  CameraSqlite.m
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-7-1.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "CameraSqlite.h"
#import "SqliteHelper.h"
@implementation CameraSqlite
+(void)opensql{
    sqlite3 *zpzchinaMobileDB;
    char *errorMsg;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    NSString *database_path = [documents stringByAppendingPathComponent:DataBaseName];
    //  NSLog(@"%@,=========%@",paths,database_path);
    if (sqlite3_open([database_path UTF8String], &zpzchinaMobileDB)==SQLITE_OK) {
        NSLog(@"打开数据库成功!");
        NSString *createSQL = @"CREATE TABLE IF NOT EXISTS Camera (id Text ,baseCameraID Text ,body Text,type TEXT,name Text,projectName Text,projectID Text,localProjectId Text,device Text,status Text); ";
        
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
        
        NSString *createSQL = @"DROP TABLE Camera";
        
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
        [sqlite executeQuery:[NSString stringWithFormat:@"delete from Camera"]];
	}
}

//新建数据
+(void)InsertData:(NSDictionary *)dic{
    NSLog(@"==>%@",dic);
    NSMutableArray *arr = [CameraSqlite loadSingleList:dic[@"id"]];
    if(arr.count == 0){
        SqliteHelper *sqlite = [[SqliteHelper alloc] init];
        if ([sqlite open:DataBaseName]) {
            [sqlite executeQuery:@"INSERT INTO Camera(id,name ,baseCameraID,body,type,projectName,projectID,localProjectId,device,status) VALUES (?,?,?,?,?,?,?,?,?,'2');",
             [dic objectForKey:@"id"],[dic objectForKey:@"name"],[dic objectForKey:@"baseCameraID"],[dic objectForKey:@"body"],[dic objectForKey:@"type"],[dic objectForKey:@"projectName"],[dic objectForKey:@"projectID"],[dic objectForKey:@"localProjectId"],[dic objectForKey:@"device"]];
        }
    }
}

+(void)InsertNewData:(CameraModel *)model{
//    NSLog(@"==>%@",model.a_id);
//    NSLog(@"==>%@",model.a_name);
//    NSLog(@"==>%@",model.a_baseCameraID);
//    NSLog(@"==>%@",model.a_body);
//    NSLog(@"==>%@",model.a_type);
//    NSLog(@"==>%@",model.a_projectName);
//    NSLog(@"==>%@",model.a_projectID);
//    NSLog(@"==>%@",model.a_localProjectId);
//    NSLog(@"==>%@",model.a_device);
    NSMutableArray *arr = [CameraSqlite loadSingleList:model.a_id];
    if(arr.count == 0){
        SqliteHelper *sqlite = [[SqliteHelper alloc] init];
        if ([sqlite open:DataBaseName]) {
            [sqlite executeQuery:@"INSERT INTO Camera(id,name ,baseCameraID,body,type,projectName,projectID,localProjectId,device,status) VALUES (?,?,?,?,?,?,?,?,?,'2');",
             model.a_id,model.a_name,model.a_baseCameraID,model.a_body,model.a_type,model.a_projectName,model.a_projectID,model.a_localProjectId,model.a_device];
        }
    }
}

//获取所有数据
+(NSMutableArray *)loadList{
    NSMutableArray *list = [[NSMutableArray alloc] init];
    SqliteHelper *sqlite = [[SqliteHelper alloc] init];
	if ([sqlite open:DataBaseName]) {
        NSArray *results = [sqlite executeQuery:[NSString stringWithFormat:@"SELECT * FROM Camera WHERE  status <>'1' order by rowid DESC"]];
        for (NSDictionary * dict in results) {
            CameraModel *model = [[CameraModel alloc]init];
            [model loadWithDB:dict];
            [list addObject:model];
        }
	}
    return list;
}
+(NSMutableArray *)loadPlanList:(NSString *)projectID{
    NSMutableArray *list = [[NSMutableArray alloc] init];
    SqliteHelper *sqlite = [[SqliteHelper alloc] init];
	if ([sqlite open:DataBaseName]) {
        NSArray *results = [sqlite executeQuery:[NSString stringWithFormat:@"SELECT * FROM Camera WHERE localProjectId = '%@' AND type = 'plan' AND status <>'1' order by rowid DESC limit 3",projectID]];
        for (NSDictionary * dict in results) {
            CameraModel *model = [[CameraModel alloc]init];
            [model loadWithDB:dict];
            [list addObject:model];
        }
	}
    return list;
}


+(NSMutableArray *) loadPlanSingleList:(NSString *)projectID{
    NSMutableArray *list = [[NSMutableArray alloc] init];
    SqliteHelper *sqlite = [[SqliteHelper alloc] init];
	if ([sqlite open:DataBaseName]) {
        NSArray *results = [sqlite executeQuery:[NSString stringWithFormat:@"SELECT * FROM Camera WHERE localProjectId = '%@' AND type = 'plan' AND status <>'1' order by rowid DESC limit 1",projectID]];
        for (NSDictionary * dict in results) {
            CameraModel *model = [[CameraModel alloc]init];
            [model loadWithDB:dict];
            [list addObject:model];
        }
	}
    return list;
}

+(NSMutableArray *)loadAllPlanList:(NSString *)projectID{
    NSMutableArray *list = [[NSMutableArray alloc] init];
    SqliteHelper *sqlite = [[SqliteHelper alloc] init];
	if ([sqlite open:DataBaseName]) {
        NSArray *results = [sqlite executeQuery:[NSString stringWithFormat:@"SELECT * FROM Camera WHERE localProjectId = '%@' AND type = 'plan' AND status <>'1' order by rowid DESC",projectID]];
        for (NSDictionary * dict in results) {
            CameraModel *model = [[CameraModel alloc]init];
            [model loadWithDB:dict];
            [list addObject:model];
        }
	}
    return list;
}


//地平图片
+(NSMutableArray *)loadHorizonList:(NSString *)projectID{
    //NSLog(@"==>%@",projectID);
    NSMutableArray *list = [[NSMutableArray alloc] init];
    SqliteHelper *sqlite = [[SqliteHelper alloc] init];
	if ([sqlite open:DataBaseName]) {
        NSArray *results = [sqlite executeQuery:[NSString stringWithFormat:@"SELECT * FROM Camera WHERE localProjectId = '%@' AND type = 'horizon' AND status <>'1' order by rowid DESC limit 3",projectID]];
        for (NSDictionary * dict in results) {
            CameraModel *model = [[CameraModel alloc]init];
            [model loadWithDB:dict];
            [list addObject:model];
        }
	}
    return list;
}

+(NSMutableArray *)loadHorizonSingleList:(NSString *)projectID{
    NSMutableArray *list = [[NSMutableArray alloc] init];
    SqliteHelper *sqlite = [[SqliteHelper alloc] init];
	if ([sqlite open:DataBaseName]) {
        NSArray *results = [sqlite executeQuery:[NSString stringWithFormat:@"SELECT * FROM Camera WHERE localProjectId = '%@' AND type = 'horizon' AND status <>'1' order by rowid DESC limit 1",projectID]];
        for (NSDictionary * dict in results) {
            CameraModel *model = [[CameraModel alloc]init];
            [model loadWithDB:dict];
            [list addObject:model];
        }
	}
    return list;
}

//获取所有地平图片
+(NSMutableArray *)loadAllHorizonList:(NSString *)projectID{
    NSMutableArray *list = [[NSMutableArray alloc] init];
    SqliteHelper *sqlite = [[SqliteHelper alloc] init];
	if ([sqlite open:DataBaseName]) {
        NSArray *results = [sqlite executeQuery:[NSString stringWithFormat:@"SELECT * FROM Camera WHERE localProjectId = '%@' AND type = 'horizon' AND status <>'1' order by rowid DESC",projectID]];
        for (NSDictionary * dict in results) {
            CameraModel *model = [[CameraModel alloc]init];
            [model loadWithDB:dict];
            [list addObject:model];
        }
	}
    return list;
}

//桩基图片
+(NSMutableArray *)loadPilePitList:(NSString *)projectID{
    NSMutableArray *list = [[NSMutableArray alloc] init];
    SqliteHelper *sqlite = [[SqliteHelper alloc] init];
	if ([sqlite open:DataBaseName]) {
        NSArray *results = [sqlite executeQuery:[NSString stringWithFormat:@"SELECT * FROM Camera WHERE localProjectId = '%@' AND type = 'pileFoundation' AND status <>'1' order by rowid DESC limit 3",projectID]];
        for (NSDictionary * dict in results) {
            CameraModel *model = [[CameraModel alloc]init];
            [model loadWithDB:dict];
            [list addObject:model];
        }
	}
    return list;
}

+(NSMutableArray *)loadPilePitSingleList:(NSString *)projectID{
    NSMutableArray *list = [[NSMutableArray alloc] init];
    SqliteHelper *sqlite = [[SqliteHelper alloc] init];
	if ([sqlite open:DataBaseName]) {
        NSArray *results = [sqlite executeQuery:[NSString stringWithFormat:@"SELECT * FROM Camera WHERE localProjectId = '%@' AND type = 'pileFoundation' AND status <>'1' order by rowid DESC limit 1",projectID]];
        for (NSDictionary * dict in results) {
            CameraModel *model = [[CameraModel alloc]init];
            [model loadWithDB:dict];
            [list addObject:model];
        }
	}
    return list;
}

//获取所有桩基图片
+(NSMutableArray *)loadAllPilePitList:(NSString *)projectID{
    NSMutableArray *list = [[NSMutableArray alloc] init];
    SqliteHelper *sqlite = [[SqliteHelper alloc] init];
	if ([sqlite open:DataBaseName]) {
        NSArray *results = [sqlite executeQuery:[NSString stringWithFormat:@"SELECT * FROM Camera WHERE localProjectId = '%@' AND type = 'pileFoundation' AND status <>'1' order by rowid DESC",projectID]];
        for (NSDictionary * dict in results) {
            CameraModel *model = [[CameraModel alloc]init];
            [model loadWithDB:dict];
            [list addObject:model];
        }
	}
    return list;
}

//主体施工图片
+(NSMutableArray *)loadMainConstructionList:(NSString *)projectID{
    NSMutableArray *list = [[NSMutableArray alloc] init];
    SqliteHelper *sqlite = [[SqliteHelper alloc] init];
	if ([sqlite open:DataBaseName]) {
        NSArray *results = [sqlite executeQuery:[NSString stringWithFormat:@"SELECT * FROM Camera WHERE localProjectId = '%@' AND type = 'mainPart' AND status <>'1' order by rowid DESC limit 3",projectID]];
        for (NSDictionary * dict in results) {
            CameraModel *model = [[CameraModel alloc]init];
            [model loadWithDB:dict];
            [list addObject:model];
        }
	}
    return list;
}

+(NSMutableArray *)loadMainConstructionSingleList:(NSString *)projectID{
    NSMutableArray *list = [[NSMutableArray alloc] init];
    SqliteHelper *sqlite = [[SqliteHelper alloc] init];
	if ([sqlite open:DataBaseName]) {
        NSArray *results = [sqlite executeQuery:[NSString stringWithFormat:@"SELECT * FROM Camera WHERE localProjectId = '%@' AND type = 'mainPart' AND status <>'1' order by rowid DESC limit 1",projectID]];
        for (NSDictionary * dict in results) {
            CameraModel *model = [[CameraModel alloc]init];
            [model loadWithDB:dict];
            [list addObject:model];
        }
	}
    return list;
}

//获取所有主体施工图片
+(NSMutableArray *)loadAllMainConstructionList:(NSString *)projectID{
    NSMutableArray *list = [[NSMutableArray alloc] init];
    SqliteHelper *sqlite = [[SqliteHelper alloc] init];
	if ([sqlite open:DataBaseName]) {
        NSArray *results = [sqlite executeQuery:[NSString stringWithFormat:@"SELECT * FROM Camera WHERE localProjectId = '%@' AND type = 'mainPart' AND status <>'1' order by rowid DESC",projectID]];
        for (NSDictionary * dict in results) {
            CameraModel *model = [[CameraModel alloc]init];
            [model loadWithDB:dict];
            [list addObject:model];
        }
	}
    return list;
}

//获取地勘图片
+(NSMutableArray *)loadexplorationList:(NSString *)projectID{
    NSMutableArray *list = [[NSMutableArray alloc] init];
    SqliteHelper *sqlite = [[SqliteHelper alloc] init];
	if ([sqlite open:DataBaseName]) {
        NSArray *results = [sqlite executeQuery:[NSString stringWithFormat:@"SELECT * FROM Camera WHERE localProjectId = '%@' AND type = 'exploration' AND status <>'1' order by rowid DESC limit 3",projectID]];
        for (NSDictionary * dict in results) {
            CameraModel *model = [[CameraModel alloc]init];
            [model loadWithDB:dict];
            [list addObject:model];
        }
	}
    return list;
}

+(NSMutableArray *)loadexplorationSingleList:(NSString *)projectID{
    NSMutableArray *list = [[NSMutableArray alloc] init];
    SqliteHelper *sqlite = [[SqliteHelper alloc] init];
	if ([sqlite open:DataBaseName]) {
        NSArray *results = [sqlite executeQuery:[NSString stringWithFormat:@"SELECT * FROM Camera WHERE localProjectId = '%@' AND type = 'exploration' AND status <>'1' order by rowid DESC limit 1",projectID]];
        for (NSDictionary * dict in results) {
            CameraModel *model = [[CameraModel alloc]init];
            [model loadWithDB:dict];
            [list addObject:model];
        }
	}
    return list;
}

+(NSMutableArray *)loadAllexplorationList:(NSString *)projectID{
    NSMutableArray *list = [[NSMutableArray alloc] init];
    SqliteHelper *sqlite = [[SqliteHelper alloc] init];
	if ([sqlite open:DataBaseName]) {
        NSArray *results = [sqlite executeQuery:[NSString stringWithFormat:@"SELECT * FROM Camera WHERE localProjectId = '%@' AND type = 'exploration' AND status <>'1' order by rowid DESC",projectID]];
        for (NSDictionary * dict in results) {
            CameraModel *model = [[CameraModel alloc]init];
            [model loadWithDB:dict];
            [list addObject:model];
        }
	}
    return list;
}

//获取消防图片
+(NSMutableArray *)loadfireControlList:(NSString *)projectID{
    NSMutableArray *list = [[NSMutableArray alloc] init];
    SqliteHelper *sqlite = [[SqliteHelper alloc] init];
	if ([sqlite open:DataBaseName]) {
        NSArray *results = [sqlite executeQuery:[NSString stringWithFormat:@"SELECT * FROM Camera WHERE localProjectId = '%@' AND type = 'fireControl' AND status <>'1' order by rowid DESC limit 3",projectID]];
        for (NSDictionary * dict in results) {
            CameraModel *model = [[CameraModel alloc]init];
            [model loadWithDB:dict];
            [list addObject:model];
        }
	}
    return list;
}

+(NSMutableArray *)loadAllfireControlList:(NSString *)projectID{
    NSMutableArray *list = [[NSMutableArray alloc] init];
    SqliteHelper *sqlite = [[SqliteHelper alloc] init];
	if ([sqlite open:DataBaseName]) {
        NSArray *results = [sqlite executeQuery:[NSString stringWithFormat:@"SELECT * FROM Camera WHERE localProjectId = '%@' AND type = 'fireControl' AND status <>'1' order by rowid DESC",projectID]];
        for (NSDictionary * dict in results) {
            CameraModel *model = [[CameraModel alloc]init];
            [model loadWithDB:dict];
            [list addObject:model];
        }
	}
    return list;
}

+(NSMutableArray *)loadfireControlSingleList:(NSString *)projectID{
    NSMutableArray *list = [[NSMutableArray alloc] init];
    SqliteHelper *sqlite = [[SqliteHelper alloc] init];
	if ([sqlite open:DataBaseName]) {
        NSArray *results = [sqlite executeQuery:[NSString stringWithFormat:@"SELECT * FROM Camera WHERE localProjectId = '%@' AND type = 'fireControl' AND status <>'1' order by rowid DESC limit 1",projectID]];
        for (NSDictionary * dict in results) {
            CameraModel *model = [[CameraModel alloc]init];
            [model loadWithDB:dict];
            [list addObject:model];
        }
	}
    return list;
}

//弱点安装图片
+(NSMutableArray *)loadelectroweakList:(NSString *)projectID{
    NSMutableArray *list = [[NSMutableArray alloc] init];
    SqliteHelper *sqlite = [[SqliteHelper alloc] init];
	if ([sqlite open:DataBaseName]) {
        NSArray *results = [sqlite executeQuery:[NSString stringWithFormat:@"SELECT * FROM Camera WHERE localProjectId = '%@' AND type = 'electroweak' AND status <>'1' order by rowid DESC limit 3",projectID]];
        for (NSDictionary * dict in results) {
            CameraModel *model = [[CameraModel alloc]init];
            [model loadWithDB:dict];
            [list addObject:model];
        }
	}
    return list;
}

+(NSMutableArray *)loadAllelectroweakList:(NSString *)projectID{
    NSMutableArray *list = [[NSMutableArray alloc] init];
    SqliteHelper *sqlite = [[SqliteHelper alloc] init];
	if ([sqlite open:DataBaseName]) {
        NSArray *results = [sqlite executeQuery:[NSString stringWithFormat:@"SELECT * FROM Camera WHERE localProjectId = '%@' AND type = 'electroweak' AND status <>'1' order by rowid DESC",projectID]];
        for (NSDictionary * dict in results) {
            CameraModel *model = [[CameraModel alloc]init];
            [model loadWithDB:dict];
            [list addObject:model];
        }
	}
    return list;
}

+(NSMutableArray *)loadelectroweakSingleList:(NSString *)projectID{
    NSMutableArray *list = [[NSMutableArray alloc] init];
    SqliteHelper *sqlite = [[SqliteHelper alloc] init];
	if ([sqlite open:DataBaseName]) {
        NSArray *results = [sqlite executeQuery:[NSString stringWithFormat:@"SELECT * FROM Camera WHERE localProjectId = '%@' AND type = 'electroweak' AND status <>'1' order by rowid DESC limit 1",projectID]];
        for (NSDictionary * dict in results) {
            CameraModel *model = [[CameraModel alloc]init];
            [model loadWithDB:dict];
            [list addObject:model];
        }
	}
    return list;
}

//删除数据
+(void)delData:(NSString *)aid{
    SqliteHelper *sqlite = [[SqliteHelper alloc] init];
	if ([sqlite open:DataBaseName]) {
        [sqlite executeQuery:[NSString stringWithFormat:@"DELETE FROM Camera WHERE id = '%@'",aid]];
	}
}

+(void)UpdataProjectId:(NSString *)projectId aid:(NSString *)aid projectName:(NSString *)projectName{
    SqliteHelper *sqlite = [[SqliteHelper alloc] init];
	if ([sqlite open:DataBaseName]) {
        [sqlite executeQuery:[NSString stringWithFormat:@"UPDATE Camera SET projectId='%@',projectName='%@'  WHERE localProjectId ='%@'",projectId,projectName,aid]];
	}
}

+(void)UpdataBaseId:(NSString *)baseCameraID aid:(NSString *)aid{
    SqliteHelper *sqlite = [[SqliteHelper alloc] init];
	if ([sqlite open:DataBaseName]) {
        [sqlite executeQuery:[NSString stringWithFormat:@"UPDATE Camera SET baseCameraID='%@',status='0'  WHERE id ='%@'",baseCameraID,aid]];
	}
}

//获取单条数据
+(NSMutableArray *)loadList:(NSString *)aid{
    NSMutableArray *list = [[NSMutableArray alloc] init];
    SqliteHelper *sqlite = [[SqliteHelper alloc] init];
	if ([sqlite open:DataBaseName]) {
        NSArray *results = [sqlite executeQuery:[NSString stringWithFormat:@"SELECT * FROM Camera WHERE localProjectId = '%@' AND status <>'1'",aid]];
        for (NSDictionary * dict in results) {
            CameraModel *model = [[CameraModel alloc]init];
            [model loadWithDB:dict];
            [list addObject:model];
        }
	}
    return list;
}

+(NSMutableArray *)loadSingleList:(NSString *)aid{
    NSMutableArray *list = [[NSMutableArray alloc] init];
    SqliteHelper *sqlite = [[SqliteHelper alloc] init];
	if ([sqlite open:DataBaseName]) {
        NSArray *results = [sqlite executeQuery:[NSString stringWithFormat:@"SELECT * FROM Camera WHERE id = '%@' AND status <>'1'",aid]];
        for (NSDictionary * dict in results) {
            CameraModel *model = [[CameraModel alloc]init];
            [model loadWithDB:dict];
            [list addObject:model];
        }
	}
    return list;
}
@end
