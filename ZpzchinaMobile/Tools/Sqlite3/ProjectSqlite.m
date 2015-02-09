//
//  ProjectSqlite.m
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-25.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "ProjectSqlite.h"
#import "SqliteHelper.h"
#import "ProjectModel.h"
@implementation ProjectSqlite
+(void)opensql{
    sqlite3 *zpzchinaMobileDB;
    char *errorMsg;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    NSString *database_path = [documents stringByAppendingPathComponent:DataBaseName];
    //  NSLog(@"%@,=========%@",paths,database_path);
    if (sqlite3_open([database_path UTF8String], &zpzchinaMobileDB)==SQLITE_OK) {
        NSLog(@"打开数据库成功!");
        NSString *createSQL = @"CREATE TABLE IF NOT EXISTS Project (id Text ,projectId Text ,projectCode Text,projectVersion Text,landName TEXT,district Text,province Text,city Text,landAddress Text ,area Text,plotRatio Text,usage Text,auctionUnit Text,projectName Text ,description Text ,owner Text,expectedStartTime Text,expectedFinishTime TEXT,investment Text,areaOfStructure Text,storeyHeight Text,foreignInvestment Text ,ownerType Text,longitude Text,latitude Text,mainDesignStage Text,propertyElevator Text,propertyAirCondition Text,propertyHeating Tet,propertyExternalWallMeterial Text,propertyStealStructure Text,actualStartTime Text,fireControl Text,green Text,electroweakInstallation Text,decorationSituation Text,decorationProgress Text,projectStage Text,CompressImage Text,CompressImageWidth Text,CompressImageHeight Text,status Text); ";
        
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
        
        NSString *createSQL = @"DROP TABLE Project";
        
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
        [sqlite executeQuery:[NSString stringWithFormat:@"delete from Project"]];
	}
}

