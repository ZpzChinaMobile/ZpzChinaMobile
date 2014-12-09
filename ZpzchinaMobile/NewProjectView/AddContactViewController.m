//
//  AddContactViewController.m
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-24.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "AddContactViewController.h"
#import "ContactSqlite.h"
#import "ContactModel.h"
@interface AddContactViewController ()

@end

@implementation AddContactViewController
@synthesize delegate;
@synthesize dataDic;
@synthesize btnTag;
@synthesize dropDown;
@synthesize contactType;
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
    int value = (arc4random() % 9999999) + 1000000;
    self.dataDic = [[NSMutableDictionary alloc] init];
    [self.dataDic setValue:[NSString stringWithFormat:@"%d",value] forKey:@"id"];
    [self.dataDic setValue:@"" forKey:@"contactName"];
    [self.dataDic setValue:@"" forKey:@"mobilePhone"];
    [self.dataDic setValue:@"" forKey:@"accountName"];
    [self.dataDic setValue:@"" forKey:@"accountAddress"];
    [self.dataDic setValue:@"" forKey:@"projectID"];
    [self.dataDic setValue:@"" forKey:@"projectName"];
    [self.dataDic setValue:@"" forKey:@"localProjectId"];
    [self.dataDic setValue:@"" forKey:@"baseContactID"];
    [self.dataDic setValue:@"" forKeyPath:@"duties"];
    UIImageView *bgimageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 262, 431)];
    [bgimageView setImage:[GetImagePath getImagePath:@"新建项目1_03"]];
    [self.view addSubview:bgimageView];
    
    UIImageView *headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(118.5, 10, 25, 25)];
    [headerImageView setImage:[GetImagePath getImagePath:@"新建项目1_06"]];
    [self.view addSubview:headerImageView];
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 120, 262, 311)];
    for (int i=0; i<5; i++) {
        UIImageView *lingImage = [[UIImageView alloc] initWithFrame:CGRectMake(31, 45*(i+1), 200, 1)];
        [lingImage setImage:[GetImagePath getImagePath:@"新建项目5_27"]];
        [contentView addSubview:lingImage];
    }
    
    UIImageView *btnImageView = [[UIImageView alloc] initWithFrame:CGRectMake(60, 250, 143.5, 32)];
    [btnImageView setImage:[GetImagePath getImagePath:@"新建项目1_11"]];
    [contentView addSubview:btnImageView];
    
    saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    saveBtn.frame = CGRectMake(60, 250, 143.5, 32);
    [saveBtn setBackgroundColor:[UIColor clearColor]];
    [saveBtn setTitle:@"保  存" forState:UIControlStateNormal];
    [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    saveBtn.titleLabel.font = [UIFont fontWithName:@"GurmukhiMN-Bold" size:16];;
    [saveBtn addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:saveBtn];
    
    addName = [[UITextField alloc] initWithFrame:CGRectMake(31, 10, 205, 32)];
    addName.delegate = self;
    addName.textAlignment=NSTextAlignmentLeft;
    addName.placeholder=@"添加姓名";
    addName.returnKeyType=UIReturnKeyDone;
    addName.tag = 0;
    [addName setClearButtonMode:UITextFieldViewModeWhileEditing];
    [contentView addSubview:addName];
    
    addPhone = [[UITextField alloc] initWithFrame:CGRectMake(31, 55, 205, 32)];
    addPhone.delegate = self;
    addPhone.textAlignment=NSTextAlignmentLeft;
    addPhone.placeholder=@"添加电话";
    addPhone.returnKeyType=UIReturnKeyDone;
    addPhone.keyboardType = UIKeyboardTypeNumberPad;
    addPhone.tag = 1;
    [addPhone setClearButtonMode:UITextFieldViewModeWhileEditing];
    [contentView addSubview:addPhone];
    
    title = [UIButton buttonWithType:UIButtonTypeCustom];
    title.frame = CGRectMake(31, 100, 143.5, 32);
    [title setTitle:@"岗位" forState:UIControlStateNormal];
    [title setTitleColor:BlueColor forState:UIControlStateNormal];
    title.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    title.titleLabel.font = [UIFont fontWithName:@"GurmukhiMN-Bold" size:16];;
    [title addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:title];
    
    UIImageView *arrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(220,108, 8, 12.5)];
    [arrowImage setImage:[GetImagePath getImagePath:@"新建项目5_09"]];
    [contentView addSubview:arrowImage];
    
    accountName = [[UITextField alloc] initWithFrame:CGRectMake(31, 145, 205, 32)];
    accountName.delegate = self;
    accountName.textAlignment=NSTextAlignmentLeft;
    accountName.placeholder=@"单位名称";
    accountName.returnKeyType=UIReturnKeyDone;
    accountName.tag = 2;
    [accountName setClearButtonMode:UITextFieldViewModeWhileEditing];
    [contentView addSubview:accountName];
    
    address = [[UITextField alloc] initWithFrame:CGRectMake(31, 190, 205, 32)];
    address.delegate = self;
    address.textAlignment=NSTextAlignmentLeft;
    address.placeholder=@"单位地址";
    address.returnKeyType=UIReturnKeyDone;
    address.tag = 3;
    [address setClearButtonMode:UITextFieldViewModeWhileEditing];
    [contentView addSubview:address];
    
    [self.view addSubview:contentView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setlocalProjectId:(NSString *)aid{
    [self.dataDic setValue:aid forKey:@"localProjectId"];
    [self.dataDic setValue:aid forKey:@"projectID"];
    NSLog(@"self.dataDic ==> %@",self.dataDic);
}

-(void)updataContact:(NSMutableDictionary *)dic index:(int)index{
    //NSLog(@"dic ===> %@",dic);
    self.dataDic = dic;
    self.btnTag = index;
    [addName setText:[dic objectForKey:@"contactName"]];
    [addPhone setText:[dic objectForKey:@"mobilePhone"]];
    [accountName setText:[dic objectForKey:@"accountName"]];
    [address setText:[dic objectForKey:@"accountAddress"]];
    [title setTitle:[NSString stringWithFormat:@"岗位:%@",[dic objectForKey:@"duties"]] forState:UIControlStateNormal];
}

-(void)saveBtnClick{
    if([[self.dataDic objectForKey:@"contactName"] isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"请填写姓名！"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil,nil];
        [alert show];
        return;
    }
    
    if([[self.dataDic objectForKey:@"mobilePhone"] isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"请填写电话！"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil,nil];
        [alert show];
        return;
    }
    
    if ([delegate respondsToSelector:@selector(back:btnTag:)]){
        [delegate back:self.dataDic btnTag:self.btnTag];
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    [self.view setFrame:CGRectMake(self.view.frame.origin.x, -50, 320, self.view.frame.size.height)];
    textfield = nil;
    textfield = textField;
    closeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 310, self.view.frame.size.height)];
    closeView.userInteractionEnabled = YES;
    UITapGestureRecognizer *closeViewtapGestureRecognizer = [[UITapGestureRecognizer alloc] init];
    [closeViewtapGestureRecognizer addTarget:self action:@selector(closeKeyBoard)];
    [closeViewtapGestureRecognizer setNumberOfTapsRequired:1];
    [closeViewtapGestureRecognizer setNumberOfTouchesRequired:1];
    [closeView addGestureRecognizer:closeViewtapGestureRecognizer];
    [self.view addSubview:closeView];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [closeView removeFromSuperview];
    closeView = nil;
    [self.view setFrame:CGRectMake(self.view.frame.origin.x, 70, 320, self.view.frame.size.height)];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    switch (textField.tag) {
        case 0:
            NSLog(@"=====%@",self.dataDic);
            [self.dataDic setValue:textField.text forKey:@"contactName"];
            break;
        case 1:
            [self.dataDic setValue:textField.text forKey:@"mobilePhone"];
            break;
        case 2:
            [self.dataDic setValue:textField.text forKey:@"accountName"];
            break;
        case 3:
            [self.dataDic setValue:textField.text forKey:@"accountAddress"];
            break;
        default:
            break;
    }
}


