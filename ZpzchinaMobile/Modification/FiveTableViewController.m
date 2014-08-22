//
//  FiveTableViewController.m
//  ZpzchinaMobile
//
//  Created by 孙元侃 on 14-8-14.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "FiveTableViewController.h"
#import "PlotTableViewCell.h"
#import "AddContactViewController.h"
#import "DatePickerView.h"
#import "UIViewController+MJPopupViewController.h"
#import "OwnerTypeViewController.h"
#import "LocationViewController.h"
#import "SinglePickerView.h"
#import "AppModel.h"
@interface FiveTableViewController ()<PlotDelegate,AddContactViewDelegate,UIActionSheetDelegate>{
    DatePickerView* datepickerview;
    AddContactViewController* addcontactView;
}
@property (nonatomic,strong)NSArray *titleArray;
@end

@implementation FiveTableViewController
//出图阶段

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    datepickerview = (DatePickerView *)actionSheet;
    if(buttonIndex == 0) {
        NSLog(@"Cancel");
    }else {
        //_isUpdata = YES;
        if(self.timeflag == 0){
            [self.dataDic setObject:datepickerview.timeSp forKey:@"expectedStartTime"];
        }else if(self.timeflag == 1){
            [self.dataDic setObject:datepickerview.timeSp forKey:@"expectedFinishTime"];
        }else{
            [self.dataDic setObject:datepickerview.timeSp forKey:@"actualStartTime"];
        }
    }
    [self.tableView reloadData];
}

-(void)back:(NSMutableDictionary *)dic btnTag:(int)btnTag{
    [dic setValue:@"ownerUnitContacts" forKeyPath:@"category"];
    if(btnTag != 0){
        NSLog(@"==>%@",[dic objectForKey:@"accountName"]);
        [self.contacts replaceObjectAtIndex:btnTag-1 withObject:dic];
    }else{
        [self.contacts addObject:dic];
    }
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationSlideBottomBottom];
    [self.tableView reloadData];
}

-(void)addContactViewPlot:(int)index{
    [datepickerview removeFromSuperview];
    datepickerview = nil;
    switch (index) {
        case 0:
            //self.flag = 1;
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
            break;
        case 1:
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
                [datepickerview showInView:self.tableView.superview];
            }
            self.timeflag = 0;
            break;
        case  2:
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
                [datepickerview showInView:self.tableView.superview];
            }
            self.timeflag = 1;
            break;
        default:
            break;
    }
}
-(void)updataPlotOwner:(NSMutableDictionary *)dic index:(int)index{
    addcontactView = [[AddContactViewController alloc] init];
    [addcontactView.view setFrame:CGRectMake(0, 0, 262, 431)];
    addcontactView.delegate = self;
    [addcontactView updataContact:[self.contacts objectAtIndex:index-1] index:index];
    //    if(self.fromView == 1){
    //        if(self.isRelease == 0){
    //            [addcontactView setenabled:self.ownerArr];
    //        }
    //    }
    [self presentPopupViewController:addcontactView animationType:MJPopupViewAnimationSlideBottomBottom];
}
-(void)addSwitchValue:(int)index value:(BOOL)value{
    //   _isUpdata = YES;
    switch (index) {
        case 0:
            [self.dataDic setObject:[NSString stringWithFormat:@"%d",value] forKey:@"propertyElevator"];
            break;
        case 1:
            [self.dataDic setObject:[NSString stringWithFormat:@"%d",value] forKey:@"propertyAirCondition"];
            break;
        case 2:
            [self.dataDic setObject:[NSString stringWithFormat:@"%d",value] forKey:@"propertyHeating"];
            break;
        case 3:
            [self.dataDic setObject:[NSString stringWithFormat:@"%d",value] forKey:@"propertyExternalWallMeterial"];
            break;
        case 4:
            [self.dataDic setObject:[NSString stringWithFormat:@"%d",value] forKey:@"propertyStealStructure"];
            break;
        default:
            break;
    }
}

-(instancetype)initWithSingle:(NSMutableDictionary*)singleDic dataDic:(NSMutableDictionary*)dataDic contacts:(NSMutableArray*)contacts images:(NSMutableArray *)images{
    if ([super init]) {
        self.singleDic=singleDic;
        self.dataDic=dataDic;
        self.contacts=contacts;
    }
    return self;
}

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
//    if (self.fromView==0) {
//        AppModel* appModel=[AppModel sharedInstance];
//        appModel.ownerAry =[NSMutableArray array];
//        self.contacts=appModel.ownerAry;
//    }
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
    //if(!cell){
    if(self.fromView == 0){
        cell = [[PlotTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stringcell dic:self.dataDic flag:0 Arr:self.contacts singleDic:nil];
    }else{
        cell = [[PlotTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stringcell dic:self.dataDic flag:1 Arr:self.contacts singleDic:self.singleDic];
    }
    
    cell.delegate=self;
    //}
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    // Configure the cell...
    
    return cell;
    
    
    return cell;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 400;
}
-(void)dealloc{
    NSLog(@"fiveDealloc");
}
@end
