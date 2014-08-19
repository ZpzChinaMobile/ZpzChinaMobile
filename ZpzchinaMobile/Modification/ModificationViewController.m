//
//  ModificationViewController.m
//  ZpzchinaMobile
//
//  Created by 孙元侃 on 14-8-14.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "ModificationViewController.h"
#import "OneTableViewController.h"
#import "TwoTableViewController.h"
#import "ThreeTableViewController.h"
#import "FourTableViewController.h"
#import "FiveTableViewController.h"
#import "SixTableViewController.h"
#import "SevenTableViewController.h"
#import "EightTableViewController.h"
#import "NineTableViewController.h"
#import "TenTableViewController.h"
#import "ModificationSelectViewCell.h"
#import "ProjectStage.h"
#import "ProjectSqlite.h"
#import "ContactSqlite.h"
#import "CameraSqlite.h"
#import "CameraModel.h"
#import "GetBigImage.h"
#import "AppModel.h"
@interface ModificationViewController ()<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate,OneTVCDelegate,TwoTVCDelegate>
@property(nonatomic,strong)UILabel* bigStageLabel;//上导航中 大阶段label
@property(nonatomic,strong)UILabel* smallStageLabel;//上导航中 小阶段label
@property(nonatomic,strong)UIImageView* bigStageImageView;//上导航中大阶段图片

@property(nonatomic,strong)UITableView* myTableView;//筛选页面

@property(nonatomic,strong)UIView* tableViewSpace;//下方tableView的画布

@property(nonatomic,strong)OneTableViewController* oneTVC;
@property(nonatomic,strong)TwoTableViewController* twoTVC;
@property(nonatomic,strong)ThreeTableViewController* threeTVC;
@property(nonatomic,strong)FourTableViewController* fourTVC;
@property(nonatomic,strong)FiveTableViewController* fiveTVC;
@property(nonatomic,strong)SixTableViewController* sixTVC;
@property(nonatomic,strong)SevenTableViewController* sevenTVC;
@property(nonatomic,strong)EightTableViewController* eightTVC;
@property(nonatomic,strong)NineTableViewController* nineTVC;
@property(nonatomic,strong)TenTableViewController* tenTVC;
@property(nonatomic,strong)NSArray* contacts;//联系人数组
@property(nonatomic,strong)NSArray* images;//图片数组
@property(nonatomic,strong)NSArray* tvcArray;

@property(nonatomic,strong)UIView* shadowView;//保存到数据库,直到用户点击确认之后才消失的背景
@end

@implementation ModificationViewController