-(void)titleClick:(id)sender{
    [textfield resignFirstResponder];
    if(dropDown == nil) {
        NSMutableArray *dataTempArr = nil;
        if([self.contactType isEqualToString:@"auctionUnitContacts"]||[self.contactType isEqualToString:@"explorationUnitContacts"]){
            dataTempArr = [[NSMutableArray alloc]initWithObjects:@"项目负责人", nil];
        }else if([self.contactType isEqualToString:@"ownerUnitContacts"]){
            dataTempArr = [[NSMutableArray alloc]initWithObjects:@"项目经理",@"采购经理",@"设计经理",@"项目总负责",@"其他", nil];
        }else if([self.contactType isEqualToString:@"contractorUnitContacts"]||[self.contactType isEqualToString:@"pileFoundationUnitContacts"]){
            dataTempArr = [[NSMutableArray alloc]initWithObjects:@"现场经理",@"采购负责人", nil];
        }else if([self.contactType isEqualToString:@"designInstituteContacts"]){
            dataTempArr = [[NSMutableArray alloc]initWithObjects:@"建筑师",@"结构工程师",@"电气工程师",@"暖通工程师",@"给排水工程师",@"幕墙工程师", nil];
        }
        dropDown = [[NIDropDown alloc] initWithFrame:sender arr:dataTempArr tit:@"Foreignparticipation"];
        dropDown.delegate = self;
    }
    else {
        [dropDown hideDropDown:sender];
        dropDown = nil;
    }
}

