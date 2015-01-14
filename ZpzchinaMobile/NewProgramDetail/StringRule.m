//
//  StringRule.m
//  ZpzchinaMobile
//
//  Created by 孙元侃 on 15/1/14.
//  Copyright (c) 2015年 汪洋. All rights reserved.
//

#import "StringRule.h"

@implementation StringRule
+ (NSString *)hasContent:(NSString *)string{
    return [string isEqualToString:@""]?@"－":string;
}
@end
