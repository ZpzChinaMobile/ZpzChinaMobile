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
#import "MultipleChoiceViewController.h"
#import "LocationViewController.h"
#import "Camera.h"
#import "CameraSqlite.h"
#import "AppModel.h"
@interface ThreeTableViewController ()<GeologicalSurveyDelegate,AddContactViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,CameraDelegate,UITableViewDataSource,UITableViewDelegate>{
    AddContactViewController* addcontactView;
    Camera* camera;
    NSInteger newImageCount;
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
    NSLog(@"%@",self.contacts);
    [self.view.window.rootViewController dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    [self.tableView reloadData];
}

-(void)addContactViewGeologicalSurvey{
    //self.flag = 2;
    NSLog(@"=====》%@",self.contacts);
    if(self.contacts.count <3){
        addcontactView = [[AddContactViewController alloc] init];
        addcontactView.delegate = self;
        addcontactView.contactType = @"explorationUnitContacts";
        [addcontactView.view setFrame:CGRectMake(0, 0, 262, 431)];
        if(self.fromView == 0){
            [addcontactView setlocalProjectId:[self.dataDic objectForKey:@"id"]];
        }else{
            if(self.superVC.isRelease == 0){
                [addcontactView setlocalProjectId:[self.singleDic objectForKey:@"projectID"]];
            }else{
                [addcontactView setlocalProjectId:[self.singleDic objectForKey:@"id"]];
            }
        }
        [self.view.window.rootViewController presentPopupViewController:addcontactView animationType:MJPopupViewAnimationFade];
    }else{
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"名额已经满了！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
}

-(void)updataExplorationUnitContacts:(NSMutableDictionary *)dic index:(int)index{
    //self.flag = 2;
    addcontactView = [[AddContactViewController alloc] init];
    addcontactView.delegate = self;
    addcontactView.contactType = @"explorationUnitContacts";
    [addcontactView.view setFrame:CGRectMake(0, 0, 262, 431)];
    [addcontactView updataContact:[self.contacts objectAtIndex:index-1] index:index];
    //    if(self.fromView == 1){
    //        if(self.isRelease == 0){
    //            [addcontactView setenabled:self.explorationUnitArr];
    //        }
    //    }
    [self.view.window.rootViewController presentPopupViewController:addcontactView animationType:MJPopupViewAnimationFade];
}

-(instancetype)initWithSingle:(NSMutableDictionary*)singleDic dataDic:(NSMutableDictionary*)dataDic contacts:(NSMutableArray*)contacts images:(NSMutableArray*)images{
    if ([super init]) {
        self.singleDic=singleDic;
        self.dataDic=dataDic;
        self.contacts=contacts;
        self.images=images;
        
        self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 568-64.5-50) style:UITableViewStylePlain];
        self.tableView.delegate=self;
        self.tableView.dataSource=self;
        self.tableView.separatorStyle=NO;
        [self.view addSubview:self.tableView];
        newImageCount=0;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.separatorStyle=NO;
}

-(void)didReceiveMemoryWarning
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
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        GeologicalSurveyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlanAndAuctionTableViewCell"];
        [cell removeFromSuperview];
        cell = nil;
        // if (!cell) {
        if(self.fromView == 0){
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

-(UIImage*)saveImage:(UIView*)view{
    UIGraphicsBeginImageContext(CGSizeMake(view.bounds.size.width, view.bounds.size.height));
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return viewImage;
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
    [imageAry addObject:[UIImage imageNamed:@"新建项目－6_03.png"]];
    
    CGFloat cellHeight=120;
    UIView* view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, cellHeight*((imageAry.count-1)/3+1))];
    view.backgroundColor=RGBCOLOR(229, 229, 229);

    for (int i=0; i<imageAry.count; i++) {
        UIImageView* imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
        imageView.center=CGPointMake(320*1.0/3*(i%3+.5), cellHeight*(i/3+.5));
        imageView.image=imageAry[i];
        imageView.image=[self saveImage:imageView];
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

-(void)backCamera:(CameraModel *)cameraModel{
    if (!self.images) {
        self.images=[NSMutableArray array];
    }
    if (!cameraModel) return;
    newImageCount++;
    [self.images addObject:cameraModel];
    [self.tableView reloadData];
    return;
    
    if (!self.images.count) {
        self.images=[NSMutableArray array];
    }
    
    if(self.fromView == 0){
        [self.images removeAllObjects];
        self.images = [CameraSqlite loadAllexplorationList:[self.dataDic objectForKey:@"id"]];
    }else{
        if(self.superVC.isRelease == 0){
            // if(cameraflag == 0){
            if([CameraSqlite loadexplorationSingleList:[self.singleDic objectForKey:@"projectID"]].count!=0){
                [self.images insertObject:[[CameraSqlite loadAllexplorationList:[self.singleDic objectForKey:@"projectID"]] objectAtIndex:0] atIndex:0];
            }
        }else{
            [self.images removeAllObjects];
            if([[self.singleDic objectForKey:@"projectID"] isEqualToString:@""]){
                self.images = [CameraSqlite loadAllexplorationList:[self.singleDic objectForKey:@"id"]];
            }else{
                self.images = [CameraSqlite loadAllexplorationList:[self.singleDic objectForKey:@"projectID"]];
            }
        }
    }
    [self.tableView reloadData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        return ((self.images.count)/3+1)*120;
    }
    return 50;
}
-(void)viewDidDisappear:(BOOL)animated{
    AppModel* model=[AppModel sharedInstance];
    if (self.images.count) {
        model.explorationImageArr=self.images;
    }
    NSLog(@"threeDisappear");
}
-(void)dealloc{
    addcontactView=nil;
    camera=nil;
    for (int i=0; i<newImageCount; i++) {
        [self.images removeLastObject];
    }
    NSLog(@"threeDealloc");
}
@end
