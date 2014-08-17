//
//  ProjectStage.m
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-7-2.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "ProjectStage.h"

@implementation ProjectStage
+(NSMutableArray *)JudgmentProjectLog:(NSMutableDictionary *)oldDic newDic:(NSMutableDictionary *)newDic{
    NSMutableArray *dataArr = [[NSMutableArray alloc] init];
    NSEnumerator * enumerator = [newDic keyEnumerator];
    //定义一个不确定类型的对象
    id object;
    //遍历输出
    while(object = [enumerator nextObject])
    {
        //NSLog(@"键值为：%@",object);
        id objectValue = [newDic objectForKey:object];
        if(objectValue != nil)
        {
            //NSLog(@"%@===>%@",object,objectValue);
            if(![object isEqualToString:@"id"]){
                NSMutableDictionary *dataDic = [[NSMutableDictionary alloc] init];
                if(![objectValue isEqualToString:@""]){
                    [dataDic setValue:objectValue forKeyPath:@"newValue"];
                    [dataDic setValue:[oldDic objectForKey:object] forKeyPath:@"oldValue"];
                    [dataDic setValue:[oldDic objectForKey:@"projectID"] forKeyPath:@"projectID"];
                    [dataDic setValue:object forKeyPath:@"projectFieldName"];
                    [dataDic setValue:[NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]] forKey:@"updataTime"];
                    [dataDic setValue:@"" forKey:@"userID"];
                    int value = (arc4random() % 9999999) + 1000000;
                    [dataDic setValue:[NSString stringWithFormat:@"%d",value] forKey:@"id"];
                    [dataDic setValue:@"" forKey:@"baseLogID"];
                    [dataArr addObject:dataDic];
                }
            }
        }
        
    }
    return dataArr;
}

