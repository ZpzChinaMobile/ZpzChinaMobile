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
@interface EightTableViewController ()

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
        cell.contentView.backgroundColor=[UIColor yellowColor];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    
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
        return ((self.images.count-1)/3+1)*120;
}

@end
