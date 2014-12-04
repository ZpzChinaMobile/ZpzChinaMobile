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
#import "UserModel.h"
#import "UserSqlite.h"
#import "BesideViewAlert.h"
#import "ModifiBaseViewController.h"
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
@property(nonatomic,strong)NSMutableArray* originContacts;

@property(nonatomic,strong)NSMutableArray* originContactAry;
@property(nonatomic,strong)NSMutableArray* originOwnerAry;
@property(nonatomic,strong)NSMutableArray* originExplorationAry;
@property(nonatomic,strong)NSMutableArray* originHorizonAry;
@property(nonatomic,strong)NSMutableArray* originDesignAry;
@property(nonatomic,strong)NSMutableArray* originPileAry;

@property(nonatomic,strong)UIView* shadowView;//保存到数据库,直到用户点击确认之后才消失的背景

@property(nonatomic)NSInteger gotoBigImageCount;//服务器加载下来的项目保存到数据库中，计算需要请求服务器高清图的张数
@property(nonatomic)NSInteger backFromBigImageCount;//请求高清图完成的张数
@property(nonatomic,strong)ModifiBaseViewController* currentVC;
@property(nonatomic,strong)BesideViewAlert* besideViewAlert;
@end

@implementation ModificationViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    [self.mm_drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeNone];
    [self.tvcArray[1] getLocationNil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [self.mm_drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
}

-(instancetype)initWithSingle:(NSMutableDictionary*)singleDic contacts:(NSArray*)contacts horizonImageArr:(NSMutableArray*)horizonImageArr pilePitImageArr:(NSMutableArray*)pilePitImageArr mainConstructionImageArr:(NSMutableArray*)mainConstructionImageArr explorationImageArr:(NSMutableArray*)explorationImageArr fireControlImageArr:(NSMutableArray*)fireControlImageArr electroweakImageArr:(NSMutableArray*)electroweakImageArr planImageArr:(NSMutableArray*)planImageArr{
    if ([super init]) {
        self.gotoBigImageCount=0;
        self.backFromBigImageCount=0;
        
        AppModel* appModel=[AppModel sharedInstance];
        
        //复制一个未改动的联系人备份
        self.originContactAry=[NSMutableArray array];
        self.originOwnerAry=[NSMutableArray array];
        self.originExplorationAry=[NSMutableArray array];
        self.originHorizonAry=[NSMutableArray array];
        self.originDesignAry=[NSMutableArray array];
        self.originPileAry=[NSMutableArray array];
        
        self.originContacts=[NSMutableArray arrayWithObjects:self.originContactAry,self.originOwnerAry,self.originExplorationAry,self.originHorizonAry,self.originDesignAry,self.originPileAry,nil];
        
        NSArray* tempContacs=[NSArray arrayWithObjects:appModel.contactAry,appModel.ownerAry,appModel.explorationAry,appModel.horizonAry,appModel.designAry,appModel.pileAry, nil];
        
        for (int i=0; i<tempContacs.count; i++) {
            for (int k=0; k<[tempContacs[i] count]; k++) {
                [self.originContacts[i] addObject:[tempContacs[i][k] mutableCopy]];
            }
        }
    }
    return self;
}

-(void)getNoti{
    NSLog(@"=====getNoti");
    self.backFromBigImageCount++;
    if (self.gotoBigImageCount==self.backFromBigImageCount) {
        [self loadAlertView];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getNoti) name:@"bigImage" object:nil];
    
    AppModel* appModel=[AppModel sharedInstance];
    NSLog(@"viewDidLoad");
    
    //此处判断是用户选择的时 修改还是新增 ,如果是新增页面进 则初始化model
    if (!self.fromView) {
        [appModel getNew];
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
    
    [self initdataDic];
    [self initTVC];
    [self initNavi];
    [self initTableViewSpace];
    [self initThemeView];
    [self.tableViewSpace addSubview:self.oneTVC.view];
    [self initTableView];
    
}

-(void)upTVCSpaceWithHeight:(CGFloat)height{
    [UIView animateWithDuration:.5 animations:^{
        CGPoint point=self.tableViewSpace.center;
        point.y-=height+45;
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
    
    self.oneTVC=[[OneTableViewController alloc]initWithSingle:self.singleDic dataDic:self.dataDic contacts:appModel.contactAry images:self.planImageArr];
    self.oneTVC.fromView=self.fromView;
    self.oneTVC.superVC=self;
    self.oneTVC.delegate=self;
    self.oneTVC.indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
    
    //ownerAry flag 1
    self.twoTVC=[[TwoTableViewController alloc]initWithSingle:self.singleDic dataDic:self.dataDic contacts:appModel.ownerAry images:nil];
    self.twoTVC.fromView=self.fromView;
    self.twoTVC.superVC=self;
    self.twoTVC.delegate=self;
    self.twoTVC.indexPath=[NSIndexPath indexPathForRow:1 inSection:0];

    //explorationAry flag 2
    self.threeTVC=[[ThreeTableViewController alloc]initWithSingle:self.singleDic dataDic:self.dataDic contacts:appModel.explorationAry images:self.explorationImageArr];
    self.threeTVC.fromView=self.fromView;
    self.threeTVC.superVC=self;
    self.threeTVC.indexPath=[NSIndexPath indexPathForRow:0 inSection:1];

    //designAry flag 3
    self.fourTVC=[[FourTableViewController alloc]initWithSingle:self.singleDic dataDic:self.dataDic contacts:appModel.designAry images:nil];
    self.fourTVC.fromView=self.fromView;
    self.fourTVC.superVC=self;
    self.fourTVC.indexPath=[NSIndexPath indexPathForRow:1 inSection:1];

    //ownerAry flag 1
    self.fiveTVC=[[FiveTableViewController alloc]initWithSingle:self.singleDic dataDic:self.dataDic contacts:appModel.ownerAry images:nil];
    self.fiveTVC.fromView=self.fromView;
    self.fiveTVC.superVC=self;
    self.fiveTVC.indexPath=[NSIndexPath indexPathForRow:2 inSection:1];

    
    //horizonAry flag 4
    self.sixTVC=[[SixTableViewController alloc]initWithSingle:self.singleDic dataDic:self.dataDic contacts:appModel.horizonAry images:self.horizonImageArr];
    self.sixTVC.fromView=self.fromView;
    self.sixTVC.superVC=self;
    self.sixTVC.indexPath=[NSIndexPath indexPathForRow:0 inSection:2];

    //pileAry flag 5
    self.sevenTVC=[[SevenTableViewController alloc]initWithSingle:self.singleDic dataDic:self.dataDic contacts:appModel.pileAry images:self.pilePitImageArr];
    self.sevenTVC.fromView=self.fromView;
    self.sevenTVC.superVC=self;
    self.sevenTVC.indexPath=[NSIndexPath indexPathForRow:1 inSection:2];

    self.eightTVC=[[EightTableViewController alloc]initWithSingle:self.singleDic dataDic:self.dataDic contacts:nil images:self.mainConstructionImageArr];
    self.eightTVC.fromView=self.fromView;
    self.eightTVC.superVC=self;
    self.eightTVC.indexPath=[NSIndexPath indexPathForRow:2 inSection:2];

    self.nineTVC=[[NineTableViewController alloc]initWithSingle:self.singleDic dataDic:self.dataDic images:self.fireControlImageArr];
    self.nineTVC.fromView=self.fromView;
    self.nineTVC.superVC=self;
    self.nineTVC.indexPath=[NSIndexPath indexPathForRow:3 inSection:2];

    self.tenTVC=[[TenTableViewController alloc] initWithSingle:self.singleDic dataDic:self.dataDic images:self.electroweakImageArr];
    self.tenTVC.fromView=self.fromView;
    self.tenTVC.superVC=self;
    self.tenTVC.indexPath=[NSIndexPath indexPathForRow:0 inSection:3];

    self.tvcArray=@[self.oneTVC,self.twoTVC,self.threeTVC,self.fourTVC,self.fiveTVC,self.sixTVC,self.sevenTVC,self.eightTVC,self.nineTVC,self.tenTVC];
    
    for (int i=0; i<10; i++) {
        UIViewController* vc=self.tvcArray[i];
        //因为是vc,所以vc.view.frame与tableView.frame的大小不同,会影响动画效果,所以需要重新设置vc.view.frame
        CGRect frame=vc.view.frame;
        frame.size.height-=64.5+50;
        vc.view.frame=frame;
    }
    self.currentVC=self.oneTVC;
    if (!self.besideViewAlert) {
        self.besideViewAlert=[[BesideViewAlert alloc]init];
    }
    self.currentVC.tableView.tableHeaderView=self.besideViewAlert;
    [self.besideViewAlert setLeftText:nil rigthText:@"项目立项"];
}

-(void)initTableViewSpace{
    self.tableViewSpace=[[UIView alloc]initWithFrame:CGRectMake(0, 50, 320, 568-64.5-50)];
    UISwipeGestureRecognizer* leftSwipe=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(userSwipe:)];
    leftSwipe.direction=UISwipeGestureRecognizerDirectionLeft;
    [self.tableViewSpace addGestureRecognizer:leftSwipe];
    
    UISwipeGestureRecognizer* rightSwipe=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(userSwipe:)];
    rightSwipe.direction=UISwipeGestureRecognizerDirectionRight;
    [self.tableViewSpace addGestureRecognizer:rightSwipe];
    
    self.tableViewSpace.backgroundColor=[UIColor clearColor];
    [self.contentView addSubview:self.tableViewSpace];
}

-(void)themeViewReload{
    UIImage* image=[GetImagePath getImagePath:@"筛选中01"];
    self.bigStageImageView.image=image;
    
    self.bigStageLabel.text=@"土地信息";

    self.topLabel.text=@"土地规划/拍卖";
}

-(void)initThemeView{
    //画布themeView初始,因为上导航栏下方的阴影需要半透明,而上方部分不需要透明,所以该view分2块
    UIView* view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    [self.contentView addSubview:view];
    
    //上导航栏第一部分，非透明部分
    UIView* tempView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 48.5)];
    tempView.backgroundColor=[UIColor whiteColor];
    [view addSubview:tempView];
    
    //大标题左边的大阶段图片
    CGRect frame=CGRectMake(109, 13, 25, 22);
    self.bigStageImageView=[[UIImageView alloc]initWithFrame:frame];
    [tempView addSubview:self.bigStageImageView];
    
    //大阶段标题label
    self.bigStageLabel=[[UILabel alloc]initWithFrame:CGRectMake(139, 10, 100, 30)];
    self.bigStageLabel.font=[UIFont systemFontOfSize:15];
    [tempView addSubview:self.bigStageLabel];
    
    //小阶段标题label
    self.smallStageLabel=[[UILabel alloc]initWithFrame:CGRectMake(250, 10, 60, 30)];
    self.smallStageLabel.textColor=BlueColor;
    self.smallStageLabel.font=[UIFont systemFontOfSize:14];
    self.smallStageLabel.text=@"阶段选择";
    //self.smallStageLabel.textAlignment=NSTextAlignmentRight;
    [tempView addSubview:self.smallStageLabel];
    
    //给上面3个self的属性赋值
    [self themeViewReload];
    
    //上导航栏themeView第二部分,上导航下方阴影
    UIImageView* shadowView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 48.5, 320, 1.5)];
    shadowView.image=[GetImagePath getImagePath:@"Shadow-top"];
    shadowView.alpha=.2;
    [view addSubview:shadowView];
    
    //使该view被点击可以触发
    UIButton* button=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    [button addTarget:self action:@selector(change) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
}