//-(void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    NSLog(@"back");
//    //[self.delegate backToPro];
//}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(instancetype)initWithSingle:(NSMutableDictionary*)singleDic contacts:(NSArray*)contacts horizonImageArr:(NSMutableArray*)horizonImageArr pilePitImageArr:(NSMutableArray*)pilePitImageArr mainConstructionImageArr:(NSMutableArray*)mainConstructionImageArr explorationImageArr:(NSMutableArray*)explorationImageArr fireControlImageArr:(NSMutableArray*)fireControlImageArr electroweakImageArr:(NSMutableArray*)electroweakImageArr planImageArr:(NSMutableArray*)planImageArr{
    if ([super init]) {
        //        AppModel* appModel=[AppModel sharedInstance];
        //        self.singleDic=appModel.singleDic;
        //       // NSLog(@"222222%@",self.dataDic);
        //        self.contacts=@[appModel.contactAry,appModel.ownerAry,appModel.explorationAry,appModel.horizonAry,appModel.designAry,appModel.pileAry];
        //        self.horizonImageArr=appModel.horizonImageArr;
        //        self.pilePitImageArr=appModel.pilePitImageArr;
        //        self.mainConstructionImageArr=appModel.mainConstructionImageArr;
        //        self.explorationImageArr=appModel.explorationImageArr;
        //        self.fireControlImageArr=appModel.fireControlImageArr;
        //        self.electroweakImageArr=appModel.electroweakImageArr;
        //        self.planImageArr=appModel.planImageArr;
        
        //        self.singleDic=singleDic;
        //        NSLog(@"222222%@",self.dataDic);
        //        self.contacts=contacts;
        //        self.horizonImageArr=horizonImageArr;
        //        self.pilePitImageArr=pilePitImageArr;
        //        self.mainConstructionImageArr=mainConstructionImageArr;
        //        self.explorationImageArr=explorationImageArr;
        //        self.fireControlImageArr=fireControlImageArr;
        //        self.electroweakImageArr=electroweakImageArr;
        //        self.planImageArr=planImageArr;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    AppModel* appModel=[AppModel sharedInstance];
    NSLog(@"viewDidLoad");
    
    //此处判断是用户选择的时 修改还是新增 ,如果是新增页面进 则初始化model
   // if (self.isRelease) {
    if (!self.fromView) {
        [appModel getNew];
       // appModel.singleDic=[NSMutableDictionary dictionary];
    }
    
    
    //singleDic赋值只针对修改，新建页面无用
    self.singleDic=appModel.singleDic;
    
    self.contacts=[NSArray arrayWithObjects:appModel.contactAry,appModel.ownerAry,appModel.explorationAry,appModel.horizonAry,appModel.designAry,appModel.pileAry, nil];
    self.horizonImageArr=appModel.horizonImageArr;
    self.pilePitImageArr=appModel.pilePitImageArr;
    self.mainConstructionImageArr=appModel.mainConstructionImageArr;
    self.explorationImageArr=appModel.explorationImageArr;
    self.fireControlImageArr=appModel.fireControlImageArr;
    self.electroweakImageArr=appModel.electroweakImageArr;
    self.planImageArr=appModel.planImageArr;
    
    self.dataDic=[NSMutableDictionary dictionary];
    
    
    
    //AppModel* appModel=[AppModel sharedInstance];
    //appModel.dataDic=self.dataDic;
    
    [self initdataDic];
    
    [self initTVC];
    
    [self initNavi];
    // [self initTableView];
    [self initThemeView];
    [self initTableViewSpace];
    [self.tableViewSpace addSubview:self.twoTVC.tableView];
    [self.tableViewSpace addSubview:self.oneTVC.tableView];
    [self initTableView];
    // Do any additional setup after loading the view.
}

-(void)upTVCSpaceWithHeight:(CGFloat)height{
    [UIView animateWithDuration:.5 animations:^{
        CGPoint point=self.tableViewSpace.center;
        point.y-=height;
        self.tableViewSpace.center=point;
    }];
}

-(void)downTVCSpace{
    [UIView animateWithDuration:.5 animations:^{
        self.tableViewSpace.center=CGPointMake(160, 50+(568-64.5-50)*.5);
    }];
}

