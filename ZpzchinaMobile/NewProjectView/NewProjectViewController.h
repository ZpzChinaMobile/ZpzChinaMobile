//
//  NewProjectViewController.h
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-17.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "AddContactViewController.h"
#import "PlanAndAuctionTableViewCell.h"
#import "ProjectTableViewCell.h"
#import "GeologicalSurveyTableViewCell.h"
#import "DesignTableViewCell.h"
#import "PlotTableViewCell.h"
#import "HorizonTableViewCell.h"
#import "PilePitTableViewCell.h"
#import "MainConstructionTableViewCell.h"
#import "FirefightingTableViewCell.h"
#import "LandscapingTableViewCell.h"
#import "WeakinstallationTableViewCell.h"
#import "DecorationTableViewCell.h"
#import "RenovationprogressTableViewCell.h"
#import "UIViewController+MJPopupViewController.h"
#import "LocateView.h"
#import "DatePickerView.h"
#import "MultipleChoiceViewController.h"
#import "OwnerTypeViewController.h"
#import "LocationViewController.h"
#import "SinglePickerView.h"
#import "Camera.h"
#import "CollectionViewController.h"
@interface NewProjectViewController :BaseViewController<UITableViewDelegate,UITableViewDataSource,PlanAndAuctionDelegate,ProjectDelegate,AddContactViewDelegate,UIActionSheetDelegate,MChoiceViewDelegate,OwnerTypeViewDelegate,UIAlertViewDelegate,LocationViewDelegate,GeologicalSurveyDelegate,DesignDelegate,PlotDelegate,HorizonDelegate,PilePitDelegate,CameraDelegate,MainConstructionDelegate,FirefightingDelegate,LandscapingDelegate,WeakinstallationDelegate,DecorationDelegate,RenovationprogressDelegate>{
    UITableView *_tableView;
    NSMutableArray *mainStageArr;
    NSMutableArray *phasedArr;
    NSInteger mysection;
    NSInteger myrow;
    BOOL _section_1_isOn;
    BOOL _section_2_isOn;
    BOOL _section_3_isOn;
    BOOL _section_4_isOn;
    BOOL _openRow;
    
    NSInteger endSection;
    NSInteger didSection;
    int flag;
    
    AddContactViewController *addcontactView;
    UIViewController *bgviewcontroller;
    LocateView *locateview;
    DatePickerView *datepickerview;
    SinglePickerView *singlepickerview;
    MultipleChoiceViewController *muview;
    OwnerTypeViewController *ownertypeview;
    LocationViewController *locationView;
    CollectionViewController *collectionview;
    
    NSMutableDictionary *dataDic;
    NSMutableDictionary *SingleDataDic;
    
    NSMutableArray *cellArr;
    NSMutableArray *contactArr;
    NSMutableArray *contactArr2;
    NSMutableArray *ownerArr;
    NSMutableArray *explorationUnitArr;
    NSMutableArray *designInstituteArr;
    NSMutableArray *horizonArr;
    NSMutableArray *pileFoundationUnitArr;
    
    NSMutableArray *horizonImageArr;
    NSMutableArray *pilePitImageArr;
    NSMutableArray *mainConstructionImageArr;
    NSMutableArray *explorationImageArr;
    NSMutableArray *fireControlImageArr;
    NSMutableArray *electroweakImageArr;
    NSInteger timeflag;
    
    int fromView;
    int isRelease;
    UIActionSheet *_myActionSheet;
    Camera *camera;
    
    int cameraflag;
    
    BOOL _isUpdata;
    
    UIView *bgView2;
}
@property(nonatomic,assign)int flag;
@property(nonatomic,assign)int fromView;
@property(nonatomic,assign)int isRelease;
@property(retain,nonatomic)NSMutableArray *mainStageArr;
@property(retain,nonatomic)NSMutableArray *phasedArr;
@property(retain,nonatomic)NSMutableArray *cellArr;
@property(retain,nonatomic)NSMutableArray *contactArr;
@property(retain,nonatomic)NSMutableArray *ownerArr;
@property(retain,nonatomic)NSMutableArray *explorationUnitArr;
@property(retain,nonatomic)NSMutableArray *designInstituteArr;
@property(retain,nonatomic)NSMutableDictionary *dataDic;
@property(retain,nonatomic)NSMutableDictionary *SingleDataDic;
@property(nonatomic)NSInteger mysection;
@property(nonatomic)NSInteger myrow;
@property(nonatomic)NSInteger timeflag;
@property(retain,nonatomic)AddContactViewController *addcontactView;
@property(retain,nonatomic)LocateView *locateview;
@property(retain,nonatomic)DatePickerView *datepickerview;
@property(retain,nonatomic)MultipleChoiceViewController *muview;
@property(retain,nonatomic)OwnerTypeViewController *ownertypeview;
@end
