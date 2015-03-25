//
//  AdvancedSearchViewController.m
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-23.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "AdvancedSearchViewController.h"
#import "networkConnect.h"
@interface AdvancedSearchViewController ()

@end

@implementation AdvancedSearchViewController
@synthesize titleArr;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addBackButton];
    [self addtittle:@"高级搜索"];
    [self addRightButton:CGRectMake(280, 23, 30, 30) title:@"搜索" iamge:nil];
    dataDic = [[NSMutableDictionary alloc] init];
    [dataDic setValue:@"" forKey:@"keyStr"];
    [dataDic setValue:@"" forKey:@"companyName"];
    [dataDic setValue:@"" forKey:@"district"];
    [dataDic setValue:@"" forKey:@"province"];
    [dataDic setValue:@"" forKey:@"projectStage"];
    [dataDic setValue:@"" forKey:@"projectCategory"];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, kScreenHeight-55) style:UITableViewStylePlain];
    //[_tableView setBackgroundColor:[UIColor colorWithRed:(239/255.0)  green:(237/255.0)  blue:(237/255.0)  alpha:1.0]];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    //_tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:_tableView];
    
    self.titleArr = [[NSMutableArray alloc] initWithObjects:@"项目关键词",@"相关公司名称",
                     //ƒ@"省份",@"城市",
                     @"项目阶段",@"项目类别", nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    [self.navigationController setEnableBackGesture:true];
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    [self.mm_drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeNone];
}

-(void)viewDidDisappear:(BOOL)animated{
    [self.navigationController setEnableBackGesture:false];
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [self.mm_drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellWithIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellWithIdentifier];
    }
    if(indexPath.row == 0 || indexPath.row == 1){
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        textfield = [[UITextField alloc] initWithFrame:CGRectMake(20, 10, 300, 30)];
        textfield.delegate = self;
        textfield.tag = indexPath.row+100;
        textfield.returnKeyType=UIReturnKeyDone;
        [textfield setClearButtonMode:UITextFieldViewModeWhileEditing];
        textfield.placeholder=[self.titleArr objectAtIndex:indexPath.row];
        [cell.contentView addSubview:textfield];
    }else{
        btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(20,10, 300, 30);
        [btn setTitle:[self.titleArr objectAtIndex:indexPath.row] forState:UIControlStateNormal];
        [btn setTitleColor:BlueColor forState:UIControlStateNormal];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        btn.titleLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:16];
        btn.tag = indexPath.row+100;
        [btn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:btn];
        
        UIImageView *arrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(290,17, 8, 12.5)];
        [arrowImage setImage:[GetImagePath getImagePath:@"新建项目5_09"]];
        [cell.contentView addSubview:arrowImage];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)rightAction{
    NSLog(@"%@",dataDic);
    if(![[networkConnect sharedInstance] connectedToNetwork]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"当前网络不可用请检查连接"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil,nil];
        [alert show];
    }else{
        if(![dataDic[@"keyStr"] isEqualToString:@""]){
            resultsview = [[ResultsViewController alloc] init];
            resultsview.dataDic = dataDic;
            [self.navigationController pushViewController:resultsview animated:YES];
        }else{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请填写关键字" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    switch (textField.tag-100) {
        case 0:
            [dataDic setValue:textField.text forKey:@"keyStr"];
            break;
        case 1:
            [dataDic setValue:textField.text forKey:@"companyName"];
            break;
//        case 2:
//            [dataDic setValue:textField.text forKey:@"district"];
//            break;
//        case 3:
//            [dataDic setValue:textField.text forKey:@"province"];
        case 2:
            [dataDic setValue:textField.text forKey:@"projectStage"];
            break;
        case 3:
            [dataDic setValue:textField.text forKey:@"projectCategory"];
            break;
        default:
            break;
    }
}

