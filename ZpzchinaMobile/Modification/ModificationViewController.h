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

@property(nonatomic,strong)NSMutableArray* horizonImageArr;
@property(nonatomic,strong)NSMutableArray* pilePitImageArr;
@property(nonatomic,strong)NSMutableArray* mainConstructionImageArr;
@property(nonatomic,strong)NSMutableArray* explorationImageArr;
@property(nonatomic,strong)NSMutableArray* fireControlImageArr;
@property(nonatomic,strong)NSMutableArray* electroweakImageArr;

@property(nonatomic,strong)NSMutableArray* planImageArr;
@property(nonatomic)int isRelease;
@property(nonatomic)NSInteger fromView;//判断是新建还是修改 新建是0 修改是1

-(instancetype)initWithSingle:(NSMutableDictionary*)singleDic contacts:(NSArray*)contacts horizonImageArr:(NSArray*)horizonImageArr pilePitImageArr:(NSArray*)pilePitImageArr mainConstructionImageArr:(NSArray*)mainConstructionImageArr explorationImageArr:(NSArray*)explorationImageArr fireControlImageArr:(NSArray*)fireControlImageArr electroweakImageArr:(NSArray*)electroweakImageArr planImageArr:(NSMutableArray*)planImageArr;

@end
