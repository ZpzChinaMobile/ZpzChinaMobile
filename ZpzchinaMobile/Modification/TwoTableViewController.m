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
#import "MultipleChoiceViewController.h"
#import "LocationViewController.h"
#import "AppModel.h"
#import "AppDelegate.h"
#import "networkConnect.h"
@interface TwoTableViewController ()<ProjectDelegate,AddContactViewDelegate,MChoiceViewDelegate,LocationViewDelegate,UIActionSheetDelegate,UITableViewDataSource,UITableViewDelegate>{
    AddContactViewController* addcontactView;
    DatePickerView* datepickerview;
    MultipleChoiceViewController* muview;
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
    //    NSLog(@"==>%d",self.flag);
    [dic setValue:@"ownerUnitContacts" forKeyPath:@"category"];
    if(btnTag != 0){
        NSLog(@"==>%@",[dic objectForKey:@"accountName"]);
        [self.contacts replaceObjectAtIndex:btnTag-1 withObject:dic];
    }else{
        [self.contacts addObject:dic];
    }
    [self.view.window.rootViewController dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    [self.tableView reloadData];
    
    //
    [[self.superVC.tvcArray[4] tableView] reloadData];
}

-(void)locationBack:(NSString *)address testLocation:(CLLocationCoordinate2D)testLocation{
    [self.dataDic setObject:address forKey:@"landAddress"];
    [self.dataDic setObject:[NSString stringWithFormat:@"%f",testLocation.longitude] forKey:@"longitude"];
    [self.dataDic setObject:[NSString stringWithFormat:@"%f",testLocation.latitude] forKey:@"latitude"];
    [self.tableView reloadData];
    [[self.superVC.tvcArray[0] tableView]reloadData];

}

-(void)backMChoiceViewController{
    [self.view.window.rootViewController dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
}

-(void)choiceData:(NSMutableArray *)arr index:(int)index{
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
    [self.view.window.rootViewController dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
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
                addcontactView.delegate = self;
                addcontactView.contactType = @"ownerUnitContacts";
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
            muview = [[MultipleChoiceViewController alloc] init];
            muview.arr = [[NSMutableArray alloc] initWithObjects:@"外商独资",@"中外合资",@"私人企业",@"政府机关",@"国有企业",@"其他", nil];
            muview.flag = 0;
            muview.delegate = self;
            [muview.view setFrame:CGRectMake(0, 0, 272, 350)];
            [self.view.window.rootViewController presentPopupViewController:muview animationType:MJPopupViewAnimationFade];
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
//            if([str isEqualToString:@""]){
//                if(self.fromView == 0){
//                    [self.dataDic setObject:@"0" forKey:@"investment"];
//                }else{
//                    [self.dataDic setObject:@"0" forKey:@"investment"];
//                }
//            }else{
//                if([str floatValue]<=999999999){
//                    [self.dataDic setObject:[NSString stringWithFormat:@"%.2f",[str floatValue]] forKey:@"investment"];
//                }else{
//                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"数字过大" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//                    [alertView show];
//                    [self.dataDic setObject:@"0" forKey:@"investment"];
//                }
//            }
            
            if(![str isEqualToString:@""]){
                if([str floatValue]<=999999999){
                    [self.dataDic setObject:[NSString stringWithFormat:@"%.2f",round([str doubleValue]*100)/100] forKey:@"investment"];
                }else{
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"数字过大" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alertView show];
                    [self.dataDic setObject:@"0" forKey:@"investment"];
                }
            }
            break;
        case 3:
//            if([str isEqualToString:@""]){
//                if(self.fromView == 0){
//                    [self.dataDic setObject:@"0" forKey:@"areaOfStructure"];
//                }else{
//                    [self.dataDic setObject:@"0" forKey:@"areaOfStructure"];
//                }
//            }else{
//                if([str floatValue]<=999999999){
//                    [self.dataDic setObject:[NSString stringWithFormat:@"%.0f",[str floatValue]] forKey:@"areaOfStructure"];
//                }else{
//                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"数字过大" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//                    [alertView show];
//                    [self.dataDic setObject:@"0" forKey:@"areaOfStructure"];
//                }
//            }
            if(![str isEqualToString:@""]){
                if([str floatValue]<=999999999){
                    NSArray *arr = [[NSString stringWithFormat:@"%f",[str doubleValue]] componentsSeparatedByString:@"."];
                    if([[arr[1] substringToIndex:1] intValue] <5){
                        [self.dataDic setObject:[NSString stringWithFormat:@"%.0f",[str doubleValue]] forKey:@"areaOfStructure"];
                    }else{
                        [self.dataDic setObject:[NSString stringWithFormat:@"%.0f",ceilf([str doubleValue])] forKey:@"areaOfStructure"];
                    }
                }else{
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"数字过大" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alertView show];
                    [self.dataDic setObject:@"0" forKey:@"areaOfStructure"];
                }
            }
            break;
        case 4:
//            if([str isEqualToString:@""]){
//                if(self.fromView == 0){
//                    [self.dataDic setObject:@"0" forKey:@"storeyHeight"];
//                }else{
//                    [self.dataDic setObject:@"0" forKey:@"storeyHeight"];
//                }
//            }else{
//                if([str intValue]<=9999){
//                    [self.dataDic setObject:[NSString stringWithFormat:@"%d",[str intValue]] forKey:@"storeyHeight"];
//                }else{
//                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"建筑层高不能超过9999层" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//                    [alertView show];
//                    [self.dataDic setObject:@"0" forKey:@"storeyHeight"];
//                }
//            }
            if(![str isEqualToString:@""]){
                if([str intValue]<=9999){
                    [self.dataDic setObject:[NSString stringWithFormat:@"%d",[str intValue]] forKey:@"storeyHeight"];
                }else{
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"建筑层高不能超过9999层" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alertView show];
                    [self.dataDic setObject:@"0" forKey:@"storeyHeight"];
                }
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
    addcontactView.delegate = self;
    addcontactView.contactType = @"ownerUnitContacts";
    [addcontactView.view setFrame:CGRectMake(0, 0, 262, 431)];
    [addcontactView updataContact:[self.contacts objectAtIndex:index-1] index:index];

    [self.view.window.rootViewController presentPopupViewController:addcontactView animationType:MJPopupViewAnimationFade];
}

-(void)gotoMap:(NSString *)address city:(NSString *)city{
    NSLog(@"====>%@",city);
    if([CLLocationManager locationServicesEnabled] && [CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"请先打开定位功能" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }else{
        if(![[networkConnect sharedInstance] connectedToNetwork]){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"当前网络不可用请检查连接"
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil,nil];
            [alert show];
        }else{
            AppDelegate* app=[AppDelegate instance];
            if (!app.locationView) {
                app.locationView = [[LocationViewController alloc] init];
            }
            app.locationView.delegate = self;
            app.locationView.baseAddress = address;
            app.locationView.baseCity = city;
            [self.superVC.navigationController pushViewController:app.locationView animated:YES];
        }
    }
}

-(void)getLocationNil{
    AppDelegate* app=[AppDelegate instance];
    if (app.locationView) {
        app.locationView=nil;
    }
}

-(instancetype)initWithSingle:(NSMutableDictionary*)singleDic dataDic:(NSMutableDictionary*)dataDic contacts:(NSMutableArray*)contacts images:(NSMutableArray*)images{
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
    
    NSString *stringcell = @"ProjectTableViewCell";
    ProjectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:stringcell];
    //if(!cell){
    [cell removeFromSuperview];
    cell = nil;
    if(self.fromView == 0){
        cell=[[ProjectTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stringcell dic:self.dataDic flag:self.fromView ownerArr:self.contacts singleDic:nil];
    }else{
        cell = [[ProjectTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stringcell dic:self.dataDic flag:1 ownerArr:self.contacts singleDic:self.singleDic] ;

    }
    cell.delegate=self;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)beginEditWithHeight:(CGFloat)height{
    NSLog(@"beginEdit");
    CGFloat a=height-self.tableView.contentOffset.y+45;
    if (a>=210) {
        [self.delegate upTVCSpaceWithHeight:a-210];
    }
}

-(void)endEdit{
    NSLog(@"endEdit");
    [self.delegate downTVCSpace];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 550;
}

-(void)cellTextFieldResignFirstResponder{
    ProjectTableViewCell* cell=(ProjectTableViewCell*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [cell closeKeyBoard];
}

-(void)dealloc{
    addcontactView=nil;
    datepickerview=nil;
    muview=nil;
    locationView=nil;
    NSLog(@"twoDealloc");
}
@end
