//
//  ModificationViewController.h
//  ZpzchinaMobile
//
//  Created by 孙元侃 on 14-8-14.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "BaseViewController.h"

@interface ModificationViewController : BaseViewController
@property(nonatomic,strong)NSMutableDictionary* dataDic;//新建用字典
@property(nonatomic,strong)NSMutableDictionary* singleDic;//修改用字典
-(instancetype)initWithSingle:(NSMutableDictionary*)singleDic contacts:(NSArray*)contacts;
@end
