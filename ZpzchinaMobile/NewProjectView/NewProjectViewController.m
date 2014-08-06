//
//  NewProjectViewController.m
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-17.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "NewProjectViewController.h"
#import "ProjectSqlite.h"
#import "ContactSqlite.h"
#import "ContactModel.h"
#import "LoginSqlite.h"
#import "CameraModel.h"
#import "CameraSqlite.h"
#import "ProjectStage.h"
#import "GetBigImage.h"
@interface NewProjectViewController ()

@end

@implementation NewProjectViewController
@synthesize mainStageArr,phasedArr,cellArr,contactArr,ownerArr,explorationUnitArr,designInstituteArr;
@synthesize mysection,myrow,timeflag;
@synthesize addcontactView,locateview,datepickerview,muview,ownertypeview;
@synthesize dataDic,SingleDataDic;
@synthesize flag,fromView,isRelease;
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
    _section_2_isOn = NO;
    _section_3_isOn = NO;
    _section_4_isOn = NO;
    _openRow = NO;
    _isUpdata = NO;
    camera = [[Camera alloc] init];
    camera.delegate = self;
    dataDic = [[NSMutableDictionary alloc] init];
    contactArr = [[NSMutableArray alloc] init];
    self.ownerArr = [[NSMutableArray alloc] init];
    self.explorationUnitArr = [[NSMutableArray alloc] init];
    self.designInstituteArr = [[NSMutableArray alloc] init];
    horizonArr = [[NSMutableArray alloc] init];
    pileFoundationUnitArr = [[NSMutableArray alloc] init];
    horizonImageArr = [[NSMutableArray alloc] init];
    pilePitImageArr = [[NSMutableArray alloc] init];
    mainConstructionImageArr = [[NSMutableArray alloc] init];
    explorationImageArr = [[NSMutableArray alloc] init];
    fireControlImageArr = [[NSMutableArray alloc] init];
    electroweakImageArr = [[NSMutableArray alloc] init];
    if(self.fromView == 0){
        [self addtittle:@"新建项目"];
        [self addRightButton:CGRectMake(280, 25, 29, 28.5) title:nil iamge:[UIImage imageNamed:@"icon__09.png"]];
        [self initdataDic];
        //NSLog(@"%@",dataDic);
    }else{
        //NSLog(@"==> %@",[self.SingleDataDic objectForKey:@"projectName"]);
        [self addRightButton:CGRectMake(280, 25, 29, 28.5) title:nil iamge:[UIImage imageNamed:@"icon__09.png"]];
        [self initdataDic];
        [self addtittle:[self.SingleDataDic objectForKey:@"projectName"]];
        if(isRelease == 0){
            //NSLog(@"%@",self.SingleDataDic);
            [self loadProjectValue:[self.SingleDataDic objectForKey:@"url"]];
        }else{
            //NSLog(@"%@",self.SingleDataDic);
            [self loadLocalContact:[self.SingleDataDic objectForKey:@"id"]];
            [self loadLocalImage:[self.SingleDataDic objectForKey:@"id"]];
        }
    }
    [self addBackButton];
    
    [self.contentView setBackgroundColor:[UIColor colorWithRed:(239/255.0)  green:(237/255.0)  blue:(237/255.0)  alpha:1.0]];
    
    self.mainStageArr = [[NSMutableArray alloc] initWithObjects:@"土地信息阶段",@"主体设计阶段",@"主体施工阶段",@"装修阶段", nil];
    self.phasedArr = [[NSMutableArray alloc] initWithObjects:@"土地规划/拍卖",@"项目立项",@"地勘阶段",@"设计阶段",@"出图阶段",@"地平",@"桩基基坑",@"主体施工",@"消防",@"景观绿化",@"弱电安装",@"装修情况",@"装修进度" ,nil];
    self.cellArr = [[NSMutableArray alloc] init];
    bgviewcontroller = [[UIViewController alloc] init];
    [bgviewcontroller.view setFrame:CGRectMake(0, 0, 320, self.contentView.frame.size.height)];
    //[self.contentView addSubview:bgviewcontroller.view];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(5, 0, 310, self.contentView.frame.size.height) style:UITableViewStylePlain];
    [_tableView setBackgroundColor:[UIColor colorWithRed:(239/255.0)  green:(237/255.0)  blue:(237/255.0)  alpha:1.0]];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [bgviewcontroller.view addSubview:_tableView];
    [self.contentView addSubview:bgviewcontroller.view];
    didSection = self.phasedArr.count+1;
}

-(void)initdataDic{
    int value = (arc4random() % 9999999) + 1000000;
    //土地规划/拍卖
    [dataDic setObject:[NSString stringWithFormat:@"%d",value] forKey:@"id"];
    [dataDic setObject:@"" forKey:@"landName"];
    [dataDic setObject:@"" forKey:@"district"];
    [dataDic setObject:@"" forKey:@"province"];
    [dataDic setObject:@"" forKey:@"landAddress"];
    [dataDic setObject:@"" forKey:@"city"];
    [dataDic setObject:@"" forKey:@"usage"];
    [dataDic setObject:@"" forKey:@"auctionUnit"];
    //建立项目
    [dataDic setObject:@"" forKey:@"projectID"];
    [dataDic setObject:@"" forKey:@"projectCode"];
    [dataDic setObject:@"" forKey:@"projectName"];
    [dataDic setObject:@"" forKey:@"projectVersion"];
    [dataDic setObject:@"" forKey:@"description"];
    [dataDic setObject:@"" forKey:@"owner"];
    [dataDic setObject:@"" forKey:@"expectedStartTime"];
    [dataDic setObject:@"" forKey:@"expectedFinishTime"];
    [dataDic setObject:@"" forKey:@"ownerType"];
    //地勘阶段
    [dataDic setObject:@"" forKey:@"mainDesignStage"];
    //地平
    [dataDic setObject:@"" forKey:@"actualStartTime"];
    //消防
    [dataDic setObject:@"" forKey:@"fireControl"];
    //景观绿化
    [dataDic setObject:@"" forKey:@"green"];
    //装修阶段
    [dataDic setObject:@"" forKey:@"electroweakInstallation"];
    [dataDic setObject:@"" forKey:@"decorationSituation"];
    [dataDic setObject:@"" forKey:@"decorationProgress"];
    [dataDic setObject:@"" forKey:@"url"];
    
    if(self.fromView == 0){
        [dataDic setObject:@"0" forKey:@"area"];
        [dataDic setObject:@"0" forKey:@"plotRatio"];
        [dataDic setObject:@"0" forKey:@"investment"];
        [dataDic setObject:@"0" forKey:@"areaOfStructure"];
        [dataDic setObject:@"0" forKey:@"storeyHeight"];
        [dataDic setObject:@"0" forKey:@"foreignInvestment"];
        [dataDic setObject:@"0" forKey:@"longitude"];
        [dataDic setObject:@"0" forKey:@"latitude"];
        //出图阶段
        [dataDic setObject:@"0" forKey:@"propertyElevator"];
        [dataDic setObject:@"0" forKey:@"propertyAirCondition"];
        [dataDic setObject:@"0" forKey:@"propertyHeating"];
        [dataDic setObject:@"0" forKey:@"propertyExternalWallMeterial"];
        [dataDic setObject:@"0" forKey:@"propertyStealStructure"];
    }else{
        [dataDic setObject:@"" forKey:@"area"];
        [dataDic setObject:@"" forKey:@"plotRatio"];
        [dataDic setObject:@"" forKey:@"investment"];
        [dataDic setObject:@"" forKey:@"areaOfStructure"];
        [dataDic setObject:@"" forKey:@"storeyHeight"];
        [dataDic setObject:@"" forKey:@"foreignInvestment"];
        [dataDic setObject:@"" forKey:@"longitude"];
        [dataDic setObject:@"" forKey:@"latitude"];
        //出图阶段
        [dataDic setObject:@"" forKey:@"propertyElevator"];
        [dataDic setObject:@"" forKey:@"propertyAirCondition"];
        [dataDic setObject:@"" forKey:@"propertyHeating"];
        [dataDic setObject:@"" forKey:@"propertyExternalWallMeterial"];
        [dataDic setObject:@"" forKey:@"propertyStealStructure"];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
//保存数据
- (void)rightAction
{
    bgView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
    [bgView2 setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:bgView2];
    bgView2.alpha = 0.5;
    if(self.fromView == 0){
        if(_isUpdata){
            [ProjectSqlite InsertData:dataDic];
            if(contactArr.count !=0){
                for(int i=0; i<contactArr.count;i++){
                    [ContactSqlite InsertData:[contactArr objectAtIndex:i]];
                }
            }
            
            if(self.ownerArr.count !=0){
                for(int i=0; i<self.ownerArr.count;i++){
                    [ContactSqlite InsertData:[self.ownerArr objectAtIndex:i]];
                }
            }
            
            if(self.explorationUnitArr.count !=0){
                for(int i=0; i<self.explorationUnitArr.count;i++){
                    [ContactSqlite InsertData:[self.explorationUnitArr objectAtIndex:i]];
                }
            }
            
            if(self.designInstituteArr.count !=0){
                for(int i=0; i<self.designInstituteArr.count;i++){
                    [ContactSqlite InsertData:[self.designInstituteArr objectAtIndex:i]];
                }
            }
            
    
            if(horizonArr.count !=0){
                for(int i=0; i<horizonArr.count;i++){
                    [ContactSqlite InsertData:[horizonArr objectAtIndex:i]];
                }
            }
            
            if(pileFoundationUnitArr.count !=0){
                for(int i=0; i<pileFoundationUnitArr.count;i++){
                    [ContactSqlite InsertData:[pileFoundationUnitArr objectAtIndex:i]];
                }
            }
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"保存完毕，请到本地保存项目查看！"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil,nil];
            [alert show];
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"请填写内容！"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil,nil];
            [alert show];
        }
        
    }else{
        if(_isUpdata){
            //NSLog(@"==>%@",[ProjectStage JudgmentProjectLog:self.SingleDataDic newDic:dataDic]);
            NSMutableDictionary *dic = [ProjectStage JudgmentUpdataProjectStr:self.SingleDataDic newDic:dataDic];
            if(isRelease ==0){
                [dic setValue:[self.SingleDataDic objectForKey:@"projectID"] forKeyPath:@"id"];
                for(int i=0;i<horizonImageArr.count;i++){
                    CameraModel *model = [horizonImageArr objectAtIndex:i];
                    if([model.a_device isEqualToString:@"ios"]){
                        [GetBigImage getbigimage:model.a_url];
                    }
                }
                for(int i=0;i<pilePitImageArr.count;i++){
                    CameraModel *model = [pilePitImageArr objectAtIndex:i];
                    if([model.a_device isEqualToString:@"ios"]){
                        [GetBigImage getbigimage:model.a_url];
                    }
                }
                
                for(int i=0;i<mainConstructionImageArr.count;i++){
                    CameraModel *model = [mainConstructionImageArr objectAtIndex:i];
                    if([model.a_device isEqualToString:@"ios"]){
                        [GetBigImage getbigimage:model.a_url];
                    }
                }
                
                for(int i=0;i<explorationImageArr.count;i++){
                    CameraModel *model = [explorationImageArr objectAtIndex:i];
                    if([model.a_device isEqualToString:@"ios"]){
                        [GetBigImage getbigimage:model.a_url];
                    }
                }
                
                for(int i=0;i<fireControlImageArr.count;i++){
                    CameraModel *model = [fireControlImageArr objectAtIndex:i];
                    if([model.a_device isEqualToString:@"ios"]){
                        [GetBigImage getbigimage:model.a_url];
                    }
                }
                
                for(int i=0;i<electroweakImageArr.count;i++){
                    CameraModel *model = [electroweakImageArr objectAtIndex:i];
                    if([model.a_device isEqualToString:@"ios"]){
                        [GetBigImage getbigimage:model.a_url];
                    }
                }
            }else{
                [dic setValue:[self.SingleDataDic objectForKey:@"id"] forKeyPath:@"id"];
            }
            [ProjectSqlite InsertUpdataServerData:dic];
            if(contactArr.count !=0){
                for(int i=0; i<contactArr.count;i++){
                    [ContactSqlite InsertUpdataServerData:[contactArr objectAtIndex:i]];
                }
            }
            
            if(self.ownerArr.count !=0){
                for(int i=0; i<self.ownerArr.count;i++){
                    [ContactSqlite InsertUpdataServerData:[self.ownerArr objectAtIndex:i]];
                }
            }
            
            if(self.explorationUnitArr.count !=0){
                for(int i=0; i<self.explorationUnitArr.count;i++){
                    [ContactSqlite InsertUpdataServerData:[self.explorationUnitArr objectAtIndex:i]];
                }
            }
            
            if(self.designInstituteArr.count !=0){
                for(int i=0; i<self.designInstituteArr.count;i++){
                    [ContactSqlite InsertData:[self.designInstituteArr objectAtIndex:i]];
                }
            }
            
            if(horizonArr.count !=0){
                for(int i=0; i<horizonArr.count;i++){
                    [ContactSqlite InsertData:[horizonArr objectAtIndex:i]];
                }
            }
            
            if(pileFoundationUnitArr.count !=0){
                for(int i=0; i<pileFoundationUnitArr.count;i++){
                    [ContactSqlite InsertData:[pileFoundationUnitArr objectAtIndex:i]];
                }
            }
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"保存完毕，请到本地保存项目查看！"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil,nil];
            [alert show];
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"请填写内容！"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil,nil];
            [alert show];
        }
    }
}

