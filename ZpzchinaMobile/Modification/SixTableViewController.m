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
#import "MultipleChoiceViewController.h"
#import "LocationViewController.h"
#import "SinglePickerView.h"
#import "Camera.h"
#import "CameraSqlite.h"
#import "AppModel.h"
#import "EGOImageView.h"
@interface SixTableViewController ()<HorizonDelegate,AddContactViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,CameraDelegate,UITableViewDelegate,UITableViewDataSource>{
    DatePickerView* datepickerview;
    AddContactViewController* addcontactView;
    LocationViewController* locateview;
    Camera* camera;
    NSInteger newImageCount;
}

@end

@implementation SixTableViewController
//地平阶段

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) return;
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
    
    [self.view.window.rootViewController dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
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
                addcontactView.delegate = self;
                addcontactView.contactType = @"contractorUnitContacts";
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
            break;
        default:
            break;
    }
}

-(void)updataContractorUnitContacts:(NSMutableDictionary *)dic index:(int)index{
    // self.flag = 4;
    addcontactView = [[AddContactViewController alloc] init];
    addcontactView.delegate = self;
    addcontactView.contactType = @"contractorUnitContacts";
    [addcontactView.view setFrame:CGRectMake(0, 0, 262, 431)];
    [addcontactView updataContact:[self.contacts objectAtIndex:index-1] index:index];
    //    if(self.fromView == 1){
    //        if(self.isRelease == 0){
    //            [addcontactView setenabled:horizonArr];
    //        }
    //    }
    [self.view.window.rootViewController presentPopupViewController:addcontactView animationType:MJPopupViewAnimationFade];
}


-(instancetype)initWithSingle:(NSMutableDictionary*)singleDic dataDic:(NSMutableDictionary*)dataDic contacts:(NSMutableArray*)contacts images:(NSMutableArray *)images{
    if ([super init]) {
        self.singleDic=singleDic;
        self.dataDic=dataDic;
        self.contacts=contacts;
        self.images=images;
        
        self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, kScreenHeight-64.5-50) style:UITableViewStylePlain];
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
        HorizonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HorizonTableViewCell"];
        [cell removeFromSuperview];
        cell = nil;
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
}

-(UIImage*)saveImage:(UIView*)view{
    UIGraphicsBeginImageContext(CGSizeMake(view.bounds.size.width, view.bounds.size.height));
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return viewImage;
}


-(UIView*)getImageViewsWithImages:(NSArray*)images{
    CGFloat cellHeight=120;
    UIView* view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, cellHeight*(images.count/3+1))];
    view.backgroundColor=RGBCOLOR(229, 229, 229);
    
    for (int i=0; i<images.count+1; i++) {
        EGOImageView* imageView=[[EGOImageView alloc]initWithPlaceholderImage:[GetImagePath getImagePath:i==images.count?@"018":@"imgDefault"]];
        imageView.frame=CGRectMake(0, 0, 80, 80);
        imageView.center=CGPointMake(320*1.0/3*(i%3+.5), cellHeight*(i/3+.5));
        [view addSubview:imageView];
        
        if (i==images.count) {
            UIButton* button=[[UIButton alloc]initWithFrame:imageView.frame];
            [button addTarget:self action:@selector(tap:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:button];
        }else{
            if ([images[i] isKindOfClass:[CameraModel class]]) {
                CameraModel* model= images[i];
                if (model.isNewImage) {
                    imageView.image=[UIImage imageWithData:[GTMBase64 decodeString:model.a_body]];
                }else{
                    imageView.imageURL=[NSURL URLWithString:[NSString stringWithFormat:@"%s%@",imageAddress,model.a_body]];
                }
            }else{
                imageView.imageURL=[NSURL URLWithString:[NSString stringWithFormat:@"%s%@",imageAddress,images[i]]];
            }
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

-(void)backCamera:(CameraModel *)cameraModel{
    if (!self.images) {
        self.images=[NSMutableArray array];
    }
    if (!cameraModel) return;
    [self.images addObject:cameraModel];
    newImageCount++;
    [self.tableView reloadData];
    return;
    
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
            }
        }else{
            [self.images removeAllObjects];
            if([[self.singleDic objectForKey:@"projectID"] isEqualToString:@""]){
                self.images = [CameraSqlite loadAllHorizonList:[self.singleDic objectForKey:@"id"]];
            }else{
                self.images = [CameraSqlite loadAllHorizonList:[self.singleDic objectForKey:@"projectID"]];
            }
            
        }
    }
    NSLog(@"=====%d",self.images.count);
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
    datepickerview=nil;
    addcontactView=nil;
    locateview=nil;
    camera=nil;
    for (int i=0; i<newImageCount; i++) {
        [self.images removeLastObject];
    }
    NSLog(@"sixDealloc");
}
@end
