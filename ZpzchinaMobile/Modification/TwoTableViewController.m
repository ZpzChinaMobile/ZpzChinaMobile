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
#import "DatePickerView.h"
#import "UIViewController+MJPopupViewController.h"
#import "OwnerTypeViewController.h"
#import "LocationViewController.h"
@interface TwoTableViewController ()<ProjectDelegate,AddContactViewDelegate,OwnerTypeViewDelegate,LocationViewDelegate,UIActionSheetDelegate>{
    AddContactViewController* addcontactView;
    DatePickerView* datepickerview;
    OwnerTypeViewController* ownertypeview;
    LocationViewController* locationView;
}

@end

@implementation TwoTableViewController
//项目立项

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{

        datepickerview = (DatePickerView *)actionSheet;
        if(buttonIndex == 0) {
            NSLog(@"Cancel");
        }else {
  //          _isUpdata = YES;
            if(self.timeflag == 0){
                [self.dataDic setObject:datepickerview.timeSp forKey:@"expectedStartTime"];
            }else if(self.timeflag == 1){
                [self.dataDic setObject:datepickerview.timeSp forKey:@"expectedFinishTime"];
            }else{
                //[self.dataDic setObject:datepickerview.timeSp forKey:@"actualStartTime"];
            }
        }
        [self.tableView reloadData];
}

-(void)back:(NSMutableDictionary *)dic btnTag:(int)btnTag{
    //   _isUpdata = YES;
    //    NSLog(@"==>%d",self.flag);
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

-(void)locationBack:(NSString *)address testLocation:(CLLocationCoordinate2D)testLocation{
    //    _isUpdata = YES;
    [self.dataDic setObject:address forKey:@"landAddress"];
    [self.dataDic setObject:[NSString stringWithFormat:@"%f",testLocation.longitude] forKey:@"longitude"];
    [self.dataDic setObject:[NSString stringWithFormat:@"%f",testLocation.latitude] forKey:@"latitude"];
    [self.tableView reloadData];
}

-(void)backOwnerTypeViewController{
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationSlideBottomBottom];
}

-(void)choiceDataOwnerType:(NSMutableArray *)arr{
    NSMutableString *string = [[NSMutableString alloc] init];
    for(int i=0;i<arr.count;i++){
        if(![[arr objectAtIndex:i] isEqualToString:@""]){
            [string appendString:[NSString stringWithFormat:@"%@,",[arr objectAtIndex:i]]];
        }
    }
    
    if(string.length !=0){
        NSString *aStr=[string substringToIndex:([string length]-1)];
        [self.dataDic setObject:aStr forKey:@"ownerType"];
    }else{
        [self.dataDic setObject:@"" forKey:@"ownerType"];
    }
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationSlideBottomTop];
    [self.tableView reloadData];
    
}

-(void)addContactViewProject:(int)index{
    [datepickerview removeFromSuperview];
    datepickerview = nil;
    switch (index) {
        case 0:
            break;
        case 1:
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
                [datepickerview showInView:self.tableView.superview];
                [self.tableView scrollRectToVisible:CGRectMake(0, 200, 320, 500) animated:YES];
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
                [datepickerview showInView:self.tableView.superview];
                //将tableview滚动至可以看到参考内容的rect
                [self.tableView scrollRectToVisible:CGRectMake(0, 200, 320, self.tableView.contentSize.height-200) animated:YES];
            }
            self.timeflag = 1;
            break;
        case 4:
            
            break;
        case 5:
            ownertypeview = [[OwnerTypeViewController alloc] init];
            [ownertypeview.view setFrame:CGRectMake(0, 0, 262, 431)];
            ownertypeview.delegate = self;
            [self presentPopupViewController:ownertypeview animationType:MJPopupViewAnimationSlideBottomBottom];
            break;
        default:
            break;
    }
}

-(void)addContentProject:(NSString *)str index:(int)index{
    //_isUpdata = YES;
    switch (index) {
        case 0:
            [self.dataDic setObject:str forKey:@"projectName"];
            break;
        case 1:
            [self.dataDic setObject:str forKey:@"description"];
            break;
        case 2:
            if([str isEqualToString:@""]){
                if(self.fromView == 0){
                    [self.dataDic setObject:@"0" forKey:@"investment"];
                }else{
                    [self.dataDic setObject:@"" forKey:@"investment"];
                }
            }else{
                [self.dataDic setObject:[NSString stringWithFormat:@"%d",[str intValue]] forKey:@"investment"];
            }
            break;
        case 3:
            if([str isEqualToString:@""]){
                if(self.fromView == 0){
                    [self.dataDic setObject:@"0" forKey:@"areaOfStructure"];
                }else{
                    [self.dataDic setObject:@"" forKey:@"areaOfStructure"];
                }
            }else{
                [self.dataDic setObject:[NSString stringWithFormat:@"%d",[str intValue]] forKey:@"areaOfStructure"];
            }
            break;
        case 4:
            if([str isEqualToString:@""]){
                if(self.fromView == 0){
                    [self.dataDic setObject:@"0" forKey:@"storeyHeight"];
                }else{
                    [self.dataDic setObject:@"" forKey:@"storeyHeight"];
                }
            }else{
                [self.dataDic setObject:[NSString stringWithFormat:@"%d",[str intValue]] forKey:@"storeyHeight"];
            }
            break;
        default:
            break;
    }
    [self.tableView reloadData];
}
-(void)addforeignInvestment:(NSString *)str{
    //_isUpdata = YES;
    if([str isEqualToString:@"参与"]){
        [self.dataDic setObject:@"1" forKey:@"foreignInvestment"];
    }else{
        [self.dataDic setObject:@"0" forKey:@"foreignInvestment"];
    }
    [self.tableView reloadData];
}

-(void)updataOwner:(NSMutableDictionary *)dic index:(int)index{
    //    self.flag = 1;
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

-(void)gotoMap:(NSString *)address city:(NSString *)city{
    //[locateview removeFromSuperview];
    //locateview = nil;
    NSLog(@"%@",city);
    locationView = [[LocationViewController alloc] init];
    locationView.delegate = self;
    locationView.baseAddress = address;
    locationView.baseCity = city;
    [self.navigationController pushViewController:locationView animated:YES];
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
//    self.bgVC=[[UIViewController alloc]init];
//    self.bgVC.view.frame=CGRectMake(0, 568-64.5-431, 320, 431);
//    [self.tableView.superview addSubview:self.bgVC.view];
    //self.bgVC.view.frame=;
    
    self.fromView=1;
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
    //if(!cell){
    cell = [[ProjectTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stringcell dic:self.dataDic flag:1 ownerArr:self.contacts singleDic:self.singleDic] ;
    cell.delegate=self;
    //}
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    // Configure the cell...
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 550;
}
@end
