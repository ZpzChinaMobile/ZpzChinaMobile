//
//  UpdataPassWordEvent.h
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-10-10.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UpdataPassWordEvent : NSObject
+ (NSURLSessionDataTask *)PutUserWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block dataDic:(NSMutableDictionary *)dataDic;
@end
