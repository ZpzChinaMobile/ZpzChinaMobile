//
//  ProgramDetailViewController.m
//  programDetail
//
//  Created by 孙元侃 on 14-8-7.
//  Copyright (c) 2014年 sunyk. All rights reserved.
//

#import "ProgramDetailViewController.h"
#import "TuDiXinXi.h"
#import "ZhuTiSheJi.h"
#import "ZhuTiShiGong.h"
#import "ZhuangXiu.h"
#import "ProgramSelectViewCell.h"
#import "ScrollViewController.h"
#import "ViewController.h"
#import "AFAppDotNetAPIClient.h"
#import "ProjectModel.h"
#import "ProjectSqlite.h"
#import "ProjectStage.h"
#import "CameraModel.h"
#import "CameraSqlite.h"
#import "GTMBase64.h"
@interface ProgramDetailViewController ()<UITableViewDataSource,UITableViewDelegate,ProgramSelectViewCellDelegate>

@property(nonatomic,strong)UIScrollView* myScrollView;
@property(nonatomic,strong)UIView* tuDiXinXi;//土地信息大模块
@property(nonatomic,strong)UIView* zhuTiSheJi;//主体设计阶段
@property(nonatomic,strong)UIView* zhuTiShiGong;//主体施工阶段
@property(nonatomic,strong)UIView* zhuangXiu;//装修阶段

@property(nonatomic)CGFloat loadNewViewStandardY;//判断是否需要加载新大阶段view的标准线
@property(nonatomic,strong)UITableView* myTableView;//筛选页面

@property(nonatomic,strong)UILabel* bigStageLabel;//上导航中 大阶段label
@property(nonatomic,strong)UILabel* smallStageLabel;//上导航中 小阶段label
@property(nonatomic,strong)UIImageView* bigStageImageView;//上导航中大阶段图片

//筛选界面中,跳转页面时,根据以下高度进行跳转到指定位置
@property(nonatomic)CGFloat firstViewFirstStage;//土地信息阶段 土地规划/拍卖
@property(nonatomic)CGFloat firstViewSecondStage;//土地信息阶段 项目立项

@property(nonatomic)CGFloat secondViewFirstStage;//主体设计阶段 地勘阶段
@property(nonatomic)CGFloat secondViewSecondStage;//主体设计阶段 设计阶段
@property(nonatomic)CGFloat secondViewThirdStage;//主体设计阶段 出图阶段

@property(nonatomic)CGFloat thirdViewFirstStage;//主体施工阶段 地平
@property(nonatomic)CGFloat thirdViewSecondStage;//主体施工阶段 桩基基坑
@property(nonatomic)CGFloat thirdViewThirdStage;//主体施工阶段 主体施工
@property(nonatomic)CGFloat thirdViewFourthStage;//主体施工阶段 消防/景观绿化


//以下4属性用于sectionHeader被点击时所需要传参数时用的东西
@property(nonatomic,strong)NSMutableArray* sectionButtonArray;

@property(nonatomic,strong)UIActivityIndicatorView* animationView;//加载新view时的菊花动画

@end

@implementation ProgramDetailViewController


