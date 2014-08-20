//
//  SixTableViewController.m
//  ZpzchinaMobile
//
//  Created by 孙元侃 on 14-8-14.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "SixTableViewController.h"
#import "HorizonTableViewCell.h"
#import "CameraModel.h"
#import "GTMBase64.h"
#import "AddContactViewController.h"
#import "DatePickerView.h"
#import "UIViewController+MJPopupViewController.h"
#import "OwnerTypeViewController.h"
#import "LocationViewController.h"
#import "SinglePickerView.h"
#import "Camera.h"
#import "CameraSqlite.h"
#import "AppModel.h"

@interface SixTableViewController ()<HorizonDelegate,AddContactViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,CameraDelegate>{
    DatePickerView* datepickerview;
    AddContactViewController* addcontactView;
    LocationViewController* locateview;
    Camera* camera;
}

@end

@implementation SixTableViewController
//地平阶段

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(self.timeflag == 0){
        [self.dataDic setObject:datepickerview.timeSp forKey:@"expectedStartTime"];
    }else if(self.timeflag == 1){
        [self.dataDic setObject:datepickerview.timeSp forKey:@"expectedFinishTime"];
    }else{
        [self.dataDic setObject:datepickerview.timeSp forKey:@"actualStartTime"];
    }
    [self.tableView reloadData];
}

-(void)back:(NSMutableDictionary *)dic btnTag:(int)btnTag{
    
    [dic setValue:@"contractorUnitContacts" forKey:@"category"];
    if(btnTag != 0){
        [self.contacts replaceObjectAtIndex:btnTag-1 withObject:dic];
    }else{
        [self.contacts addObject:dic];
    }
    
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationSlideBottomBottom];
    [self.tableView reloadData];
}

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
                [datepickerview showInView:self.tableView.superview];
            }
            self.timeflag = 2;
            break;
        case 1:
            //self.flag = 4;
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
            break;
        default:
            break;
    }
}

-(void)updataContractorUnitContacts:(NSMutableDictionary *)dic index:(int)index{
    // self.flag = 4;
    addcontactView = [[AddContactViewController alloc] init];
    [addcontactView.view setFrame:CGRectMake(0, 0, 262, 431)];
    addcontactView.delegate = self;
    [addcontactView updataContact:[self.contacts objectAtIndex:index-1] index:index];
    //    if(self.fromView == 1){
    //        if(self.isRelease == 0){
    //            [addcontactView setenabled:horizonArr];
    //        }
    //    }
    [self presentPopupViewController:addcontactView animationType:MJPopupViewAnimationSlideBottomBottom];
}


-(instancetype)initWithSingle:(NSMutableDictionary*)singleDic dataDic:(NSMutableDictionary*)dataDic contacts:(NSMutableArray*)contacts images:(NSMutableArray *)images{
    if ([super init]) {
        self.singleDic=singleDic;
        self.dataDic=dataDic;
        self.contacts=contacts;
        self.images=images;
    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    //    if (self.fromView==0) {
    //        AppModel* appModel=[AppModel sharedInstance];
    //        appModel.horizonAry =[NSMutableArray array];
    //        [appModel.horizonImageArr removeAllObjects];
    //        self.contacts=appModel.horizonAry;
    //    }
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
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        HorizonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HorizonTableViewCell"];
        // if (!cell) {
        if(self.fromView == 0){
            cell=[[HorizonTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HorizonTableViewCell" dic:self.dataDic flag:0 Arr:self.contacts singleDic:nil];
        }else{
            cell=[[HorizonTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HorizonTableViewCell" dic:self.dataDic flag:1 Arr:self.contacts singleDic:self.singleDic];
            
        }
        cell.delegate=self;
        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        // Configure the cell...
        
        return cell;
    }
    // cell.contentView.backgroundColor=[UIColor yellowColor];
    //cell.selectionStyle=UITableViewCellSelectionStyleNone;
    // return cell;
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
            [camera getCameraView:self.superVC flag:0 aid:[self.singleDic objectForKey:@"id"]];
        }else{
            [camera getCameraView:self.superVC flag:0 aid:[self.singleDic objectForKey:@"projectID"]];
        }
    }else{
        [camera getCameraView:self.superVC flag:0 aid:[self.dataDic objectForKey:@"id"]];
    }
}

-(void)backCamera{
    if (!self.images.count) {
        self.images=[NSMutableArray array];
    }
    
    if(self.fromView == 0){
        [self.images removeAllObjects];
        self.images = [CameraSqlite loadAllHorizonList:[self.dataDic objectForKey:@"id"]];
    }else{
        if(self.superVC.isRelease == 0){
            // if(cameraflag == 0){
            if([CameraSqlite loadHorizonSingleList:[self.singleDic objectForKey:@"projectID"]].count!=0){
                [self.images insertObject:[[CameraSqlite loadAllHorizonList:[self.singleDic objectForKey:@"projectID"]] objectAtIndex:0] atIndex:0];
            }else{
                [self.images removeAllObjects];
                if([[self.singleDic objectForKey:@"projectID"] isEqualToString:@""]){
                    self.images = [CameraSqlite loadAllHorizonList:[self.singleDic objectForKey:@"id"]];
                }else{
                    self.images = [CameraSqlite loadAllHorizonList:[self.singleDic objectForKey:@"projectID"]];
                }
            }
        }
    }
    [self.tableView reloadData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        return (self.images.count/3+1)*120;
    }
    return 100;
}
-(void)viewDidDisappear:(BOOL)animated{
    AppModel* model=[AppModel sharedInstance];
    if (self.images.count) {
        model.horizonImageArr=self.images;
    }
    NSLog(@"sixDisappear");
}
-(void)dealloc{
    NSLog(@"sixDealloc");
}
@end
