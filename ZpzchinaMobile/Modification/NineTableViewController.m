//
//  NineTableViewController.m
//  ZpzchinaMobile
//
//  Created by 孙元侃 on 14-8-14.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "NineTableViewController.h"

@interface NineTableViewController ()

@end

@implementation NineTableViewController
//消防/景观绿化
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
    ClearFireCell *cell = [tableView dequeueReusableCellWithIdentifier:stringcell];
    if(!cell){
        cell = [[ClearFireCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stringcell dic:nil flag:1 Arr:nil singleDic:nil];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.delegate =self;
   
    // Configure the cell...
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

-(void)addContactViewFirefighting{
    [singlepickerview removeFromSuperview];
    singlepickerview = nil;
    NSArray *arr = [[NSArray alloc] initWithObjects:@"招标",@"正在施工",@"施工完成",nil];
    singlepickerview = [[SinglePickerView alloc] initWithTitle:CGRectMake(0, 0, 320, 260) title:nil Arr:arr delegate:self];
    singlepickerview.tag = 3;
    [singlepickerview showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
}


@end
