//
//  MyTaskViewController.m
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-18.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "MyTaskViewController.h"
#import "ProjectSqlite.h"
#import "ProjectModel.h"
#import "networkConnect.h"
#import "LoginSqlite.h"
#import "ProjectModel.h"
#import "ProjectSqlite.h"
#import "ContactModel.h"
#import "ContactSqlite.h"
#import "CameraModel.h"
#import "CameraSqlite.h"
#import "ProjectStage.h"
#import "MJRefresh.h"
#import "AFAppDotNetAPIClient.h"
#import "ProgramDetailViewController.h"
@interface MyTaskViewController ()

@end

@implementation MyTaskViewController
@synthesize showArr,dataArr,contactArr;
int startIndex;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];//[[TFIndicatorView alloc]initWithFrame:CGRectMake(135, 280, 50, 50)];
    indicator.center=CGPointMake(160,305);
    indicator.color=[UIColor blackColor];
    [indicator startAnimating];
    flag =0;
    [self addBackButton];
    [self addtittle:@"我的任务"];
    [self setBgColor:[UIColor colorWithRed:(239/255.0)  green:(237/255.0)  blue:(237/255.0)  alpha:1.0]];
    startIndex = 0;
    getproject = [[GetProject alloc] init];
    self.showArr = [[NSMutableArray alloc] init];
    [self loadServer:startIndex];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 88.5, 320, 503.5) style:UITableViewStyleGrouped];
    [_tableView setBackgroundColor:[UIColor colorWithRed:(239/255.0)  green:(237/255.0)  blue:(237/255.0)  alpha:1.0]];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:_tableView];
    
    UIView *bgView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 64.5, 320, 50)];
    [bgView2 setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:bgView2];
    bgView2.alpha = 0.9;
    
    UIButton *releaseProjuctBtn =  [UIButton buttonWithType:UIButtonTypeCustom];
    releaseProjuctBtn.frame = CGRectMake(20, 74.5, 120, 36);
    [releaseProjuctBtn setTitle:@"我发布的项目" forState:UIControlStateNormal];
    releaseProjuctBtn.titleLabel.font = [UIFont fontWithName:@"GurmukhiMN-Bold" size:12];
    [releaseProjuctBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [releaseProjuctBtn addTarget:self action:@selector(releaseProjuctBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:releaseProjuctBtn];
    
    UIButton *localProjuctBtn =  [UIButton buttonWithType:UIButtonTypeCustom];
    localProjuctBtn.frame = CGRectMake(180, 74.5, 120, 36);
    [localProjuctBtn setTitle:@"本地保存项目" forState:UIControlStateNormal];
    localProjuctBtn.titleLabel.font = [UIFont fontWithName:@"GurmukhiMN-Bold" size:12];
    [localProjuctBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [localProjuctBtn addTarget:self action:@selector(localProjuctBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:localProjuctBtn];
    
    coverView=[[UIView alloc]init];//网络加载时不让点
    coverView.frame=CGRectMake(0, 64.5, 320, 50);
    coverView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:coverView];
    
    _lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(44, 112.5, 71.5, 2)];
    [_lineImage setImage:[UIImage imageNamed:@"我的任务_03.png"]];
    [self.view addSubview:_lineImage];
    
    //集成刷新控件
    [self setupRefresh];
    [self.view addSubview:indicator];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewDidAppear:(BOOL)animated{
    NSLog(@"flag %d",flag);
    if(flag == 1){
        [self.showArr removeAllObjects];
        self.showArr = [ProjectSqlite loadList];
        [_tableView reloadData];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [_tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    //[_tableView headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [_tableView addFooterWithTarget:self action:@selector(footerRereshing)];
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    [self.showArr removeAllObjects];
    startIndex = 0;
    [self loadServer:startIndex];
}

- (void)footerRereshing
{
    startIndex = startIndex +1;
    [self loadServer:startIndex];
    // 2.2秒后刷新表格UI
    /*dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.tableView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [__tableView footerEndRefreshing];
    });*/
}

-(void)releaseProjuctBtnClick{
    if (![self.view.subviews containsObject:coverView]) {
        [self.view addSubview:coverView];
    }
    [indicator startAnimating];
    flag = 0;
    [self removeRightBtn];
    [self.showArr removeAllObjects];
    [self setupRefresh];
    startIndex = 0;
    [self loadServer:startIndex];
    [UIView animateWithDuration:0.5 animations:^{
        [_lineImage setFrame:CGRectMake(44, 112.5, 71.5, 2)];
    }completion:^(BOOL finish){
    }];
}

-(void)localProjuctBtnClick{
    if (![self.view.subviews containsObject:coverView]) {
        [self.view addSubview:coverView];
    }
    flag = 1;
    [_tableView removeHeader];
    [_tableView removeFooter];
    [self addRightButton:CGRectMake(270, 25, 29, 28.5) title:nil iamge:[UIImage imageNamed:@"DRIBBBLE-icon45-blue-drops_07.png"]];
    [self.showArr removeAllObjects];
    self.showArr = [ProjectSqlite loadList];
    [_tableView reloadData];
    [UIView animateWithDuration:0.5 animations:^{
        [_lineImage setFrame:CGRectMake(205, 112.5, 71.5, 2)];
    }completion:^(BOOL finish){
        if ([self.view.subviews containsObject:coverView]) {
            [coverView removeFromSuperview];
        }
    }];
    [indicator stopAnimating];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.showArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(flag == 0){
        NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%d",indexPath.section];
        ProjectContentCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        if(self.showArr.count !=0){
            ProjectModel *model = [self.showArr objectAtIndex:indexPath.section];
            dic = [ProjectStage JudgmentStr:model];
        }
        //if(!cell){
            cell = [[ProjectContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier dic:dic];
        //}
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        NSString *CellIdentifier = [NSString stringWithFormat:@"aCell%d",indexPath.section];
        ProjectContentCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        if(self.showArr.count !=0){
            ProjectModel *model = [self.showArr objectAtIndex:indexPath.section];
            dic = [ProjectStage JudgmentStr:model];
        }
        //if(!cell){
            cell = [[ProjectContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier dic:dic];
        //}
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return 50;
    }
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 260;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //新建项目页面
    if(flag == 0){
        ProjectModel *model = [self.showArr objectAtIndex:indexPath.section];
        NSMutableDictionary *dic = [ProjectStage JudgmentStr:model];
        NSLog(@"11111111%@",model);
        NSLog(@"2222222%@",dic);
//        _newProject = [[NewProjectViewController alloc] init];
//        _newProject.fromView = 1;
//        _newProject.isRelease =0;
//        _newProject.SingleDataDic = dic;
        
        //        _newProject = nil;
        //        _newProject = [[NewProjectViewController alloc] init];
        //        _newProject.fromView = 1;
        //        _newProject.isRelease = 0;
        //        NSLog(@"%@",[dataArr objectAtIndex:indexPath.section]);
        
        //      以下为新vc的数据
        //        _newProject.SingleDataDic = [dataArr objectAtIndex:indexPath.section];
        // NSLog(@"%@",[dataArr objectAtIndex:indexPath.section]);
        ProgramDetailViewController* vc=[[ProgramDetailViewController alloc]init];
        vc.url=dic[@"url"];
        vc.isRelease=0;
       // vc.url=[dataArr objectAtIndex:indexPath.section][@"url"];
        vc.fromView=1;
        NSLog(@"uitableviewcell%@",self.showArr);
       // if ([[self.showArr objectAtIndex:indexPath.section] objectForKey:@"projectID"]) {
            vc.ID=dic[@"projectID"];
       // }
        [self.navigationController pushViewController:vc animated:YES];
        
        
        
        
        //[self.navigationController pushViewController:_newProject animated:YES];
    }else{
        NSLog(@"本地本地");
        [self.showArr removeAllObjects];
        self.showArr = [ProjectSqlite loadList];
        ProjectModel *model = [self.showArr objectAtIndex:indexPath.section];
        NSMutableDictionary *dic = [ProjectStage JudgmentStr:model];
//        _newProject = [[NewProjectViewController alloc] init];
//        _newProject.fromView = 1;
//        _newProject.isRelease =1;
//        _newProject.SingleDataDic = dic;
//        [self.navigationController pushViewController:_newProject animated:YES];
        ProgramDetailViewController* vc=[[ProgramDetailViewController alloc]init];
        vc.url=dic[@"url"];
        vc.dataDic=dic;
        NSLog(@"&&&&&&&&&&&&&&&&%@",dic);
        vc.ID=dic[@"projectID"];
        // vc.url=[dataArr objectAtIndex:indexPath.section][@"url"];
        vc.fromView=1;
        vc.isRelease=1;
        [self.navigationController pushViewController:vc animated:YES];

    }
}

- (void)rightAction
{
    if([[networkConnect sharedInstance] connectedToNetwork]){
        if(self.showArr.count == 0){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"没有数据!"
                                                           delegate:nil
                                                  cancelButtonTitle:@"取消"
                                                  otherButtonTitles:nil,nil];
            [alert show];
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"同步数据"
                                                           delegate:nil
                                                  cancelButtonTitle:@"取消"
                                                  otherButtonTitles:@"同步数据",nil];
            alert.delegate = self;
            alert.tag = 0;
            [alert show];
        }
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"网络未链接"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil,nil];
        alert.delegate = self;
        [alert show];
    }
}

-(void)addActionSheet{
    _myActionSheet = [[UIActionSheet alloc]
                      initWithTitle:nil
                      delegate:self
                      cancelButtonTitle:@"取消"
                      destructiveButtonTitle:nil
                      otherButtonTitles: @"编辑本条信息", @"删除",nil];
    _myActionSheet.destructiveButtonIndex=1;
    [_myActionSheet showInView:self.view];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView.tag == 0){
        bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
        [bgView setBackgroundColor:[UIColor blackColor]];
        UIActivityIndicatorView *testActivityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        testActivityIndicator.center = CGPointMake(160, 284);//只能设置中心，不能设置大小
        testActivityIndicator.color = [UIColor whiteColor]; // 改变圈圈的颜色为红色； iOS5引入
        [testActivityIndicator startAnimating]; // 开始旋转
        [bgView addSubview:testActivityIndicator];
        [self.view addSubview:bgView];
        NSLog(@"%@",bgView);
        bgView.alpha = 0.5;
        self.dataArr = [ProjectSqlite loadInsertData];
        [self setServer:0];
    }
}

-(void)setServer:(NSInteger)index{
    if(index<self.dataArr.count){
        ProjectModel *model = [self.dataArr objectAtIndex:index];
        NSString *starttime = [NSString stringWithFormat:@"/Date(%@000+0800)/",model.a_expectedStartTime];
        NSString *endtime = [NSString stringWithFormat:@"/Date(%@000+0800)/",model.a_expectedFinishTime];
        NSString *actualStartTime = [NSString stringWithFormat:@"/Date(%@000+0800)/",model.a_actualStartTime];
        NSDictionary *parametersdata = [[NSDictionary alloc] initWithObjectsAndKeys:
                                        model.a_landName,@"landName",
                                        model.a_projectName,@"projectName",
                                        model.a_district,@"district",
                                        model.a_province,@"province",
                                        model.a_city,@"city",
                                        model.a_landAddress,@"landAddress",
                                        model.a_area,@"area",
                                        model.a_usage,@"usage",
                                        model.a_description,@"description",
                                        starttime,@"expectedStartTime",
                                        endtime,@"expectedFinishTime",
                                        model.a_investment,@"investment",
                                        model.a_areaOfStructure,@"areaOfStructure",
                                        model.a_storeyHeight,@"storeyHeight",
                                        model.a_foreignInvestment,@"foreignInvestment",
                                        model.a_ownerType,@"ownerType",
                                        model.a_plotRatio,@"plotRatio",
                                        model.a_longitude,@"longitude",
                                        model.a_latitude,@"latitude",
                                        model.a_mainDesignStage,@"mainDesignStage",
                                        model.a_propertyElevator,@"propertyElevator",
                                        model.a_propertyAirCondition,@"propertyAirCondition",
                                        model.a_propertyHeating,@"propertyHeating",
                                        model.a_propertyExternalWallMeterial,@"propertyExternalWallMeterial",
                                        model.a_propertyStealStructure,@"propertyStealStructure",
                                        actualStartTime,@"actualStartTime",
                                        model.a_fireControl,@"fireControl",
                                        model.a_green,@"green",
                                        model.a_electroweakInstallation,@"electroweakInstallation",
                                        model.a_decorationSituation,@"decorationSituation",
                                        model.a_decorationProgress,@"decorationProgress",
                                        nil];
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
        [parameters setValue:parametersdata forKey:@"data"];
        [parameters setValue:[LoginSqlite getdata:@"UserToken" defaultdata:@"UserToken"] forKey:@"token"];
        NSLog(@"%@",parameters);
        [ProjectModel globalPostWithBlock:^(NSMutableArray *posts, NSError *error) {
            if (!error) {
                int j = index+1;
                [self setServer:j];
            }else{
                [bgView removeFromSuperview];
                bgView = nil;
            }
        } parameters:parameters aid:model.a_id];
    }else{
        NSLog(@"setServer结束");
        self.contactArr = [ContactSqlite loadInsertData];
        [self setContactServer:0];
        
    }
}

-(void)setContactServer:(NSInteger)index{
    if(index<self.contactArr.count){
        ContactModel *model = [self.contactArr objectAtIndex:index];
        //[LoginSqlite getdata:@"UserToken" defaultdata:@"UserToken"],@"userToken"
        NSDictionary *parametersdata = [[NSDictionary alloc] initWithObjectsAndKeys:model.a_contactName,@"name",model.a_mobilePhone,@"telephone",model.a_projectName,@"project",model.a_category,@"category",model.a_duties,@"duties",model.a_accountName,@"workAt",model.a_accountAddress,@"workAddress",model.a_projectId,@"projectID",model.a_projectName,@"project",model.a_baseContactID,@"baseContactID",nil];
        //NSLog(@"%@",parametersdata);
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
        [parameters setValue:parametersdata forKey:@"data"];
        [parameters setValue:[LoginSqlite getdata:@"UserToken" defaultdata:@"UserToken"] forKey:@"token"];
        //NSLog(@"%@",parameters);
        [ContactModel globalPostWithBlock:^(NSMutableArray *posts, NSError *error) {
            if (!error) {
                int j = index+1;
                [self setContactServer:j];
            }else{
                [bgView removeFromSuperview];
                bgView = nil;
            }
        } parameters:parameters aid:model.a_id];
    }else{
        NSLog(@"setContactServer结束");
        imageArr = [CameraSqlite loadList];
        [self setImageServer:0];
    }
}

-(void)setImageServer:(NSInteger)index{
    if(index<imageArr.count){
        CameraModel *model = [imageArr objectAtIndex:index];
        //[LoginSqlite getdata:@"UserToken" defaultdata:@"UserToken"],@"userToken"
        NSDictionary *parametersdata = [[NSDictionary alloc] initWithObjectsAndKeys:model.a_name,@"imgName",model.a_body,@"imgContent",model.a_projectName,@"project",model.a_type,@"category",model.a_projectID,@"projectID",@"ios",@"device",model.a_baseCameraID,@"imgID",nil];
        //NSLog(@"%@",parametersdata);
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
        [parameters setValue:parametersdata forKey:@"data"];
        [parameters setValue:[LoginSqlite getdata:@"UserToken" defaultdata:@"UserToken"] forKey:@"token"];
        
        [CameraModel globalPostWithBlock:^(NSMutableArray *posts, NSError *error) {
            if (!error) {
                int j = index+1;
                [self setImageServer:j];
            }else{
                [bgView removeFromSuperview];
                bgView = nil;
            }
        } parameters:parameters aid:model.a_id];
    }else{
        NSLog(@"setImageServer结束");
        updataProjectArr = [ProjectSqlite loadUpdataData];
        [self updataServer:0];
    }
}

-(void)updataServer:(NSInteger)index{
    NSLog(@"updataServer");
    if(index<updataProjectArr.count){
        ProjectModel *model = [updataProjectArr objectAtIndex:index];
        NSLog(@"%@",model.a_foreignInvestment);
        //[LoginSqlite getdata:@"UserToken" defaultdata:@"UserToken"],@"userToken"
        NSString *starttime = [NSString stringWithFormat:@"/Date(%@000+0800)/",model.a_expectedStartTime];
        NSString *endtime = [NSString stringWithFormat:@"/Date(%@000+0800)/",model.a_expectedFinishTime];
        NSString *actualStartTime = [NSString stringWithFormat:@"/Date(%@000+0800)/",model.a_actualStartTime];
        NSDictionary *parametersdata = [[NSDictionary alloc] initWithObjectsAndKeys:
                                        model.a_landName,@"landName",
                                        model.a_projectName,@"projectName",
                                        model.a_district,@"district",
                                        model.a_province,@"province",
                                        model.a_city,@"city",
                                        model.a_landAddress,@"landAddress",
                                        model.a_area,@"area",
                                        model.a_usage,@"usage",
                                        model.a_description,@"description",
                                        starttime,@"expectedStartTime",
                                        endtime,@"expectedFinishTime",
                                        model.a_investment,@"investment",
                                        model.a_areaOfStructure,@"areaOfStructure",
                                        model.a_storeyHeight,@"storeyHeight",
                                        model.a_foreignInvestment,@"foreignInvestment",
                                        model.a_ownerType,@"ownerType",
                                        model.a_plotRatio,@"plotRatio",
                                        model.a_longitude,@"longitude",
                                        model.a_latitude,@"latitude",
                                        model.a_mainDesignStage,@"mainDesignStage",
                                        model.a_propertyElevator,@"propertyElevator",
                                        model.a_propertyAirCondition,@"propertyAirCondition",
                                        model.a_propertyHeating,@"propertyHeating",
                                        model.a_propertyExternalWallMeterial,@"propertyExternalWallMeterial",
                                        model.a_propertyStealStructure,@"propertyStealStructure",
                                        actualStartTime,@"actualStartTime",
                                        model.a_fireControl,@"fireControl",
                                        model.a_green,@"green",
                                        model.a_electroweakInstallation,@"electroweakInstallation",
                                        model.a_decorationSituation,@"decorationSituation",
                                        model.a_decorationProgress,@"decorationProgress",
                                        model.a_projectId,@"projectID",
                                        model.a_projectCode,@"projectCode",
                                        nil];
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
        [parameters setValue:parametersdata forKey:@"data"];
        [parameters setValue:[LoginSqlite getdata:@"UserToken" defaultdata:@"UserToken"] forKey:@"token"];
        //NSLog(@"parameters ===>%@",parameters);
        [ProjectModel globalPutWithBlock:^(NSMutableArray *posts, NSError *error) {
            if(!error){
                int j = index+1;
                [self updataServer:j];
            }else{
                NSLog(@"%@",bgView);
                [bgView removeFromSuperview];
                bgView = nil;
            }
        } parameters:parameters aid:model.a_id];
    }else{
        NSLog(@"updataServer结束");
        if(flag == 1){
            [self.showArr removeAllObjects];
            self.showArr = [ProjectSqlite loadList];
        }
        [_tableView reloadData];
        [bgView removeFromSuperview];
        bgView = nil;
    }
}


-(void)loadServer:(int)startIndex{
    [ProjectModel globalMyProjectWithBlock:^(NSMutableArray *posts, NSError *error) {
        if (!error) {
            [self.showArr addObjectsFromArray:posts];
            [_tableView reloadData];
            [indicator stopAnimating];
            if(startIndex !=0){
                [_tableView footerEndRefreshing];
            }else{
                [_tableView headerEndRefreshing];
            }
            //NSLog(@"%@",bgView);
            [bgView removeFromSuperview];
            bgView = nil;
            [coverView removeFromSuperview];
            
        }
    } index:startIndex];
}
@end