+(NSMutableDictionary *)JudgmentStr:(ProjectModel *)model{
    //NSLog(@"expectedFinishTime ===>%@",model.a_expectedFinishTime);
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    //[dic setObject:model.a_id forKey:@"id"];
    if([[NSString stringWithFormat:@"%@",model.a_id] isEqualToString:@"<null>"] || [[NSString stringWithFormat:@"%@",model.a_id] isEqualToString:@"(null)"]){
        [dic setObject:@"" forKey:@"id"];
    }else{
        [dic setObject:model.a_id forKey:@"id"];
    }
    //土地规划/拍卖
    if([[NSString stringWithFormat:@"%@",model.a_landName] isEqualToString:@"<null>"] || [[NSString stringWithFormat:@"%@",model.a_landName] isEqualToString:@"(null)"]){
        [dic setObject:@"" forKey:@"landName"];
    }else{
        [dic setObject:[NSString stringWithFormat:@"%@",model.a_landName] forKey:@"landName"];
    }
    
    if([[NSString stringWithFormat:@"%@",model.a_district] isEqualToString:@"<null>"] || [[NSString stringWithFormat:@"%@",model.a_district] isEqualToString:@"(null)"]){
        [dic setObject:@"" forKey:@"district"];
    }else{
        [dic setObject:[NSString stringWithFormat:@"%@",model.a_district] forKey:@"district"];
    }
    
    if([[NSString stringWithFormat:@"%@",model.a_province] isEqualToString:@"<null>"] || [[NSString stringWithFormat:@"%@",model.a_province] isEqualToString:@"(null)"]){
        [dic setObject:@"" forKey:@"province"];
    }else{
        [dic setObject:[NSString stringWithFormat:@"%@",model.a_province] forKey:@"province"];
    }
    
    if([[NSString stringWithFormat:@"%@",model.a_landAddress] isEqualToString:@"<null>"] || [[NSString stringWithFormat:@"%@",model.a_landAddress] isEqualToString:@"(null)"]){
        [dic setObject:@"" forKey:@"landAddress"];
    }else{
        [dic setObject:[NSString stringWithFormat:@"%@",model.a_landAddress] forKey:@"landAddress"];
    }
    
    if([[NSString stringWithFormat:@"%@",model.a_city] isEqualToString:@"<null>"] ||[[NSString stringWithFormat:@"%@",model.a_city] isEqualToString:@"(null)"]){
        [dic setObject:@"" forKey:@"city"];
    }else{
        [dic setObject:[NSString stringWithFormat:@"%@",model.a_city] forKey:@"city"];
    }
    
    if([[NSString stringWithFormat:@"%@",model.a_area] isEqualToString:@"<null>"] || [[NSString stringWithFormat:@"%@",model.a_area] isEqualToString:@"(null)"]){
        [dic setObject:@"0" forKey:@"area"];
    }else{
        [dic setObject:[NSString stringWithFormat:@"%@",model.a_area] forKey:@"area"];
    }
    
    if([[NSString stringWithFormat:@"%@",model.a_plotRatio] isEqualToString:@"<null>"] || [[NSString stringWithFormat:@"%@",model.a_plotRatio] isEqualToString:@"(null)"]){
        [dic setObject:@"0" forKey:@"plotRatio"];
    }else{
        [dic setObject:[NSString stringWithFormat:@"%@",model.a_plotRatio] forKey:@"plotRatio"];
    }
    
    if([[NSString stringWithFormat:@"%@",model.a_usage] isEqualToString:@"<null>"]||[[NSString stringWithFormat:@"%@",model.a_usage] isEqualToString:@"(null)"]){
        [dic setObject:@"" forKey:@"usage"];
    }else{
        [dic setObject:[NSString stringWithFormat:@"%@",model.a_usage] forKey:@"usage"];
    }
    
    if([[NSString stringWithFormat:@"%@",model.a_auctionUnit] isEqualToString:@"<null>"] || [[NSString stringWithFormat:@"%@",model.a_auctionUnit] isEqualToString:@"(null)"]){
        [dic setObject:@"" forKey:@"auctionUnit"];
    }else{
        [dic setObject:[NSString stringWithFormat:@"%@",model.a_auctionUnit] forKey:@"auctionUnit"];
    }
    //建立项目
    if([[NSString stringWithFormat:@"%@",model.a_projectId] isEqualToString:@"<null>"] || [[NSString stringWithFormat:@"%@",model.a_projectId] isEqualToString:@"(null)"]){
        [dic setObject:@"" forKey:@"projectID"];
    }else{
        [dic setObject:[NSString stringWithFormat:@"%@",model.a_projectId] forKey:@"projectID"];
    }
    
    if([[NSString stringWithFormat:@"%@",model.a_projectCode] isEqualToString:@"<null>"] || [[NSString stringWithFormat:@"%@",model.a_projectCode] isEqualToString:@"(null)"]){
        [dic setObject:@"" forKey:@"projectCode"];
    }else{
        [dic setObject:[NSString stringWithFormat:@"%@",model.a_projectCode] forKey:@"projectCode"];
    }
    
    if([[NSString stringWithFormat:@"%@",model.a_projectName] isEqualToString:@"<null>"] || [[NSString stringWithFormat:@"%@",model.a_projectName] isEqualToString:@"(null)"]){
        [dic setObject:@"" forKey:@"projectName"];
    }else{
        [dic setObject:[NSString stringWithFormat:@"%@",model.a_projectName] forKey:@"projectName"];
    }
    
    if([[NSString stringWithFormat:@"%@",model.a_projectVersion] isEqualToString:@"<null>"] || [[NSString stringWithFormat:@"%@",model.a_projectVersion] isEqualToString:@"(null)"]){
        [dic setObject:@"" forKey:@"projectVersion"];
    }else{
        [dic setObject:[NSString stringWithFormat:@"%@",model.a_projectVersion] forKey:@"projectVersion"];
    }
    
    if([[NSString stringWithFormat:@"%@",model.a_description] isEqualToString:@"<null>"] ||[[NSString stringWithFormat:@"%@",model.a_description] isEqualToString:@"(null)"]){
        [dic setObject:@"" forKey:@"description"];
    }else{
        [dic setObject:[NSString stringWithFormat:@"%@",model.a_description] forKey:@"description"];
    }
    
    if([[NSString stringWithFormat:@"%@",model.a_owner] isEqualToString:@"<null>"] || [[NSString stringWithFormat:@"%@",model.a_owner] isEqualToString:@"(null)"]){
        [dic setObject:@"" forKey:@"owner"];
    }else{
        [dic setObject:[NSString stringWithFormat:@"%@",model.a_owner] forKey:@"owner"];
    }
    
    if([[NSString stringWithFormat:@"%@",model.a_expectedStartTime] isEqualToString:@"<null>"] || [[NSString stringWithFormat:@"%@",model.a_expectedStartTime] isEqualToString:@"(null)"]){
        [dic setObject:@"" forKey:@"expectedStartTime"];
    }else{
        if([model.a_expectedStartTime length] == 10 || [model.a_expectedStartTime length] == 0){
            [dic setObject:[NSString stringWithFormat:@"%@",model.a_expectedStartTime] forKey:@"expectedStartTime"];
        }else{
            NSString *astr =  [model.a_expectedStartTime stringByReplacingOccurrencesOfString:@"/Date(" withString:@""];
            astr =  [astr stringByReplacingOccurrencesOfString:@"+0800)/" withString:@""];
            if([astr isEqualToString:@"0"]){
                [dic setObject:[NSString stringWithFormat:@"%@",model.a_expectedStartTime] forKey:@"expectedStartTime"];
            }else{
                [dic setObject:[NSString stringWithFormat:@"%@",[model.a_expectedStartTime substringWithRange:NSMakeRange(6,10)]] forKey:@"expectedStartTime"];
            }
        }
    }
    
    if([[NSString stringWithFormat:@"%@",model.a_expectedFinishTime] isEqualToString:@"<null>"] || [[NSString stringWithFormat:@"%@",model.a_expectedFinishTime] isEqualToString:@"(null)"]){
        [dic setObject:@"" forKey:@"expectedFinishTime"];
    }else{
        if([model.a_expectedFinishTime length] == 10 || [model.a_expectedFinishTime length] == 0){
            [dic setObject:[NSString stringWithFormat:@"%@",model.a_expectedFinishTime] forKey:@"expectedFinishTime"];
        }else{
            NSString *astr =  [model.a_expectedFinishTime stringByReplacingOccurrencesOfString:@"/Date(" withString:@""];
            astr =  [astr stringByReplacingOccurrencesOfString:@"+0800)/" withString:@""];
            if([astr isEqualToString:@"0"]){
                NSLog(@"[astr isEqualToString:@0]");
                [dic setObject:[NSString stringWithFormat:@"%@",model.a_expectedFinishTime] forKey:@"expectedFinishTime"];
            }else{
                [dic setObject:[NSString stringWithFormat:@"%@",[model.a_expectedFinishTime substringWithRange:NSMakeRange(6,10)]] forKey:@"expectedFinishTime"];
            }
        }
    }
    
    if([[NSString stringWithFormat:@"%@",model.a_investment] isEqualToString:@"<null>"] || [[NSString stringWithFormat:@"%@",model.a_investment] isEqualToString:@"(null)"]){
        [dic setObject:@"0" forKey:@"investment"];
    }else{
        [dic setObject:[NSString stringWithFormat:@"%@",model.a_investment] forKey:@"investment"];
    }
    
    if([[NSString stringWithFormat:@"%@",model.a_areaOfStructure] isEqualToString:@"<null>"] || [[NSString stringWithFormat:@"%@",model.a_areaOfStructure] isEqualToString:@"(null)"]){
        [dic setObject:@"0" forKey:@"areaOfStructure"];
    }else{
        [dic setObject:[NSString stringWithFormat:@"%@",model.a_areaOfStructure] forKey:@"areaOfStructure"];
    }
    
    if([[NSString stringWithFormat:@"%@",model.a_storeyHeight] isEqualToString:@"<null>"] || [[NSString stringWithFormat:@"%@",model.a_storeyHeight] isEqualToString:@"(null)"]){
        [dic setObject:@"0" forKey:@"storeyHeight"];
    }else{
        [dic setObject:[NSString stringWithFormat:@"%@",model.a_storeyHeight] forKey:@"storeyHeight"];
    }
    
    if([[NSString stringWithFormat:@"%@",model.a_foreignInvestment] isEqualToString:@"<null>"] || [[NSString stringWithFormat:@"%@",model.a_foreignInvestment] isEqualToString:@"(null)"]){
        [dic setObject:@"0" forKey:@"foreignInvestment"];
    }else{
        [dic setObject:[NSString stringWithFormat:@"%@",model.a_foreignInvestment] forKey:@"foreignInvestment"];
    }
    
    if([[NSString stringWithFormat:@"%@",model.a_ownerType] isEqualToString:@"<null>"] || [[NSString stringWithFormat:@"%@",model.a_ownerType] isEqualToString:@"(null)"]){
        [dic setObject:@"" forKey:@"ownerType"];
    }else{
        [dic setObject:[NSString stringWithFormat:@"%@",model.a_ownerType] forKey:@"ownerType"];
    }
    
    if([[NSString stringWithFormat:@"%@",model.a_longitude] isEqualToString:@"<null>"] || [[NSString stringWithFormat:@"%@",model.a_longitude] isEqualToString:@"(null)"]){
        [dic setObject:@"0" forKey:@"longitude"];
    }else{
        [dic setObject:[NSString stringWithFormat:@"%@",model.a_longitude] forKey:@"longitude"];
    }
    
    if([[NSString stringWithFormat:@"%@",model.a_latitude] isEqualToString:@"<null>"] || [[NSString stringWithFormat:@"%@",model.a_latitude] isEqualToString:@"(null)"]){
        [dic setObject:@"0" forKey:@"latitude"];
    }else{
        [dic setObject:[NSString stringWithFormat:@"%@",model.a_latitude] forKey:@"latitude"];
    }
    
    if([[NSString stringWithFormat:@"%@",model.a_mainDesignStage] isEqualToString:@"<null>"] || [[NSString stringWithFormat:@"%@",model.a_mainDesignStage] isEqualToString:@"(null)"]){
        [dic setObject:@"" forKey:@"mainDesignStage"];
    }else{
        [dic setObject:[NSString stringWithFormat:@"%@",model.a_mainDesignStage] forKey:@"mainDesignStage"];
    }
    
    if([[NSString stringWithFormat:@"%@",model.a_propertyElevator] isEqualToString:@"<null>"] || [[NSString stringWithFormat:@"%@",model.a_propertyElevator] isEqualToString:@"(null)"]){
        [dic setObject:@"0" forKey:@"propertyElevator"];
    }else{
        [dic setObject:[NSString stringWithFormat:@"%@",model.a_propertyElevator] forKey:@"propertyElevator"];
    }
    
    if([[NSString stringWithFormat:@"%@",model.a_propertyAirCondition] isEqualToString:@"<null>"] || [[NSString stringWithFormat:@"%@",model.a_propertyAirCondition] isEqualToString:@"(null)"]){
        [dic setObject:@"0" forKey:@"propertyAirCondition"];
    }else{
        [dic setObject:[NSString stringWithFormat:@"%@",model.a_propertyAirCondition] forKey:@"propertyAirCondition"];
    }
    
    if([[NSString stringWithFormat:@"%@",model.a_propertyHeating] isEqualToString:@"<null>"] || [[NSString stringWithFormat:@"%@",model.a_propertyHeating] isEqualToString:@"(null)"]){
        [dic setObject:@"0" forKey:@"propertyHeating"];
    }else{
        [dic setObject:[NSString stringWithFormat:@"%@",model.a_propertyHeating] forKey:@"propertyHeating"];
    }
    
    if([[NSString stringWithFormat:@"%@",model.a_propertyExternalWallMeterial] isEqualToString:@"<null>"] || [[NSString stringWithFormat:@"%@",model.a_propertyExternalWallMeterial] isEqualToString:@"(null)"]){
        [dic setObject:@"0" forKey:@"propertyExternalWallMeterial"];
    }else{
        [dic setObject:[NSString stringWithFormat:@"%@",model.a_propertyExternalWallMeterial] forKey:@"propertyExternalWallMeterial"];
    }
    
    if([[NSString stringWithFormat:@"%@",model.a_propertyStealStructure] isEqualToString:@"<null>"] || [[NSString stringWithFormat:@"%@",model.a_propertyStealStructure] isEqualToString:@"(null)"]){
        [dic setObject:@"0" forKey:@"propertyStealStructure"];
    }else{
        [dic setObject:[NSString stringWithFormat:@"%@",model.a_propertyStealStructure] forKey:@"propertyStealStructure"];
    }
    
    if([[NSString stringWithFormat:@"%@",model.a_actualStartTime] isEqualToString:@"<null>"] || [[NSString stringWithFormat:@"%@",model.a_actualStartTime] isEqualToString:@"(null)"]){
        [dic setObject:@"" forKey:@"actualStartTime"];
    }else{
        if([model.a_actualStartTime length] == 10 || [model.a_actualStartTime length] == 0){
            [dic setObject:[NSString stringWithFormat:@"%@",model.a_actualStartTime] forKey:@"actualStartTime"];
        }else{
            NSString *astr =  [model.a_actualStartTime stringByReplacingOccurrencesOfString:@"/Date(" withString:@""];
            astr =  [astr stringByReplacingOccurrencesOfString:@"+0800)/" withString:@""];
            if([astr isEqualToString:@"0"]){
                [dic setObject:[NSString stringWithFormat:@"%@",model.a_actualStartTime] forKey:@"actualStartTime"];
            }else{
                [dic setObject:[NSString stringWithFormat:@"%@",[model.a_actualStartTime substringWithRange:NSMakeRange(6,10)]] forKey:@"actualStartTime"];
            }
        }
    }
    
    if([[NSString stringWithFormat:@"%@",model.a_fireControl] isEqualToString:@"<null>"] || [[NSString stringWithFormat:@"%@",model.a_fireControl] isEqualToString:@"(null)"]){
        [dic setObject:@"" forKey:@"fireControl"];
    }else{
        [dic setObject:[NSString stringWithFormat:@"%@",model.a_fireControl] forKey:@"fireControl"];
    }
    
    if([[NSString stringWithFormat:@"%@",model.a_green] isEqualToString:@"<null>"] || [[NSString stringWithFormat:@"%@",model.a_green] isEqualToString:@"(null)"]){
        [dic setObject:@"" forKey:@"green"];
    }else{
        [dic setObject:[NSString stringWithFormat:@"%@",model.a_green] forKey:@"green"];
    }
    
    if([[NSString stringWithFormat:@"%@",model.a_electroweakInstallation] isEqualToString:@"<null>"] || [[NSString stringWithFormat:@"%@",model.a_electroweakInstallation] isEqualToString:@"(null)"]){
        [dic setObject:@"" forKey:@"electroweakInstallation"];
    }else{
        [dic setObject:[NSString stringWithFormat:@"%@",model.a_electroweakInstallation] forKey:@"electroweakInstallation"];
    }
    
    if([[NSString stringWithFormat:@"%@",model.a_decorationSituation] isEqualToString:@"<null>"] || [[NSString stringWithFormat:@"%@",model.a_decorationSituation] isEqualToString:@"(null)"]){
        [dic setObject:@"" forKey:@"decorationSituation"];
    }else{
        [dic setObject:[NSString stringWithFormat:@"%@",model.a_decorationSituation] forKey:@"decorationSituation"];
    }
    
    if([[NSString stringWithFormat:@"%@",model.a_decorationProgress] isEqualToString:@"<null>"] || [[NSString stringWithFormat:@"%@",model.a_decorationProgress] isEqualToString:@"(null)"]){
        [dic setObject:@"" forKey:@"decorationProgress"];
    }else{
        [dic setObject:[NSString stringWithFormat:@"%@",model.a_decorationProgress] forKey:@"decorationProgress"];
    }
    
    if([[NSString stringWithFormat:@"%@",model.a_url] isEqualToString:@"<null>"] || [[NSString stringWithFormat:@"%@",model.a_url] isEqualToString:@"(null)"]){
        [dic setObject:@"" forKey:@"url"];
    }else{
        [dic setObject:[NSString stringWithFormat:@"%@",model.a_url] forKey:@"url"];
    }
    return dic;
}

