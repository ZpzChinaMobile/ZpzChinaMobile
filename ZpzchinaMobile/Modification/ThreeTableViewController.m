//
//  ThreeTableViewController.m
//  ZpzchinaMobile
//
//  Created by 孙元侃 on 14-8-14.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "ThreeTableViewController.h"
#import "GeologicalSurveyTableViewCell.h"
#import "CameraModel.h"
#import "GTMBase64.h"
#import "AddContactViewController.h"
#import "DatePickerView.h"
#import "UIViewController+MJPopupViewController.h"
#import "OwnerTypeViewController.h"
#import "LocationViewController.h"
#import "Camera.h"
#import "CameraSqlite.h"
#import "AppModel.h"
@interface ThreeTableViewController ()<GeologicalSurveyDelegate,AddContactViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,CameraDelegate>{
    AddContactViewController* addcontactView;
    Camera* camera;
}

@end

@implementation ThreeTableViewController
//地勘阶段

-(void)back:(NSMutableDictionary *)dic btnTag:(int)btnTag{
    //   _isUpdata = YES;
    [dic setValue:@"explorationUnitContacts" forKey:@"category"];
    if(btnTag != 0){
        [self.contacts replaceObjectAtIndex:btnTag-1 withObject:dic];
    }else{
        [self.contacts addObject:dic];
    }
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationSlideBottomBottom];
    [self.tableView reloadData];
}

-(void)addContactViewGeologicalSurvey{
    //self.flag = 2;
    if(self.contacts.count <3){
        addcontactView = [[AddContactViewController alloc] init];
        [addcontactView.view setFrame:CGRectMake(0, 0, 262, 431)];
        addcontactView.delegate = self;
        if(self.fromView == 0){
            [addcontactView setlocalProjectId:[self.dataDic objectForKey:@"id"]];
        }else{
            [addcontactView setlocalProjectId:[self.singleDic objectForKey:@"projectID"]];
        }
        [self presentPopupViewController:addcontactView animationType:MJPopupViewAnimationSlideBottomBottom];
    }else{
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"名额已经满了！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
}

-(void)updataExplorationUnitContacts:(NSMutableDictionary *)dic index:(int)index{
    //self.flag = 2;
    addcontactView = [[AddContactViewController alloc] init];
    [addcontactView.view setFrame:CGRectMake(0, 0, 262, 431)];
    addcontactView.delegate = self;
    [addcontactView updataContact:[self.contacts objectAtIndex:index-1] index:index];
    //    if(self.fromView == 1){
    //        if(self.isRelease == 0){
    //            [addcontactView setenabled:self.explorationUnitArr];
    //        }
    //    }
    [self presentPopupViewController:addcontactView animationType:MJPopupViewAnimationSlideBottomBottom];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

-(instancetype)initWithSingle:(NSMutableDictionary*)singleDic dataDic:(NSMutableDictionary*)dataDic contacts:(NSMutableArray*)contacts images:(NSMutableArray*)images{
    if ([super init]) {
        self.singleDic=singleDic;
        self.dataDic=dataDic;
        self.contacts=contacts;
        self.images=images;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (self.fromView==0) {
        AppModel* appModel=[AppModel sharedInstance];
        appModel.explorationAry =[NSMutableArray array];
        self.contacts=appModel.explorationAry;
    }
    self.tableView.separatorStyle=NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        if (!cell) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        }
        [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [cell.contentView addSubview:[self getImageViewsWithImages:self.images]];
        cell.contentView.backgroundColor=[UIColor yellowColor];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        GeologicalSurveyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlanAndAuctionTableViewCell"];
       // if (!cell) {
        if(self.fromView == 0){
            //AppModel* appModel=[AppModel sharedInstance];
            cell=[[GeologicalSurveyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GeologicalSurveyTableViewCell" flag:self.fromView Arr:self.contacts explorationImageArr:nil];
        }else{
            cell=[[GeologicalSurveyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GeologicalSurveyTableViewCell" flag:1 Arr:self.contacts explorationImageArr:nil];
        }
        cell.delegate=self;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        // Configure the cell...
        
        return cell;
    }
}

-(UIView*)getImageViewsWithImages:(NSArray*)images{
    NSMutableArray* imageAry=[NSMutableArray array];
    for (int i=0; i<images.count; i++) {
        CameraModel* model= images[i];
        UIImage *aimage;
        if ([model.a_device isEqualToString:@"localios"]) {
            aimage=[UIImage imageWithData:[GTMBase64 decodeString:model.a_body]];
        }else{
            aimage=[UIImage imageWithData:[GTMBase64 decodeString:model.a_imgCompressionContent]];
        }
        [imageAry addObject:aimage];
    }
    [imageAry addObject:[UIImage imageNamed:@"新建项目1_06.png"]];
    
    CGFloat cellHeight=120;
    UIView* view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, cellHeight*((imageAry.count-1)/3+1))];
    
    for (int i=0; i<imageAry.count; i++) {
        UIImageView* imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
        imageView.center=CGPointMake(320*1.0/3*(i%3+.5), cellHeight*(i/3+.5));
        imageView.image=imageAry[i];
        [view addSubview:imageView];
        
        if (i==imageAry.count-1) {
            UIButton* button=[[UIButton alloc]initWithFrame:imageView.frame];
            [button addTarget:self action:@selector(tap:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:button];
        }
    }
    return view;
}


-(void)tap:(UIButton*)button{
    camera=[[Camera alloc]init];
    camera.delegate=self;
    if(self.fromView == 1){
        if([[self.singleDic objectForKey:@"projectID"] isEqualToString:@""]){
            [camera getCameraView:self.superVC flag:3 aid:[self.singleDic objectForKey:@"id"]];
        }else{
            [camera getCameraView:self.superVC flag:3 aid:[self.singleDic objectForKey:@"projectID"]];
        }
    }else{
        [camera getCameraView:self.superVC flag:3 aid:[self.dataDic objectForKey:@"id"]];
    }
}

-(void)backCamera{
    if (!self.images.count) {
        self.images=[NSMutableArray array];
    }
    
    if(self.fromView == 0){
        [self.images removeAllObjects];
        self.images = [CameraSqlite loadexplorationList:[self.dataDic objectForKey:@"id"]];
    }else{
        // if(isRelease == 0){
        // if(cameraflag == 0){
        if([CameraSqlite loadexplorationSingleList:[self.singleDic objectForKey:@"projectID"]].count!=0){
            [self.images insertObject:[[CameraSqlite loadexplorationList:[self.singleDic objectForKey:@"projectID"]] objectAtIndex:0] atIndex:0];
        }
        //        //  }else{
        //        [self.images removeAllObjects];
        //
        //        if([[self.singleDic objectForKey:@"projectID"] isEqualToString:@""]){
        //            self.images = [CameraSqlite loadHorizonList:[self.singleDic objectForKey:@"id"]];
        //
        //        }else{
        //            self.images = [CameraSqlite loadHorizonList:[self.singleDic objectForKey:@"projectID"]];
        //        }
    }
    [self.tableView reloadData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        return ((self.images.count)/3+1)*120;
    }
    return 50;
}
@end
