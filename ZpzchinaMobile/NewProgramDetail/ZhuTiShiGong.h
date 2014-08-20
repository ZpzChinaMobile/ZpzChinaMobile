//
//  ZhuTiShiGong.h
//  programDetail
//
//  Created by 孙元侃 on 14-8-7.
//  Copyright (c) 2014年 sunyk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProgramDetailViewController.h"

@interface ZhuTiShiGong : NSObject
+(UIView*)zhuTiShiGongWithFirstViewHeight:(CGFloat*)firstViewHeight secondView:(CGFloat*)secondViewHeight thirdViewHeight:(CGFloat*)thirdViewHeight delegate:(ProgramDetailViewController*)delegate;
+(void)myDealloc;
@end
