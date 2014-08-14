//
//  FourTableViewController.m
//  ZpzchinaMobile
//
//  Created by 孙元侃 on 14-8-14.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "FourTableViewController.h"

@interface FourTableViewController ()
@property (nonatomic,strong)NSArray *titleArray;
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
    _titleArray = @[@"地勘公司",@"主体设计阶段"];

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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    UILabel *GFALabe = [[UILabel alloc] initWithFrame:CGRectMake(20,10, 100, 30)];
    GFALabe.font = [UIFont fontWithName:@"GurmukhiMN" size:14];
    GFALabe.text = [_titleArray objectAtIndex:indexPath.row];
    GFALabe.textColor = BlueColor;
    [cell addSubview:GFALabe];
    UIImageView *lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(20,46,280,1)];
    [lineImage setImage:[UIImage imageNamed:@"新建项目5_27"]];
    [cell addSubview:lineImage];
    
    if (indexPath.row==0) {
        UIImageView *addImage = [[UIImageView alloc] initWithFrame:CGRectMake(90,15, 20, 20)];
        [addImage setImage:[UIImage imageNamed:@"新建项目5_03.png"]];
        [cell addSubview:addImage];

    }
    else if (indexPath.row==1) {
        UIImageView *arrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(120,15, 10, 20)];
        [arrowImage setImage:[UIImage imageNamed:@"新建项目5_09.png"]];
        [cell addSubview:arrowImage];

    }
    

    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(void)rightBtnClicked
{


}
@end
