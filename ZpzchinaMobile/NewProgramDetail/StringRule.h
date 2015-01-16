//
//  StringRule.h
//  ZpzchinaMobile
//
//  Created by 孙元侃 on 15/1/14.
//  Copyright (c) 2015年 汪洋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StringRule : NSObject
+ (NSString*)hasContent:(NSString*)string;//判断是否为空，空则返回-
+ (NSString*)isZero:(NSString*)string;//判断是否为0，0则返回-
+ (NSString*)hasAreaName:(NSString*)string;//判断是否为空，空则返回地块名称
+ (NSString*)hasAreaPart:(NSString*)string;//判断是否为空，空则返回地块区域
+ (NSString*)hasAreaAddress:(NSString*)string;//判断是否为空，空则返回地块地址
+ (NSString*)hasProgramName:(NSString*)string;//判断是否为空，空则返回项目名称
+ (NSString*)hasProgramAddress:(NSString*)string;//判断是否为空，空则返回项目地址
+ (NSString*)hasProgramDescribe:(NSString*)string;//判断是否为空，空则返回项目描述
+ (NSString*)hasUserTypeContent:(NSString*)string;//判断是否为空，空则返回业主类型
@end
