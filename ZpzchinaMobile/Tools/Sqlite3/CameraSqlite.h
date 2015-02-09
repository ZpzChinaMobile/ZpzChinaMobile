//
//  CameraSqlite.h
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-7-1.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CameraModel.h"
@interface CameraSqlite : NSObject
+(void)opensql;
+(void)dropTable;
+(void)delAll;

+(NSMutableArray *)loadList;
+(NSMutableArray *)loadLocalList:(NSString *)projectID;

+(NSMutableArray *)loadAllHorizonList:(NSString *)projectID;
+(NSMutableArray *)loadAllPilePitList:(NSString *)projectID;
+(NSMutableArray *)loadAllMainConstructionList:(NSString *)projectID;
+(NSMutableArray *)loadHorizonList:(NSString *)projectID;
+(NSMutableArray *)loadPilePitList:(NSString *)projectID;
+(NSMutableArray *)loadMainConstructionList:(NSString *)projectID;
+(NSMutableArray *)loadPlanList:(NSString *)projectID;
+(NSMutableArray *)loadPlanSingleList:(NSString *)projectID;
+(NSMutableArray *)loadAllPlanList:(NSString *)projectID;
+(NSMutableArray *)loadHorizonSingleList:(NSString *)projectID;
+(NSMutableArray *)loadPilePitSingleList:(NSString *)projectID;
+(NSMutableArray *)loadMainConstructionSingleList:(NSString *)projectID;
+(NSMutableArray *)loadexplorationList:(NSString *)projectID;
+(NSMutableArray *)loadAllexplorationList:(NSString *)projectID;
+(NSMutableArray *)loadexplorationSingleList:(NSString *)projectID;
+(NSMutableArray *)loadfireControlList:(NSString *)projectID;
+(NSMutableArray *)loadAllfireControlList:(NSString *)projectID;
+(NSMutableArray *)loadfireControlSingleList:(NSString *)projectID;
+(NSMutableArray *)loadelectroweakList:(NSString *)projectID;
+(NSMutableArray *)loadAllelectroweakList:(NSString *)projectID;
+(NSMutableArray *)loadelectroweakSingleList:(NSString *)projectID;


+(NSMutableArray *)loadList:(NSString *)aid;
+(NSMutableArray *)loadSingleList:(NSString *)aid;
+(void)InsertData:(NSDictionary *)dic;
+(void)delData:(NSString *)aid;
+(void)UpdataProjectId:(NSString *)projectId aid:(NSString *)aid projectName:(NSString *)projectName;
+(void)UpdataBaseId:(NSString *)baseCameraID aid:(NSString *)aid;

+(void)InsertNewData:(CameraModel *)model;
@end