-(void)initTVC{
    //contactAry flag 0
    AppModel* appModel=[AppModel sharedInstance];
    
    NSLog(@"initTVC====%@",self.singleDic);
    self.oneTVC=[[OneTableViewController alloc]initWithSingle:self.singleDic dataDic:self.dataDic contacts:appModel.contactAry images:self.planImageArr];
    //    self.oneTVC=[[OneTableViewController alloc]initWithSingle:self.singleDic dataDic:self.dataDic contacts:[self.contacts[0] mutableCopy] images:self.planImageArr];
    self.oneTVC.fromView=self.fromView;
    self.oneTVC.superVC=self;
    self.oneTVC.delegate=self;
    
    //ownerAry flag 1
    self.twoTVC=[[TwoTableViewController alloc]initWithSingle:self.singleDic dataDic:self.dataDic contacts:appModel.ownerAry images:nil];
    self.twoTVC.fromView=self.fromView;
    self.twoTVC.superVC=self;
    self.twoTVC.delegate=self;
    
    //explorationAry flag 2
    self.threeTVC=[[ThreeTableViewController alloc]initWithSingle:self.singleDic dataDic:self.dataDic contacts:appModel.explorationAry images:self.explorationImageArr];
    self.threeTVC.fromView=self.fromView;
    self.threeTVC.superVC=self;
    
    //designAry flag 3
    self.fourTVC=[[FourTableViewController alloc]initWithSingle:self.singleDic dataDic:self.dataDic contacts:appModel.designAry images:nil];
    self.fourTVC.fromView=self.fromView;
    self.fourTVC.superVC=self;
    
    //ownerAry flag 1
    self.fiveTVC=[[FiveTableViewController alloc]initWithSingle:self.singleDic dataDic:self.dataDic contacts:appModel.ownerAry images:nil];
    self.fiveTVC.fromView=self.fromView;
    self.fiveTVC.superVC=self;
    
    
    //horizonAry flag 4
    self.sixTVC=[[SixTableViewController alloc]initWithSingle:self.singleDic dataDic:self.dataDic contacts:appModel.horizonAry images:self.horizonImageArr];
    self.sixTVC.fromView=self.fromView;
    self.sixTVC.superVC=self;
    
    //pileAry flag 5
    self.sevenTVC=[[SevenTableViewController alloc]initWithSingle:self.singleDic dataDic:self.dataDic contacts:appModel.pileAry images:self.pilePitImageArr];
    self.sevenTVC.fromView=self.fromView;
    self.sevenTVC.superVC=self;
    
    self.eightTVC=[[EightTableViewController alloc]initWithSingle:self.singleDic dataDic:self.dataDic contacts:nil images:self.mainConstructionImageArr];
    self.eightTVC.fromView=self.fromView;
    self.eightTVC.superVC=self;
    
    self.nineTVC=[[NineTableViewController alloc]initWithSingle:self.singleDic dataDic:self.dataDic images:self.fireControlImageArr];
    self.nineTVC.fromView=self.fromView;
    self.nineTVC.superVC=self;
    
    self.tenTVC=[[TenTableViewController alloc] initWithSingle:self.singleDic dataDic:self.dataDic images:self.electroweakImageArr];
    self.tenTVC.fromView=self.fromView;
    self.tenTVC.superVC=self;
    
    self.tvcArray=@[self.oneTVC,self.twoTVC,self.threeTVC,self.fourTVC,self.fiveTVC,self.sixTVC,self.sevenTVC,self.eightTVC,self.nineTVC,self.tenTVC];
    
    for (int i=0; i<10; i++) {
        UITableViewController* tvc=self.tvcArray[i];
        tvc.tableView.frame=CGRectMake(0, 0, 320, 568-64.5-50);
    }
    
}

-(void)initTableViewSpace{
    self.tableViewSpace=[[UIView alloc]initWithFrame:CGRectMake(0, 50, 320, 568-64.5-50)];
    self.tableViewSpace.backgroundColor=[UIColor clearColor];
    [self.contentView insertSubview:self.tableViewSpace atIndex:0];
    //[self.contentView addSubview:self.tableViewSpace];
}

-(void)initThemeView{
    //画布themeView初始,因为上导航栏下方的阴影需要半透明,而上方部分不需要透明,所以该view分2块
    UIView* view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    //themeView.backgroundColor=[UIColor clearColor];
    [self.contentView addSubview:view];
    
    //上导航栏第一部分，非透明部分
    UIView* tempView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 48.5)];
    tempView.backgroundColor=[UIColor whiteColor];
    [view addSubview:tempView];
    
    
    //大标题左边的大阶段图片
    UIImage* image=[UIImage imageNamed:@"XiangMuXiangQing/map@2x.png"];
    CGRect frame=CGRectMake(20, 12, image.size.width*.5, image.size.height*.5);
    self.bigStageImageView=[[UIImageView alloc]initWithFrame:frame];
    self.bigStageImageView.image=image;
    [tempView addSubview:self.bigStageImageView];
    
    //大阶段标题label
    self.bigStageLabel=[[UILabel alloc]initWithFrame:CGRectMake(50, 10, 150, 30)];
    self.bigStageLabel.text=@"土地信息";
    self.bigStageLabel.font=[UIFont systemFontOfSize:16];
    [tempView addSubview:self.bigStageLabel];
    
    //小阶段标题label
    self.smallStageLabel=[[UILabel alloc]initWithFrame:CGRectMake(170, 10, 110, 30)];
    self.smallStageLabel.text=@"土地规划/拍卖";
    self.smallStageLabel.textColor=BlueColor;
    self.smallStageLabel.font=[UIFont systemFontOfSize:14];
    self.smallStageLabel.textAlignment=NSTextAlignmentRight;
    [tempView addSubview:self.smallStageLabel];
    
    //右箭头imageView
    UIImageView* imageView=[[UIImageView alloc]initWithFrame:CGRectMake(280, 14, 25.5, 22.5)];
    imageView.image=[UIImage imageNamed:@"XiangMuXiangQing/more_02@2x.png"];
    [tempView addSubview:imageView];
    
    //上导航栏themeView第二部分,上导航下方阴影
    UIImageView* shadowView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 48.5, 320, 1.5)];
    shadowView.image=[UIImage imageNamed:@"XiangMuXiangQing/Shadow-top.png"];
    shadowView.alpha=.2;
    [view addSubview:shadowView];
    
    //使该view被点击可以触发
    UIButton* button=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    [button addTarget:self action:@selector(change) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
}