-(CGFloat)loadNewViewStandardY{
    if (!self.zhuTiSheJi) {
        return 50+56+self.tuDiXinXi.frame.size.height-568+64.5;//50和76分别为themeView和给之后预留的动画view的高,568为屏幕高,64.5为伪navi高
    }else if(!self.zhuTiShiGong){
        return 50+56+self.tuDiXinXi.frame.size.height-568+self.zhuTiSheJi.frame.size.height+64.5;
    }else if(!self.zhuangXiu){
        return 50+56+self.tuDiXinXi.frame.size.height-568+self.zhuTiSheJi.frame.size.height+self.zhuTiShiGong.frame.size.height+64.5;
    }else{
        //所有view 加载完成，无需再进行加载新view
        return CGFLOAT_MAX;
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

-(instancetype)init{
    if ([super init]) {
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
    }
    return self;
}


-(void)userChangeImageWithButtons:(UIButton *)button{
    NSLog(@"userChangeImage");
    if (button==self.firstStageButton1) {
        ViewController* vc=[[ViewController alloc]init];
        CameraModel *model = self.horizonImageArr[0];
        UIImage *aimage = [UIImage imageWithData:[GTMBase64 decodeString:model.a_imgCompressionContent]];
        NSArray *a = [[NSArray alloc] initWithObjects:aimage, nil];
        vc.imagesArray= [a mutableCopy];
        [self presentViewController:vc animated:NO completion:nil];
        
        NSLog(@"firstStageButton1");
    }else if(button==self.secondStageButton1){
        ScrollViewController* vc=[[ScrollViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        NSLog(@"secondStageButton1");
    }else if(button==self.thirdStageButton1){
        ScrollViewController* vc=[[ScrollViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        NSLog(@"thirdStageButton1");
    }else if(button==self.thirdStageButton2){
        ScrollViewController* vc=[[ScrollViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        NSLog(@"thirdStageButton2");
    }else if(button==self.thirdStageButton3){
        ScrollViewController* vc=[[ScrollViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        NSLog(@"thirdStageButton3");
    }else if(button==self.fourthStageButton1){
        ScrollViewController* vc=[[ScrollViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        NSLog(@"fourthStageButton1");
    }
}


//在scrollView添加view,并将scrollView的contentSize.height增加该view的height,如果是加载装修阶段view,则取消最下方的动画区域
-(void)setOriginToView:(UIView*)view{
    CGRect frame=view.frame;
    //如果动画所在的view的高度调整，这边的-50必须修改
    frame.origin.y=self.myScrollView.contentSize.height-56;
    view.frame=frame;
    [self.myScrollView addSubview:view];
    
    CGSize size=self.myScrollView.contentSize;
    //如果动画所在的view的高度调整，这边的-50必须修改
    size.height+=frame.size.height;
    
    //如果是最后个大view装修阶段加载完，去除下方的预留动画位置
    if (self.zhuangXiu) {
        size.height-=56;
    }
    self.myScrollView.contentSize=size;
}


//观察contentOffset的值判断加载哪个新view
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if (self.myScrollView.contentOffset.y>=self.loadNewViewStandardY) {
        
        CGFloat a,b,c;//返回值为个view各部分的height
        if (!self.zhuTiSheJi) {
            //加载主体设计
            self.zhuTiSheJi=[ZhuTiSheJi zhuTiSheJiWithFirstViewHeight:&a secondView:&b delegate:self];
            self.secondViewFirstStage=self.tuDiXinXi.frame.size.height;
            self.secondViewSecondStage=a+self.tuDiXinXi.frame.size.height;
            self.secondViewThirdStage=b+self.tuDiXinXi.frame.size.height;
            
            [self addViewWithAnimation:YES view:self.zhuTiSheJi];
        }else if(!self.zhuTiShiGong){
            //加载主体施工
            self.zhuTiShiGong=[ZhuTiShiGong zhuTiShiGongWithFirstViewHeight:&a secondView:&b thirdViewHeight:&c delegate:self];
            self.thirdViewFirstStage=self.tuDiXinXi.frame.size.height+self.zhuTiSheJi.frame.size.height;
            self.thirdViewSecondStage=a+self.tuDiXinXi.frame.size.height+self.zhuTiSheJi.frame.size.height;
            self.thirdViewThirdStage=b+self.tuDiXinXi.frame.size.height+self.zhuTiSheJi.frame.size.height;
            self.thirdViewFourthStage=c+self.tuDiXinXi.frame.size.height+self.zhuTiSheJi.frame.size.height;
            
            [self addViewWithAnimation:YES view:self.zhuTiShiGong];
            
        }else if(!self.zhuangXiu){
            //加载装修
            self.zhuangXiu=[ZhuangXiu zhuangXiuWithdelegate:self ];
            [self addViewWithAnimation:YES view:self.zhuangXiu];
        }
    }
    
    //判断上导航栏的大标题和小标题
    [self getStageName];
    
}


//判断上导航栏的大标题和小标题
-(void)getStageName{
    NSArray* ary0=@[@"土地规划/拍卖",@"项目立项"];
    NSArray* ary1=@[@"地勘阶段",@"设计阶段",@"出图阶段"];
    NSArray* ary2=@[@"地平",@"桩基基坑",@"立体施工",@"消防/景观绿化"];
    NSArray* ary3=@[@""];
    
    CGFloat firstArray[2]={self.firstViewFirstStage,self.firstViewSecondStage};
    CGFloat secondArray[3]={self.secondViewFirstStage,self.secondViewSecondStage,self.secondViewThirdStage};
    CGFloat thirdArray[4]={self.thirdViewFirstStage,self.thirdViewSecondStage,self.thirdViewThirdStage,self.thirdViewFourthStage};
    //    CGFloat fourthArray[1]={self.zhuangXiu.frame.origin.y-50};
    
    if (self.zhuangXiu&&self.myScrollView.contentOffset.y>=self.zhuangXiu.frame.origin.y-568+64.5) {
        self.bigStageLabel.text=@"装修阶段";//大标题
        
        UIImage* image=[UIImage imageNamed:@"XiangMuXiangQing_3/paint_01@2x.png"];
        self.bigStageImageView.image=image;//大阶段图片
        self.bigStageImageView.bounds=CGRectMake(0, 0, image.size.width*.5, image.size.height*.5);
        
        self.smallStageLabel.text=ary3[0];//小标题
    }else if(self.zhuTiShiGong&&self.myScrollView.contentOffset.y>=self.zhuTiShiGong.frame.origin.y-568+64.5){
        self.bigStageLabel.text=@"主体施工阶段";//大标题
        
        UIImage* image=[UIImage imageNamed:@"XiangMuXiangQing_2/Subject_01@2x.png"];
        self.bigStageImageView.image=image;//大阶段图片
        self.bigStageImageView.bounds=CGRectMake(0, 0, image.size.width*.5, image.size.height*.5);
        
        for (int i=3; i>=0; i--) {//小标题
            if (self.myScrollView.contentOffset.y>=thirdArray[i]+50-568+64.5) {
                self.smallStageLabel.text=ary2[i];
                break;
            }
        }
    }else if(self.zhuTiSheJi&&self.myScrollView.contentOffset.y>=self.zhuTiSheJi.frame.origin.y-568+64.5){
        self.bigStageLabel.text=@"主体设计阶段";//大标题
        
        UIImage* image=[UIImage imageNamed:@"XiangMuXiangQing_1/pen_01@2x.png"];
        self.bigStageImageView.image=image;//大阶段图片
        self.bigStageImageView.bounds=CGRectMake(0, 0, image.size.width*.5, image.size.height*.5);
        
        for (int i=2; i>=0; i--) {//小标题
            if (self.myScrollView.contentOffset.y>=secondArray[i]+50-568+64.5) {
                self.smallStageLabel.text=ary1[i];
                break;
            }
        }
    }else{
        self.bigStageLabel.text=@"土地信息";//大标题
        
        UIImage* image=[UIImage imageNamed:@"XiangMuXiangQing/map@2x.png"];
        self.bigStageImageView.image=image;//大阶段图片
        self.bigStageImageView.bounds=CGRectMake(0, 0, image.size.width*.5, image.size.height*.5);
        
        for (int i=1; i>=0; i--) {//小标题
            if (self.myScrollView.contentOffset.y>=firstArray[i]+50-568+64.5) {
                self.smallStageLabel.text=ary0[i];
                break;
            }
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"GET" URLString:[NSString stringWithFormat:@"%s/%@",serverAddress,self.url] parameters:nil error:nil];
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSLog(@"JSON: %@", responseObject);
        NSNumber *statusCode = [[[responseObject objectForKey:@"d"] objectForKey:@"status"] objectForKey:@"statusCode"];
        if([[NSString stringWithFormat:@"%@",statusCode] isEqualToString:@"200"]){
            NSArray *zz = [[responseObject objectForKey:@"d"] objectForKey:@"data"];
            for(NSDictionary *item in zz){
                ProjectModel *model = [[ProjectModel alloc] init];
                [model loadWithDictionary:item];
                self.dataDic = [ProjectStage JudgmentStr:model];
                //NSLog(@"%@",self.dataDic);
                //NSLog(@"contactItem%d",[[item objectForKey:@"baseContacts"] count]);
                
                
                for(NSDictionary *contactItem in [item objectForKey:@"baseContacts"]){
                    NSMutableArray *resultArr = [[NSMutableArray alloc]init];
                    for (NSMutableDictionary *contactItem2 in [contactItem objectForKey:@"data"]) {
                        NSLog(@"contactItem2 ==> %@",contactItem2);
                        ContactModel *model = [[ContactModel alloc] init];
                        [model loadWithDictionary:contactItem2];
                        [resultArr addObject:model];
                    }
                    //NSLog(@"%@",self.contactArr);
                    [self addArray:resultArr projectID:self.dataDic[@"projectID"]];
                }
                
                
                for(NSDictionary *imageItem in [item objectForKey:@"projectImgs"]){
                   // NSLog(@"*******************%@",[imageItem objectForKey:@"data"]);
                    //NSMutableArray *resultArr = [[NSMutableArray alloc]init];
                    for (NSMutableDictionary *imageItem2 in [imageItem objectForKey:@"data"]) {
                        CameraModel *model = [[CameraModel alloc] init];
                        [model loadWithDictionary:imageItem2];
                        NSLog(@"--------------%@",imageItem2);
                        if([[imageItem2 objectForKey:@"category"] isEqualToString:@"horizon"]){
                            [self.horizonImageArr addObject:model];
                        }else if([[imageItem2 objectForKey:@"category"] isEqualToString:@"pileFoundation"]){
                            [self.pilePitImageArr addObject:model];
                        }else if([[imageItem2 objectForKey:@"category"] isEqualToString:@"mainPart"]){
                            [self.mainConstructionImageArr addObject:model];
                        }else if([[imageItem2 objectForKey:@"category"] isEqualToString:@"exploration"]){
                            [self.explorationImageArr addObject:model];
                        }else if([[imageItem2 objectForKey:@"category"] isEqualToString:@"fireControl"]){
                            [self.fireControlImageArr addObject:model];
                        }else if([[imageItem2 objectForKey:@"category"] isEqualToString:@"electroweak"]){
                            [self.electroweakImageArr addObject:model];
                        }
                    }
                }
            }
            
            //NSLog(@"*******************%@",self.horizonImageArr[0]);
            

            
            [self initNaviAndScrollView];//初始navi,创建返回Button,初始scrollView,初始加载新view的动画
            [self addBackButton];
            
            [self initThemeView];//主体view初始
            
            CGFloat a;
            self.tuDiXinXi=[TuDiXinXi tuDiXinXiWithFirstViewHeight:&a delegate:self];
            self.firstViewFirstStage=0;
            self.firstViewSecondStage=a;
            
            [self setOriginToView:self.tuDiXinXi];
            
            [self initTableView];
            
            [self.myScrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
            
            
        }else{
            NSLog(@"%@",[[[responseObject objectForKey:@"d"] objectForKey:@"status"] objectForKey:@"errors"]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"fail");
        
        NSLog(@"Error: %@", error);
    }];
    [[NSOperationQueue mainQueue] addOperation:op];
    
    
    /*============================================================*/
    /*============================================================*/
    /*============================================================*/
    /*============================================================*/
    /*============================================================*/
    /*============================================================*/
    /*============================================================*/
    
}


-(void)addArray:(NSMutableArray *)list projectID:(NSString *)projectID{
    NSLog(@"=======>%lu",(unsigned long)list.count);
    
    for(int i=0;i<list.count;i++){
        NSMutableDictionary *contactDic = [[NSMutableDictionary alloc] init];
        ContactModel *model = [list objectAtIndex:i];
        contactDic = [ProjectStage JudgmentContactStr:model];
        [contactDic setValue:model.a_baseContactID forKeyPath:@"id"];
        [contactDic setValue:projectID forKeyPath:@"localProjectId"];
        NSLog(@"=================%@",model.a_contactName);
        if([model.a_category isEqualToString:@"auctionUnitContacts"]){
            [self.contactAry addObject:contactDic];
        }else if([model.a_category isEqualToString:@"ownerUnitContacts"]){
            [self.ownerAry addObject:contactDic];
        }else if([model.a_category isEqualToString:@"explorationUnitContacts"]){
            [self.explorationAry addObject:contactDic];
        }else if([model.a_category isEqualToString:@"contractorUnitContacts"]){
            [self.horizonAry addObject:contactDic];
        }else if([model.a_category isEqualToString:@"designInstituteContacts"]){
            [self.designAry addObject:contactDic];
        }else if([model.a_category isEqualToString:@"pileFoundationUnitContacts"]){
            [self.pileAry addObject:contactDic];
        }
    }
}


-(void)initTableView{
    self.myTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 568-64.5) style:UITableViewStylePlain];
    self.myTableView.delegate=self;
    self.myTableView.dataSource=self;
    self.myTableView.center=CGPointMake(160, -(568-64.5)*.5);
    [self.myTableView registerClass:[ProgramSelectViewCell class] forCellReuseIdentifier:@"Cell"];
    self.myTableView.showsVerticalScrollIndicator=NO;
    self.myTableView.scrollEnabled=NO;
    self.myTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.myTableView.backgroundColor=[UIColor colorWithWhite:1 alpha:.95];
    
    //用于存放使sectionHeader可以被点击的button的array
    self.sectionButtonArray=[NSMutableArray array];
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
        default://等于case 3
            return 1;//用来放下箭头和透明view
            break;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 37.5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==3) {
        return 40;
    }else{
        return 34;
    }
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSString* mainPath=@"XiangMuXiangQing_ShaiXuan";
    NSArray* path=@[@"map@2x.png",@"pen_01@2x.png",@"Subject@2x.png",@"paint@2x.png"];
    
    UIView* view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 37.5)];
    
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
    [view addSubview:label];
    
    UIView* separatorLine=[[UIView alloc]initWithFrame:CGRectMake(47, 36.5, 273, 1)];
    separatorLine.backgroundColor=RGBCOLOR(96, 96, 96);
    [view addSubview:separatorLine];
    
    //使该sectionHeader可以被点击
    UIButton* button=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 320, 37.5)];
    [button addTarget:self action:@selector(selectSection:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    [self.sectionButtonArray addObject:button];
    
    return view;
}


//判断用户点击的是哪个sectionHeader,然后将section传过去
-(void)selectSection:(id)button{
    NSLog(@"%d",[self.sectionButtonArray indexOfObject:button]);
    [self didchangeStageSection:[self.sectionButtonArray indexOfObject:button] row:0];
}

-(BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==3) {
        return NO;
    }else{
        return YES;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //为了让sectionHeader可以被点击,所以将cell被点击之后实现的跳转加载功能封装到其他方法
    [self didchangeStageSection:indexPath.section row:indexPath.row];
}



-(void)didchangeStageSection:(NSInteger)section row:(NSInteger)row{
    NSLog(@"=======%f",self.myScrollView.contentOffset.y);
    
    CGFloat a,b,c;
    for (int i=1; i<=section; i++) {//土地信息阶段必存在，不用判断和操作
        if (!self.zhuTiSheJi&&i==1) {
            //加载主体设计
            self.zhuTiSheJi=[ZhuTiSheJi zhuTiSheJiWithFirstViewHeight:&a secondView:&b delegate:self];
            [self addViewWithAnimation:NO view:self.zhuTiSheJi];
            self.secondViewFirstStage=self.tuDiXinXi.frame.size.height;
            self.secondViewSecondStage=a+self.tuDiXinXi.frame.size.height;
            self.secondViewThirdStage=b+self.tuDiXinXi.frame.size.height;
            
        }else if(!self.zhuTiShiGong&&i==2){
            //加载主体施工
            self.zhuTiShiGong=[ZhuTiShiGong zhuTiShiGongWithFirstViewHeight:&a secondView:&b thirdViewHeight:&c delegate:self];
            [self addViewWithAnimation:NO view:self.zhuTiShiGong];
            self.thirdViewFirstStage=self.tuDiXinXi.frame.size.height+self.zhuTiSheJi.frame.size.height;
            self.thirdViewSecondStage=a+self.tuDiXinXi.frame.size.height+self.zhuTiSheJi.frame.size.height;
            self.thirdViewThirdStage=b+self.tuDiXinXi.frame.size.height+self.zhuTiSheJi.frame.size.height;
            self.thirdViewFourthStage=c+self.tuDiXinXi.frame.size.height+self.zhuTiSheJi.frame.size.height;
            
            //如果导致装修的界面需要被动画加载出来，则进行无动画加载装修view
            if (!self.zhuangXiu&&row==3) {//计算坐标比较复杂，直接从结果中判断是否需要加载装修页面,判断下来,当用户点击第三大阶段第四小阶段时,需要无动画加载装修
                self.zhuangXiu=[ZhuangXiu zhuangXiuWithdelegate:self];
                [self addViewWithAnimation:NO view:self.zhuangXiu];
            }
        }else if(!self.zhuangXiu&&i==3){
            //加载装修
            self.zhuangXiu=[ZhuangXiu zhuangXiuWithdelegate:self];
            [self addViewWithAnimation:NO view:self.zhuangXiu];
        }
    }
    
    //把标准线放入数组，容易判断
    CGFloat firstArray[2]={self.firstViewFirstStage,self.firstViewSecondStage};
    CGFloat secondArray[3]={self.secondViewFirstStage,self.secondViewSecondStage,self.secondViewThirdStage};
    CGFloat thirdArray[4]={self.thirdViewFirstStage,self.thirdViewSecondStage,self.thirdViewThirdStage,self.thirdViewFourthStage};
    
    CGFloat fourthViewFirstStage=self.zhuangXiu.frame.origin.y-50;
    CGFloat fourthArray[1]={fourthViewFirstStage};
    CGFloat* ary[4]={firstArray,secondArray,thirdArray,fourthArray};
    
    //因去除了真navi,所以不用减64.5这个自定义伪navi高了
    /*
     //遍历不太好，后期可改进
     for (int i=0; i<sizeof(firstArray)/sizeof(CGFloat); i++) {
     firstArray[i]-=64.5;
     }
     for (int i=0; i<sizeof(secondArray)/sizeof(CGFloat); i++) {
     secondArray[i]-=64.5;
     }
     for (int i=0; i<sizeof(thirdArray)/sizeof(CGFloat); i++) {
     thirdArray[i]-=64.5;
     }
     fourthArray[0]-=64.5;
     */
    
    [self.myScrollView  setContentOffset:CGPointMake(0, ary[section][row]) animated:YES];
    [self selectCancel];
    
}


//筛选界面拉回去
-(void)selectCancel{
    [UIView animateWithDuration:1 animations:^{
        self.myTableView.center=CGPointMake(160, -(568-64.5)*.5);
    } completion:^(BOOL finished){
        [self.myTableView removeFromSuperview];
    }];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ProgramSelectViewCell* cell=[ProgramSelectViewCell dequeueReusableCellWithTabelView:tableView identifier:@"Cell" indexPath:indexPath firstIcon:YES secondIcon:YES thirdIcon:YES];
    cell.delegate=self;
    
    return cell;
}

//添加一个detailView进scrollView,并判断是否需要动画，需要则动画后加入scrollView
-(void)addViewWithAnimation:(BOOL)isNeedAnimation view:(UIView*)detailView{
    if (isNeedAnimation) {
        self.animationView.center=CGPointMake(160, self.myScrollView.contentSize.height-55+17);
        [self.myScrollView addSubview:self.animationView];
        [self.animationView startAnimating];
        
        //动画区域显示正在加载哪个view的label
        UILabel* label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 20)];
        NSString* tempStr;
        if (detailView==self.zhuTiSheJi) {
            tempStr=@"主体设计";
        }else if(detailView==self.zhuTiShiGong){
            tempStr=@"主体施工";
        }else{
            tempStr=@"装修";
        }
        tempStr=[NSString stringWithFormat:@"正在加载 %@ 阶段",tempStr];
        NSMutableAttributedString* attStr=[[NSMutableAttributedString alloc]initWithString:tempStr];
        [attStr addAttribute:NSForegroundColorAttributeName value:RGBCOLOR(82, 125, 237) range:NSMakeRange(4, tempStr.length-6)];
        label.attributedText=[attStr copy];
        label.font=[UIFont systemFontOfSize:15];
        label.textAlignment=NSTextAlignmentCenter;
        label.center=CGPointMake(160, self.myScrollView.contentSize.height-55+40);
        [self.myScrollView addSubview:label];
        
        //动画时不让用户选择筛选界面中的选项，否则会出现bug
        self.myTableView.allowsSelection=NO;
        
        //触发动画,不位移，不延迟2秒
        CGRect frame=self.animationView.frame;
        frame.origin.x+=.0001;
        [UIView animateWithDuration:2 animations:^{
            self.animationView.frame=frame;
            
        } completion:^(BOOL finished){
            [self.animationView stopAnimating];
            [self setOriginToView:detailView];
            //动画时不让用户选择筛选界面中的选项，否则会出现bug,动画结束后的现在可以选择
            self.myTableView.allowsSelection=YES;
        }];
    }else{
        [self setOriginToView:detailView];
    }
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
    self.smallStageLabel.textColor=[UIColor grayColor];
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
    shadowView.alpha=.5;
    [view addSubview:shadowView];
    
    //使该view被点击可以触发
    UIButton* button=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    [button addTarget:self action:@selector(change) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
}

-(void)change{
    NSLog(@"用户选择了筛选");
    //暂时移除观察者,避免加新view时有动画
    
    //self.myTableView.allowsSelection=NO;
    [self.view addSubview:self.myTableView];
    [UIView animateWithDuration:1 animations:^{
        self.myTableView.center=CGPointMake(160, (568-64.5)*.5+64.5);
        //self.myTableView.allowsSelection=YES;
    }];
}

-(void)initNaviAndScrollView{
    //scrollView初始
    NSLog(@"============%f",self.contentView.frame.size.height);
    self.myScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, self.contentView.frame.size.height)];
    self.myScrollView.backgroundColor=RGBCOLOR(229, 229, 229);
    self.myScrollView.showsVerticalScrollIndicator=NO;
    [self.contentView addSubview:self.myScrollView];
    
    CGSize size=self.myScrollView.bounds.size;
    //预留下方动画高度
    size.height=50+56;//50是上导航的位置,56是下方动画的预留位置
    self.myScrollView.contentSize=size;
    
    //动画view控制初始
    self.animationView=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    self.animationView.color=[UIColor blackColor];
}

-(void)show{
    NSLog(@"%f",self.myScrollView.contentOffset.y);
}

-(void)dealloc{
    [self.myScrollView removeObserver:self forKeyPath:@"contentOffset"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