-(void)change{
    NSLog(@"用户选择了筛选");
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
    self.myTableView.backgroundColor=[UIColor whiteColor];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSMutableArray* ary=[NSMutableArray array];
    for (int i=0; i<10; i++) {
        UIView* tv;
        tv=[self.tvcArray[i] view];
        [ary addObject:tv];
    }
    
    NSInteger a=[ary indexOfObject:[self.tableViewSpace.subviews lastObject]];
    
    ModificationSelectViewCell* cell=[ModificationSelectViewCell dequeueReusableCellWithTabelView:tableView identifier:@"Cell" indexPath:indexPath nowTableView:a];
    
    return cell;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSArray* path=@[@"01",@"02",@"03",@"04"];
    
    UIView* view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 37.5)];
    view.backgroundColor=RGBCOLOR(234,234,234);
    
    UIImage* image=[GetImagePath getImagePath:path[section]];
    CGRect frame=CGRectMake(0, 0, image.size.width, image.size.height);
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
    int array[4]={2,3,4,1};
    return array[section];
}

-(void)selectStage:(NSIndexPath*)indexPath{
    [self.myTableView reloadData];
    int a[4]={0,2,5,9};
    NSArray* bigStages=@[@"土地信息",@"主体设计阶段",@"主体施工阶段",@"装修阶段"];
    NSArray* smallStages=@[@"土地规划/拍卖",@"项目立项",@"地勘阶段",@"设计阶段",@"出图阶段",@"地平",@"桩基基坑",@"主体施工",@"消防/景观绿化",@"装修阶段"];
    self.currentVC.tableView.tableHeaderView=nil;
    self.currentVC=self.tvcArray[a[indexPath.section]+indexPath.row];
    NSInteger number=[self.tvcArray indexOfObject:self.currentVC];
    self.currentVC.tableView.tableHeaderView=self.besideViewAlert;
    [self.besideViewAlert setLeftText:number?smallStages[number-1]:nil rigthText:number!=9?smallStages[number+1]:nil];

    [self.tableViewSpace.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    [self.tableViewSpace addSubview:self.currentVC.view];
    [self selectCancel];
    
    self.bigStageLabel.text=bigStages[indexPath.section];
    self.topLabel.text=smallStages[a[indexPath.section]+indexPath.row];
    NSArray* path=@[@"筛选中01",@"筛选中02",@"筛选中03",@"筛选中04"];
    self.bigStageImageView.image=[GetImagePath getImagePath:path[indexPath.section]];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self selectStage:indexPath];
}

