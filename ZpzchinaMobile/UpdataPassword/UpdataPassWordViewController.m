//
//  UpdataPassWordViewController.m
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-10-10.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "UpdataPassWordViewController.h"
#import "HomePageCenterViewController.h"
#import "LoginSqlite.h"
#import "UpdataPassWordEvent.h"
#import "MD5.h"
@interface UpdataPassWordViewController ()

@end

@implementation UpdataPassWordViewController

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
    [self addtittle:@"修改密码"];
    
    UILabel *oldPassWord = [[UILabel alloc] initWithFrame:CGRectMake(8, 20, 60, 30)];
    oldPassWord.textColor = BlueColor;
    oldPassWord.text = @"原密码";
    oldPassWord.font = [UIFont fontWithName:@"GurmukhiMN" size:14];
    [self.contentView addSubview:oldPassWord];
    
    oldPassWordTextField = [[UITextField alloc] initWithFrame:CGRectMake(85, 20, 200, 30)];
    oldPassWordTextField.placeholder = @"原密码";
    oldPassWordTextField.font = [UIFont fontWithName:@"GurmukhiMN" size:14];
    oldPassWordTextField.delegate = self;
    oldPassWordTextField.secureTextEntry = YES;
    oldPassWordTextField.clearButtonMode = UITextFieldViewModeAlways;
    [oldPassWordTextField setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    [self.contentView addSubview:oldPassWordTextField];
    
    UIImageView *lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(8, 55, 304, 1)];
    [lineImage setBackgroundColor:[UIColor blackColor]];
    [self.contentView addSubview:lineImage];
    lineImage.alpha = 0.2;
    
    UILabel *newPassWord = [[UILabel alloc] initWithFrame:CGRectMake(8, 65, 60, 30)];
    newPassWord.textColor = BlueColor;
    newPassWord.text = @"新密码";
    newPassWord.font = [UIFont fontWithName:@"GurmukhiMN" size:14];
    [self.contentView addSubview:newPassWord];
    
    newPassWordTextField = [[UITextField alloc] initWithFrame:CGRectMake(85, 65, 200, 30)];
    newPassWordTextField.placeholder = @"新密码";
    newPassWordTextField.font = [UIFont fontWithName:@"GurmukhiMN" size:14];
    newPassWordTextField.delegate = self;
    newPassWordTextField.secureTextEntry = YES;
    newPassWordTextField.clearButtonMode = UITextFieldViewModeAlways;
    [newPassWordTextField setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    [self.contentView addSubview:newPassWordTextField];
    
    UIImageView *lineImage2 = [[UIImageView alloc] initWithFrame:CGRectMake(8, 100, 304, 1)];
    [lineImage2 setBackgroundColor:[UIColor blackColor]];
    [self.contentView addSubview:lineImage2];
    lineImage2.alpha = 0.2;
    
    UILabel *newAgainPassWord = [[UILabel alloc] initWithFrame:CGRectMake(8, 110, 60, 30)];
    newAgainPassWord.textColor = BlueColor;
    newAgainPassWord.text = @"重复密码";
    newAgainPassWord.font = [UIFont fontWithName:@"GurmukhiMN" size:14];
    [self.contentView addSubview:newAgainPassWord];
    
    newAgainPassWordTextField = [[UITextField alloc] initWithFrame:CGRectMake(85, 110, 200, 30)];
    newAgainPassWordTextField.placeholder = @"再次输入";
    newAgainPassWordTextField.font = [UIFont fontWithName:@"GurmukhiMN" size:14];
    newAgainPassWordTextField.delegate = self;
    newAgainPassWordTextField.secureTextEntry = YES;
    newAgainPassWordTextField.clearButtonMode = UITextFieldViewModeAlways;
    [newAgainPassWordTextField setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    [self.contentView addSubview:newAgainPassWordTextField];
    
    UIImageView *lineImage3 = [[UIImageView alloc] initWithFrame:CGRectMake(8, 145, 304, 1)];
    [lineImage3 setBackgroundColor:[UIColor blackColor]];
    [self.contentView addSubview:lineImage3];
    lineImage3.alpha = 0.2;
    
    confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmBtn.frame = CGRectMake(8, 155, 304, 41);
    [confirmBtn setImage:[GetImagePath getImagePath:@"修改密码_03"] forState:UIControlStateNormal];
    [confirmBtn addTarget:self action:@selector(updataPassWordAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:confirmBtn];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}


-(void)updataPassWordAction{
    if(![newPassWordTextField.text isEqualToString:newAgainPassWordTextField.text]){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"二次密码不一致" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }else{
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setValue:[MD5 md5HexDigest:oldPassWordTextField.text] forKey:@"oldPassword"];
        [dic setValue:[MD5 md5HexDigest:newPassWordTextField.text] forKey:@"newPassword"];
        [dic setValue:[LoginSqlite getdata:@"UserToken" defaultdata:@"UserToken"] forKey:@"token"];
        [UpdataPassWordEvent PutUserWithBlock:^(NSMutableArray *posts, NSError *error) {
            if(!error){
                if (posts) {
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"密码修改成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alertView show];
                }else{
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"原密码错误" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alertView show];
                }
            }
        } dataDic:dic];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
