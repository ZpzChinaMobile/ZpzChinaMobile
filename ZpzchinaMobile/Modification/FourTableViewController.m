//
//  FourTableViewController.m
//  ZpzchinaMobile
//
//  Created by 孙元侃 on 14-8-14.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "FourTableViewController.h"
#import "DesignTableViewCell.h"
#import "AddContactViewController.h"
#import "DatePickerView.h"
#import "UIViewController+MJPopupViewController.h"
#import "OwnerTypeViewController.h"
#import "LocationViewController.h"
#import "SinglePickerView.h"
#import "AppModel.h"
@interface FourTableViewController ()<DesignDelegate,AddContactViewDelegate,UIActionSheetDelegate>{
    AddContactViewController* addcontactView;
    SinglePickerView* singlepickerview;
}

@end

@implementation FourTableViewController
//设计阶段


-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    singlepickerview = (SinglePickerView *)actionSheet;
    if(buttonIndex == 0) {
        NSLog(@"Cancel");
    }else {
        //           _isUpdata = YES;
        [self.dataDic setObject:singlepickerview.selectStr forKey:@"mainDesignStage"];
    }
    NSLog(@"222%@",self.dataDic);
    [self.tableView reloadData];
}

-(void)back:(NSMutableDictionary *)dic btnTag:(int)btnTag{
    
    [dic setValue:@"designInstituteContacts" forKey:@"category"];
    if(btnTag != 0){
        [self.contacts replaceObjectAtIndex:btnTag-1 withObject:dic];
    }else{
        [self.contacts addObject:dic];
    }
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationSlideBottomBottom];
    [self.tableView reloadData];
}

-(void)addContactViewDesign{
    //self.flag = 3;
    if(self.contacts.count <3){
        addcontactView = [[AddContactViewController alloc] init];
        [addcontactView.view setFrame:CGRectMake(0, 0, 262, 431)];
        addcontactView.delegate = self;
        if(self.fromView == 0){
            [addcontactView setlocalProjectId:[self.dataDic objectForKey:@"id"]];
        }else{
            [addcontactView setlocalProjectId:[self.singleDic objectForKey:@"projectID"]];
        }
        [self presentPopupViewController:addcontactView animationType:MJPopupViewAnimationSlideBottomBottom];
    }else{
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"名额已经满了！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
}
-(void)updataDesignInstituteContacts:(NSMutableDictionary *)dic index:(int)index{
    addcontactView = [[AddContactViewController alloc] init];
    [addcontactView.view setFrame:CGRectMake(0, 0, 262, 431)];
    addcontactView.delegate = self;
    [addcontactView updataContact:[self.contacts objectAtIndex:index-1] index:index];
    //    if(self.fromView == 1){
    //        if(self.isRelease == 0){
    //            [addcontactView setenabled:self.designInstituteArr];
    //        }
    //    }
    [self presentPopupViewController:addcontactView animationType:MJPopupViewAnimationSlideBottomBottom];
}

-(void)addSinglePickerView{
    [singlepickerview removeFromSuperview];
    singlepickerview = nil;
    NSArray *arr = [[NSArray alloc] initWithObjects:@"结构",@"立面",@"幕墙",@"暖通",@"扩初",@"蓝图",@"送审",@"审结",nil];
    singlepickerview = [[SinglePickerView alloc] initWithTitle:CGRectMake(0, 0, 320, 260) title:@"主体设计" Arr:arr delegate:self];
    singlepickerview.tag = 2;
    [singlepickerview showInView:self.tableView.superview];
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
//    if (self.fromView==0) {
//        AppModel* appModel=[AppModel sharedInstance];
//        appModel.designAry =[NSMutableArray array];
//        self.contacts=appModel.designAry;
//    }
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
   // if(!cell){
    if(self.fromView == 0){
        //AppModel* appModel=[AppModel sharedInstance];
        cell = [[DesignTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stringcell dic:self.dataDic flag:self.fromView Arr:self.contacts singleDic:nil];
    }else{
    
        cell = [[DesignTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stringcell dic:self.dataDic flag:1 Arr:self.contacts singleDic:self.singleDic];
    NSLog(@"%@",self.dataDic);
    }        cell.delegate=self;

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
