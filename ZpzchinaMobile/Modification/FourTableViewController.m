//
//  FourTableViewController.m
//  ZpzchinaMobile
//
//  Created by 孙元侃 on 14-8-14.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "FourTableViewController.h"
#import "DesignTableViewCell.h"
@interface FourTableViewController ()<DesignDelegate>

@end

@implementation FourTableViewController
//设计阶段

-(void)addContactViewDesign{
    NSLog(@"11");
}
-(void)updataDesignInstituteContacts:(NSMutableDictionary *)dic index:(int)index{
    NSLog(@"11");
}
-(void)addSinglePickerView{
    NSLog(@"11");
}

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
        cell = [[DesignTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil dic:self.dataDic flag:1 Arr:self.contacts singleDic:self.singleDic];
        cell.delegate=self;
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    // Configure the cell...
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

-(void)rightBtnClicked
{


}
@end