-(void)userSwipe:(UISwipeGestureRecognizer*)swipe{
    NSInteger temp=[self.tvcArray indexOfObject:self.currentVC];
    if (swipe.direction==UISwipeGestureRecognizerDirectionLeft) {
        if (temp==9) {
            return;
        }else{
            temp++;
        }
    }else{
        if (temp==0) {
            return;
        }else{
            temp--;
        }
    }
    [self selectStage:[self.tvcArray[temp] indexPath]];
}

-(void)initNavi{
    [self addBackButton];
    [self addRightButton:CGRectMake(280, 25, 28, 28) title:nil iamge:[GetImagePath getImagePath:@"020"]];
    [self addtittle:@"土地规划/拍卖"];
    self.topLabel.font=[UIFont fontWithName:@"GurmukhiMN-Bold" size:18];
}

-(void)leftAction
{
    if (self.delegate&&self.fromView==1) {
        if (self.isRelease==0) {
            AppModel* appModel=[AppModel sharedInstance];
            
            NSArray* tempAry=@[appModel.contactAry,appModel.ownerAry,appModel.explorationAry,appModel.horizonAry,appModel.designAry,appModel.pileAry];
            for (int i=0; i<tempAry.count; i++) {
                [tempAry[i] removeAllObjects];
                for (int k=0; k<[self.originContacts[i] count]; k++) {
                    [tempAry[i] addObject:self.originContacts[i][k]];
                    
                }
            }
        }
        [self.delegate backToProgramDetailViewWithIsRelease:self.isRelease];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightAction{
    OneTableViewController* oneVC=self.tvcArray[0];
    [oneVC cellTextFieldResignFirstResponder];
    TwoTableViewController* twoVC=self.tvcArray[1];
    [twoVC cellTextFieldResignFirstResponder];
    
    AppModel* appModel=[AppModel sharedInstance];
    NSLog(@"SAVE");
    
    self.shadowView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 568)];
    self.shadowView.backgroundColor=[UIColor blackColor];
    self.shadowView.alpha=.5;
    [self.view addSubview:self.shadowView];
    
    UIActivityIndicatorView *testActivityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    testActivityIndicator.center = CGPointMake(160, 284);//只能设置中心，不能设置大小
    testActivityIndicator.color = [UIColor whiteColor]; // 改变圈圈的颜色为红色； iOS5引入
    [testActivityIndicator startAnimating]; // 开始旋转
    [self.shadowView addSubview:testActivityIndicator];
    
    if (self.fromView==0) {
        NSString *stage = [ProjectStage JudgmentProjectStage:self.dataDic];
        [self.dataDic setValue:stage forKey:@"projectStage"];
        NSLog(@"%@",self.dataDic);
        
        [ProjectSqlite InsertData:self.dataDic];
        
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
        
        if (appModel.planImageArr.count) {
            for(int i=0;i<appModel.planImageArr.count;i++){
                CameraModel *model = appModel.planImageArr[i];
                [CameraSqlite InsertNewData:model];
            }
        }
        
        if (appModel.horizonImageArr.count) {
            for(int i=0;i<appModel.horizonImageArr.count;i++){
                CameraModel *model = appModel.horizonImageArr[i];
                [CameraSqlite InsertNewData:model];
            }
        }
        
        if (appModel.pilePitImageArr.count) {
            for(int i=0;i<appModel.pilePitImageArr.count;i++){
                CameraModel *model = appModel.pilePitImageArr[i];
                [CameraSqlite InsertNewData:model];
            }
        }
        
        if (appModel.mainConstructionImageArr.count) {
            for(int i=0;i<appModel.mainConstructionImageArr.count;i++){
                CameraModel *model = appModel.mainConstructionImageArr[i];
                [CameraSqlite InsertNewData:model];
            }
        }
        
        if (appModel.explorationImageArr.count) {
            for(int i=0;i<appModel.explorationImageArr.count;i++){
                CameraModel *model = appModel.explorationImageArr[i];
                [CameraSqlite InsertNewData:model];
            }
        }
        
        if (appModel.fireControlImageArr.count) {
            for(int i=0;i<appModel.fireControlImageArr.count;i++){
                CameraModel *model = appModel.fireControlImageArr[i];
                [CameraSqlite InsertNewData:model];
            }
        }
        
        if (appModel.electroweakImageArr.count) {
            for(int i=0;i<appModel.electroweakImageArr.count;i++){
                CameraModel *model = appModel.electroweakImageArr[i];
                [CameraSqlite InsertNewData:model];
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
        
        [dic setValue:[self.singleDic objectForKey:self.isRelease?@"id":@"projectID"] forKeyPath:@"id"];
        
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
                [ContactSqlite InsertUpdataServerData:[self.contacts[4] objectAtIndex:i]];
            }
        }
        
        if([self.contacts[3] count] !=0){
            for(int i=0; i<[self.contacts[3] count];i++){
                [ContactSqlite InsertUpdataServerData:[self.contacts[3] objectAtIndex:i]];
            }
        }
        
        if([self.contacts[5] count] !=0){
            for(int i=0; i<[self.contacts[5] count];i++){
                [ContactSqlite InsertUpdataServerData:[self.contacts[5] objectAtIndex:i]];
            }
        }
        
        if (!self.isRelease) {
            [self carculateImageCount];
            [self saveImage];
        }else{
            if (appModel.planImageArr.count) {
                for(int i=0;i<appModel.planImageArr.count;i++){
                    CameraModel *model = appModel.planImageArr[i];
                    [CameraSqlite InsertNewData:model];
                }
            }
            
            if (appModel.horizonImageArr.count) {
                for(int i=0;i<appModel.horizonImageArr.count;i++){
                    CameraModel *model = appModel.horizonImageArr[i];
                    [CameraSqlite InsertNewData:model];
                }
            }
            
            if (appModel.pilePitImageArr.count) {
                for(int i=0;i<appModel.pilePitImageArr.count;i++){
                    CameraModel *model = appModel.pilePitImageArr[i];
                    [CameraSqlite InsertNewData:model];
                }
            }
            
            if (appModel.mainConstructionImageArr.count) {
                for(int i=0;i<appModel.mainConstructionImageArr.count;i++){
                    CameraModel *model = appModel.mainConstructionImageArr[i];
                    [CameraSqlite InsertNewData:model];
                }
            }
            
            if (appModel.explorationImageArr.count) {
                for(int i=0;i<appModel.explorationImageArr.count;i++){
                    CameraModel *model = appModel.explorationImageArr[i];
                    [CameraSqlite InsertNewData:model];
                }
            }
            
            if (appModel.fireControlImageArr.count) {
                for(int i=0;i<appModel.fireControlImageArr.count;i++){
                    CameraModel *model = appModel.fireControlImageArr[i];
                    [CameraSqlite InsertNewData:model];
                }
            }
            
            if (appModel.electroweakImageArr.count) {
                for(int i=0;i<appModel.electroweakImageArr.count;i++){
                    CameraModel *model = appModel.electroweakImageArr[i];
                    [CameraSqlite InsertNewData:model];
                }
            }
        }
        
        if (self.gotoBigImageCount==0) {
            [self loadAlertView];
        }
    }
}