-(void)BtnClick:(UIButton *)button{
    [singlepickerview removeFromSuperview];
    singlepickerview = nil;
    UITableViewCell *newCell = (UITableViewCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    UITextField *newText = (UITextField *)[newCell.contentView viewWithTag:100];
    [newText resignFirstResponder];
    UITableViewCell *newCell2 = (UITableViewCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    UITextField *newText2 = (UITextField *)[newCell2.contentView viewWithTag:101];
    [newText2 resignFirstResponder];
    NSArray *arr = nil;
   // NSString *path = [[NSBundle mainBundle]pathForResource:@"area" ofType:@"plist"];
    //NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    //NSMutableArray *allCityArray = [[NSMutableArray alloc] init];
//    if(button.tag == 102){
//        NSMutableArray *allCityArray2 = [[NSMutableArray alloc] init];
//        for (NSString *key in [dict allKeys]) {
//            [allCityArray addObject:[dict objectForKey:key]];
//        }
//        
//        for(int i=0;i<allCityArray.count;i++){
//            [allCityArray2 addObject:[[allCityArray[i] allKeys] lastObject]];
//        }
//        arr = allCityArray2;
//    }else if(button.tag == 103){
//        NSLog(@"===>%@",dataDic[@"province"]);
//        if([[NSString stringWithFormat:@"%@",dataDic[@"province"]] isEqualToString:@""]){
//            NSString *path=[[NSBundle mainBundle] pathForResource:@"citydict"
//                                                           ofType:@"plist"];
//            NSMutableDictionary *cities = nil;
//            cities = [NSMutableDictionary dictionaryWithContentsOfFile:path];
//            NSMutableArray *keys = [[NSMutableArray alloc] initWithArray:[cities allKeys]];
//            NSMutableArray *cityArr = [[NSMutableArray alloc] init];
//            for(int i=0;i<keys.count;i++){
//                for(int l=0;l<[[cities objectForKey:[keys objectAtIndex:i]] count];l++){
//                    [cityArr addObject:[[cities objectForKey:[keys objectAtIndex:i]] objectAtIndex:l]];
//                }
//            }
//            
//            arr = cityArr;
//        }else{
//            NSString *path = [[NSBundle mainBundle]pathForResource:@"area" ofType:@"plist"];
//            NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
//            NSMutableArray *allCityArray = [[NSMutableArray alloc] init];
//            NSMutableArray *cityArr = [[NSMutableArray alloc] init];
//            for (NSString *key in [dict allKeys]) {
//                //NSLog(@"%@",[dict objectForKey:key]);
//                [allCityArray addObject:[dict objectForKey:key]];
//            }
//            NSDictionary *dictCity = [allCityArray[index] objectForKey:dataDic[@"province"]];
//            for (NSString * k in [dictCity allKeys]) {
//                NSDictionary *dict = [dictCity objectForKey:k];
//                for (NSString *cityName in [dict allKeys]) {
//                    [cityArr addObject:cityName];
//                }
//            }
//            arr = cityArr;
//        }
//    }else
    if(button.tag == 102){
        NSArray *newarr = [[NSArray alloc] initWithObjects:@"土地信息阶段",@"主体设计阶段",@"主体施工阶段",@"装修阶段",nil];
        arr = newarr;
    }else{
        NSArray *newarr = [[NSArray alloc] initWithObjects:@"工业",@"酒店及餐饮",@"商务办公",@"住宅/经济适用房",@"公用事业设施（教育、医疗、科研、基础建设等）",@"其他",nil];
        arr = newarr;
    }
    singlepickerview = [[SinglePickerView alloc] initWithTitle:CGRectMake(0, 0, 320, 260) title:@"主体设计" Arr:arr delegate:self];
    singlepickerview.tag = button.tag;
    [singlepickerview showInView:self.view];
}

//选择框
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UITableViewCell *newCell = (UITableViewCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:actionSheet.tag-100 inSection:0]];
    UIButton *newBtn = (UIButton *)[newCell.contentView viewWithTag:actionSheet.tag];
    singlepickerview = (SinglePickerView *)actionSheet;
//    if(actionSheet.tag == 102){
//        if(buttonIndex == 0) {
//            NSLog(@"Cancel");
//        }else {
//            //NSLog(@"%d",singlepickerview.limitIndex);
//            index = singlepickerview.limitIndex;
//            [dataDic setValue:singlepickerview.selectStr forKey:@"province"];
//            [newBtn setTitle:singlepickerview.selectStr forState:UIControlStateNormal];
//        }
//    }else if(actionSheet.tag == 103){
//        
//        if(buttonIndex == 0) {
//            NSLog(@"Cancel");
//        }else {
//            [dataDic setValue:singlepickerview.selectStr forKey:@"district"];
//            [newBtn setTitle:singlepickerview.selectStr forState:UIControlStateNormal];
//        }
//    }else
    if(actionSheet.tag == 102){
        if(buttonIndex == 0) {
            NSLog(@"Cancel");
        }else {
            /**
             *  NSArray *newarr = [[NSArray alloc] initWithObjects:@"土地信息阶段",@"主体设计阶段",@"主体施工阶段",@"装修阶段",nil];
             arr = newarr;
             }else{
             NSArray *newarr = [[NSArray alloc] initWithObjects:@"工业",@"酒店及餐饮",@"商务办公",@"住宅/经济适用房",@"公用事业设施（教育、医疗、科研、基础建设等）",@"其他",nil];
             */
            
            NSString* stageNum=[NSString stringWithFormat:@"%d",singlepickerview.limitIndex+1];
            [dataDic setValue:stageNum forKey:@"projectStage"];
            [newBtn setTitle:singlepickerview.selectStr forState:UIControlStateNormal];
        }
    }else if(actionSheet.tag == 103){
        if(buttonIndex == 0) {
            NSLog(@"Cancel");
        }else {
            [dataDic setValue:singlepickerview.selectStr forKey:@"projectCategory"];
            [newBtn setTitle:singlepickerview.selectStr forState:UIControlStateNormal];
        }
    }
}
@end