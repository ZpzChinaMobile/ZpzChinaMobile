//
//  AppModel.h
//  ZpzchinaMobile
//
//  Created by 孙元侃 on 14-8-16.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppModel : NSObject

@property(nonatomic,strong)NSMutableArray* contactAry;
@property(nonatomic,strong)NSMutableArray* ownerAry;
@property(nonatomic,strong)NSMutableArray* explorationAry;
@property(nonatomic,strong)NSMutableArray* horizonAry;
@property(nonatomic,strong)NSMutableArray* designAry;
@property(nonatomic,strong)NSMutableArray* pileAry;

@property(nonatomic,strong)NSMutableArray* horizonImageArr;
@property(nonatomic,strong)NSMutableArray* pilePitImageArr;
@property(nonatomic,strong)NSMutableArray* mainConstructionImageArr;
@property(nonatomic,strong)NSMutableArray* explorationImageArr;
@property(nonatomic,strong)NSMutableArray* fireControlImageArr;
@property(nonatomic,strong)NSMutableArray* electroweakImageArr;
@property(nonatomic,strong)NSMutableArray* planImageArr;

//@property(nonatomic,strong)NSMutableDictionary* dataDic;//新建用字典
@property(nonatomic,strong)NSMutableDictionary* singleDic;//修改用字典
-(void)becomeNil;
+(AppModel*)sharedInstance;
-(void)getNew;
@end