-(void)change{
    NSLog(@"用户选择了筛选");
    //暂时移除观察者,避免加新view时有动画
    //table没有出现的时候才进行添加,避免反复添加
    if (![self.view.subviews containsObject:self.myTableView]) {
        [self.view addSubview:self.myTableView];
        [UIView animateWithDuration:0.5 animations:^{
            self.myTableView.center=CGPointMake(160, (568-64.5)*.5+64.5);
        }];
    }
}

//筛选界面拉回去
-(void)selectCancel{
    //table出现的时候才进行拉回去的以及移除的操作,避免反复移除
    if ([self.view.subviews containsObject:self.myTableView]) {
        [UIView animateWithDuration:0.5 animations:^{
            self.myTableView.center=CGPointMake(160, -(568-64.5)*.5);
        } completion:^(BOOL finished){
            [self.myTableView removeFromSuperview];
        }];
    }
}

-(void)initTableView{
    self.myTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 568-64.5) style:UITableViewStylePlain];
    self.myTableView.delegate=self;
    self.myTableView.dataSource=self;
    self.myTableView.center=CGPointMake(160, -(568-64.5)*.5);
    [self.myTableView registerClass:[ModificationSelectViewCell class] forCellReuseIdentifier:@"Cell"];
    self.myTableView.showsVerticalScrollIndicator=NO;
    self.myTableView.scrollEnabled=NO;
    self.myTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    //self.myTableView.backgroundColor=[UIColor colorWithWhite:1 alpha:.95];
    self.myTableView.backgroundColor=[UIColor whiteColor];
    //用于存放使sectionHeader可以被点击的button的array
    //self.sectionButtonArray=[NSMutableArray array];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSMutableArray* ary=[NSMutableArray array];
    for (int i=0; i<10; i++) {
        UITableView* tv=[self.tvcArray[i] tableView];
        [ary addObject:tv];
    }
    
    NSInteger a=[ary indexOfObject:[self.tableViewSpace.subviews lastObject]];
    
    
    //NSLog(@"a=%d",a);
    ModificationSelectViewCell* cell=[ModificationSelectViewCell dequeueReusableCellWithTabelView:tableView identifier:@"Cell" indexPath:indexPath nowTableView:a];
    
    return cell;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSString* mainPath=@"XiangMuJieDuan";
    NSArray* path=@[@"map2@x.png",@"pen@2x.png",@"Subject@2x.png",@"paint@2x.png"];
    
    UIView* view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 37.5)];
    view.backgroundColor=RGBCOLOR(234,234,234);
    
    
    UIImage* image=[UIImage imageNamed:[mainPath stringByAppendingPathComponent:path[section]]];
    CGRect frame=CGRectMake(0, 0, image.size.width*.5, image.size.height*.5);
    UIImageView* imageView=[[UIImageView alloc]initWithFrame:frame];
    imageView.center=CGPointMake(23.5, 37.5*.5);
    imageView.image=image;
    [view addSubview:imageView];
    
    UILabel* label=[[UILabel alloc]initWithFrame:CGRectMake(47, 12, 200, 16)];
    NSArray* ary=@[@"土地信息阶段",@"主体设计阶段",@"主体施工阶段",@"装修阶段"];
    label.text=ary[section];
    label.font=[UIFont systemFontOfSize:16];
    label.textColor=RGBCOLOR(150, 150, 150);
    [view addSubview:label];
    
    return view;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 34;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 37.5;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 2;
            break;
        case 1:
            return 3;
            break;
        case 2:
            return 4;
            break;
        default:
            return 1;
            break;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.myTableView reloadData];
    
    int a[4]={0,2,5,9};
    //NSLog(@"%d",a[indexPath.section]+indexPath.row);
    NSLog(@"%d",self.tableViewSpace.subviews.count);
    UITableViewController* tvc=self.tvcArray[a[indexPath.section]+indexPath.row];
   // [self.tableViewSpace.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

    [self.tableViewSpace addSubview:tvc.tableView];
    [self selectCancel];
    
    self.bigStageLabel.text=@[@"土地信息",@"主体设计阶段",@"主体施工阶段",@"装修阶段"][indexPath.section];
    self.smallStageLabel.text=@[@"土地规划/拍卖",@"项目立项",@"地勘阶段",@"设计阶段",@"出图阶段",@"地平",@"桩基基坑",@"主体施工",@"消防/景观绿化",@"装修阶段"][a[indexPath.section]+indexPath.row];
}

