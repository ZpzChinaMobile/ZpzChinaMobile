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
@interface ModificationViewController ()<UITableViewDataSource,UITableViewDelegate>
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

@property(nonatomic,strong)NSArray* tvcArray;
@end

@implementation ModificationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(instancetype)init{
    if ([super init]) {
        self.oneTVC=[[OneTableViewController alloc]init];
        self.twoTVC=[[TwoTableViewController alloc]init];
        self.threeTVC=[[ThreeTableViewController alloc]init];
        self.fourTVC=[[FourTableViewController alloc]init];
        self.fiveTVC=[[FiveTableViewController alloc]init];
        self.sixTVC=[[SixTableViewController alloc]init];
        self.sevenTVC=[[SevenTableViewController alloc]init];
        self.eightTVC=[[EightTableViewController alloc]init];
        self.nineTVC=[[NineTableViewController alloc]init];
        self.tenTVC=[[TenTableViewController alloc]init];
        
        self.tvcArray=@[self.oneTVC,self.twoTVC,self.threeTVC,self.fourTVC,self.fiveTVC,self.sixTVC,self.sevenTVC,self.eightTVC,self.nineTVC,self.tenTVC];
        
        for (int i=0; i<10; i++) {
            UITableViewController* tvc=self.tvcArray[i];
            tvc.tableView.frame=CGRectMake(0, 0, 320, 568-64.5-50);
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initNavi];
    [self initThemeView];
    [self initTableViewSpace];
    [self.tableViewSpace addSubview:self.oneTVC.tableView];
    [self initTableView];
    // Do any additional setup after loading the view.
}

-(void)initTableViewSpace{
    self.tableViewSpace=[[UIView alloc]initWithFrame:CGRectMake(0, 50, 320, 568-64.5-50)];
    self.tableViewSpace.backgroundColor=[UIColor redColor];
    [self.contentView addSubview:self.tableViewSpace];
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
    [self.view addSubview:self.myTableView];
    [UIView animateWithDuration:1 animations:^{
        self.myTableView.center=CGPointMake(160, (568-64.5)*.5+64.5);
    }];
}

//筛选界面拉回去
-(void)selectCancel{
    [UIView animateWithDuration:1 animations:^{
        self.myTableView.center=CGPointMake(160, -(568-64.5)*.5);
    } completion:^(BOOL finished){
        [self.myTableView removeFromSuperview];
    }];
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
    ModificationSelectViewCell* cell=[ModificationSelectViewCell dequeueReusableCellWithTabelView:tableView identifier:@"Cell" indexPath:indexPath nowTableView:10];
    //cell.contentView.backgroundColor=[UIColor redColor];
    NSLog(@"22");
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
    int a[4]={0,2,5,9};
    NSLog(@"%d",a[indexPath.section]+indexPath.row);
    UITableViewController* tvc=self.tvcArray[a[indexPath.section]+indexPath.row];
    [self.tableViewSpace addSubview:tvc.tableView];
    [self selectCancel];
    
    self.bigStageLabel.text=@[@"土地信息",@"主体设计阶段",@"主体施工阶段",@"装修阶段"][indexPath.section];
    self.smallStageLabel.text=@[@"土地规划/拍卖",@"项目立项",@"地勘阶段",@"设计阶段",@"出图阶段",@"地平",@"桩基基坑",@"立体施工",@"消防/景观绿化",@"装修阶段"][a[indexPath.section]+indexPath.row];
}

-(void)initNavi{
    [self addBackButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