-(void)loadProjectValue:(NSString *)url{
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"GET" URLString:[NSString stringWithFormat:@"%s/%@",serverAddress,url] parameters:nil error:nil];
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSLog(@"JSON: %@", responseObject);
        NSNumber *statusCode = [[[responseObject objectForKey:@"d"] objectForKey:@"status"] objectForKey:@"statusCode"];
        if([[NSString stringWithFormat:@"%@",statusCode] isEqualToString:@"200"]){
            NSArray *a = [[responseObject objectForKey:@"d"] objectForKey:@"data"];
            for(NSDictionary *item in a){
                ProjectModel *model = [[ProjectModel alloc] init];
                [model loadWithDictionary:item];
                self.SingleDataDic = [ProjectStage JudgmentStr:model];
                //NSLog(@"%@",[item objectForKey:@"baseContacts"]);
                for(NSDictionary *contactItem in [item objectForKey:@"baseContacts"]){
                    //NSLog(@"%@",[item2 objectForKey:@"data"]);
                    NSMutableArray *resultArr = [[NSMutableArray alloc]init];
                    for (NSMutableDictionary *contactItem2 in [contactItem objectForKey:@"data"]) {
                        //NSLog(@"%@",item3);
                        ContactModel *model = [[ContactModel alloc] init];
                        [model loadWithDictionary:contactItem2];
                        [resultArr addObject:model];
                    }
                    //NSLog(@"%@",self.contactArr);
                    [self addArray:resultArr projectID:[self.SingleDataDic objectForKey:@"projectID"]];
                }
                
                for(NSDictionary *imageItem in [item objectForKey:@"projectImgs"]){
                    //NSLog(@"%@",[item2 objectForKey:@"data"]);
                    //NSMutableArray *resultArr = [[NSMutableArray alloc]init];
                    for (NSMutableDictionary *imageItem2 in [imageItem objectForKey:@"data"]) {
                        CameraModel *model = [[CameraModel alloc] init];
                        [model loadWithDictionary:imageItem2];
                        if([[imageItem2 objectForKey:@"category"] isEqualToString:@"horizon"]){
                            [horizonImageArr addObject:model];
                        }else if([[imageItem2 objectForKey:@"category"] isEqualToString:@"pileFoundation"]){
                            [pilePitImageArr addObject:model];
                        }else if([[imageItem2 objectForKey:@"category"] isEqualToString:@"mainPart"]){
                            [mainConstructionImageArr addObject:model];
                        }else if([[imageItem2 objectForKey:@"category"] isEqualToString:@"exploration"]){
                            [explorationImageArr addObject:model];
                        }else if([[imageItem2 objectForKey:@"category"] isEqualToString:@"fireControl"]){
                            [fireControlImageArr addObject:model];
                        }else if([[imageItem2 objectForKey:@"category"] isEqualToString:@"electroweak"]){
                            [electroweakImageArr addObject:model];
                        }
                    }
                }
            }
            //[self loadContact:[self.SingleDataDic objectForKey:@"projectID"]];
            //[self loadImage:[self.SingleDataDic objectForKey:@"projectID"]];
            [_tableView reloadData];
        }else{
            NSLog(@"%@",[[[responseObject objectForKey:@"d"] objectForKey:@"status"] objectForKey:@"errors"]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    [[NSOperationQueue mainQueue] addOperation:op];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(self.fromView == 0){
        [self initdataDic];
    }
    [bgView2 removeFromSuperview];
    bgView2 = nil;
    [_tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == didSection) {
        return 1;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.phasedArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 350;
    }else if(indexPath.section == 1){
        return 550;
    }else if(indexPath.section == 3 || indexPath.section == 5){
        return 100;
    }else if(indexPath.section ==4){
        return 400;
    }else if(indexPath.section == 7){
        return 400;
    }else if(indexPath.section == 2 ||indexPath.section == 8 || indexPath.section == 10){
        return 150;
    }else{
        return 50;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return 109;
    }else if(section == 2 || section ==5 || section == 10 || section == 13){
        return 84;
    }else{
        return 46;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(section == 0){
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 310, 109)];
        [bgView setBackgroundColor:[UIColor colorWithRed:(245/255.0)  green:(244/255.0)  blue:(244/255.0)  alpha:1.0]];
        UILabel *countLabel = [[UILabel alloc] initWithFrame:CGRectMake(130, 10, 100, 20)];
        countLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:12];
        countLabel.textColor = GrayColor;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy/MM/dd"];
        NSString *dateStr = [dateFormatter stringFromDate:[NSDate date]];
        countLabel.text = dateStr;
        [bgView addSubview:countLabel];
        
        UIImageView *smallBgImage = [[UIImageView alloc] initWithFrame:CGRectMake(18,59, 6, 11)];
        [smallBgImage setBackgroundColor:[UIColor blackColor]];
        [bgView addSubview:smallBgImage];
        smallBgImage.alpha = 0.1;
        
        UIImageView *smallImage = [[UIImageView alloc] initWithFrame:CGRectMake(11.5, 40, 19, 19)];
        [smallImage setImage:[UIImage imageNamed:@"新建项目5_06.png"]];
        [bgView addSubview:smallImage];
        
        UILabel *countLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(45, 40, 160, 25)];
        countLabel2.font = [UIFont fontWithName:@"GurmukhiMN-Bold" size:17];
        countLabel2.textColor = BlueColor;
        countLabel2.text = [self.mainStageArr objectAtIndex:0];
        [bgView addSubview:countLabel2];
        
        
        UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 65, 310, 44)];
        [topView setBackgroundColor:[UIColor colorWithRed:(245/255.0)  green:(244/255.0)  blue:(244/255.0)  alpha:1.0]];
        
        UIImageView *bgImage = [[UIImageView alloc] initWithFrame:CGRectMake(18,0, 6, 44)];
        [bgImage setBackgroundColor:[UIColor blackColor]];
        [topView addSubview:bgImage];
        bgImage.alpha = 0.1;
        
        UIImageView *smallImage2 = [[UIImageView alloc] initWithFrame:CGRectMake(13,14, 16, 16)];
        [smallImage2 setImage:[UIImage imageNamed:@"新建项目5_12.png"]];
        [topView addSubview:smallImage2];
        
        UILabel *countLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(100, 10, 160, 20)];
        countLabel3.font = [UIFont fontWithName:@"GurmukhiMN" size:16];
        countLabel3.textColor = BlueColor;
        countLabel3.text = @"土地规划/拍卖";
        [topView addSubview:countLabel3];
        
        UIImageView *arrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(280,16, 8, 12.5)];
        [arrowImage setImage:[UIImage imageNamed:@"新建项目5_09.png"]];
        [topView addSubview:arrowImage];
        
        UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
        [bt setFrame:CGRectMake(0, 0, 310, 44)];
        [bt setTag:section];
        [bt addTarget:self action:@selector(addCell:) forControlEvents:UIControlEventTouchUpInside];
        [topView addSubview:bt];
        [bgView addSubview:topView];
        return bgView;
    }else if(section == 2 || section ==5 || section ==10 || section ==13){
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 310, 90)];
        UIImageView *smallBgImage = [[UIImageView alloc] initWithFrame:CGRectMake(18,0, 6, 40)];
        [smallBgImage setBackgroundColor:[UIColor blackColor]];
        [bgView addSubview:smallBgImage];
        smallBgImage.alpha = 0.1;
        
        UIImageView *smallImage = [[UIImageView alloc] initWithFrame:CGRectMake(11.5, 10, 19, 19)];
        [smallImage setImage:[UIImage imageNamed:@"新建项目5_06.png"]];
        [bgView addSubview:smallImage];
        
        UILabel *countLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(45, 10, 160, 25)];
        countLabel2.font = [UIFont fontWithName:@"GurmukhiMN-Bold" size:17];
        countLabel2.textColor = BlueColor;
        if(section == 2){
            countLabel2.text = @"主体设计阶段";
        }else if(section == 5){
            countLabel2.text = @"主体施工阶段";
        }else if(section ==10){
            countLabel2.text = @"装修阶段";
        }/*else{
            countLabel2.text = @"关联项目";
        }*/
        [bgView addSubview:countLabel2];
        
        UIButton *moreBtn =  [UIButton buttonWithType:UIButtonTypeCustom];
        moreBtn.frame = CGRectMake(260,8, 35, 25);
        moreBtn.tag = section;
        if(section == 2 ){
            [moreBtn setBackgroundImage:[UIImage imageNamed:@"补充_03.png"] forState:UIControlStateNormal];
            [moreBtn addTarget:self action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [bgView addSubview:moreBtn];
        }else if(section == 5){
            [moreBtn setBackgroundImage:[UIImage imageNamed:@"补充_03.png"] forState:UIControlStateNormal];
            [moreBtn addTarget:self action:@selector(moreBtnClick2:) forControlEvents:UIControlEventTouchUpInside];
            [bgView addSubview:moreBtn];
        }else if(section == 10){
            [moreBtn setBackgroundImage:[UIImage imageNamed:@"补充_03.png"] forState:UIControlStateNormal];
            [moreBtn addTarget:self action:@selector(moreBtnClick3:) forControlEvents:UIControlEventTouchUpInside];
            [bgView addSubview:moreBtn];
        }
        
        UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 40, 310, 44)];
        [topView setBackgroundColor:[UIColor colorWithRed:(245/255.0)  green:(244/255.0)  blue:(244/255.0)  alpha:1.0]];
        
        UIImageView *bgImage = [[UIImageView alloc] initWithFrame:CGRectMake(18,0, 6, 44)];
        [bgImage setBackgroundColor:[UIColor blackColor]];
        [topView addSubview:bgImage];
        bgImage.alpha = 0.1;
        
        UIImageView *smallImage2 = [[UIImageView alloc] initWithFrame:CGRectMake(13,14, 16, 16)];
        [smallImage2 setImage:[UIImage imageNamed:@"新建项目5_12.png"]];
        [topView addSubview:smallImage2];
        
        UILabel *countLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(100, 10, 160, 20)];
        countLabel3.font = [UIFont fontWithName:@"GurmukhiMN" size:16];
        countLabel3.textColor = BlueColor;
        countLabel3.text = [self.phasedArr objectAtIndex:section];
        [topView addSubview:countLabel3];
        
        UIImageView *arrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(280,16, 8, 12.5)];
        [arrowImage setImage:[UIImage imageNamed:@"新建项目5_09.png"]];
        [topView addSubview:arrowImage];
        
        UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
        [bt setFrame:CGRectMake(0, 0, 310, 44)];
        [bt setTag:section];
        [bt addTarget:self action:@selector(addCell:) forControlEvents:UIControlEventTouchUpInside];
        [topView addSubview:bt];
        [bgView addSubview:topView];
        return bgView;
    }else{
        UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 310, 44)];
        [topView setBackgroundColor:[UIColor colorWithRed:(245/255.0)  green:(244/255.0)  blue:(244/255.0)  alpha:1.0]];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 310, 2)];
        [lineView setBackgroundColor:[UIColor whiteColor]];
        [topView addSubview:lineView];
        
        UIImageView *bgImage = [[UIImageView alloc] initWithFrame:CGRectMake(18,0, 6, 46)];
        [bgImage setBackgroundColor:[UIColor blackColor]];
        [topView addSubview:bgImage];
        bgImage.alpha = 0.1;
        
        UIImageView *smallImage2 = [[UIImageView alloc] initWithFrame:CGRectMake(13,14, 16, 16)];
        [smallImage2 setImage:[UIImage imageNamed:@"新建项目5_12.png"]];
        [topView addSubview:smallImage2];
        
        UILabel *countLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(100, 10, 160, 20)];
        countLabel3.font = [UIFont fontWithName:@"GurmukhiMN" size:16];
        countLabel3.textColor = BlueColor;
        countLabel3.text = [self.phasedArr objectAtIndex:section];
        [topView addSubview:countLabel3];
        
        UIImageView *arrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(280,16, 8, 12.5)];
        [arrowImage setImage:[UIImage imageNamed:@"新建项目5_09.png"]];
        [topView addSubview:arrowImage];
        
        UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
        [bt setFrame:CGRectMake(0, 0, 310, 44)];
        [bt setTag:section];
        [bt addTarget:self action:@selector(addCell:) forControlEvents:UIControlEventTouchUpInside];
        [topView addSubview:bt];
        return topView;
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        NSString *stringcell = @"PlanAndAuctionTableViewCell";
        PlanAndAuctionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:stringcell];
        if(self.fromView == 0){
            cell = [[PlanAndAuctionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stringcell dic:dataDic singleDic:nil flag:self.fromView contactArr:contactArr] ;
        }else{
            cell = [[PlanAndAuctionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stringcell dic:dataDic singleDic:self.SingleDataDic flag:self.fromView contactArr:contactArr] ;
        }
        cell.delegate = self;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }else if(indexPath.section == 1){
        NSString *stringcell = @"ProjectTableViewCell";
        ProjectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:stringcell];
        if(self.fromView == 0){
            cell = [[ProjectTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stringcell dic:dataDic flag:self.fromView ownerArr:self.ownerArr singleDic:nil] ;
        }else{
            cell = [[ProjectTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stringcell dic:dataDic flag:self.fromView ownerArr:self.ownerArr singleDic:self.SingleDataDic] ;
        }
        cell.delegate = self;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        [self.cellArr addObject:cell];
        return cell;
    }else if(indexPath.section == 2){
        cameraflag = 3;
        NSString *stringcell = @"GeologicalSurveyTableViewCell";
        GeologicalSurveyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:stringcell];
        cell = [[GeologicalSurveyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stringcell flag:self.fromView Arr:self.explorationUnitArr explorationImageArr:explorationImageArr] ;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        [self.cellArr addObject:cell];
        return cell;
    }else if(indexPath.section == 3){
        NSString *stringcell = @"DesignTableViewCell";
        DesignTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:stringcell];
        if(self.fromView == 0){
            cell = [[DesignTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stringcell dic:dataDic flag:self.fromView Arr:self.designInstituteArr singleDic:nil] ;
        }else{
            cell = [[DesignTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stringcell dic:dataDic flag:self.fromView Arr:self.designInstituteArr singleDic:self.SingleDataDic] ;
        }
        cell.delegate = self;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        [self.cellArr addObject:cell];
        return cell;
    }else if(indexPath.section == 4){
        NSString *stringcell = @"PlotTableViewCell";
        PlotTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:stringcell];
        if(self.fromView == 0){
            cell = [[PlotTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stringcell dic:dataDic flag:self.fromView Arr:self.ownerArr singleDic:nil] ;
        }else{
            cell = [[PlotTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stringcell dic:dataDic flag:self.fromView Arr:self.ownerArr singleDic:self.SingleDataDic] ;
        }
        cell.delegate = self;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        [self.cellArr addObject:cell];
        return cell;
    }else if(indexPath.section == 5){
        cameraflag = 0;
        NSString *stringcell = @"HorizonTableViewCell";
        HorizonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:stringcell];
        if(self.fromView == 0){
            cell = [[HorizonTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stringcell dic:dataDic flag:self.fromView Arr:horizonArr singleDic:nil] ;
        }else{
            cell = [[HorizonTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stringcell dic:dataDic flag:self.fromView Arr:horizonArr singleDic:self.SingleDataDic] ;
        }
        cell.delegate = self;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        [self.cellArr addObject:cell];
        return cell;
    }else if(indexPath.section == 6){
        cameraflag = 1;
        NSString *stringcell = @"PilePitTableViewCell";
        PilePitTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:stringcell];
        cell = [[PilePitTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stringcell flag:self.fromView Arr:pileFoundationUnitArr] ;
        cell.delegate = self;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        [self.cellArr addObject:cell];
        return cell;
    }else if(indexPath.section == 7){
        cameraflag = 2;
        NSString *stringcell = @"MainConstructionTableViewCell";
        MainConstructionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:stringcell];
        cell = [[MainConstructionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stringcell flag:self.fromView HorizonArr:horizonImageArr PilePitArr:pilePitImageArr MainConstructionArr:mainConstructionImageArr isRelease:isRelease] ;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        [self.cellArr addObject:cell];
        return cell;
    }else if(indexPath.section == 8){
        cameraflag = 4;
        NSString *stringcell = @"FirefightingTableViewCell";
        FirefightingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:stringcell];
        if(self.fromView == 0){
            cell = [[FirefightingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stringcell dic:dataDic flag:self.fromView singleDic:nil fireControlArr:fireControlImageArr] ;
        }else{
            cell = [[FirefightingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stringcell dic:dataDic flag:self.fromView singleDic:self.SingleDataDic fireControlArr:fireControlImageArr] ;
        }
        cell.delegate = self;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        [self.cellArr addObject:cell];
        return cell;
    }else if(indexPath.section == 9){
        NSString *stringcell = @"LandscapingTableViewCell";
        LandscapingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:stringcell];
        if(self.fromView == 0){
            cell = [[LandscapingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stringcell dic:dataDic flag:self.fromView singleDic:nil] ;
        }else{
            cell = [[LandscapingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stringcell dic:dataDic flag:self.fromView singleDic:self.SingleDataDic] ;
        }
        cell.delegate = self;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        [self.cellArr addObject:cell];
        return cell;
    }else if(indexPath.section ==10){
        cameraflag = 5;
        NSString *stringcell = @"WeakinstallationTableViewCell";
        WeakinstallationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:stringcell];
        if(self.fromView == 0){
            cell = [[WeakinstallationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stringcell dic:dataDic flag:self.fromView singleDic:nil electroweakArr:electroweakImageArr] ;
        }else{
            cell = [[WeakinstallationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stringcell dic:dataDic flag:self.fromView singleDic:self.SingleDataDic electroweakArr:electroweakImageArr] ;
        }
        cell.delegate = self;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        [self.cellArr addObject:cell];
        return cell;
    }else if(indexPath.section == 11){
        NSString *stringcell = @"DecorationTableViewCell";
        DecorationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:stringcell];
        if(self.fromView == 0){
            cell = [[DecorationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stringcell dic:dataDic flag:self.fromView singleDic:nil] ;
        }else{
            cell = [[DecorationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stringcell dic:dataDic flag:self.fromView singleDic:self.SingleDataDic] ;
        }
        cell.delegate = self;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        [self.cellArr addObject:cell];
        return cell;
    }else if(indexPath.section == 12){
        NSString *stringcell = @"RenovationprogressTableViewCell";
        RenovationprogressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:stringcell];
        if(self.fromView == 0){
            cell = [[RenovationprogressTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stringcell dic:dataDic flag:self.fromView singleDic:nil] ;
        }else{
            cell = [[RenovationprogressTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stringcell dic:dataDic flag:self.fromView singleDic:self.SingleDataDic] ;
        }
        cell.delegate = self;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        [self.cellArr addObject:cell];
        return cell;
    }else{
        static NSString *CellWithIdentifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellWithIdentifier];
        }
        return cell;
    }
}

- (void)addCell:(UIButton *)bt{
    endSection = bt.tag;
    if (didSection== self.phasedArr.count+1) {
        _openRow = NO;
        didSection = endSection;
        [self didSelectCellRowFirstDo:YES nextDo:NO];
    }
    else{
        if (didSection==endSection) {
            [self didSelectCellRowFirstDo:NO nextDo:NO];
        }
        else{
            [self didSelectCellRowFirstDo:NO nextDo:YES];
        }
    }
}

- (void)didSelectCellRowFirstDo:(BOOL)firstDoInsert nextDo:(BOOL)nextDoInsert{
    [_tableView beginUpdates];
    _openRow = firstDoInsert;
    NSMutableArray* rowToInsert = [[NSMutableArray alloc] init];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:didSection];
    [rowToInsert addObject:indexPath];
    if (!_openRow) {
        didSection = self.phasedArr.count+1;
        [_tableView deleteRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationFade];
    }else{
        [_tableView insertRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationFade];
    }
    [_tableView endUpdates];
    if (nextDoInsert) {
        didSection = endSection;
        [self didSelectCellRowFirstDo:YES nextDo:NO];
    }
    [_tableView scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionTop animated:YES];
    if(didSection == 1 || didSection == 2){
        [_tableView setContentOffset:CGPointMake(0, 109) animated:YES];
    }else if(didSection == 3 || didSection == 4){
        [_tableView setContentOffset:CGPointMake(0, 193) animated:YES];
    }else if(didSection == 5 || didSection == 6){
        [_tableView setContentOffset:CGPointMake(0, 325) animated:YES];
    }else if(didSection == 7){
        [_tableView setContentOffset:CGPointMake(0, 417) animated:YES];
    }else if(didSection == 8){
        [_tableView setContentOffset:CGPointMake(0, 463) animated:YES];
    }
}

-(void)moreBtnClick:(UIButton *)button{
    if(_openRow){
        NSLog(@"==>%d",didSection);
        if(didSection == 2){
            _myActionSheet = [[UIActionSheet alloc]
                              initWithTitle:nil
                              delegate:self
                              cancelButtonTitle:@"取消"
                              destructiveButtonTitle:nil
                              otherButtonTitles: @"拍照",nil];
            _myActionSheet.tag = 99;
            [_myActionSheet showInView:bgviewcontroller.view];
        }
    }
}

-(void)moreBtnClick2:(UIButton *)button{
    if(_openRow){
        NSLog(@"==>%d",didSection);
        if(didSection == 5 || didSection == 6||didSection==7||didSection==8){
            _myActionSheet = [[UIActionSheet alloc]
                              initWithTitle:nil
                              delegate:self
                              cancelButtonTitle:@"取消"
                              destructiveButtonTitle:nil
                              otherButtonTitles: @"拍照",nil];
            _myActionSheet.tag = 99;
            [_myActionSheet showInView:bgviewcontroller.view];
        }
    }
}

-(void)moreBtnClick3:(UIButton *)button{
    if(_openRow){
        NSLog(@"==>%d",didSection);
        if(didSection == 10){
            _myActionSheet = [[UIActionSheet alloc]
                              initWithTitle:nil
                              delegate:self
                              cancelButtonTitle:@"取消"
                              destructiveButtonTitle:nil
                              otherButtonTitles: @"拍照",nil];
            _myActionSheet.tag = 99;
            [_myActionSheet showInView:bgviewcontroller.view];
        }
    }
}

-(void)addContactView:(int)index{
    [locateview removeFromSuperview];
    locateview = nil;
    if(index == 0){
        if(locateview == nil){
            locateview = [[LocateView alloc] initWithTitle:CGRectMake(0, 0, 320, 260) title:@"定位城市" delegate:self];
            locateview.tag = 0;
            [locateview showInView:bgviewcontroller.view];
        }
    }else if(index == 1){
        muview = [[MultipleChoiceViewController alloc] init];
        [muview.view setFrame:CGRectMake(0, 0, 262, 431)];
        muview.delegate = self;
        [bgviewcontroller presentPopupViewController:muview animationType:MJPopupViewAnimationSlideBottomBottom];
    }else{
        self.flag = 0;
        if(contactArr.count <3){
            addcontactView = [[AddContactViewController alloc] init];
            [addcontactView.view setFrame:CGRectMake(0, 0, 262, 431)];
            addcontactView.delegate = self;
            if(self.fromView == 0){
                [addcontactView setlocalProjectId:[dataDic objectForKey:@"id"]];
            }else{
                [addcontactView setlocalProjectId:[self.SingleDataDic objectForKey:@"projectID"]];
            }
            [bgviewcontroller presentPopupViewController:addcontactView animationType:MJPopupViewAnimationSlideBottomBottom];
        }else{
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"名额已经满了！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
}

-(void)addContent:(NSString *)str index:(int)index{
    _isUpdata = YES;
    switch (index) {
        case 0:
            [dataDic setObject:str forKey:@"landName"];
            break;
        case 1:
            [dataDic setObject:str forKey:@"landAddress"];
            break;
        case 2:
            if([str isEqualToString:@""]){
                if(self.fromView == 0){
                    [dataDic setObject:@"0" forKey:@"area"];
                }else{
                    [dataDic setObject:@"" forKey:@"area"];
                }
            }else{
                [dataDic setObject:[NSString stringWithFormat:@"%d",[str intValue]] forKey:@"area"];
            }
            break;
        case 3:
            if([str isEqualToString:@""]){
                if(self.fromView == 0){
                    [dataDic setObject:@"0" forKey:@"plotRatio"];
                }else{
                    [dataDic setObject:@"" forKey:@"plotRatio"];
                }
            }else{
                [dataDic setObject:[NSString stringWithFormat:@"%d",[str intValue]] forKey:@"plotRatio"];
            }
            break;
        default:
            break;
    }
    [_tableView reloadData];
}

//联系人数据
-(void)back:(NSMutableDictionary *)dic btnTag:(int)btnTag{
    _isUpdata = YES;
    NSLog(@"==>%d",self.flag);
    if(self.flag == 0){
        [dic setValue:@"auctionUnitContacts" forKeyPath:@"category"];
        if(btnTag !=0){
            [contactArr replaceObjectAtIndex:btnTag-1 withObject:dic];
        }else{
            [contactArr addObject:dic];
        }
    }else if(self.flag == 1){
        [dic setValue:@"ownerUnitContacts" forKeyPath:@"category"];
        if(btnTag != 0){
            NSLog(@"==>%@",[dic objectForKey:@"accountName"]);
            [self.ownerArr replaceObjectAtIndex:btnTag-1 withObject:dic];
        }else{
            [self.ownerArr addObject:dic];
        }
    }else if(self.flag == 2){
        [dic setValue:@"explorationUnitContacts" forKey:@"category"];
        if(btnTag != 0){
            [self.explorationUnitArr replaceObjectAtIndex:btnTag-1 withObject:dic];
        }else{
            [self.explorationUnitArr addObject:dic];
        }
    }else if(self.flag ==3){
        [dic setValue:@"designInstituteContacts" forKey:@"category"];
        if(btnTag != 0){
            [self.designInstituteArr replaceObjectAtIndex:btnTag-1 withObject:dic];
        }else{
            [self.designInstituteArr addObject:dic];
        }
    }else if (self.flag ==4){
        [dic setValue:@"contractorUnitContacts" forKey:@"category"];
        if(btnTag != 0){
            [horizonArr replaceObjectAtIndex:btnTag-1 withObject:dic];
        }else{
            [horizonArr addObject:dic];
        }
    }else if(self.flag ==5){
        [dic setValue:@"pileFoundationUnitContacts" forKey:@"category"];
        if(btnTag != 0){
            [pileFoundationUnitArr replaceObjectAtIndex:btnTag-1 withObject:dic];
        }else{
            [pileFoundationUnitArr addObject:dic];
        }
    }
    [bgviewcontroller dismissPopupViewControllerWithanimationType:MJPopupViewAnimationSlideBottomBottom];
    [_tableView reloadData];
}

-(void)updataContact:(NSMutableDictionary *)dic index:(int)index{
    self.flag = 0;
    addcontactView = [[AddContactViewController alloc] init];
    [addcontactView.view setFrame:CGRectMake(0, 0, 262, 431)];
    addcontactView.delegate = self;
    //[addcontactView updataContact:dic index:index];
    [addcontactView updataContact:[contactArr objectAtIndex:index-1] index:index];
    if(self.fromView == 1){
        if(self.isRelease == 0){
            [addcontactView setenabled:contactArr];
        }
    }
    [bgviewcontroller presentPopupViewController:addcontactView animationType:MJPopupViewAnimationSlideBottomBottom];
}

-(void)updataOwner:(NSMutableDictionary *)dic index:(int)index{
    self.flag = 1;
    addcontactView = [[AddContactViewController alloc] init];
    [addcontactView.view setFrame:CGRectMake(0, 0, 262, 431)];
    addcontactView.delegate = self;
    [addcontactView updataContact:[self.ownerArr objectAtIndex:index-1] index:index];
    if(self.fromView == 1){
        if(self.isRelease == 0){
            [addcontactView setenabled:self.ownerArr];
        }
    }
    [bgviewcontroller presentPopupViewController:addcontactView animationType:MJPopupViewAnimationSlideBottomBottom];
}

-(void)addContentProject:(NSString *)str index:(int)index{
    _isUpdata = YES;
    switch (index) {
        case 0:
            [dataDic setObject:str forKey:@"projectName"];
            break;
        case 1:
            [dataDic setObject:str forKey:@"description"];
            break;
        case 2:
            if([str isEqualToString:@""]){
                if(self.fromView == 0){
                    [dataDic setObject:@"0" forKey:@"investment"];
                }else{
                    [dataDic setObject:@"" forKey:@"investment"];
                }
            }else{
                [dataDic setObject:[NSString stringWithFormat:@"%d",[str intValue]] forKey:@"investment"];
            }
            break;
        case 3:
            if([str isEqualToString:@""]){
                if(self.fromView == 0){
                    [dataDic setObject:@"0" forKey:@"areaOfStructure"];
                }else{
                    [dataDic setObject:@"" forKey:@"areaOfStructure"];
                }
            }else{
                [dataDic setObject:[NSString stringWithFormat:@"%d",[str intValue]] forKey:@"areaOfStructure"];
            }
            break;
        case 4:
            if([str isEqualToString:@""]){
                if(self.fromView == 0){
                    [dataDic setObject:@"0" forKey:@"storeyHeight"];
                }else{
                    [dataDic setObject:@"" forKey:@"storeyHeight"];
                }
            }else{
                [dataDic setObject:[NSString stringWithFormat:@"%d",[str intValue]] forKey:@"storeyHeight"];
            }
            break;
        default:
            break;
    }
    [_tableView reloadData];
}

//项目立项
-(void)addContactViewProject:(int)index{
    [datepickerview removeFromSuperview];
    datepickerview = nil;
    switch (index) {
        case 0:
            
            break;
        case 1:
            self.flag = 1;
            if(ownerArr.count <3){
                addcontactView = [[AddContactViewController alloc] init];
                [addcontactView.view setFrame:CGRectMake(0, 0, 262, 431)];
                addcontactView.delegate = self;
                if(self.fromView == 0){
                    [addcontactView setlocalProjectId:[dataDic objectForKey:@"id"]];
                }else{
                    [addcontactView setlocalProjectId:[self.SingleDataDic objectForKey:@"projectID"]];
                }
                [bgviewcontroller presentPopupViewController:addcontactView animationType:MJPopupViewAnimationSlideBottomBottom];
            }else{
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"名额已经满了！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
            }
            break;
        case 2:
            if(datepickerview == nil){
                NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd"];
                NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[[self.dataDic objectForKey:@"expectedStartTime"] intValue]];
                if([[self.dataDic objectForKey:@"expectedStartTime"] isEqualToString:@""]){
                    datepickerview = [[DatePickerView alloc] initWithTitle:CGRectMake(0, 0, 320, 260) delegate:self date:nil];
                }else{
                    datepickerview = [[DatePickerView alloc] initWithTitle:CGRectMake(0, 0, 320, 260) delegate:self date:confromTimesp];
                }
                datepickerview.tag = 1;
                [datepickerview showInView:bgviewcontroller.view];
            }
            self.timeflag = 0;
            break;
        case 3:
            if(datepickerview == nil){
                NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd"];
                NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[[self.dataDic objectForKey:@"expectedFinishTime"] intValue]];
                if([[self.dataDic objectForKey:@"expectedFinishTime"] isEqualToString:@""]){
                    datepickerview = [[DatePickerView alloc] initWithTitle:CGRectMake(0, 0, 320, 260) delegate:self date:nil];
                }else{
                    datepickerview = [[DatePickerView alloc] initWithTitle:CGRectMake(0, 0, 320, 260) delegate:self date:confromTimesp];
                }
                datepickerview.tag = 1;
                [datepickerview showInView:bgviewcontroller.view];
            }
            self.timeflag = 1;
            break;
        case 4:
            
            break;
        case 5:
            ownertypeview = [[OwnerTypeViewController alloc] init];
            [ownertypeview.view setFrame:CGRectMake(0, 0, 262, 431)];
            ownertypeview.delegate = self;
            [bgviewcontroller presentPopupViewController:ownertypeview animationType:MJPopupViewAnimationSlideBottomBottom];
            break;
        default:
            break;
    }
}


//选择框
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(actionSheet.tag == 0){
        if(buttonIndex == 0) {
            NSLog(@"Cancel");
        }else {
            _isUpdata = YES;
            locateview = (LocateView *)actionSheet;
            [dataDic setObject:[locateview.proviceDictionary objectForKey:@"provice"] forKey:@"province"];
            [dataDic setObject:[locateview.proviceDictionary objectForKey:@"city"] forKey:@"city"];
            [dataDic setObject:[locateview.proviceDictionary objectForKey:@"county"] forKey:@"district"];
        }
    }else if(actionSheet.tag == 1){
        datepickerview = (DatePickerView *)actionSheet;
        if(buttonIndex == 0) {
            NSLog(@"Cancel");
        }else {
            _isUpdata = YES;
            if(self.timeflag == 0){
                [dataDic setObject:datepickerview.timeSp forKey:@"expectedStartTime"];
            }else if(self.timeflag == 1){
                [dataDic setObject:datepickerview.timeSp forKey:@"expectedFinishTime"];
            }else{
                [dataDic setObject:datepickerview.timeSp forKey:@"actualStartTime"];
            }
        }
    }else if(actionSheet.tag == 2){
        singlepickerview = (SinglePickerView *)actionSheet;
        if(buttonIndex == 0) {
            NSLog(@"Cancel");
        }else {
            _isUpdata = YES;
            [self.dataDic setObject:singlepickerview.selectStr forKey:@"mainDesignStage"];
        }
    }else if(actionSheet.tag == 3){
        singlepickerview = (SinglePickerView *)actionSheet;
        if(buttonIndex == 0) {
            NSLog(@"Cancel");
        }else {
            _isUpdata = YES;
            [self.dataDic setObject:singlepickerview.selectStr forKey:@"fireControl"];
        }
    }else if(actionSheet.tag == 4){
        singlepickerview = (SinglePickerView *)actionSheet;
        if(buttonIndex == 0) {
            NSLog(@"Cancel");
        }else {
            _isUpdata = YES;
            [self.dataDic setObject:singlepickerview.selectStr forKey:@"green"];
        }
    }else if(actionSheet.tag == 5){
        singlepickerview = (SinglePickerView *)actionSheet;
        if(buttonIndex == 0) {
            NSLog(@"Cancel");
        }else {
            _isUpdata = YES;
            [self.dataDic setObject:singlepickerview.selectStr forKey:@"electroweakInstallation"];
        }
    }else if(actionSheet.tag == 6){
        singlepickerview = (SinglePickerView *)actionSheet;
        if(buttonIndex == 0) {
            NSLog(@"Cancel");
        }else {
            _isUpdata = YES;
            [self.dataDic setObject:singlepickerview.selectStr forKey:@"decorationSituation"];
        }
    }else if(actionSheet.tag == 7){
        singlepickerview = (SinglePickerView *)actionSheet;
        if(buttonIndex == 0) {
            NSLog(@"Cancel");
        }else {
            _isUpdata = YES;
            [self.dataDic setObject:singlepickerview.selectStr forKey:@"decorationProgress"];
        }
    }else{
        if(buttonIndex == 0){
            if(self.fromView == 1){
                if([[self.SingleDataDic objectForKey:@"projectID"] isEqualToString:@""]){
                    [camera getCameraView:self flag:cameraflag aid:[self.SingleDataDic objectForKey:@"id"]];
                }else{
                    [camera getCameraView:self flag:cameraflag aid:[self.SingleDataDic objectForKey:@"projectID"]];
                }
            }else{
                [camera getCameraView:self flag:cameraflag aid:[dataDic objectForKey:@"id"]];
            }
        }
    }
    [_tableView reloadData];
}

-(void)choiceData:(NSMutableArray *)arr{
    NSMutableString *string = [[NSMutableString alloc] init];
    for(int i=0;i<arr.count;i++){
        if(![[arr objectAtIndex:i] isEqualToString:@""]){
            [string appendString:[NSString stringWithFormat:@"%@,",[arr objectAtIndex:i]]];
        }
    }
    NSString *aStr=[string substringToIndex:([string length]-1)];
    [dataDic setObject:aStr forKey:@"usage"];
    [bgviewcontroller dismissPopupViewControllerWithanimationType:MJPopupViewAnimationSlideBottomTop];
    [_tableView reloadData];
}

-(void)addforeignInvestment:(NSString *)str{
    _isUpdata = YES;
    if([str isEqualToString:@"参与"]){
        [dataDic setObject:@"1" forKey:@"foreignInvestment"];
    }else{
        [dataDic setObject:@"0" forKey:@"foreignInvestment"];
    }
}

-(void)backMChoiceViewController{
    [bgviewcontroller dismissPopupViewControllerWithanimationType:MJPopupViewAnimationSlideBottomBottom];
}

-(void)choiceDataOwnerType:(NSMutableArray *)arr{
    NSMutableString *string = [[NSMutableString alloc] init];
    for(int i=0;i<arr.count;i++){
        if(![[arr objectAtIndex:i] isEqualToString:@""]){
            [string appendString:[NSString stringWithFormat:@"%@,",[arr objectAtIndex:i]]];
        }
    }
    NSString *aStr=[string substringToIndex:([string length]-1)];
    [dataDic setObject:aStr forKey:@"ownerType"];
    [bgviewcontroller dismissPopupViewControllerWithanimationType:MJPopupViewAnimationSlideBottomTop];
    [_tableView reloadData];
}

-(void)backOwnerTypeViewController{
    [bgviewcontroller dismissPopupViewControllerWithanimationType:MJPopupViewAnimationSlideBottomBottom];
}


//获取联系人
/*-(void)loadContact:(NSString *)projectId{
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"GET" URLString:[NSString stringWithFormat:@"%s/BaseContacts/%@?projectID=%@",serverAddress,[LoginSqlite getdata:@"UserToken" defaultdata:@"UserToken"],projectId] parameters:nil error:nil];
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSLog(@"JSON: %@", responseObject);
        NSMutableArray *resultArr = [[NSMutableArray alloc]init];
        NSArray *a = [[responseObject objectForKey:@"d"] objectForKey:@"data"];
        for (NSMutableDictionary *item in a) {
            NSLog(@"%@",item);
            ContactModel *model = [[ContactModel alloc] init];
            [model loadWithDictionary:item];
            [resultArr addObject:model];
        }
        //NSLog(@"%@",self.contactArr);
        [self addArray:resultArr projectID:projectId];
        [_tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    [[NSOperationQueue mainQueue] addOperation:op];
}*/

//获取图片
/*-(void)loadImage:(NSString *)projectId{
    NSLog(@"%@",[NSString stringWithFormat:@"%s/ProjectImgs/%@?projectID=%@",serverAddress,[LoginSqlite getdata:@"UserToken" defaultdata:@"UserToken"],projectId]);
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"GET" URLString:[NSString stringWithFormat:@"%s/ProjectImgs/%@?projectID=%@",serverAddress,[LoginSqlite getdata:@"UserToken" defaultdata:@"UserToken"],projectId] parameters:nil error:nil];
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSLog(@"JSON: %@", responseObject);
        NSArray *a = [[responseObject objectForKey:@"d"] objectForKey:@"data"];
        for (NSMutableDictionary *item in a) {
            NSLog(@"%@",[item objectForKey:@"category"]);
            CameraModel *model = [[CameraModel alloc] init];
            [model loadWithDictionary:item];
            if([[item objectForKey:@"category"] isEqualToString:@"horizon"]){
                [horizonImageArr addObject:model];
            }else if([[item objectForKey:@"category"] isEqualToString:@"pileFoundation"]){
                [pilePitImageArr addObject:model];
            }else if([[item objectForKey:@"category"] isEqualToString:@"mainPart"]){
                [mainConstructionImageArr addObject:model];
            }else if([[item objectForKey:@"category"] isEqualToString:@"exploration"]){
                [explorationImageArr addObject:model];
            }else if([[item objectForKey:@"category"] isEqualToString:@"fireControl"]){
                [fireControlImageArr addObject:model];
            }else if([[item objectForKey:@"category"] isEqualToString:@"electroweak"]){
                [electroweakImageArr addObject:model];
            }
        }
        NSLog(@"horizonImageArr ==> %@",horizonImageArr);
        [_tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    [[NSOperationQueue mainQueue] addOperation:op];
}*/

//本地创建的联系人
-(void)loadLocalContact:(NSString *)localProjectId{
    NSMutableArray *a = [ContactSqlite loadList:[self.SingleDataDic objectForKey:@"id"]];
    NSMutableDictionary *contactDic = [[NSMutableDictionary alloc] init];
    for (int i=0; i<a.count; i++) {
        ContactModel *model = [a objectAtIndex:i];
        contactDic = [ProjectStage JudgmentContactStr:model];
        [contactDic setValue:localProjectId forKeyPath:@"localProjectId"];
        if([model.a_category isEqualToString:@"auctionUnitContacts"]){
            [contactArr addObject:contactDic];
        }else if([model.a_category isEqualToString:@"ownerUnitContacts"]){
            [self.ownerArr addObject:contactDic];
        }else if([model.a_category isEqualToString:@"explorationUnitContacts"]){
            [self.explorationUnitArr addObject:contactDic];
        }else if([model.a_category isEqualToString:@"contractorUnitContacts"]){
            [horizonArr addObject:contactDic];
        }else if([model.a_category isEqualToString:@"designInstituteContacts"]){
            [self.designInstituteArr addObject:contactDic];
        }else if([model.a_category isEqualToString:@"pileFoundationUnitContacts"]){
            [pileFoundationUnitArr addObject:contactDic];
        }
    }
    [_tableView reloadData];
}

-(void)addArray:(NSMutableArray *)list projectID:(NSString *)projectID{
    for(int i=0;i<list.count;i++){
        NSMutableDictionary *contactDic = [[NSMutableDictionary alloc] init];
        ContactModel *model = [list objectAtIndex:i];
        contactDic = [ProjectStage JudgmentContactStr:model];
        [contactDic setValue:model.a_baseContactID forKeyPath:@"id"];
        [contactDic setValue:projectID forKeyPath:@"localProjectId"];
        if([model.a_category isEqualToString:@"auctionUnitContacts"]){
            [contactArr addObject:contactDic];
        }else if([model.a_category isEqualToString:@"ownerUnitContacts"]){
            [self.ownerArr addObject:contactDic];
        }else if([model.a_category isEqualToString:@"explorationUnitContacts"]){
            [self.explorationUnitArr addObject:contactDic];
        }else if([model.a_category isEqualToString:@"contractorUnitContacts"]){
            [horizonArr addObject:contactDic];
        }else if([model.a_category isEqualToString:@"designInstituteContacts"]){
            [self.designInstituteArr addObject:contactDic];
        }else if([model.a_category isEqualToString:@"pileFoundationUnitContacts"]){
            [pileFoundationUnitArr addObject:contactDic];
        }
    }
    [_tableView reloadData];
}

-(void)loadLocalImage:(NSString *)localProjectId{
    NSLog(@"===>%@",localProjectId);
    [horizonImageArr removeAllObjects];
    [pilePitImageArr removeAllObjects];
    [mainConstructionImageArr removeAllObjects];
    [explorationImageArr removeAllObjects];
    [fireControlImageArr removeAllObjects];
    [electroweakImageArr removeAllObjects];
    horizonImageArr = [CameraSqlite loadHorizonList:localProjectId];
    pilePitImageArr = [CameraSqlite loadPilePitList:localProjectId];
    mainConstructionImageArr = [CameraSqlite loadMainConstructionList:localProjectId];
    explorationImageArr = [CameraSqlite loadexplorationList:localProjectId];
    fireControlImageArr = [CameraSqlite loadfireControlList:localProjectId];
    electroweakImageArr = [CameraSqlite loadelectroweakList:localProjectId];
    [_tableView reloadData];
}

-(void)gotoMap:(NSString *)address city:(NSString *)city{
    //[locateview removeFromSuperview];
    //locateview = nil;
    NSLog(@"%@",city);
    locationView = [[LocationViewController alloc] init];
    locationView.delegate = self;
    locationView.baseAddress = address;
    locationView.baseCity = city;
    [self.navigationController pushViewController:locationView animated:YES];
}

-(void)locationBack:(NSString *)address testLocation:(CLLocationCoordinate2D)testLocation{
    _isUpdata = YES;
    [dataDic setObject:address forKey:@"landAddress"];
    [dataDic setObject:[NSString stringWithFormat:@"%f",testLocation.longitude] forKey:@"longitude"];
    [dataDic setObject:[NSString stringWithFormat:@"%f",testLocation.latitude] forKey:@"latitude"];
    [_tableView reloadData];
}

-(void)addContactViewGeologicalSurvey{
    self.flag = 2;
    if(self.explorationUnitArr.count <3){
        addcontactView = [[AddContactViewController alloc] init];
        [addcontactView.view setFrame:CGRectMake(0, 0, 262, 431)];
        addcontactView.delegate = self;
        if(self.fromView == 0){
            [addcontactView setlocalProjectId:[dataDic objectForKey:@"id"]];
        }else{
            [addcontactView setlocalProjectId:[self.SingleDataDic objectForKey:@"projectID"]];
        }
        [bgviewcontroller presentPopupViewController:addcontactView animationType:MJPopupViewAnimationSlideBottomBottom];
    }else{
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"名额已经满了！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
}

-(void)updataExplorationUnitContacts:(NSMutableDictionary *)dic index:(int)index{
    self.flag = 2;
    addcontactView = [[AddContactViewController alloc] init];
    [addcontactView.view setFrame:CGRectMake(0, 0, 262, 431)];
    addcontactView.delegate = self;
    [addcontactView updataContact:[self.explorationUnitArr objectAtIndex:index-1] index:index];
    if(self.fromView == 1){
        if(self.isRelease == 0){
            [addcontactView setenabled:self.explorationUnitArr];
        }
    }
    [bgviewcontroller presentPopupViewController:addcontactView animationType:MJPopupViewAnimationSlideBottomBottom];
}

-(void)addContactViewDesign{
    self.flag = 3;
    if(self.designInstituteArr.count <3){
        addcontactView = [[AddContactViewController alloc] init];
        [addcontactView.view setFrame:CGRectMake(0, 0, 262, 431)];
        addcontactView.delegate = self;
        if(self.fromView == 0){
            [addcontactView setlocalProjectId:[dataDic objectForKey:@"id"]];
        }else{
            [addcontactView setlocalProjectId:[self.SingleDataDic objectForKey:@"projectID"]];
        }
        [bgviewcontroller presentPopupViewController:addcontactView animationType:MJPopupViewAnimationSlideBottomBottom];
    }else{
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"名额已经满了！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
}

-(void)updataDesignInstituteContacts:(NSMutableDictionary *)dic index:(int)index{
    self.flag = 3;
    addcontactView = [[AddContactViewController alloc] init];
    [addcontactView.view setFrame:CGRectMake(0, 0, 262, 431)];
    addcontactView.delegate = self;
    [addcontactView updataContact:[self.designInstituteArr objectAtIndex:index-1] index:index];
    if(self.fromView == 1){
        if(self.isRelease == 0){
            [addcontactView setenabled:self.designInstituteArr];
        }
    }
    [bgviewcontroller presentPopupViewController:addcontactView animationType:MJPopupViewAnimationSlideBottomBottom];
}

-(void)addSinglePickerView{
    [singlepickerview removeFromSuperview];
    singlepickerview = nil;
    NSArray *arr = [[NSArray alloc] initWithObjects:@"结构",@"立面",@"幕墙",@"暖通",@"扩初",@"蓝图",@"送审",@"审结",nil];
    singlepickerview = [[SinglePickerView alloc] initWithTitle:CGRectMake(0, 0, 320, 260) title:@"主体设计" Arr:arr delegate:self];
    singlepickerview.tag = 2;
    [singlepickerview showInView:bgviewcontroller.view];
}

-(void)addContactViewPlot:(int)index{
    [datepickerview removeFromSuperview];
    datepickerview = nil;
    switch (index) {
        case 0:
            self.flag = 1;
            if(ownerArr.count <3){
                addcontactView = [[AddContactViewController alloc] init];
                [addcontactView.view setFrame:CGRectMake(0, 0, 262, 431)];
                addcontactView.delegate = self;
                if(self.fromView == 0){
                    [addcontactView setlocalProjectId:[dataDic objectForKey:@"id"]];
                }else{
                    [addcontactView setlocalProjectId:[self.SingleDataDic objectForKey:@"projectID"]];
                }
                [bgviewcontroller presentPopupViewController:addcontactView animationType:MJPopupViewAnimationSlideBottomBottom];
            }else{
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"名额已经满了！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
            }
            break;
        case 1:
            if(datepickerview == nil){
                NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd"];
                NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[[self.dataDic objectForKey:@"expectedStartTime"] intValue]];
                if([[self.dataDic objectForKey:@"expectedStartTime"] isEqualToString:@""]){
                    datepickerview = [[DatePickerView alloc] initWithTitle:CGRectMake(0, 0, 320, 260) delegate:self date:nil];
                }else{
                    datepickerview = [[DatePickerView alloc] initWithTitle:CGRectMake(0, 0, 320, 260) delegate:self date:confromTimesp];
                }
                datepickerview.tag = 1;
                [datepickerview showInView:bgviewcontroller.view];
            }
            self.timeflag = 0;
            break;
        case  2:
            if(datepickerview == nil){
                NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd"];
                NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[[self.dataDic objectForKey:@"expectedFinishTime"] intValue]];
                if([[self.dataDic objectForKey:@"expectedFinishTime"] isEqualToString:@""]){
                    datepickerview = [[DatePickerView alloc] initWithTitle:CGRectMake(0, 0, 320, 260) delegate:self date:nil];
                }else{
                    datepickerview = [[DatePickerView alloc] initWithTitle:CGRectMake(0, 0, 320, 260) delegate:self date:confromTimesp];
                }
                datepickerview.tag = 1;
                [datepickerview showInView:bgviewcontroller.view];
            }
            self.timeflag = 1;
            break;
        default:
            break;
    }
}

-(void)updataPlotOwner:(NSMutableDictionary *)dic index:(int)index{
    addcontactView = [[AddContactViewController alloc] init];
    [addcontactView.view setFrame:CGRectMake(0, 0, 262, 431)];
    addcontactView.delegate = self;
    [addcontactView updataContact:[self.ownerArr objectAtIndex:index-1] index:index];
    if(self.fromView == 1){
        if(self.isRelease == 0){
            [addcontactView setenabled:self.ownerArr];
        }
    }
    [bgviewcontroller presentPopupViewController:addcontactView animationType:MJPopupViewAnimationSlideBottomBottom];
}

//出图switch
-(void)addSwitchValue:(int)index value:(BOOL)value{
    _isUpdata = YES;
    switch (index) {
        case 0:
            [dataDic setObject:[NSString stringWithFormat:@"%d",value] forKey:@"propertyElevator"];
            break;
        case 1:
            [dataDic setObject:[NSString stringWithFormat:@"%d",value] forKey:@"propertyAirCondition"];
            break;
        case 2:
            [dataDic setObject:[NSString stringWithFormat:@"%d",value] forKey:@"propertyHeating"];
            break;
        case 3:
            [dataDic setObject:[NSString stringWithFormat:@"%d",value] forKey:@"propertyExternalWallMeterial"];
            break;
        case 4:
            [dataDic setObject:[NSString stringWithFormat:@"%d",value] forKey:@"propertyStealStructure"];
            break;
        default:
            break;
    }
}

//主体施工-地平
-(void)addContactViewHorizon:(int)index{
    [datepickerview removeFromSuperview];
    datepickerview = nil;
    switch (index) {
        case 0:
            if(datepickerview == nil){
                NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd"];
                NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[[self.dataDic objectForKey:@"actualStartTime"] intValue]];
                if([[self.dataDic objectForKey:@"actualStartTime"] isEqualToString:@""]){
                    datepickerview = [[DatePickerView alloc] initWithTitle:CGRectMake(0, 0, 320, 260) delegate:self date:nil];
                }else{
                    datepickerview = [[DatePickerView alloc] initWithTitle:CGRectMake(0, 0, 320, 260) delegate:self date:confromTimesp];
                }
                datepickerview.tag = 1;
                [datepickerview showInView:bgviewcontroller.view];
            }
            self.timeflag = 2;
            break;
        case 1:
            self.flag = 4;
            if(horizonArr.count <3){
                addcontactView = [[AddContactViewController alloc] init];
                [addcontactView.view setFrame:CGRectMake(0, 0, 262, 431)];
                addcontactView.delegate = self;
                if(self.fromView == 0){
                    [addcontactView setlocalProjectId:[dataDic objectForKey:@"id"]];
                }else{
                    [addcontactView setlocalProjectId:[self.SingleDataDic objectForKey:@"projectID"]];
                }
                [bgviewcontroller presentPopupViewController:addcontactView animationType:MJPopupViewAnimationSlideBottomBottom];
            }else{
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"名额已经满了！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
            }
            break;
        default:
            break;
    }
}

-(void)updataContractorUnitContacts:(NSMutableDictionary *)dic index:(int)index{
    self.flag = 4;
    addcontactView = [[AddContactViewController alloc] init];
    [addcontactView.view setFrame:CGRectMake(0, 0, 262, 431)];
    addcontactView.delegate = self;
    [addcontactView updataContact:[horizonArr objectAtIndex:index-1] index:index];
    if(self.fromView == 1){
        if(self.isRelease == 0){
            [addcontactView setenabled:horizonArr];
        }
    }
    [bgviewcontroller presentPopupViewController:addcontactView animationType:MJPopupViewAnimationSlideBottomBottom];
}

//桩基基坑
-(void)addContactViewPilePit{
    self.flag = 5;
    if(pileFoundationUnitArr.count <3){
        addcontactView = [[AddContactViewController alloc] init];
        [addcontactView.view setFrame:CGRectMake(0, 0, 262, 431)];
        addcontactView.delegate = self;
        if(self.fromView == 0){
            [addcontactView setlocalProjectId:[dataDic objectForKey:@"id"]];
        }else{
            [addcontactView setlocalProjectId:[self.SingleDataDic objectForKey:@"projectID"]];
        }
        [bgviewcontroller presentPopupViewController:addcontactView animationType:MJPopupViewAnimationSlideBottomBottom];
    }else{
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"名额已经满了！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
}

-(void)updataPileFoundationUnitContacts:(NSMutableDictionary *)dic index:(int)index{
    self.flag = 5;
    addcontactView = [[AddContactViewController alloc] init];
    [addcontactView.view setFrame:CGRectMake(0, 0, 262, 431)];
    addcontactView.delegate = self;
    [addcontactView updataContact:[pileFoundationUnitArr objectAtIndex:index-1] index:index];
    if(self.fromView == 1){
        if(self.isRelease == 0){
            [addcontactView setenabled:pileFoundationUnitArr];
        }
    }
    [bgviewcontroller presentPopupViewController:addcontactView animationType:MJPopupViewAnimationSlideBottomBottom];
}

-(void)backCamera{
    _isUpdata = YES;
    if(self.fromView == 0){
        [horizonImageArr removeAllObjects];
        [pilePitImageArr removeAllObjects];
        [mainConstructionImageArr removeAllObjects];
        [explorationImageArr removeAllObjects];
        [fireControlImageArr removeAllObjects];
        [electroweakImageArr removeAllObjects];
        horizonImageArr = [CameraSqlite loadHorizonList:[dataDic objectForKey:@"id"]];
        pilePitImageArr = [CameraSqlite loadPilePitList:[dataDic objectForKey:@"id"]];
        mainConstructionImageArr = [CameraSqlite loadMainConstructionList:[dataDic objectForKey:@"id"]];
        explorationImageArr = [CameraSqlite loadexplorationList:[dataDic objectForKey:@"id"]];
        fireControlImageArr = [CameraSqlite loadfireControlList:[dataDic objectForKey:@"id"]];
        electroweakImageArr = [CameraSqlite loadelectroweakList:[dataDic objectForKey:@"id"]];
    }else{
        if(isRelease == 0){
            if(cameraflag == 0){
                if([CameraSqlite loadHorizonSingleList:[self.SingleDataDic objectForKey:@"projectID"]].count!=0){
                    [horizonImageArr insertObject:[[CameraSqlite loadHorizonList:[self.SingleDataDic objectForKey:@"projectID"]] objectAtIndex:0] atIndex:0];
                }
            }else if(cameraflag == 1){
                if([CameraSqlite loadPilePitSingleList:[self.SingleDataDic objectForKey:@"projectID"]].count!=0){
                    [pilePitImageArr insertObject:[[CameraSqlite loadPilePitSingleList:[self.SingleDataDic objectForKey:@"projectID"]] objectAtIndex:0] atIndex:0];
                }
            }else if (cameraflag == 2){
                if([CameraSqlite loadMainConstructionSingleList:[self.SingleDataDic objectForKey:@"projectID"]].count!=0){
                    [mainConstructionImageArr insertObject:[[CameraSqlite loadMainConstructionSingleList:[self.SingleDataDic objectForKey:@"projectID"]] objectAtIndex:0] atIndex:0];
                }
            }else if (cameraflag == 3){
                if([CameraSqlite loadexplorationSingleList:[self.SingleDataDic objectForKey:@"projectID"]].count!=0){
                    [explorationImageArr insertObject:[[CameraSqlite loadexplorationSingleList:[self.SingleDataDic objectForKey:@"projectID"]] objectAtIndex:0] atIndex:0];
                }
            }else if(cameraflag == 4){
                if([CameraSqlite loadfireControlSingleList:[self.SingleDataDic objectForKey:@"projectID"]].count!=0){
                    [fireControlImageArr insertObject:[[CameraSqlite loadfireControlSingleList:[self.SingleDataDic objectForKey:@"projectID"]] objectAtIndex:0] atIndex:0];
                }
            }else if(cameraflag == 5){
                if([CameraSqlite loadelectroweakSingleList:[self.SingleDataDic objectForKey:@"projectID"]].count!=0){
                    [electroweakImageArr insertObject:[[CameraSqlite loadelectroweakSingleList:[self.SingleDataDic objectForKey:@"projectID"]] objectAtIndex:0] atIndex:0];
                }
            }
        }else{
            [horizonImageArr removeAllObjects];
            [pilePitImageArr removeAllObjects];
            [mainConstructionImageArr removeAllObjects];
            [explorationImageArr removeAllObjects];
            [fireControlImageArr removeAllObjects];
            [electroweakImageArr removeAllObjects];
            if([[self.SingleDataDic objectForKey:@"projectID"] isEqualToString:@""]){
                horizonImageArr = [CameraSqlite loadHorizonList:[self.SingleDataDic objectForKey:@"id"]];
                pilePitImageArr = [CameraSqlite loadPilePitList:[self.SingleDataDic objectForKey:@"id"]];
                mainConstructionImageArr = [CameraSqlite loadMainConstructionList:[self.SingleDataDic objectForKey:@"id"]];
                explorationImageArr = [CameraSqlite loadexplorationList:[self.SingleDataDic objectForKey:@"id"]];
                fireControlImageArr = [CameraSqlite loadfireControlList:[self.SingleDataDic objectForKey:@"id"]];
                electroweakImageArr = [CameraSqlite loadelectroweakList:[self.SingleDataDic objectForKey:@"id"]];
            }else{
                horizonImageArr = [CameraSqlite loadHorizonList:[self.SingleDataDic objectForKey:@"projectID"]];
                pilePitImageArr = [CameraSqlite loadPilePitList:[self.SingleDataDic objectForKey:@"projectID"]];
                mainConstructionImageArr = [CameraSqlite loadMainConstructionList:[self.SingleDataDic objectForKey:@"projectID"]];
                explorationImageArr = [CameraSqlite loadexplorationList:[self.SingleDataDic objectForKey:@"projectID"]];
                fireControlImageArr = [CameraSqlite loadfireControlList:[self.SingleDataDic objectForKey:@"projectID"]];
                electroweakImageArr = [CameraSqlite loadelectroweakList:[self.SingleDataDic objectForKey:@"projectID"]];
            }
        }
    }
    [_tableView reloadData];
}

-(void)moreImage:(int)index{
    if(self.fromView == 0){
        [horizonImageArr removeAllObjects];
        [pilePitImageArr removeAllObjects];
        [mainConstructionImageArr removeAllObjects];
        [explorationImageArr removeAllObjects];
        [fireControlImageArr removeAllObjects];
        [electroweakImageArr removeAllObjects];
        horizonImageArr = [CameraSqlite loadAllHorizonList:[dataDic objectForKey:@"id"]];
        pilePitImageArr = [CameraSqlite loadAllPilePitList:[dataDic objectForKey:@"id"]];
        mainConstructionImageArr = [CameraSqlite loadAllMainConstructionList:[dataDic objectForKey:@"id"]];
        explorationImageArr = [CameraSqlite loadAllexplorationList:[dataDic objectForKey:@"id"]];
        fireControlImageArr = [CameraSqlite loadAllfireControlList:[dataDic objectForKey:@"id"]];
        electroweakImageArr = [CameraSqlite loadAllelectroweakList:[dataDic objectForKey:@"id"]];
    }else{
        if(isRelease == 1){
            [horizonImageArr removeAllObjects];
            [pilePitImageArr removeAllObjects];
            [mainConstructionImageArr removeAllObjects];
            [explorationImageArr removeAllObjects];
            [fireControlImageArr removeAllObjects];
            [electroweakImageArr removeAllObjects];
            if([[self.SingleDataDic objectForKey:@"projectID"] isEqualToString:@""]){
                horizonImageArr = [CameraSqlite loadAllHorizonList:[self.SingleDataDic objectForKey:@"id"]];
                pilePitImageArr = [CameraSqlite loadAllPilePitList:[self.SingleDataDic objectForKey:@"id"]];
                mainConstructionImageArr = [CameraSqlite loadAllMainConstructionList:[self.SingleDataDic objectForKey:@"id"]];
                explorationImageArr = [CameraSqlite loadAllexplorationList:[self.SingleDataDic objectForKey:@"id"]];
                fireControlImageArr = [CameraSqlite loadAllfireControlList:[self.SingleDataDic objectForKey:@"id"]];
                electroweakImageArr = [CameraSqlite loadAllelectroweakList:[self.SingleDataDic objectForKey:@"id"]];
            }else{
                horizonImageArr = [CameraSqlite loadAllHorizonList:[self.SingleDataDic objectForKey:@"projectID"]];
                pilePitImageArr = [CameraSqlite loadAllPilePitList:[self.SingleDataDic objectForKey:@"projectID"]];
                mainConstructionImageArr = [CameraSqlite loadAllMainConstructionList:[self.SingleDataDic objectForKey:@"projectID"]];
                explorationImageArr = [CameraSqlite loadAllexplorationList:[self.SingleDataDic objectForKey:@"projectID"]];
                fireControlImageArr = [CameraSqlite loadAllfireControlList:[self.SingleDataDic objectForKey:@"projectID"]];
                electroweakImageArr = [CameraSqlite loadAllelectroweakList:[self.SingleDataDic objectForKey:@"projectID"]];
            }
        }
    }
    switch (index) {
        case 0:
            collectionview = [[CollectionViewController alloc] init];
            collectionview.showArr = horizonImageArr;
            collectionview.flag = self.fromView;
            collectionview.title = @"地平";
            [self.navigationController pushViewController:collectionview animated:YES];
            break;
        case 1:
            collectionview = [[CollectionViewController alloc] init];
            collectionview.showArr = pilePitImageArr;
            collectionview.flag = self.fromView;
            collectionview.title = @"桩基基坑";
            [self.navigationController pushViewController:collectionview animated:YES];
            break;
        case 2:
            collectionview = [[CollectionViewController alloc] init];
            collectionview.showArr = mainConstructionImageArr;
            collectionview.flag = self.fromView;
            collectionview.title = @"主体施工";
            [self.navigationController pushViewController:collectionview animated:YES];
            break;
        case 3:
            collectionview = [[CollectionViewController alloc] init];
            collectionview.showArr = explorationImageArr;
            collectionview.flag = self.fromView;
            collectionview.title = @"地勘";
            [self.navigationController pushViewController:collectionview animated:YES];
            break;
        case 4:
            collectionview = [[CollectionViewController alloc] init];
            collectionview.showArr = fireControlImageArr;
            collectionview.flag = self.fromView;
            collectionview.title = @"消防";
            [self.navigationController pushViewController:collectionview animated:YES];
            break;
        case 5:
            collectionview = [[CollectionViewController alloc] init];
            collectionview.showArr = electroweakImageArr;
            collectionview.flag = self.fromView;
            collectionview.title = @"弱点安装";
            [self.navigationController pushViewController:collectionview animated:YES];
            break;
        default:
            break;
    }
}

-(void)addContactViewFirefighting{
    [singlepickerview removeFromSuperview];
    singlepickerview = nil;
    NSArray *arr = [[NSArray alloc] initWithObjects:@"招标",@"正在施工",@"施工完成",nil];
    singlepickerview = [[SinglePickerView alloc] initWithTitle:CGRectMake(0, 0, 320, 260) title:nil Arr:arr delegate:self];
    singlepickerview.tag = 3;
    [singlepickerview showInView:bgviewcontroller.view];
}

-(void)addContactViewLandscaping{
    [singlepickerview removeFromSuperview];
    singlepickerview = nil;
    NSArray *arr = [[NSArray alloc] initWithObjects:@"招标",@"正在施工",@"施工完成",nil];
    singlepickerview = [[SinglePickerView alloc] initWithTitle:CGRectMake(0, 0, 320, 260) title:nil Arr:arr delegate:self];
    singlepickerview.tag = 4;
    [singlepickerview showInView:bgviewcontroller.view];
}

-(void)addContactViewWeakinstallation{
    [singlepickerview removeFromSuperview];
    singlepickerview = nil;
    NSArray *arr = [[NSArray alloc] initWithObjects:@"招标",@"正在施工",@"施工完成",nil];
    singlepickerview = [[SinglePickerView alloc] initWithTitle:CGRectMake(0, 0, 320, 260) title:nil Arr:arr delegate:self];
    singlepickerview.tag = 5;
    [singlepickerview showInView:bgviewcontroller.view];
}

-(void)addContactViewDecoration{
    [singlepickerview removeFromSuperview];
    singlepickerview = nil;
    NSArray *arr = [[NSArray alloc] initWithObjects:@"无装修",@"简单全装修",@"部分装修",@"精装修",nil];
    singlepickerview = [[SinglePickerView alloc] initWithTitle:CGRectMake(0, 0, 320, 260) title:nil Arr:arr delegate:self];
    singlepickerview.tag = 6;
    [singlepickerview showInView:bgviewcontroller.view];
}

-(void)addContactViewRenovationprogress{
    [singlepickerview removeFromSuperview];
    singlepickerview = nil;
    NSArray *arr = [[NSArray alloc] initWithObjects:@"招标",@"正在施工",@"施工完成",nil];
    singlepickerview = [[SinglePickerView alloc] initWithTitle:CGRectMake(0, 0, 320, 260) title:nil Arr:arr delegate:self];
    singlepickerview.tag = 7;
    [singlepickerview showInView:bgviewcontroller.view];
}
@end
