//
//  TuDiXinXi.h
//  programDetail
//
//  Created by 孙元侃 on 14-8-7.
//  Copyright (c) 2014年 sunyk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProgramDetailViewController.h"
@interface TuDiXinXi : UIView
+(TuDiXinXi*)tuDiXinXiWithFirstViewHeight:(CGFloat*)firstViewHeight delegate:(ProgramDetailViewController*)delegate;
+(void)myDealloc;
@end