+(NSMutableDictionary *)JudgmentContactStr:(ContactModel *)model{
    NSMutableDictionary *contactDic = [[NSMutableDictionary alloc] init];
    //[contactDic setValue:model.a_localProjectId forKey:@"localProjectId"];
    if([[NSString stringWithFormat:@"%@",model.a_id] isEqualToString:@"<null>"] || [[NSString stringWithFormat:@"%@",model.a_id] isEqualToString:@"(null)"]){
        [contactDic setObject:@"" forKey:@"id"];
    }else{
        [contactDic setObject:[NSString stringWithFormat:@"%@",model.a_id] forKey:@"id"];
    }
    if([[NSString stringWithFormat:@"%@",model.a_contactName] isEqualToString:@"<null>"] || [[NSString stringWithFormat:@"%@",model.a_contactName] isEqualToString:@"(null)"]){
        [contactDic setObject:@"" forKey:@"contactName"];
    }else{
        [contactDic setObject:[NSString stringWithFormat:@"%@",model.a_contactName] forKey:@"contactName"];
    }
    
    if([[NSString stringWithFormat:@"%@",model.a_mobilePhone] isEqualToString:@"<null>"] || [[NSString stringWithFormat:@"%@",model.a_mobilePhone] isEqualToString:@"(null)"]){
        [contactDic setObject:@"" forKey:@"mobilePhone"];
    }else{
        [contactDic setObject:[NSString stringWithFormat:@"%@",model.a_mobilePhone] forKey:@"mobilePhone"];
    }
    
    if([[NSString stringWithFormat:@"%@",model.a_duties] isEqualToString:@"<null>"] || [[NSString stringWithFormat:@"%@",model.a_duties] isEqualToString:@"(null)"]){
        [contactDic setObject:@"" forKey:@"duties"];
    }else{
        [contactDic setObject:[NSString stringWithFormat:@"%@",model.a_duties] forKey:@"duties"];
    }
    
    if([[NSString stringWithFormat:@"%@",model.a_accountName] isEqualToString:@"<null>"] || [[NSString stringWithFormat:@"%@",model.a_accountName] isEqualToString:@"(null)"]){
        [contactDic setObject:@"" forKey:@"accountName"];
    }else{
        [contactDic setObject:[NSString stringWithFormat:@"%@",model.a_accountName] forKey:@"accountName"];
    }
    
    if([[NSString stringWithFormat:@"%@",model.a_accountAddress] isEqualToString:@"<null>"] || [[NSString stringWithFormat:@"%@",model.a_accountAddress] isEqualToString:@"(null)"]){
        [contactDic setObject:@"" forKey:@"accountAddress"];
    }else{
        [contactDic setObject:[NSString stringWithFormat:@"%@",model.a_accountAddress] forKey:@"accountAddress"];
    }
    
    if([[NSString stringWithFormat:@"%@",model.a_projectId] isEqualToString:@"<null>"] || [[NSString stringWithFormat:@"%@",model.a_projectId] isEqualToString:@"(null)"]){
        [contactDic setObject:@"" forKey:@"projectID"];
    }else{
        [contactDic setObject:[NSString stringWithFormat:@"%@",model.a_projectId] forKey:@"projectID"];
    }
    
    if([[NSString stringWithFormat:@"%@",model.a_projectName] isEqualToString:@"<null>"] || [[NSString stringWithFormat:@"%@",model.a_projectName] isEqualToString:@"(null)"]){
        [contactDic setObject:@"" forKey:@"projectName"];
    }else{
        [contactDic setObject:[NSString stringWithFormat:@"%@",model.a_projectName] forKey:@"projectName"];
    }
    
    if([[NSString stringWithFormat:@"%@",model.a_baseContactID] isEqualToString:@"<null>"] || [[NSString stringWithFormat:@"%@",model.a_baseContactID] isEqualToString:@"(null)"]){
        [contactDic setObject:@"" forKey:@"baseContactID"];
    }else{
        [contactDic setObject:[NSString stringWithFormat:@"%@",model.a_baseContactID] forKey:@"baseContactID"];
    }
    
    if([[NSString stringWithFormat:@"%@",model.a_localProjectId] isEqualToString:@"<null>"] || [[NSString stringWithFormat:@"%@",model.a_localProjectId] isEqualToString:@"(null)"]){
        [contactDic setObject:@"" forKey:@"localProjectId"];
    }else{
        [contactDic setObject:[NSString stringWithFormat:@"%@",model.a_localProjectId] forKey:@"localProjectId"];
    }
    
    if([[NSString stringWithFormat:@"%@",model.a_category] isEqualToString:@"<null>"] || [[NSString stringWithFormat:@"%@",model.a_category] isEqualToString:@"(null)"]){
        [contactDic setObject:@"" forKey:@"category"];
    }else{
        [contactDic setObject:[NSString stringWithFormat:@"%@",model.a_category] forKey:@"category"];
    }
    
    if([[NSString stringWithFormat:@"%@",model.a_url] isEqualToString:@"<null>"] || [[NSString stringWithFormat:@"%@",model.a_url] isEqualToString:@"(null)"]){
        [contactDic setObject:@"" forKey:@"url"];
    }else{
        [contactDic setObject:[NSString stringWithFormat:@"%@",model.a_url] forKey:@"url"];
    }
    return contactDic;
}


