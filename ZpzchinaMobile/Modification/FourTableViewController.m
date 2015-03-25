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
#import "MultipleChoiceViewController.h"
#import "LocationViewController.h"
#import "SinglePickerView.h"
#import "AppModel.h"
@interface FourTableViewController ()<DesignDelegate,AddContactViewDelegate,UIActionSheetDelegate,UITableViewDelegate,UITableViewDataSource>{
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
     NSLog(@"%@",self.contacts);
    [self.view.window.rootViewController dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    [self.tableView reloadData];
}

-(void)addContactViewDesign{
    //self.flag = 3;
    if(self.contacts.count <3){
        addcontactView = [[AddContactViewController alloc] init];
        addcontactView.delegate = self;
        addcontactView.contactType = @"designInstituteContacts";
        [addcontactView.view setFrame:CGRectMake(0, 0, 262, 431)];
        if(self.fromView == 0){
            [addcontactView setlocalProjectId:[self.dataDic objectForKey:@"id"]];
        }else{
            if(self.superVC.isRelease == 0){
                [addcontactView setlocalProjectId:[self.singleDic objectForKey:@"projectID"]];
            }else{
                [addcontactView setlocalProjectId:[self.singleDic objectForKey:@"id"]];
            }
        }
        [self.view.window.rootViewController presentPopupViewController:addcontactView animationType:MJPopupViewAnimationFade];
    }else{
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"名额已经满了！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
}
-(void)updataDesignInstituteContacts:(NSMutableDictionary *)dic index:(int)index{
    addcontactView = [[AddContactViewController alloc] init];
    addcontactView.delegate = self;
    addcontactView.contactType = @"designInstituteContacts";
    [addcontactView.view setFrame:CGRectMake(0, 0, 262, 431)];
    [addcontactView updataContact:[self.contacts objectAtIndex:index-1] index:index];
    //    if(self.fromView == 1){
    //        if(self.isRelease == 0){
    //            [addcontactView setenabled:self.designInstituteArr];
    //        }
    //    }
    [self.view.window.rootViewController presentPopupViewController:addcontactView animationType:MJPopupViewAnimationFade];
}

-(void)addSinglePickerView{
    [singlepickerview removeFromSuperview];
    singlepickerview = nil;
    NSArray *arr = [[NSArray alloc] initWithObjects:@"结构",@"立面",@"幕墙",@"暖通",@"扩初",@"蓝图",@"送审",@"审结",nil];
    singlepickerview = [[SinglePickerView alloc] initWithTitle:CGRectMake(0, 0, 320, 260) title:@"主体设计" Arr:arr delegate:self];
    singlepickerview.tag = 2;
    [singlepickerview showInView:self.tableView.superview];
}

-(instancetype)initWithSingle:(NSMutableDictionary*)singleDic dataDic:(NSMutableDictionary*)dataDic contacts:(NSMutableArray*)contacts images:(NSMutableArray *)images{
    if ([super init]) {
        self.singleDic=singleDic;
        self.dataDic=dataDic;
        self.contacts=contacts;
        
        self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, kScreenHeight-64.5-50) style:UITableViewStylePlain];
        self.tableView.delegate=self;
        self.tableView.dataSource=self;
        self.tableView.separatorStyle=NO;
        [self.view addSubview:self.tableView];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];    
}

-(void)didReceiveMemoryWarning
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
    [cell removeFromSuperview];
    cell = nil;
    if(self.fromView == 0){
        //AppModel* appModel=[AppModel sharedInstance];
        cell = [[DesignTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stringcell dic:self.dataDic flag:self.fromView Arr:self.contacts singleDic:nil];
    }else{
    
        cell = [[DesignTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stringcell dic:self.dataDic flag:1 Arr:self.contacts singleDic:self.singleDic];
    }
    cell.delegate=self;

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
-(void)dealloc{
    addcontactView=nil;
    singlepickerview=nil;
    NSLog(@"fourDealloc");
}
@end
