//
//  SixTableViewController.m
//  ZpzchinaMobile
//
//  Created by 孙元侃 on 14-8-14.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "SixTableViewController.h"
#import "HorizonTableViewCell.h"
@interface SixTableViewController ()

@end

@implementation SixTableViewController
//地平阶段

-(instancetype)initWithSingle:(NSMutableDictionary*)singleDic dataDic:(NSMutableDictionary*)dataDic{
    if ([super init]) {
        self.singleDic=singleDic;
        self.dataDic=dataDic;
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
    self.tableView.separatorStyle=NO;
    UIImage* image1=[UIImage imageNamed:@"全部项目_13.png"];
    UIImage* image2=[UIImage imageNamed:@"全部项目_15.png"];
    UIImage* image3=[UIImage imageNamed:@"全部项目_16.png"];
    UIImage* image4=[UIImage imageNamed:@"全部项目_13.png"];
    UIImage* image5=[UIImage imageNamed:@"全部项目_15.png"];
    UIImage* image6=[UIImage imageNamed:@"全部项目_16.png"];
    UIImage* image7=[UIImage imageNamed:@"全部项目_13.png"];
    UIImage* image8=[UIImage imageNamed:@"全部项目_15.png"];
    
    UIImage* imageLast=[UIImage imageNamed:@"地图搜索_18.png"];
    self.images=@[image1,image2,image3,image4,image5,image6,image7,image8];
    NSLog(@"image stage 1 = %d",self.images.count);
    self.images=@[image1];
    self.images=[self.images arrayByAddingObject:imageLast];
    NSLog(@"image stage 2 = %d",self.images.count);
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
        HorizonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HorizonTableViewCell"];
        if (!cell) {
            cell=[[HorizonTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HorizonTableViewCell" dic:self.dataDic flag:1 Arr:nil singleDic:self.singleDic];
            
            
            //cell=[[HorizonTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HorizonTableViewCell" flag:1 Arr:nil explorationImageArr:nil];
            
            //            cell=[[GeologicalSurveyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PlanAndAuctionTableViewCell" dic:nil singleDic:nil flag:1 contactArr:nil];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        // Configure the cell...
        
        return cell;
    }
    // cell.contentView.backgroundColor=[UIColor yellowColor];
    //cell.selectionStyle=UITableViewCellSelectionStyleNone;
    // return cell;
}

-(UIView*)getImageViewsWithImages:(NSArray*)images{
    CGFloat cellHeight=120;
    UIView* view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, cellHeight*((images.count-1)/3+1))];
    
    for (int i=0; i<images.count; i++) {
        UIImageView* imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
        imageView.center=CGPointMake(320*1.0/3*(i%3+.5), cellHeight*(i/3+.5));
        imageView.image=images[i];
        [view addSubview:imageView];
        
        UIButton* button=[[UIButton alloc]initWithFrame:imageView.frame];
        button.tag=i;
        [button addTarget:self action:@selector(tap:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
    }
    return view;
}

-(void)tap:(UIButton*)button{
    NSLog(@"%d",button.tag);
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        return ((self.images.count-1)/3+1)*120;
    }
    return 100;
}

@end