-(void)carculateImageCount{
    for(int i=0;i<self.horizonImageArr.count;i++){
        CameraModel *model = [self.horizonImageArr objectAtIndex:i];
        NSLog(@"model.a_device=%@",model.a_device);
        if([model.a_device isEqualToString:@"ios"]){
            self.gotoBigImageCount++;
        }
    }
    for(int i=0;i<self.pilePitImageArr.count;i++){
        CameraModel *model = [self.pilePitImageArr objectAtIndex:i];
        if([model.a_device isEqualToString:@"ios"]){
            self.gotoBigImageCount++;
        }
    }
    
    for(int i=0;i<self.mainConstructionImageArr.count;i++){
        CameraModel *model = [self.mainConstructionImageArr objectAtIndex:i];
        if([model.a_device isEqualToString:@"ios"]){
            self.gotoBigImageCount++;
        }
    }
    
    for(int i=0;i<self.explorationImageArr.count;i++){
        CameraModel *model = [self.explorationImageArr objectAtIndex:i];
        if([model.a_device isEqualToString:@"ios"]){
            self.gotoBigImageCount++;
        }
    }
    
    for(int i=0;i<self.fireControlImageArr.count;i++){
        CameraModel *model = [self.fireControlImageArr objectAtIndex:i];
        if([model.a_device isEqualToString:@"ios"]){
            self.gotoBigImageCount++;
        }
    }
    
    for(int i=0;i<self.electroweakImageArr.count;i++){
        CameraModel *model = [self.electroweakImageArr objectAtIndex:i];
        if([model.a_device isEqualToString:@"ios"]){
            self.gotoBigImageCount++;
        }
    }
    
    for(int i=0;i<self.planImageArr.count;i++){
        CameraModel *model = [self.planImageArr objectAtIndex:i];
        if([model.a_device isEqualToString:@"ios"]){
            self.gotoBigImageCount++;
        }
    }
}