//获取所有数据
+(NSMutableArray *)loadList{
    NSMutableArray *list = [[NSMutableArray alloc] init];
    SqliteHelper *sqlite = [[SqliteHelper alloc] init];
	if ([sqlite open:DataBaseName]) {
        NSArray *results = [sqlite executeQuery:[NSString stringWithFormat:@"SELECT * FROM Project WHERE  status <>'0'"]];
        for (NSDictionary * dict in results) {
            ProjectModel *model = [[ProjectModel alloc]init];
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
        NSArray *results = [sqlite executeQuery:[NSString stringWithFormat:@"SELECT * FROM Project WHERE id = '%@' AND status <>'1'",aid]];
        for (NSDictionary * dict in results) {
            ProjectModel *model = [[ProjectModel alloc]init];
            [model loadWithDB:dict];
            [list addObject:model];
        }
	}
    return list;
}

//获取本地新建数据
+(NSMutableArray *)loadInsertData{
    NSMutableArray *list = [[NSMutableArray alloc] init];
    SqliteHelper *sqlite = [[SqliteHelper alloc] init];
	if ([sqlite open:DataBaseName]) {
        NSArray *results = [sqlite executeQuery:[NSString stringWithFormat:@"SELECT * FROM Project WHERE status =='2'"]];
        for (NSDictionary * dict in results) {
            ProjectModel *model = [[ProjectModel alloc]init];
            [model loadWithDB:dict];
            [list addObject:model];
        }
	}
    return list;
}

//获取本地更新数据
+(NSMutableArray *)loadUpdataData{
    NSMutableArray *list = [[NSMutableArray alloc] init];
    SqliteHelper *sqlite = [[SqliteHelper alloc] init];
	if ([sqlite open:DataBaseName]) {
        NSArray *results = [sqlite executeQuery:[NSString stringWithFormat:@"SELECT * FROM Project WHERE status =='3'"]];
        for (NSDictionary * dict in results) {
            ProjectModel *model = [[ProjectModel alloc]init];
            [model loadWithDB:dict];
            [list addObject:model];
        }
	}
    return list;
}

//新建数据
+(void)InsertData:(NSDictionary *)dic{
    //NSLog(@"==>%@",[dic objectForKey:@"id"]);
    NSString *aid = nil;
    NSString *status = nil;
    SqliteHelper *sqlite = [[SqliteHelper alloc] init];
	if ([sqlite open:DataBaseName]) {
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^[0-9]*$" options:NSRegularExpressionCaseInsensitive error:nil];
        NSUInteger numberOfMatches = [regex numberOfMatchesInString:[dic objectForKey:@"id"] options:0 range:NSMakeRange(0, [[dic objectForKey:@"id"] length])];
        if(numberOfMatches !=1 ){
            //服务器数据
            aid = [dic objectForKey:@"projectID"];
            status = @"3";
        }else{
            //本地数据
            aid = [dic objectForKey:@"id"];
            status = @"2";
        }
        
        [sqlite executeQuery:@"INSERT INTO Project(id, projectId,projectCode,projectVersion,landName,district,province,city,landAddress,area,plotRatio,usage,auctionUnit,projectName,description,owner,expectedStartTime,expectedFinishTime,investment,areaOfStructure,storeyHeight,foreignInvestment,ownerType,longitude,latitude,mainDesignStage,propertyElevator,propertyAirCondition,propertyHeating,propertyExternalWallMeterial,propertyStealStructure,actualStartTime,fireControl,green,electroweakInstallation,decorationSituation,decorationProgress,projectStage,CompressImage,CompressImageWidth,CompressImageHeight,status) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);",
         aid,[dic objectForKey:@"projectID"],[dic objectForKey:@"projectCode"],[dic objectForKey:@"projectVersion"],[dic objectForKey:@"landName"],[dic objectForKey:@"district"],[dic objectForKey:@"province"],[dic objectForKey:@"city"],[dic objectForKey:@"landAddress"],[dic objectForKey:@"area"],[dic objectForKey:@"plotRatio"],[dic objectForKey:@"usage"],[dic objectForKey:@"auctionUnit"],[dic objectForKey:@"projectName"],[dic objectForKey:@"description"],[dic objectForKey:@"owner"],[dic objectForKey:@"expectedStartTime"],[dic objectForKey:@"expectedFinishTime"],[dic objectForKey:@"investment"],[dic objectForKey:@"areaOfStructure"],[dic objectForKey:@"storeyHeight"],[dic objectForKey:@"foreignInvestment"],[dic objectForKey:@"ownerType"],[dic objectForKey:@"longitude"],[dic objectForKey:@"latitude"],[dic objectForKey:@"mainDesignStage"],[dic objectForKey:@"propertyElevator"],[dic objectForKey:@"propertyAirCondition"],[dic objectForKey:@"propertyHeating"],[dic objectForKey:@"propertyExternalWallMeterial"],[dic objectForKey:@"propertyStealStructure"],[dic objectForKey:@"actualStartTime"],[dic objectForKey:@"fireControl"],[dic objectForKey:@"green"],[dic objectForKey:@"electroweakInstallation"],[dic objectForKey:@"decorationSituation"],[dic objectForKey:@"decorationProgress"],[dic objectForKey:@"projectStage"],[dic objectForKey:@"CompressImage"],[dic objectForKey:@"CompressImageWidth"],[dic objectForKey:@"CompressImageHeight"],status];
	}
}

//更新数据
+(void)UpdataData:(NSDictionary *)dic{
    NSArray *tempArr = [ProjectSqlite loadDataStatus:[dic objectForKey:@"id"]];
    if(tempArr.count != 0){
        [ProjectSqlite UpdataDataStatus2:dic];
    }else{
        
    }
}

//获取数据状态
+(NSMutableArray *)loadDataStatus:(NSString *)aid{
    NSMutableArray *list = [[NSMutableArray alloc] init];
    SqliteHelper *sqlite = [[SqliteHelper alloc] init];
	if ([sqlite open:DataBaseName]) {
        NSArray *results = [sqlite executeQuery:[NSString stringWithFormat:@"SELECT * FROM Project WHERE id = '%@' AND status = '2';",aid]];
        for (NSDictionary * dict in results) {
            ProjectModel *model = [[ProjectModel alloc]init];
            [model loadWithDB:dict];
            [list addObject:model];
        }
	}
    return list;
}

//获取已修改数据状态
+(NSMutableArray *)loadUpdataDataStatus:(NSString *)aid{
    NSMutableArray *list = [[NSMutableArray alloc] init];
    SqliteHelper *sqlite = [[SqliteHelper alloc] init];
	if ([sqlite open:DataBaseName]) {
        NSArray *results = [sqlite executeQuery:[NSString stringWithFormat:@"SELECT * FROM Project WHERE id = '%@' AND status = '3';",aid]];
        for (NSDictionary * dict in results) {
            ProjectModel *model = [[ProjectModel alloc]init];
            [model loadWithDB:dict];
            [list addObject:model];
        }
	}
    return list;
}

//更新本地创建数据
+(void)UpdataDataStatus2:(NSDictionary *)dic{
    //NSLog(@"%@",dic);
    SqliteHelper *sqlite = [[SqliteHelper alloc] init];
	if ([sqlite open:DataBaseName]) {
        [sqlite executeQuery:@"UPDATE Project SET projectId=?,projectCode=?,projectVersion=?,landName=?,district=?,province=?,city=?,landAddress=?,area=?,plotRatio=?,usage=?,auctionUnit=?,projectName=?,description=?,owner=?,expectedStartTime=?,expectedFinishTime=?,investment=?,areaOfStructure=?,storeyHeight=?,foreignInvestment=?,ownerType=?, longitude=?,latitude=?,mainDesignStage=?,propertyElevator=?,propertyAirCondition=?,propertyHeating=?,propertyExternalWallMeterial=?,propertyStealStructure=?,actualStartTime=?,fireControl=?,green=?,electroweakInstallation=?,decorationSituation=?,decorationProgress=?,projectStage=?,CompressImage=?,CompressImageWidth=?,CompressImageHeight=? WHERE id=?",
         [dic objectForKey:@"projectID"],[dic objectForKey:@"projectCode"],[dic objectForKey:@"projectVersion"],[dic objectForKey:@"landName"],[dic objectForKey:@"district"],[dic objectForKey:@"province"],[dic objectForKey:@"city"],[dic objectForKey:@"landAddress"],[dic objectForKey:@"area"],[dic objectForKey:@"plotRatio"],[dic objectForKey:@"usage"],[dic objectForKey:@"auctionUnit"],[dic objectForKey:@"projectName"],[dic objectForKey:@"description"],[dic objectForKey:@"owner"],[dic objectForKey:@"expectedStartTime"],[dic objectForKey:@"expectedFinishTime"],[dic objectForKey:@"investment"],[dic objectForKey:@"areaOfStructure"],[dic objectForKey:@"storeyHeight"],[dic objectForKey:@"foreignInvestment"],[dic objectForKey:@"ownerType"],[dic objectForKey:@"longitude"],[dic objectForKey:@"latitude"],[dic objectForKey:@"mainDesignStage"],[dic objectForKey:@"propertyElevator"],[dic objectForKey:@"propertyAirCondition"],[dic objectForKey:@"propertyHeating"],[dic objectForKey:@"propertyExternalWallMeterial"],[dic objectForKey:@"propertyStealStructure"],[dic objectForKey:@"actualStartTime"],[dic objectForKey:@"fireControl"],[dic objectForKey:@"green"],[dic objectForKey:@"electroweakInstallation"],[dic objectForKey:@"decorationSituation"],[dic objectForKey:@"decorationProgress"],[dic objectForKey:@"projectStage"],[dic objectForKey:@"CompressImage"],[dic objectForKey:@"CompressImageWidth"],[dic objectForKey:@"CompressImageHeight"],[dic objectForKey:@"id"]];
	}
}

//更新服务器下载数据
+(void)UpdataDataStatus3:(NSDictionary *)dic{
    SqliteHelper *sqlite = [[SqliteHelper alloc] init];
	if ([sqlite open:DataBaseName]) {
        [sqlite executeQuery:@"UPDATE Project SET projectId=?,projectCode=?,projectVersion=?,landName=?,district=?,province=?,city=?,landAddress=?,area=?,plotRatio=?,usage=?,auctionUnit=?,projectName=?,description=?,owner=?,expectedStartTime=?,expectedFinishTime=?,investment=?,areaOfStructure=?,storeyHeight=?,foreignInvestment=?,ownerType=?,longitude=?,latitude=?,mainDesignStage=?,propertyElevator=?,propertyAirCondition=?,propertyHeating=?,propertyExternalWallMeterial=?,propertyStealStructure=?,actualStartTime=?,fireControl=?,green=?,electroweakInstallation=?,decorationSituation=?,decorationProgress=?,projectStage=?,CompressImage=?,CompressImageWidth=?,CompressImageHeight=?,status='3' WHERE id=?",
         [dic objectForKey:@"projectID"],[dic objectForKey:@"projectCode"],[dic objectForKey:@"projectVersion"],[dic objectForKey:@"landName"],[dic objectForKey:@"district"],[dic objectForKey:@"province"],[dic objectForKey:@"city"],[dic objectForKey:@"landAddress"],[dic objectForKey:@"area"],[dic objectForKey:@"plotRatio"],[dic objectForKey:@"usage"],[dic objectForKey:@"auctionUnit"],[dic objectForKey:@"projectName"],[dic objectForKey:@"description"],[dic objectForKey:@"owner"],[dic objectForKey:@"expectedStartTime"],[dic objectForKey:@"expectedFinishTime"],[dic objectForKey:@"investment"],[dic objectForKey:@"areaOfStructure"],[dic objectForKey:@"storeyHeight"],[dic objectForKey:@"foreignInvestment"],[dic objectForKey:@"ownerType"],[dic objectForKey:@"longitude"],[dic objectForKey:@"latitude"],[dic objectForKey:@"mainDesignStage"],[dic objectForKey:@"propertyElevator"],[dic objectForKey:@"propertyAirCondition"],[dic objectForKey:@"propertyHeating"],[dic objectForKey:@"propertyExternalWallMeterial"],[dic objectForKey:@"propertyStealStructure"],[dic objectForKey:@"actualStartTime"],[dic objectForKey:@"fireControl"],[dic objectForKey:@"green"],[dic objectForKey:@"electroweakInstallation"],[dic objectForKey:@"decorationSituation"],[dic objectForKey:@"decorationProgress"],[dic objectForKey:@"projectStage"],[dic objectForKey:@"CompressImage"],[dic objectForKey:@"CompressImageWidth"],[dic objectForKey:@"CompressImageHeight"],[dic objectForKey:@"id"]];
	}
}

//删除数据
+(void)delData:(NSString *)aid{
    //NSLog(@"aid==>%@",aid);
    SqliteHelper *sqlite = [[SqliteHelper alloc] init];
	if ([sqlite open:DataBaseName]) {
        //本地数据
        [sqlite executeQuery:[NSString stringWithFormat:@"DELETE FROM Project WHERE id = '%@'",aid]];
	}
}

//更新ID
+(void)UpdataProjectId:(NSString *)projectId aid:(NSString *)aid projectCode:(NSString *)projectCode{
    SqliteHelper *sqlite = [[SqliteHelper alloc] init];
	if ([sqlite open:DataBaseName]) {
        [sqlite executeQuery:[NSString stringWithFormat:@"UPDATE Project SET projectId='%@',projectCode = '%@',status='0'  WHERE id='%@'",projectId,projectCode,aid]];
	}
}

//修改在线数据
+(void)InsertUpdataServerData:(NSDictionary *)dic{
    //NSLog(@"%@",dic);
    NSArray *tempArr = [ProjectSqlite loadServerDataStatus:[dic objectForKey:@"id"]];
    NSLog(@"%d",tempArr.count);
    if(tempArr.count != 0){
        [ProjectSqlite UpdataDataStatus2:dic];
    }else{
        [ProjectSqlite InsertData:dic];
    }
}

+(NSArray *)loadServerDataStatus:(NSString *)aid{
    NSMutableArray *list = [[NSMutableArray alloc] init];
    SqliteHelper *sqlite = [[SqliteHelper alloc] init];
	if ([sqlite open:DataBaseName]) {
        NSArray *results = [sqlite executeQuery:[NSString stringWithFormat:@"SELECT * FROM Project WHERE id = '%@';",aid]];
        for (NSDictionary * dict in results) {
            ProjectModel *model = [[ProjectModel alloc]init];
            [model loadWithDB:dict];
            [list addObject:model];
        }
	}
    return list;
}
@end
