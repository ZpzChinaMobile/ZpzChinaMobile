//
//  TenTableViewController.m
//  ZpzchinaMobile
//
//  Created by 孙元侃 on 14-8-14.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "TenTableViewController.h"
#import "CameraModel.h"
#import "GTMBase64.h"
#import "Camera.h"
#import "CameraSqlite.h"
#import "AppModel.h"
@interface TenTableViewController ()<CameraDelegate>{
    Camera* camera;
}

@end

@implementation TenTableViewController
//装修阶段
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

-(instancetype)initWithSingle:(NSMutableDictionary*)singleDic dataDic:(NSMutableDictionary*)dataDic images:(NSMutableArray*)images{
    if ([super init]) {
        self.singleDic=singleDic;
        self.dataDic=dataDic;
        self.images=images;
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //    if (self.fromView==0) {
    //        AppModel* appModel=[AppModel sharedInstance];
    //        [appModel.electroweakImageArr removeAllObjects];
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
        [cell.contentView addSubview:[self getImageViewsWithImages:[self.images copy]]];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        // Configure the cell...
        
        return cell;
    }else{
        static NSString *stringcell = @"WeakElectricityCell";
        WeakElectricityCell *cell = [tableView dequeueReusableCellWithIdentifier:stringcell];
        if(self.fromView == 0){
            cell = [[WeakElectricityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stringcell dic:self.dataDic flag:0 Arr:nil singleDic:nil];
        }else{
            cell = [[WeakElectricityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stringcell dic:self.dataDic flag:1 Arr:nil singleDic:self.singleDic];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        return (self.images.count/3+1)*120;
    }
    return 150;
}

-(void)backCamera{
    if (!self.images.count) {
        self.images=[NSMutableArray array];
    }
    
    if(self.fromView == 0){
        [self.images removeAllObjects];
        self.images = [CameraSqlite loadAllelectroweakList:[self.dataDic objectForKey:@"id"]];
    }else{
        if(self.superVC.isRelease == 0){
            // if(cameraflag == 0){
            if([CameraSqlite loadelectroweakSingleList:[self.singleDic objectForKey:@"projectID"]].count!=0){
                [self.images insertObject:[[CameraSqlite loadAllelectroweakList:[self.singleDic objectForKey:@"projectID"]] objectAtIndex:0] atIndex:0];
            }
        }else{
            [self.images removeAllObjects];
            if([[self.singleDic objectForKey:@"projectID"] isEqualToString:@""]){
                self.images = [CameraSqlite loadAllelectroweakList:[self.singleDic objectForKey:@"id"]];
            }else{
                self.images = [CameraSqlite loadAllelectroweakList:[self.singleDic objectForKey:@"projectID"]];
            }
        }
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
    view.backgroundColor=RGBCOLOR(229, 229, 229);

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
            [camera getCameraView:self.superVC flag:5 aid:[self.singleDic objectForKey:@"id"]];
        }else{
            [camera getCameraView:self.superVC flag:5 aid:[self.singleDic objectForKey:@"projectID"]];
        }
    }else{
        [camera getCameraView:self.superVC flag:5 aid:[self.dataDic objectForKey:@"id"]];
    }
}



- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    singlepickerview = (SinglePickerView *)actionSheet;
    NSLog(@"%@",singlepickerview.selectStr);
    if(buttonIndex == 0) {
        NSLog(@"Cancel");
    }else {
        if(flag == 0){
            [self.dataDic setObject:singlepickerview.selectStr forKey:@"electroweakInstallation"];
        }else if(flag == 1){
            [self.dataDic setObject:singlepickerview.selectStr forKey:@"decorationSituation"];
        }else{
            [self.dataDic setObject:singlepickerview.selectStr forKey:@"decorationProgress"];
        }
    }
    [self.tableView reloadData];
}


-(void)addContactViewFirefighting:(int)index{
    flag = index;
    [singlepickerview removeFromSuperview];
    singlepickerview = nil;
    NSArray *arr = [[NSArray alloc] initWithObjects:@"招标",@"正在施工",@"施工完成",nil];
    singlepickerview = [[SinglePickerView alloc] initWithTitle:CGRectMake(0, 0, 320, 260) title:nil Arr:arr delegate:self];
    [singlepickerview showInView:self.tableView.superview];
}

-(void)viewDidDisappear:(BOOL)animated{
    AppModel* model=[AppModel sharedInstance];
    if (self.images.count) {
        model.electroweakImageArr=self.images;
    }
    NSLog(@"tenDisappear");
}
-(void)dealloc{
    camera=nil;
    NSLog(@"tenDealloc");
}
@end
