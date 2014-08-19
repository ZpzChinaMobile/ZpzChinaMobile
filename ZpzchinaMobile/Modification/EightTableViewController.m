//
//  EightTableViewController.m
//  ZpzchinaMobile
//
//  Created by 孙元侃 on 14-8-14.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "EightTableViewController.h"
#import "CameraModel.h"
#import "GTMBase64.h"
#import "Camera.h"
#import "CameraSqlite.h"
#import "AppModel.h"
@interface EightTableViewController ()<CameraDelegate>{
    Camera* camera;
}

@end

@implementation EightTableViewController
//主体施工
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
//    if (self.fromView==0) {
//        AppModel* appModel=[AppModel sharedInstance];
//        [appModel.mainConstructionImageArr removeAllObjects];
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
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        if (!cell) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        }
        [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [cell.contentView addSubview:[self getImageViewsWithImages:self.images]];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    
}

-(void)backCamera{
    if (!self.images.count) {
        self.images=[NSMutableArray array];
    }
    
    if(self.fromView == 0){
        [self.images removeAllObjects];
        self.images = [CameraSqlite loadMainConstructionList:[self.dataDic objectForKey:@"id"]];
    }else{
        // if(isRelease == 0){
        // if(cameraflag == 0){
        if([CameraSqlite loadMainConstructionSingleList:[self.singleDic objectForKey:@"projectID"]].count!=0){
            [self.images insertObject:[[CameraSqlite loadMainConstructionList:[self.singleDic objectForKey:@"projectID"]] objectAtIndex:0] atIndex:0];
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
            [camera getCameraView:self.superVC flag:2 aid:[self.singleDic objectForKey:@"id"]];
        }else{
            [camera getCameraView:self.superVC flag:2 aid:[self.singleDic objectForKey:@"projectID"]];
        }
    }else{
        [camera getCameraView:self.superVC flag:2 aid:[self.dataDic objectForKey:@"id"]];
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
        return (self.images.count/3+1)*120;
}

@end
