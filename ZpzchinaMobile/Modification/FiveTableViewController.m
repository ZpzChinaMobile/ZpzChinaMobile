//
//  FiveTableViewController.m
//  ZpzchinaMobile
//
//  Created by 孙元侃 on 14-8-14.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "FiveTableViewController.h"
#import "PlotTableViewCell.h"
@interface FiveTableViewController ()
@property (nonatomic,strong)NSArray *titleArray;
@end

@implementation FiveTableViewController
//出图阶段
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
    _titleArray = @[@"业主单位",@"预计施工时间",@"预计竣工时间",@"电梯",@"空调",@"供暖方式",@"外墙材料",@"钢结构"];
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
    
    static NSString *stringcell = @"ProjectTableViewCell";
    PlotTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:stringcell];
    if(!cell){
        cell = [[PlotTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil dic:nil flag:1 Arr:nil singleDic:nil];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    // Configure the cell...
    
    return cell;
 
    
    return cell;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 400;
}

@end
