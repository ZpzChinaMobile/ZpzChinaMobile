//
//  AppModel.m
//  ZpzchinaMobile
//
//  Created by 孙元侃 on 14-8-16.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "AppModel.h"

@implementation AppModel
static AppModel* singleton;

+(AppModel*)sharedInstance{
    if(!singleton){
        singleton=[[AppModel alloc]init];
    }
    return singleton;
}

-(void)getNew{
    self.contactAry=[NSMutableArray array];
    self.ownerAry=[NSMutableArray array];
    self.explorationAry=[NSMutableArray array];
    self.horizonAry=[NSMutableArray array];
    self.designAry=[NSMutableArray array];
    self.pileAry=[NSMutableArray array];

    self.horizonImageArr=[NSMutableArray array];
    self.pilePitImageArr=[NSMutableArray array];
    self.mainConstructionImageArr=[NSMutableArray array];
    self.explorationImageArr=[NSMutableArray array];
    self.fireControlImageArr=[NSMutableArray array];
    self.electroweakImageArr=[NSMutableArray array];
    self.planImageArr=[NSMutableArray array];
   
    self.singleDic=[NSMutableDictionary dictionary];//修改用字典
}

-(NSMutableArray *)contactAry{
    if (!_contactAry) {
        _contactAry=[NSMutableArray array];
    }
    return _contactAry;
}

-(NSMutableArray *)ownerAry{
    if (!_ownerAry) {
        _ownerAry=[NSMutableArray array];
    }
    return _ownerAry;
}

-(NSMutableArray *)explorationAry{
    if (!_explorationAry) {
        _explorationAry=[NSMutableArray array];
    }
    return _explorationAry;
}

-(NSMutableArray *)horizonAry{
    if (!_horizonAry) {
        _horizonAry=[NSMutableArray array];
    }
    return _horizonAry;
}

-(NSMutableArray *)designAry{
    if (!_designAry) {
        _designAry=[NSMutableArray array];
    }
    return _designAry;
}

-(NSMutableArray *)pileAry{
    if (!_pileAry) {
        _pileAry=[NSMutableArray array];
    }
    return _pileAry;
}

-(NSMutableArray *)horizonImageArr{
    if (!_horizonImageArr) {
        _horizonImageArr=[NSMutableArray array];
    }
    return _horizonImageArr;
}
-(NSMutableArray *)pilePitImageArr{
    if (!_pilePitImageArr) {
        _pilePitImageArr=[NSMutableArray array];
    }
    return _pilePitImageArr;
}
-(NSMutableArray *)mainConstructionImageArr{
    if (!_mainConstructionImageArr) {
        _mainConstructionImageArr=[NSMutableArray array];
    }
    return _mainConstructionImageArr;
}

-(NSMutableArray *)explorationImageArr{
    if (!_explorationImageArr) {
        _explorationImageArr=[NSMutableArray array];
    }
    return _explorationImageArr;
}

-(NSMutableArray *)fireControlImageArr{
    if (!_fireControlImageArr) {
        _fireControlImageArr=[NSMutableArray array];
    }
    return _fireControlImageArr;
}

-(NSMutableArray *)electroweakImageArr{
    if (!_electroweakImageArr) {
        _electroweakImageArr=[NSMutableArray array];
    }
    return _electroweakImageArr;
}

-(NSMutableArray *)planImageArr{
    if (!_planImageArr) {
        _planImageArr=[NSMutableArray array];
    }
    return _planImageArr;
}

-(void)dealloc{
    NSLog(@"appModelDealloc");
}

@end
