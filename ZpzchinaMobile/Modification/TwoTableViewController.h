//
//  TwoTableViewController.h
//  ZpzchinaMobile
//
//  Created by 孙元侃 on 14-8-14.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TwoTableViewController : UITableViewController
@property(nonatomic,strong)NSMutableDictionary* dataDic;//新建用字典
@property(nonatomic,strong)NSMutableDictionary* singleDic;//修改用字典
@property(nonatomic,strong)NSMutableArray* contacts;
@property(nonatomic)NSInteger fromView;//判断是新建还是修改 新建是0 修改是1
@property(nonatomic)NSInteger timeflag;

@property(nonatomic,strong)UIViewController* bgVC;

-(instancetype)initWithSingle:(NSMutableDictionary*)singleDic dataDic:(NSMutableDictionary*)dataDic contacts:(NSMutableArray*)contacts images:(NSMutableArray*)images;
@end