//保存图片至数据库
-(void)saveImage{
    for(int i=0;i<self.horizonImageArr.count;i++){
        CameraModel *model = [self.horizonImageArr objectAtIndex:i];
        NSLog(@"model.a_device=%@",model.a_device);
        if([model.a_device isEqualToString:@"ios"]){
            [GetBigImage getbigimage:model.a_url];
        }else if ([model.a_device isEqualToString:@"localios"]){
            [CameraSqlite InsertNewData:model];
        }
    }
    for(int i=0;i<self.pilePitImageArr.count;i++){
        CameraModel *model = [self.pilePitImageArr objectAtIndex:i];
        if([model.a_device isEqualToString:@"ios"]){
            [GetBigImage getbigimage:model.a_url];
        }else if ([model.a_device isEqualToString:@"localios"]){
            [CameraSqlite InsertNewData:model];
        }
    }
    
    for(int i=0;i<self.mainConstructionImageArr.count;i++){
        CameraModel *model = [self.mainConstructionImageArr objectAtIndex:i];
        if([model.a_device isEqualToString:@"ios"]){
            [GetBigImage getbigimage:model.a_url];
        }else if ([model.a_device isEqualToString:@"localios"]){
            [CameraSqlite InsertNewData:model];
        }
    }
    
    for(int i=0;i<self.explorationImageArr.count;i++){
        CameraModel *model = [self.explorationImageArr objectAtIndex:i];
        if([model.a_device isEqualToString:@"ios"]){
            [GetBigImage getbigimage:model.a_url];
        }else if ([model.a_device isEqualToString:@"localios"]){
            [CameraSqlite InsertNewData:model];
        }
    }
    
    for(int i=0;i<self.fireControlImageArr.count;i++){
        CameraModel *model = [self.fireControlImageArr objectAtIndex:i];
        if([model.a_device isEqualToString:@"ios"]){
            [GetBigImage getbigimage:model.a_url];
        }else if ([model.a_device isEqualToString:@"localios"]){
            [CameraSqlite InsertNewData:model];
        }
    }
    
    for(int i=0;i<self.electroweakImageArr.count;i++){
        CameraModel *model = [self.electroweakImageArr objectAtIndex:i];
        if([model.a_device isEqualToString:@"ios"]){
            [GetBigImage getbigimage:model.a_url];
        }else if ([model.a_device isEqualToString:@"localios"]){
            [CameraSqlite InsertNewData:model];
        }
    }
    
    for(int i=0;i<self.planImageArr.count;i++){
        CameraModel *model = [self.planImageArr objectAtIndex:i];
        if([model.a_device isEqualToString:@"ios"]){
            [GetBigImage getbigimage:model.a_url];
        }else if ([model.a_device isEqualToString:@"localios"]){
            [CameraSqlite InsertNewData:model];
        }
    }
}