-(void)initNavi{
    [self addBackButton];
    [self addRightButton:CGRectMake(280, 25, 29, 28.5) title:nil iamge:[UIImage imageNamed:@"icon__09.png"]];

}

//-(void)leftAction
//{
//    NSLog(@"self");
//    if ([self.delegate respondsToSelector:@selector(backToPro)]) {
//        [self.delegate backToPro];
//        [self.navigationController popViewControllerAnimated:YES];
//    }
//
//}

-(void)rightAction{
    self.shadowView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 568-64.5)];
    self.shadowView.backgroundColor=[UIColor blackColor];
    self.shadowView.alpha=.5;
    [self.contentView addSubview:self.shadowView];
    
    AppModel* appModel=[AppModel sharedInstance];
    
    if (self.fromView==0) {
        
        [ProjectSqlite InsertData:self.dataDic];
//        for (int i=0; i<self.contacts.count; i++) {
//            NSLog(@"========%d",[self.contacts[i] count]);
//        }
        
        if(appModel.contactAry.count){
            for(int i=0; i<appModel.contactAry.count;i++){
                [ContactSqlite InsertData:[appModel.contactAry objectAtIndex:i]];
            }
        }
        
        if(appModel.ownerAry.count){
            for(int i=0; i<appModel.ownerAry.count;i++){
                [ContactSqlite InsertData:[appModel.ownerAry objectAtIndex:i]];
            }
        }
        
        if(appModel.explorationAry.count){
            for(int i=0; i<appModel.explorationAry.count;i++){
                [ContactSqlite InsertData:[appModel.explorationAry objectAtIndex:i]];
            }
        }
        
        if(appModel.designAry.count){
            for(int i=0; i<appModel.designAry.count;i++){
                [ContactSqlite InsertData:[appModel.designAry objectAtIndex:i]];
            }
        }
        
        
        if(appModel.horizonAry.count){
            for(int i=0; i<appModel.horizonAry.count;i++){
                [ContactSqlite InsertData:[appModel.horizonAry objectAtIndex:i]];
            }
        }
        
        if(appModel.pileAry.count){
            for(int i=0; i<appModel.pileAry.count;i++){
                [ContactSqlite InsertData:[appModel.pileAry objectAtIndex:i]];
            }
        }
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"保存完毕，请到本地保存项目查看！"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil,nil];
        [alert show];
    }else{
        NSMutableDictionary *dic = [ProjectStage JudgmentUpdataProjectStr:self.singleDic newDic:self.dataDic];
        if (!self.isRelease) {
            [dic setValue:[self.singleDic objectForKey:@"projectID"] forKeyPath:@"id"];
            NSLog(@"%@",dic);
            
            //保存图片至数据库
            for(int i=0;i<self.horizonImageArr.count;i++){
                CameraModel *model = [self.horizonImageArr objectAtIndex:i];
                if([model.a_device isEqualToString:@"ios"]){
                    [GetBigImage getbigimage:model.a_url];
                }
            }
            for(int i=0;i<self.pilePitImageArr.count;i++){
                CameraModel *model = [self.pilePitImageArr objectAtIndex:i];
                if([model.a_device isEqualToString:@"ios"]){
                    [GetBigImage getbigimage:model.a_url];
                }
            }
            
            for(int i=0;i<self.mainConstructionImageArr.count;i++){
                CameraModel *model = [self.mainConstructionImageArr objectAtIndex:i];
                if([model.a_device isEqualToString:@"ios"]){
                    [GetBigImage getbigimage:model.a_url];
                }
            }
            
            for(int i=0;i<self.explorationImageArr.count;i++){
                CameraModel *model = [self.explorationImageArr objectAtIndex:i];
                if([model.a_device isEqualToString:@"ios"]){
                    [GetBigImage getbigimage:model.a_url];
                }
            }
            
            for(int i=0;i<self.fireControlImageArr.count;i++){
                CameraModel *model = [self.fireControlImageArr objectAtIndex:i];
                if([model.a_device isEqualToString:@"ios"]){
                    [GetBigImage getbigimage:model.a_url];
                }
            }
            
            for(int i=0;i<self.electroweakImageArr.count;i++){
                CameraModel *model = [self.electroweakImageArr objectAtIndex:i];
                if([model.a_device isEqualToString:@"ios"]){
                    [GetBigImage getbigimage:model.a_url];
                }
            }
            
            for(int i=0;i<self.planImageArr.count;i++){
                CameraModel *model = [self.planImageArr objectAtIndex:i];
                if([model.a_device isEqualToString:@"ios"]){
                    [GetBigImage getbigimage:model.a_url];
                }
            }
        }else{
            NSLog(@"singleDic==========%@",self.singleDic);
            [dic setValue:[self.singleDic objectForKey:@"id"] forKeyPath:@"id"];
        }
        
        
        //保存项目
        [ProjectSqlite InsertUpdataServerData:dic];
        
        
        //保存联系人
        if([self.contacts[0] count] !=0){
            for(int i=0; i<[self.contacts[0] count];i++){
                [ContactSqlite InsertUpdataServerData:[self.contacts[0] objectAtIndex:i]];
            }
        }
        
        if([self.contacts[1] count] !=0){
            for(int i=0; i<[self.contacts[1] count];i++){
                [ContactSqlite InsertUpdataServerData:[self.contacts[1] objectAtIndex:i]];
            }
        }
        
        if([self.contacts[2] count] !=0){
            for(int i=0; i<[self.contacts[2] count];i++){
                [ContactSqlite InsertUpdataServerData:[self.contacts[2] objectAtIndex:i]];
            }
        }
        
        if([self.contacts[4] count] !=0){
            for(int i=0; i<[self.contacts[4] count];i++){
                [ContactSqlite InsertData:[self.contacts[4] objectAtIndex:i]];
            }
        }
        
        if([self.contacts[3] count] !=0){
            for(int i=0; i<[self.contacts[3] count];i++){
                [ContactSqlite InsertData:[self.contacts[3] objectAtIndex:i]];
            }
        }
        
        if([self.contacts[5] count] !=0){
            for(int i=0; i<[self.contacts[5] count];i++){
                [ContactSqlite InsertData:[self.contacts[5] objectAtIndex:i]];
            }
        }
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"保存完毕，请到本地保存项目查看！"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil,nil];
        [alert show];
    }
    
    
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self.shadowView removeFromSuperview];
    if (!self.fromView) {
        AppModel* appModel=[AppModel sharedInstance];
        [appModel getNew];
        //singleDic赋值只针对修改，新建页面无用
        self.singleDic=appModel.singleDic;
        
        self.contacts=[NSArray arrayWithObjects:appModel.contactAry,appModel.ownerAry,appModel.explorationAry,appModel.horizonAry,appModel.designAry,appModel.pileAry, nil];
        self.horizonImageArr=appModel.horizonImageArr;
        self.pilePitImageArr=appModel.pilePitImageArr;
        self.mainConstructionImageArr=appModel.mainConstructionImageArr;
        self.explorationImageArr=appModel.explorationImageArr;
        self.fireControlImageArr=appModel.fireControlImageArr;
        self.electroweakImageArr=appModel.electroweakImageArr;
        self.planImageArr=appModel.planImageArr;
        
        self.dataDic=[NSMutableDictionary dictionary];
        
        [self initdataDic];
        
        [self initTVC];
        
        [self initNavi];
        // [self initTableView];
        [self initThemeView];
        [self initTableViewSpace];
        [self.tableViewSpace addSubview:self.twoTVC.tableView];
        [self.tableViewSpace addSubview:self.oneTVC.tableView];
        [self initTableView];

    }
    if (!self.isRelease&&self.fromView) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)initdataDic{
    NSLog(@"initdataDic");
    int value = (arc4random() % 9999999) + 1000000;
    //土地规划/拍卖
    
    [self.dataDic setObject:[NSString stringWithFormat:@"%d",value] forKey:@"id"];
    [self.dataDic setObject:@"" forKey:@"landName"];
    [self.dataDic setObject:@"" forKey:@"district"];
    [self.dataDic setObject:@"" forKey:@"province"];
    [self.dataDic setObject:@"" forKey:@"landAddress"];
    [self.dataDic setObject:@"" forKey:@"city"];
    [self.dataDic setObject:@"" forKey:@"usage"];
    [self.dataDic setObject:@"" forKey:@"auctionUnit"];
    //建立项目
    [self.dataDic setObject:@"" forKey:@"projectID"];
    [self.dataDic setObject:@"" forKey:@"projectCode"];
    [self.dataDic setObject:@"" forKey:@"projectName"];
    [self.dataDic setObject:@"" forKey:@"projectVersion"];
    [self.dataDic setObject:@"" forKey:@"description"];
    [self.dataDic setObject:@"" forKey:@"owner"];
    [self.dataDic setObject:@"" forKey:@"expectedStartTime"];
    [self.dataDic setObject:@"" forKey:@"expectedFinishTime"];
    [self.dataDic setObject:@"" forKey:@"ownerType"];
    //地勘阶段
    [self.dataDic setObject:@"" forKey:@"mainDesignStage"];
    //地平
    [self.dataDic setObject:@"" forKey:@"actualStartTime"];
    //消防
    [self.dataDic setObject:@"" forKey:@"fireControl"];
    //景观绿化
    [self.dataDic setObject:@"" forKey:@"green"];
    //装修阶段
    [self.dataDic setObject:@"" forKey:@"electroweakInstallation"];
    [self.dataDic setObject:@"" forKey:@"decorationSituation"];
    [self.dataDic setObject:@"" forKey:@"decorationProgress"];
    [self.dataDic setObject:@"" forKey:@"url"];
    
    if(self.fromView == 0){
        [self.dataDic setObject:@"0" forKey:@"area"];
        [self.dataDic setObject:@"0" forKey:@"plotRatio"];
        [self.dataDic setObject:@"0" forKey:@"investment"];
        [self.dataDic setObject:@"0" forKey:@"areaOfStructure"];
        [self.dataDic setObject:@"0" forKey:@"storeyHeight"];
        [self.dataDic setObject:@"0" forKey:@"foreignInvestment"];
        [self.dataDic setObject:@"0" forKey:@"longitude"];
        [self.dataDic setObject:@"0" forKey:@"latitude"];
        //出图阶段
        [self.dataDic setObject:@"0" forKey:@"propertyElevator"];
        [self.dataDic setObject:@"0" forKey:@"propertyAirCondition"];
        [self.dataDic setObject:@"0" forKey:@"propertyHeating"];
        [self.dataDic setObject:@"0" forKey:@"propertyExternalWallMeterial"];
        [self.dataDic setObject:@"0" forKey:@"propertyStealStructure"];
    }else{
        [self.dataDic setObject:@"" forKey:@"area"];
        [self.dataDic setObject:@"" forKey:@"plotRatio"];
        [self.dataDic setObject:@"" forKey:@"investment"];
        [self.dataDic setObject:@"" forKey:@"areaOfStructure"];
        [self.dataDic setObject:@"" forKey:@"storeyHeight"];
        [self.dataDic setObject:@"" forKey:@"foreignInvestment"];
        [self.dataDic setObject:@"" forKey:@"longitude"];
        [self.dataDic setObject:@"" forKey:@"latitude"];
        //出图阶段
        [self.dataDic setObject:@"" forKey:@"propertyElevator"];
        [self.dataDic setObject:@"" forKey:@"propertyAirCondition"];
        [self.dataDic setObject:@"" forKey:@"propertyHeating"];
        [self.dataDic setObject:@"" forKey:@"propertyExternalWallMeterial"];
        [self.dataDic setObject:@"" forKey:@"propertyStealStructure"];
    }
}

-(void)dealloc{
    self.oneTVC=nil;
    self.twoTVC=nil;
    self.threeTVC=nil;
    self.fourTVC=nil;
    self.fiveTVC=nil;
    self.sixTVC=nil;
    self.sevenTVC=nil;
    self.eightTVC=nil;
    self.nineTVC=nil;
    self.tenTVC=nil;
    NSLog(@"modifiDealloc");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