- (void) niDropDownDelegateMethod: (NIDropDown *) sender text:(NSString *)text tit:(NSString *)tit{
    NSLog(@"%@",text);
    [self.dataDic setValue:text forKeyPath:@"duties"];
    [title setTitle:[NSString stringWithFormat:@"岗位:%@",text] forState:UIControlStateNormal];
    /*if ([delegate respondsToSelector:@selector(addforeignInvestment:)]){
        [delegate addforeignInvestment:text];
    }*/
}

-(void)closeKeyBoard{
    [self.view setFrame:CGRectMake(self.view.frame.origin.x, 70, 320, self.view.frame.size.height)];
    [textfield resignFirstResponder];
    [closeView removeFromSuperview];
    closeView = nil;
}

-(void)setenabled:(NSMutableArray *)dataArr{
    if(dataArr.count == 0){
        [self loadContact];
    }
}

//获取联系人
-(void)loadContact{
    //NSLog(@"self.dataDic ==> %@",self.dataDic);
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"GET" URLString:[NSString stringWithFormat:@"%s/%@",serverAddress,[self.dataDic objectForKey:@"url"]] parameters:nil error:nil];
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSLog(@"JSON: %@", responseObject);
        NSMutableArray *resultArr = [[NSMutableArray alloc]init];
        NSArray *a = [[responseObject objectForKey:@"d"] objectForKey:@"data"];
        for (NSDictionary *item in a) {
            NSLog(@"item ==> %@",item);
            ContactModel *model = [[ContactModel alloc] init];
            //NSLog(@"%@",[item objectForKey:@"projectId"]);
            [model loadWithDictionary:item];
            [resultArr addObject:model];
        }
        [self setContactValue:resultArr];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    [[NSOperationQueue mainQueue] addOperation:op];
}

-(void)setContactValue:(NSMutableArray *)arr{
    ContactModel *model = [arr objectAtIndex:0];
    [addName setText:model.a_contactName];
    [addPhone setText:model.a_mobilePhone];
    [accountName setText:model.a_accountName];
    [address setText:model.a_accountAddress];
    [title setTitle:[NSString stringWithFormat:@"岗位:%@",model.a_duties] forState:UIControlStateNormal];
}
@end
