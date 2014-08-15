//
//  TwoTableViewController.m
//  ZpzchinaMobile
//
//  Created by 孙元侃 on 14-8-14.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "TwoTableViewController.h"
#import "ProjectTableViewCell.h"

#import "AddContactViewController.h"

@interface TwoTableViewController ()<ProjectDelegate>{
    AddContactViewController* addcontactView;
}

@end

@implementation TwoTableViewController
//项目立项

-(void)addContactViewProject:(int)index{
    [datepickerview removeFromSuperview];
    datepickerview = nil;
    switch (index) {
        case 0:
            
            break;
        case 1:
            self.flag = 1;
            if(ownerArr.count <3){
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
            break;
        case 2:
            if(datepickerview == nil){
                NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd"];
                NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[[self.dataDic objectForKey:@"expectedStartTime"] intValue]];
                if([[self.dataDic objectForKey:@"expectedStartTime"] isEqualToString:@""]){
                    datepickerview = [[DatePickerView alloc] initWithTitle:CGRectMake(0, 0, 320, 260) delegate:self date:nil];
                }else{
                    datepickerview = [[DatePickerView alloc] initWithTitle:CGRectMake(0, 0, 320, 260) delegate:self date:confromTimesp];
                }
                datepickerview.tag = 1;
                [datepickerview showInView:bgviewcontroller.view];
            }
            self.timeflag = 0;
            break;
        case 3:
            if(datepickerview == nil){
                NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd"];
                NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[[self.dataDic objectForKey:@"expectedFinishTime"] intValue]];
                if([[self.dataDic objectForKey:@"expectedFinishTime"] isEqualToString:@""]){
                    datepickerview = [[DatePickerView alloc] initWithTitle:CGRectMake(0, 0, 320, 260) delegate:self date:nil];
                }else{
                    datepickerview = [[DatePickerView alloc] initWithTitle:CGRectMake(0, 0, 320, 260) delegate:self date:confromTimesp];
                }
                datepickerview.tag = 1;
                [datepickerview showInView:bgviewcontroller.view];
            }
            self.timeflag = 1;
            break;
        case 4:
            
            break;
        case 5:
            ownertypeview = [[OwnerTypeViewController alloc] init];
            [ownertypeview.view setFrame:CGRectMake(0, 0, 262, 431)];
            ownertypeview.delegate = self;
            [bgviewcontroller presentPopupViewController:ownertypeview animationType:MJPopupViewAnimationSlideBottomBottom];
            break;
        default:
            break;
    }
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