+(NSMutableDictionary *)JudgmentUpdataProjectStr:(NSMutableDictionary *)oldDic newDic:(NSMutableDictionary *)newDic{
    //NSLog(@"%@",newDic);
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:[newDic objectForKey:@"id"] forKey:@"id"];
    //土地规划/拍卖
    if([[newDic objectForKey:@"landName"] isEqualToString:@""]){
        [dic setObject:[oldDic objectForKey:@"landName"] forKey:@"landName"];
    }else{
        [dic setObject:[newDic objectForKey:@"landName"] forKey:@"landName"];
    }
    
    if([[newDic objectForKey:@"district"] isEqualToString:@""]){
        [dic setObject:[oldDic objectForKey:@"district"] forKey:@"district"];
    }else{
        [dic setObject:[newDic objectForKey:@"district"] forKey:@"district"];
    }
    
    if([[newDic objectForKey:@"province"] isEqualToString:@""]){
        [dic setObject:[oldDic objectForKey:@"province"] forKey:@"province"];
    }else{
        [dic setObject:[newDic objectForKey:@"province"] forKey:@"province"];
    }
    
    if([[newDic objectForKey:@"landAddress"] isEqualToString:@""]){
        [dic setObject:[oldDic objectForKey:@"landAddress"] forKey:@"landAddress"];
    }else{
        [dic setObject:[newDic objectForKey:@"landAddress"] forKey:@"landAddress"];
    }
    
    if([[newDic objectForKey:@"city"] isEqualToString:@""]){
        [dic setObject:[oldDic objectForKey:@"city"] forKey:@"city"];
    }else{
        [dic setObject:[newDic objectForKey:@"city"] forKey:@"city"];
    }
    
    if([[newDic objectForKey:@"area"] isEqualToString:@""]){
        [dic setObject:[oldDic objectForKey:@"area"] forKey:@"area"];
    }else{
        [dic setObject:[newDic objectForKey:@"area"] forKey:@"area"];
    }
    
    if([[newDic objectForKey:@"plotRatio"] isEqualToString:@""]){
        [dic setObject:[oldDic objectForKey:@"plotRatio"] forKey:@"plotRatio"];
    }else{
        [dic setObject:[newDic objectForKey:@"plotRatio"] forKey:@"plotRatio"];
    }
    
    if([[newDic objectForKey:@"usage"] isEqualToString:@""]){
        [dic setObject:[oldDic objectForKey:@"usage"] forKey:@"usage"];
    }else{
        [dic setObject:[newDic objectForKey:@"usage"] forKey:@"usage"];
    }
    
    if([[newDic objectForKey:@"auctionUnit"] isEqualToString:@""]){
        [dic setObject:[oldDic objectForKey:@"auctionUnit"] forKey:@"auctionUnit"];
    }else{
        [dic setObject:[newDic objectForKey:@"auctionUnit"] forKey:@"auctionUnit"];
    }
    
    //建立项目
    if([[newDic objectForKey:@"projectID"] isEqualToString:@""]){
        [dic setObject:[oldDic objectForKey:@"projectID"] forKey:@"projectID"];
    }else{
        [dic setObject:[newDic objectForKey:@"projectID"] forKey:@"projectID"];
    }
    
    if([[newDic objectForKey:@"projectCode"] isEqualToString:@""]){
        [dic setObject:[oldDic objectForKey:@"projectCode"] forKey:@"projectCode"];
    }else{
        [dic setObject:[newDic objectForKey:@"projectCode"] forKey:@"projectCode"];
    }
    
    if([[newDic objectForKey:@"projectName"] isEqualToString:@""]){
        [dic setObject:[oldDic objectForKey:@"projectName"] forKey:@"projectName"];
    }else{
        [dic setObject:[newDic objectForKey:@"projectName"] forKey:@"projectName"];
    }
    
    if([[newDic objectForKey:@"projectVersion"] isEqualToString:@""]){
        [dic setObject:[oldDic objectForKey:@"projectVersion"] forKey:@"projectVersion"];
    }else{
        [dic setObject:[newDic objectForKey:@"projectVersion"] forKey:@"projectVersion"];
    }
    
    if([[newDic objectForKey:@"description"] isEqualToString:@""]){
        [dic setObject:[oldDic objectForKey:@"description"] forKey:@"description"];
    }else{
        [dic setObject:[newDic objectForKey:@"description"] forKey:@"description"];
    }
    
    if([[newDic objectForKey:@"owner"] isEqualToString:@""]){
        [dic setObject:[oldDic objectForKey:@"owner"] forKey:@"owner"];
    }else{
        [dic setObject:[newDic objectForKey:@"owner"] forKey:@"owner"];
    }
    
    if([[newDic objectForKey:@"expectedStartTime"] isEqualToString:@""]||[[NSString stringWithFormat:@"%@",[newDic objectForKey:@"expectedStartTime"]] isEqualToString:@"<null>"] || [[NSString stringWithFormat:@"%@",[newDic objectForKey:@"expectedStartTime"]] isEqualToString:@"(null)"]){
        if([[oldDic objectForKey:@"expectedStartTime"] isEqualToString:@""]||[[NSString stringWithFormat:@"%@",[oldDic objectForKey:@"expectedStartTime"]] isEqualToString:@"<null>"] || [[NSString stringWithFormat:@"%@",[oldDic objectForKey:@"expectedStartTime"]] isEqualToString:@"(null)"]){
            [dic setObject:@"" forKey:@"expectedStartTime"];
        }else{
            if([[oldDic objectForKey:@"expectedStartTime"] length] == 10 || [[oldDic objectForKey:@"expectedStartTime"] length] == 0){
                NSLog(@"%@",[oldDic objectForKey:@"expectedStartTime"]);
                [dic setObject:[oldDic objectForKey:@"expectedStartTime"] forKey:@"expectedStartTime"];
            }else{
                NSString *astr =  [[oldDic objectForKey:@"expectedStartTime"] stringByReplacingOccurrencesOfString:@"/Date(" withString:@""];
                astr =  [astr stringByReplacingOccurrencesOfString:@"+0800)/" withString:@""];
                if([astr isEqualToString:@"0"]){
                    NSLog(@"asdfasdfasdf");
                    [dic setObject:[NSString stringWithFormat:@"%@",astr] forKey:@"expectedStartTime"];
                }else{
                    [dic setObject:[NSString stringWithFormat:@"%@",[[oldDic objectForKey:@"expectedStartTime"] substringWithRange:NSMakeRange(6,10)]] forKey:@"expectedStartTime"];
                }
            }
        }
    }else{
        [dic setObject:[newDic objectForKey:@"expectedStartTime"] forKey:@"expectedStartTime"];
    }
    
    if([[newDic objectForKey:@"expectedFinishTime"] isEqualToString:@""]||[[NSString stringWithFormat:@"%@",[newDic objectForKey:@"expectedFinishTime"]] isEqualToString:@"<null>"] || [[NSString stringWithFormat:@"%@",[newDic objectForKey:@"expectedFinishTime"]] isEqualToString:@"(null)"]){
        if([[oldDic objectForKey:@"expectedFinishTime"] isEqualToString:@""]||[[NSString stringWithFormat:@"%@",[oldDic objectForKey:@"expectedFinishTime"]] isEqualToString:@"<null>"] || [[NSString stringWithFormat:@"%@",[oldDic objectForKey:@"expectedFinishTime"]] isEqualToString:@"(null)"]){
            [dic setObject:@"" forKey:@"expectedFinishTime"];
        }else{
            if([[oldDic objectForKey:@"expectedFinishTime"] length] == 10 || [[oldDic objectForKey:@"expectedFinishTime"] length] == 0){
                NSLog(@"%@",[oldDic objectForKey:@"expectedFinishTime"]);
                [dic setObject:[oldDic objectForKey:@"expectedFinishTime"] forKey:@"expectedFinishTime"];
            }else{
                NSString *astr =  [[oldDic objectForKey:@"expectedFinishTime"] stringByReplacingOccurrencesOfString:@"/Date(" withString:@""];
                astr =  [astr stringByReplacingOccurrencesOfString:@"+0800)/" withString:@""];
                if([astr isEqualToString:@"0"]){
                    [dic setObject:[NSString stringWithFormat:@"%@",astr] forKey:@"expectedFinishTime"];
                }else{
                    [dic setObject:[NSString stringWithFormat:@"%@",[[oldDic objectForKey:@"expectedFinishTime"] substringWithRange:NSMakeRange(6,10)]] forKey:@"expectedFinishTime"];
                }
            }
        }
    }else{
        [dic setObject:[newDic objectForKey:@"expectedFinishTime"] forKey:@"expectedFinishTime"];
    }
    
    if([[newDic objectForKey:@"investment"] isEqualToString:@""]){
        [dic setObject:[oldDic objectForKey:@"investment"] forKey:@"investment"];
    }else{
        [dic setObject:[newDic objectForKey:@"investment"] forKey:@"investment"];
    }
    
    if([[newDic objectForKey:@"areaOfStructure"] isEqualToString:@""]){
        [dic setObject:[oldDic objectForKey:@"areaOfStructure"] forKey:@"areaOfStructure"];
    }else{
        [dic setObject:[newDic objectForKey:@"areaOfStructure"] forKey:@"areaOfStructure"];
    }
    
    if([[newDic objectForKey:@"storeyHeight"] isEqualToString:@""]){
        [dic setObject:[oldDic objectForKey:@"storeyHeight"] forKey:@"storeyHeight"];
    }else{
        [dic setObject:[newDic objectForKey:@"storeyHeight"] forKey:@"storeyHeight"];
    }
    
    if([[newDic objectForKey:@"foreignInvestment"] isEqualToString:@""]){
        [dic setObject:[oldDic objectForKey:@"foreignInvestment"] forKey:@"foreignInvestment"];
    }else{
        [dic setObject:[newDic objectForKey:@"foreignInvestment"] forKey:@"foreignInvestment"];
    }
    
    if([[newDic objectForKey:@"ownerType"] isEqualToString:@""]){
        [dic setObject:[oldDic objectForKey:@"ownerType"] forKey:@"ownerType"];
    }else{
        [dic setObject:[newDic objectForKey:@"ownerType"] forKey:@"ownerType"];
    }
    
    if([[newDic objectForKey:@"longitude"] isEqualToString:@""]){
        [dic setObject:[oldDic objectForKey:@"longitude"] forKey:@"longitude"];
    }else{
        [dic setObject:[newDic objectForKey:@"longitude"] forKey:@"longitude"];
    }
    
    if([[newDic objectForKey:@"latitude"] isEqualToString:@""]){
        [dic setObject:[oldDic objectForKey:@"latitude"] forKey:@"latitude"];
    }else{
        [dic setObject:[newDic objectForKey:@"latitude"] forKey:@"latitude"];
    }
    
    if([[newDic objectForKey:@"mainDesignStage"] isEqualToString:@""]){
        [dic setObject:[oldDic objectForKey:@"mainDesignStage"] forKey:@"mainDesignStage"];
    }else{
        [dic setObject:[newDic objectForKey:@"mainDesignStage"] forKey:@"mainDesignStage"];
    }

    if([[newDic objectForKey:@"propertyElevator"] isEqualToString:@""]){
        [dic setObject:[oldDic objectForKey:@"propertyElevator"] forKey:@"propertyElevator"];
    }else{
        [dic setObject:[newDic objectForKey:@"propertyElevator"] forKey:@"propertyElevator"];
    }
    
    if([[newDic objectForKey:@"propertyAirCondition"] isEqualToString:@""]){
        [dic setObject:[oldDic objectForKey:@"propertyAirCondition"] forKey:@"propertyAirCondition"];
    }else{
        [dic setObject:[newDic objectForKey:@"propertyAirCondition"] forKey:@"propertyAirCondition"];
    }
    
    if([[newDic objectForKey:@"propertyHeating"] isEqualToString:@""]){
        [dic setObject:[oldDic objectForKey:@"propertyHeating"] forKey:@"propertyHeating"];
    }else{
        [dic setObject:[newDic objectForKey:@"propertyHeating"] forKey:@"propertyHeating"];
    }
    
    if([[newDic objectForKey:@"propertyExternalWallMeterial"] isEqualToString:@""]){
        [dic setObject:[oldDic objectForKey:@"propertyExternalWallMeterial"] forKey:@"propertyExternalWallMeterial"];
    }else{
        [dic setObject:[newDic objectForKey:@"propertyExternalWallMeterial"] forKey:@"propertyExternalWallMeterial"];
    }
    
    if([[newDic objectForKey:@"propertyStealStructure"] isEqualToString:@""]){
        [dic setObject:[oldDic objectForKey:@"propertyStealStructure"] forKey:@"propertyStealStructure"];
    }else{
        [dic setObject:[newDic objectForKey:@"propertyStealStructure"] forKey:@"propertyStealStructure"];
    }
    
    if([[newDic objectForKey:@"actualStartTime"] isEqualToString:@""]||[[NSString stringWithFormat:@"%@",[newDic objectForKey:@"actualStartTime"]] isEqualToString:@"<null>"] || [[NSString stringWithFormat:@"%@",[newDic objectForKey:@"actualStartTime"]] isEqualToString:@"(null)"]){
        if([[oldDic objectForKey:@"actualStartTime"] isEqualToString:@""]||[[NSString stringWithFormat:@"%@",[oldDic objectForKey:@"actualStartTime"]] isEqualToString:@"<null>"] || [[NSString stringWithFormat:@"%@",[oldDic objectForKey:@"actualStartTime"]] isEqualToString:@"(null)"]){
            [dic setObject:@"" forKey:@"actualStartTime"];
        }else{
            if([[oldDic objectForKey:@"actualStartTime"] length] == 10 || [[oldDic objectForKey:@"actualStartTime"] length] == 0){
                NSLog(@"%@",[oldDic objectForKey:@"actualStartTime"]);
                [dic setObject:[oldDic objectForKey:@"actualStartTime"] forKey:@"actualStartTime"];
            }else{
                NSString *astr =  [[oldDic objectForKey:@"actualStartTime"] stringByReplacingOccurrencesOfString:@"/Date(" withString:@""];
                astr =  [astr stringByReplacingOccurrencesOfString:@"+0800)/" withString:@""];
                if([astr isEqualToString:@"0"]){
                    [dic setObject:[NSString stringWithFormat:@"%@",astr] forKey:@"actualStartTime"];
                }else{
                    [dic setObject:[NSString stringWithFormat:@"%@",[[oldDic objectForKey:@"actualStartTime"] substringWithRange:NSMakeRange(6,10)]] forKey:@"actualStartTime"];
                }
            }
        }
    }else{
        [dic setObject:[newDic objectForKey:@"actualStartTime"] forKey:@"actualStartTime"];
    }
    
    if([[newDic objectForKey:@"fireControl"] isEqualToString:@""]){
        [dic setObject:[oldDic objectForKey:@"fireControl"] forKey:@"fireControl"];
    }else{
        [dic setObject:[newDic objectForKey:@"fireControl"] forKey:@"fireControl"];
    }
    
    if([[newDic objectForKey:@"green"] isEqualToString:@""]){
        [dic setObject:[oldDic objectForKey:@"green"] forKey:@"green"];
    }else{
        [dic setObject:[newDic objectForKey:@"green"] forKey:@"green"];
    }
    
    if([[newDic objectForKey:@"electroweakInstallation"] isEqualToString:@""]){
        [dic setObject:[oldDic objectForKey:@"electroweakInstallation"] forKey:@"electroweakInstallation"];
    }else{
        [dic setObject:[newDic objectForKey:@"electroweakInstallation"] forKey:@"electroweakInstallation"];
    }
    
    if([[newDic objectForKey:@"decorationSituation"] isEqualToString:@""]){
        [dic setObject:[oldDic objectForKey:@"decorationSituation"] forKey:@"decorationSituation"];
    }else{
        [dic setObject:[newDic objectForKey:@"decorationSituation"] forKey:@"decorationSituation"];
    }
    
    if([[newDic objectForKey:@"decorationProgress"] isEqualToString:@""]){
        [dic setObject:[oldDic objectForKey:@"decorationProgress"] forKey:@"decorationProgress"];
    }else{
        [dic setObject:[newDic objectForKey:@"decorationProgress"] forKey:@"decorationProgress"];
    }
    
    if([[newDic objectForKey:@"url"] isEqualToString:@""]){
        [dic setObject:[oldDic objectForKey:@"url"] forKey:@"url"];
    }else{
        [dic setObject:[newDic objectForKey:@"url"] forKey:@"url"];
    }
    return dic;
}

