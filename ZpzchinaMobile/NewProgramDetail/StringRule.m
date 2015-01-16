//
//  StringRule.m
//  ZpzchinaMobile
//
//  Created by 孙元侃 on 15/1/14.
//  Copyright (c) 2015年 汪洋. All rights reserved.
//

#import "StringRule.h"
#import "ProgramDetailViewController.h"
@implementation StringRule
+ (NSString *)hasContent:(NSString *)string//判断是否为空，空则返回-
{
    return [string isEqualToString:@""]?Heng:string;
}

+ (NSString *)isZero:(NSString *)string//判断是否为0，0则返回-
{
    return [string isEqualToString:@"0"]?Heng:string;
}

+ (NSString*)hasAreaName:(NSString*)string//判断是否为空，空则返回地块名称
{
    return [string isEqualToString:@""]?@"地块名称":string;
}

+ (NSString*)hasAreaPart:(NSString*)string//判断是否为空，空则返回地块区域
{
    return [string isEqualToString:@""]?@"地块区域":string;
}

+ (NSString*)hasAreaAddress:(NSString*)string//判断是否为空，空则返回地块地址
{
    return [string isEqualToString:@""]?@"地块地址":string;
}

+ (NSString*)hasProgramName:(NSString*)string//判断是否为空，空则返回项目名称
{
    return [string isEqualToString:@""]?@"项目名称":string;
}

+ (NSString*)hasProgramAddress:(NSString*)string//判断是否为空，空则返回项目地址
{
    return [string isEqualToString:@""]?@"项目地址":string;
}

+ (NSString*)hasProgramDescribe:(NSString*)string//判断是否为空，空则返回项目描述
{
    return [string isEqualToString:@""]?@"项目描述":string;
}

+ (NSString*)hasUserTypeContent:(NSString*)string//判断是否为空，空则返回业主类型
{
    return [string isEqualToString:@""]?@"业主类型":string;
}
@end
