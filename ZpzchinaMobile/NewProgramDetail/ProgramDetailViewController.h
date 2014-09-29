//
//  ProgramDetailViewController.h
//  programDetail
//
//  Created by 孙元侃 on 14-8-7.
//  Copyright (c) 2014年 sunyk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface ProgramDetailViewController : BaseViewController
@property(nonatomic,strong)UIButton* firstStageButton1;//11 第1大阶段第一个imageView的触发
@property(nonatomic,strong)UIButton* secondStageButton1;//21 第2大阶段第1个imageView的触发
@property(nonatomic,strong)UIButton* thirdStageButton1;//31 第3大阶段第1个imageView的触发
@property(nonatomic,strong)UIButton* thirdStageButton2;//32 第3大阶段第2个imageView的触发
@property(nonatomic,strong)UIButton* thirdStageButton3;//33 第3大阶段第3个imageView的触发
@property(nonatomic,strong)UIButton* fourthStageButton1;//41 第4大阶段第1个imageView的触发

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

@property(nonatomic,strong)NSMutableDictionary* dataDic;//修改用 网络数据信息或者本地数据库信息
@property(nonatomic,copy)NSString* url;//数据信息的url
@property(nonatomic)int isRelease;
@property(nonatomic,copy)NSString* ID;
@property(nonatomic)NSInteger fromView;//判断是新建还是修改 新建是0 修改是1

@property(nonatomic,strong)NSMutableDictionary* imgDic;//保存该页面的大图字典,键为@"horizonImageArr",@"pilePitImageArr",@"mainConstructionImageArr",@"explorationImageArr",@"fireControlImageArr",@"electroweakImageArr",@"planImageArr"

@property(nonatomic)BOOL isFromAllProject;
-(void)userChangeImageWithButtons:(UIButton *)button;
@end
