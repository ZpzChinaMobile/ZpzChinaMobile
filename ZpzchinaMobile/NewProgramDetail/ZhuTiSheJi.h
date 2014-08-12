//
//  ZhuTiSheJi.h
//  programDetail
//
//  Created by 孙元侃 on 14-8-7.
//  Copyright (c) 2014年 sunyk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProgramDetailViewController.h"
@interface ZhuTiSheJi : NSObject
+(UIView*)zhuTiSheJiWithFirstViewHeight:(CGFloat*)firstViewHeight secondView:(CGFloat*)secondViewHeight delegate:(ProgramDetailViewController*)delegate;
@end
