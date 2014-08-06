//
//  ProjectLogSqlite.h
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-7-3.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProjectLogSqlite : NSObject
+(void)opensql;
+(void)dropTable;
+(void)delAll;
@end
