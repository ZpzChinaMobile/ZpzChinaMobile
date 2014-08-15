//
//  TwoTableViewController.m
//  ZpzchinaMobile
//
//  Created by 孙元侃 on 14-8-14.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "TwoTableViewController.h"
#import "ProjectTableViewCell.h"
@interface TwoTableViewController ()<ProjectDelegate>

@end

@implementation TwoTableViewController
//项目立项

-(void)addContactViewProject:(int)index{
    NSLog(@"2");
}
-(void)addContentProject:(NSString *)str index:(int)index{
    NSLog(@"2");
}
-(void)addforeignInvestment:(NSString *)str{
    NSLog(@"2");
}
-(void)updataOwner:(NSMutableDictionary *)dic index:(int)index{
    NSLog(@"2");
}
-(void)gotoMap:(NSString *)address city:(NSString *)city{
    NSLog(@"2");
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

-(instancetype)initWithSingle:(NSMutableDictionary*)singleDic dataDic:(NSMutableDictionary*)dataDic contacts:(NSMutableArray*)contacts images:(NSMutableArray*)images{
    if ([super init]) {
        self.singleDic=singleDic;
        self.dataDic=dataDic;
        self.contacts=contacts;
        //self.im
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
    
    NSString *stringcell = @"ProjectTableViewCell";
    ProjectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:stringcell];
    if(!cell){
        cell = [[ProjectTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stringcell dic:self.dataDic flag:1 ownerArr:nil singleDic:self.singleDic] ;
        cell.delegate=self;
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    // Configure the cell...
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 550;
}
@end
