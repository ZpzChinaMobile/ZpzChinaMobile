//
//  FourTableViewController.m
//  ZpzchinaMobile
//
//  Created by 孙元侃 on 14-8-14.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "FourTableViewController.h"
#import "DesignTableViewCell.h"
@interface FourTableViewController ()

@end

@implementation FourTableViewController
//设计阶段
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
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   static NSString *stringcell = @"ProjectTableViewCell";
    DesignTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:stringcell];
    if(!cell){
        cell = [[DesignTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil dic:nil flag:1 Arr:nil singleDic:nil];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    // Configure the cell...
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(void)rightBtnClicked
{


}
@end
