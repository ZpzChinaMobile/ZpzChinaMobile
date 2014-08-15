//
//  SevenTableViewController.m
//  ZpzchinaMobile
//
//  Created by 孙元侃 on 14-8-14.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "SevenTableViewController.h"
#import "PilePitTableViewCell.h"
#import "CameraModel.h"
#import "GTMBase64.h"

@interface SevenTableViewController ()<PilePitDelegate>

@end

@implementation SevenTableViewController
//桩基基坑

-(void)addContactViewPilePit{
    NSLog(@"11");
}
-(void)updataPileFoundationUnitContacts:(NSMutableDictionary *)dic index:(int)index{
    NSLog(@"11");
}

-(instancetype)initWithSingle:(NSMutableDictionary*)singleDic dataDic:(NSMutableDictionary*)dataDic contacts:(NSMutableArray*)contacts images:(NSMutableArray *)images{
    if ([super init]) {
        self.singleDic=singleDic;
        self.dataDic=dataDic;
        self.contacts=contacts;
        self.images=[NSMutableArray array];
        
        for (int i=0; i<images.count; i++) {
            CameraModel* model= images[i];
            UIImage *aimage=[UIImage imageWithData:[GTMBase64 decodeString:model.a_imgCompressionContent]];
            [self.images addObject:aimage];
        }
        [self.images addObject:[UIImage imageNamed:@"新建项目1_06.png"]];
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
        PilePitTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PilePitTableViewCell"];
        if (!cell) {
            cell=[[PilePitTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PilePitTableViewCell" flag:1 Arr:self.contacts];
            cell.delegate=self;
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
    return 50;
}
@end