-(void)loadAlertView{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                    message:@"保存完毕，请到本地保存项目查看！"
                                                   delegate:self
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil,nil];
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self.shadowView removeFromSuperview];
    [self selectCancel];
    if (!self.fromView) {
        [self.tableViewSpace.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
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
        [self.tableViewSpace addSubview:self.oneTVC.view];
        [self themeViewReload];
        [self.myTableView reloadData];
    }
    if (!self.isRelease&&self.fromView) {
        [self leftAction];
    }
}

-(void)initdataDic{
    NSLog(@"initdataDic");
    int value = (arc4random() % 9999999) + 1000000;
    //土地规划/拍卖
    
    [self.dataDic setObject:[NSString stringWithFormat:@"%d",value] forKey:@"id"];
    
    [self.dataDic setObject:@"" forKey:@"auctionUnit"];
    //建立项目
    [self.dataDic setObject:@"" forKey:@"projectID"];
    [self.dataDic setObject:@"" forKey:@"projectCode"];
    [self.dataDic setObject:@"" forKey:@"projectVersion"];
    [self.dataDic setObject:@"" forKey:@"owner"];
    [self.dataDic setObject:@"" forKey:@"expectedStartTime"];
    [self.dataDic setObject:@"" forKey:@"expectedFinishTime"];
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
        NSMutableArray *arr = [UserSqlite loadList];
        UserModel *model = arr[0];
        [self.dataDic setObject:model.a_district forKey:@"district"];
        [self.dataDic setObject:model.a_province forKey:@"province"];
        [self.dataDic setObject:model.a_city forKey:@"city"];
        
        [self.dataDic setObject:@"" forKey:@"landName"];
        [self.dataDic setObject:@"" forKey:@"landAddress"];
        [self.dataDic setObject:@"" forKey:@"projectName"];
        [self.dataDic setObject:@"" forKey:@"description"];
        [self.dataDic setObject:@"" forKey:@"usage"];
        [self.dataDic setObject:@"" forKey:@"ownerType"];

        [self.dataDic setObject:@"null" forKey:@"area"];
        [self.dataDic setObject:@"null" forKey:@"plotRatio"];
        [self.dataDic setObject:@"null" forKey:@"investment"];
        [self.dataDic setObject:@"null" forKey:@"areaOfStructure"];
        [self.dataDic setObject:@"null" forKey:@"storeyHeight"];
        [self.dataDic setObject:@"null" forKey:@"foreignInvestment"];
        [self.dataDic setObject:@"0" forKey:@"longitude"];
        [self.dataDic setObject:@"0" forKey:@"latitude"];
        //出图阶段
        [self.dataDic setObject:@"null" forKey:@"propertyElevator"];
        [self.dataDic setObject:@"null" forKey:@"propertyAirCondition"];
        [self.dataDic setObject:@"null" forKey:@"propertyHeating"];
        [self.dataDic setObject:@"null" forKey:@"propertyExternalWallMeterial"];
        [self.dataDic setObject:@"null" forKey:@"propertyStealStructure"];
    }else{
        [self.dataDic setObject:@"" forKey:@"district"];
        [self.dataDic setObject:@"" forKey:@"province"];
        [self.dataDic setObject:@"" forKey:@"city"];
        
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
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"bigImage" object:nil];
    
    if (!self.fromView) {
        AppModel* app=[AppModel sharedInstance];
        app=nil;
    }
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

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