+(NSString *)JudgmentProjectStage:(NSMutableDictionary *)dic{
    //NSLog(@"%@",dic);
    NSString *stage = [[NSString alloc] init];
    if(![[dic objectForKey:@"landName"] isEqualToString:@""] ||
       ![[dic objectForKey:@"district"] isEqualToString:@""] ||
       ![[dic objectForKey:@"province"] isEqualToString:@""] ||
       ![[dic objectForKey:@"landAddress"] isEqualToString:@""] ||
       ![[dic objectForKey:@"city"] isEqualToString:@""] ||
       ![[dic objectForKey:@"area"] isEqualToString:@""] ||
       ![[dic objectForKey:@"plotRatio"] isEqualToString:@""] ||
       ![[dic objectForKey:@"usage"] isEqualToString:@""] ||
       ![[dic objectForKey:@"auctionUnit"] isEqualToString:@""] ||
       ![[dic objectForKey:@"projectName"] isEqualToString:@""] ||
       ![[dic objectForKey:@"description"] isEqualToString:@""] ||
       ![[dic objectForKey:@"expectedStartTime"] isEqualToString:@""] ||
       ![[dic objectForKey:@"investment"] isEqualToString:@""] ||
       ![[dic objectForKey:@"areaOfStructure"] isEqualToString:@""] ||
       ![[dic objectForKey:@"storeyHeight"] isEqualToString:@""] ||
       ![[dic objectForKey:@"foreignInvestment"] isEqualToString:@""] ||
       ![[dic objectForKey:@"ownerType"] isEqualToString:@""] ){
        stage = @"1";
    }
    
    if(![[dic objectForKey:@"mainDesignStage"] isEqualToString:@""] ||
       ![[dic objectForKey:@"propertyElevator"] isEqualToString:@"0"] ||
       ![[dic objectForKey:@"propertyAirCondition"] isEqualToString:@"0"] ||
       ![[dic objectForKey:@"expectedFinishTime"] isEqualToString:@""] ||
       ![[dic objectForKey:@"propertyHeating"] isEqualToString:@"0"] ||
       ![[dic objectForKey:@"propertyExternalWallMeterial"] isEqualToString:@"0"] ||
       ![[dic objectForKey:@"propertyStealStructure"] isEqualToString:@"0"] ){
        stage = @"2";
    }
    
    if(![[dic objectForKey:@"actualStartTime"] isEqualToString:@""] ||
       ![[dic objectForKey:@"fireControl"] isEqualToString:@""] ||
       ![[dic objectForKey:@"green"] isEqualToString:@""] ){
        stage = @"3";
    }
    
    if(![[dic objectForKey:@"electroweakInstallation"] isEqualToString:@""] ||
       ![[dic objectForKey:@"decorationSituation"] isEqualToString:@""] ||
       ![[dic objectForKey:@"decorationProgress"] isEqualToString:@""] ){
        stage = @"4";
    }
    
    return stage;
}
@end
