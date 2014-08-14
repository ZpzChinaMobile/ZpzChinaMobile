//
//  SixTableViewController.h
//  ZpzchinaMobile
//
//  Created by 孙元侃 on 14-8-14.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SixTableViewController : UITableViewController
@property(nonatomic,strong)NSArray* images;
@property(nonatomic,strong)NSMutableDictionary* dataDic;//新建用字典
@property(nonatomic,strong)NSMutableDictionary* singleDic;//修改用字典
@property(nonatomic,strong)NSMutableArray* contacts;

-(instancetype)initWithSingle:(NSMutableDictionary*)singleDic dataDic:(NSMutableDictionary*)dataDic contacts:(NSMutableArray*)contacts;
@end
