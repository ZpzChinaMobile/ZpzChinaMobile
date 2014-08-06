//
//  ProjectStage.h
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-7-2.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProjectModel.h"
#import "ContactModel.h"
@interface ProjectStage : NSObject
+(NSMutableArray *)JudgmentProjectLog:(NSMutableDictionary *)oldDic newDic:(NSMutableDictionary *)newDic;
+(NSMutableDictionary *)JudgmentStr:(ProjectModel *)model;
+(NSMutableDictionary *)JudgmentContactStr:(ContactModel *)model;
+(NSMutableDictionary *)JudgmentUpdataProjectStr:(NSMutableDictionary *)oldDic newDic:(NSMutableDictionary *)newDic;
+(NSString *)JudgmentProjectStage:(NSMutableDictionary *)dic;
@end
