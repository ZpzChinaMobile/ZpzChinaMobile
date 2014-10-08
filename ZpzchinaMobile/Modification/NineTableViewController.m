//
//  NineTableViewController.m
//  ZpzchinaMobile
//
//  Created by 孙元侃 on 14-8-14.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "NineTableViewController.h"
#import "CameraModel.h"
#import "GTMBase64.h"
#import "Camera.h"
#import "CameraSqlite.h"
#import "AppModel.h"
@interface NineTableViewController ()<CameraDelegate>{
    Camera* camera;
    NSInteger newImageCount;
}

@end

@implementation NineTableViewController
//消防/景观绿化
-(instancetype)initWithSingle:(NSMutableDictionary*)singleDic dataDic:(NSMutableDictionary*)dataDic images:(NSMutableArray*)images{
    if ([super init]) {
        self.singleDic=singleDic;
        self.dataDic=dataDic;
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
        [cell.contentView addSubview:[self getImageViewsWithImages:[self.images copy]]];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        return cell;
    }else{
        static NSString *stringcell = @"ClearFireCell";
        ClearFireCell *cell = [tableView dequeueReusableCellWithIdentifier:stringcell];
        [cell removeFromSuperview];
        cell = nil;
        if(self.fromView == 0){
            cell = [[ClearFireCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stringcell dic:self.dataDic flag:0 Arr:nil singleDic:nil];
        }else{
            cell = [[ClearFireCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stringcell dic:self.dataDic flag:1 Arr:nil singleDic:self.singleDic];
            
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.delegate =self;
        
        // Configure the cell...
        
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        return (self.images.count/3+1)*120;
    }
    return 100;
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
        self.images = [CameraSqlite loadAllfireControlList:[self.dataDic objectForKey:@"id"]];
    }else{
        if(self.superVC.isRelease == 0){
            if([CameraSqlite loadfireControlSingleList:[self.singleDic objectForKey:@"projectID"]].count!=0){
                [self.images insertObject:[[CameraSqlite loadAllfireControlList:[self.singleDic objectForKey:@"projectID"]] objectAtIndex:0] atIndex:0];
            }
        }else{
            [self.images removeAllObjects];
            if([[self.singleDic objectForKey:@"projectID"] isEqualToString:@""]){
                self.images = [CameraSqlite loadAllfireControlList:[self.singleDic objectForKey:@"id"]];
            }else{
                self.images = [CameraSqlite loadAllfireControlList:[self.singleDic objectForKey:@"projectID"]];
            }
        }
    }
    [self.tableView reloadData];
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
            [camera getCameraView:self.superVC flag:4 aid:[self.singleDic objectForKey:@"id"]];
        }else{
            [camera getCameraView:self.superVC flag:4 aid:[self.singleDic objectForKey:@"projectID"]];
        }
    }else{
        [camera getCameraView:self.superVC flag:4 aid:[self.dataDic objectForKey:@"id"]];
    }
}


-(void)addContactViewFirefighting:(int)index{
    flag = index;
    [singlepickerview removeFromSuperview];
    singlepickerview = nil;
    NSArray *arr = [[NSArray alloc] initWithObjects:@"招标",@"正在施工",@"施工完成",nil];
    singlepickerview = [[SinglePickerView alloc] initWithTitle:CGRectMake(0, 0, 320, 260) title:nil Arr:arr delegate:self];
    [singlepickerview showInView:self.tableView.superview];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    singlepickerview = (SinglePickerView *)actionSheet;
    NSLog(@"%@",singlepickerview.selectStr);
    if(buttonIndex == 0) {
        NSLog(@"Cancel");
    }else {
        if(flag == 0){
            [self.dataDic setObject:singlepickerview.selectStr forKey:@"fireControl"];
        }else if(flag == 1){
            [self.dataDic setObject:singlepickerview.selectStr forKey:@"green"];
        }
    }
    [self.tableView reloadData];
}

-(void)viewDidDisappear:(BOOL)animated{
    AppModel* model=[AppModel sharedInstance];
    if (self.images.count) {
        model.fireControlImageArr=self.images;
    }
    NSLog(@"nineDisappear");
}
-(void)dealloc{
    camera=nil;
    for (int i=0; i<newImageCount; i++) {
        [self.images removeLastObject];
    }
    NSLog(@"nineDealloc");
}
@end
