//
//  LoginViewController.m
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-17.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "LoginViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"
#import "HomePageCenterViewController.h"
#import "HomePageLeftViewController.h"
#import "LoginSqlite.h"
#import "RegistViewController.h"
#import "PanViewController.h"
#import "UserModel.h"
#import "UserSqlite.h"
#import "MD5.h"
@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize userToken;
//static int j =0;
//static int alertShowCount = 0;
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
    _isLogin = NO;
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.hidden = YES;
    UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 321, 568)];
    [bgImgView setImage:[GetImagePath getImagePath:@"注册"]];
    [self.view addSubview:bgImgView];
    
    UIImageView *headerImgView = [[UIImageView alloc] initWithFrame:CGRectMake(111, 80, 98.5, 98.5)];
    [headerImgView setImage:[GetImagePath getImagePath:@"登录_03"]];
    UIImageView *roundView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 89, 89)];
    roundView.layer.masksToBounds = YES;
    roundView.layer.cornerRadius = 45;
    [roundView setImage:nil];
    [headerImgView addSubview:roundView];
    [self.view addSubview:headerImgView];
    

    UIView *textView = [[UIView alloc] initWithFrame:CGRectMake(25,240,264,87)];
    UIImageView *bgImgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,264,87)];
    [bgImgView2 setImage:[GetImagePath getImagePath:@"登录_07"]];
    [textView addSubview:bgImgView2];
    _userNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(10,0,254,43)];
    _userNameTextField.delegate = self;
    _userNameTextField.textAlignment=NSTextAlignmentLeft;
    _userNameTextField.placeholder=@"请填写用户名/手机号";
    _userNameTextField.returnKeyType=UIReturnKeyDone;
    _userNameTextField.font =  [UIFont systemFontOfSize:15];
    _userNameTextField.clearButtonMode = UITextFieldViewModeAlways;
    [textView addSubview:_userNameTextField];
    _passWordTextField = [[UITextField alloc] initWithFrame:CGRectMake(10,43,254,43)];
    _passWordTextField.delegate = self;
    _passWordTextField.textAlignment=NSTextAlignmentLeft;
    _passWordTextField.placeholder=@"请填写密码";
    _passWordTextField.returnKeyType=UIReturnKeyDone;
    _passWordTextField.secureTextEntry = YES;
    _passWordTextField.font =  [UIFont systemFontOfSize:15];
    _passWordTextField.clearButtonMode = UITextFieldViewModeAlways;
    [textView addSubview:_passWordTextField];
    [self.view addSubview:textView];
    
    loginBtn =  [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(25, 340, 264, 36);
    loginBtn.tag = 20140801;
    [loginBtn setTitle:@"登    录" forState:UIControlStateNormal];
    loginBtn.titleLabel.font = [UIFont fontWithName:@"GurmukhiMN-Bold" size:17];
    [loginBtn setBackgroundImage:[GetImagePath getImagePath:@"登录_11"] forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
    UIButton *restPasswordBtn =  [UIButton buttonWithType:UIButtonTypeCustom];
    restPasswordBtn.frame = CGRectMake(175, 386, 160, 36);
    [restPasswordBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    restPasswordBtn.titleLabel.font = [UIFont fontWithName:@"GurmukhiMN-Bold" size:14];
    //[restPasswordBtn addTarget:self action:@selector(restPasswordBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //[self.view addSubview:restPasswordBtn];
    
    UIButton *rememberBtn =  [UIButton buttonWithType:UIButtonTypeCustom];
    rememberBtn.frame = CGRectMake(17, 386, 160, 36);
    [rememberBtn setTitle:@"记住我的密码" forState:UIControlStateNormal];
    rememberBtn.titleLabel.font = [UIFont fontWithName:@"GurmukhiMN-Bold" size:14];
    [rememberBtn addTarget:self action:@selector(rememberBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //[self.view addSubview:rememberBtn];
    
    rememberView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 396, 13, 13)];
    [rememberView setImage:[GetImagePath getImagePath:@"登录_15"]];
    //[self.view addSubview:rememberView];
    
    UIButton *registBtn =  [UIButton buttonWithType:UIButtonTypeCustom];
    registBtn.frame = CGRectMake(70, 500, 200, 36);
    [registBtn setTitle:@"没有账户，去注册！" forState:UIControlStateNormal];
    registBtn.titleLabel.font = [UIFont fontWithName:@"GurmukhiMN-Bold" size:17];
    [registBtn addTarget:self action:@selector(registBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //[self.view addSubview:registBtn];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)rememberBtnClick{
    if(!_isSelect){
        [rememberView setImage:[GetImagePath getImagePath:@"登录1_07"]];
        _isSelect = YES;
    }else{
        [rememberView setImage:[GetImagePath getImagePath:@"登录_15"]];
        _isSelect = NO;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    bgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bgBtn setFrame:CGRectMake(0, 0, 320, 352)];
    [bgBtn addTarget:self action:@selector(closeKeyBoard) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bgBtn];
}

-(void)closeKeyBoard{
    [bgBtn removeFromSuperview];
    bgBtn = nil;
    [_userNameTextField resignFirstResponder];
    [_passWordTextField resignFirstResponder];
}

#pragma mark  登录－－－－－－－－－－
-(void)loginBtnClick{
    //测试账号:zm 密码:123
    //登录接口
    NSLog(@"%@",[MD5 md5HexDigest:_passWordTextField.text]);
    loginBtn.enabled=NO;
    NSDictionary *parameters = [[NSDictionary alloc] initWithObjectsAndKeys:_userNameTextField.text,@"userName",[MD5 md5HexDigest:_passWordTextField.text],@"password" ,@"ios",@"deviceType",nil];
    NSLog(@"%@",parameters);
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:[NSString stringWithFormat:@"%s/Users/login",serverAddress] parameters:parameters error:nil];
    NSLog(@"==%@",[NSString stringWithFormat:@"%s/Users/login",serverAddress]);
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"==%@",responseObject);
        NSNumber *statusCode = [[[responseObject objectForKey:@"d"] objectForKey:@"status"] objectForKey:@"statusCode"];
        if([[NSString stringWithFormat:@"%@",statusCode] isEqualToString:@"200"]){
            NSArray *a = [[responseObject objectForKey:@"d"] objectForKey:@"data"];
            for(NSDictionary *item in a){
                self.userToken = [item objectForKey:@"userToken"];
                //NSString *isFaceRegisted = [item objectForKey:@"isFaceRegisted"];
                [LoginSqlite insertData:self.userToken datakey:@"UserToken"];
                [UserSqlite InsertData:item];
//                if([[LoginSqlite getdata:@"firstPassWordLogin" defaultdata:@""] isEqualToString:@""] &&![[NSString stringWithFormat:@"%@",isFaceRegisted] isEqualToString:@"1"]){//判断用户是否是第一次登陆并判断用户脸部识别的状态
//                    [LoginSqlite insertData:@"1" datakey:@"firstPassWordLogin"];
//                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否要进行脸部识别的注册" delegate:self cancelButtonTitle:@"是" otherButtonTitles:@"否", nil];
//                    
//                    [alert show];
//                }else{
//                    NSLog(@"登录成功！");
//                    [self loginSuccess];
//                }
                [self loginSuccess];
            }
        }else{
            NSLog(@"登录失败！");
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"登录失败！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            alert.tag = 1;
            [alert show];
            loginBtn.enabled=YES;
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    [[NSOperationQueue mainQueue] addOperation:op];
}

-(void)loginSuccess{             //登录成功
    loginBtn.enabled=YES;

    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"登录成功！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    alert.tag = 20140731;
    [alert show];
}

#pragma mark 注册－－－－－－－－－－
-(void)registBtnClick{           //进行注册
    NSLog(@"registBtnClick");
    RegistViewController *registView = [[RegistViewController alloc] init];
    
    [self.navigationController pushViewController:registView animated:YES];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
        NSLog(@"mlmlmll %d",alertView.tag);
    if(alertView.tag ==20140731){      //登录成功进行登录界面的跳转
        UIViewController * leftViewController = [[HomePageLeftViewController alloc] init];
        UIViewController * centerViewController = [[HomePageCenterViewController alloc] init];
        UINavigationController * navigationController = [[UINavigationController alloc] initWithRootViewController:centerViewController];
        navigationController.navigationBarHidden = YES;
        MMDrawerController * drawerController = [[MMDrawerController alloc]
                                                 initWithCenterViewController:navigationController
                                                 leftDrawerViewController:leftViewController
                                                 rightDrawerViewController:nil];
        [drawerController setMaximumRightDrawerWidth:200.0];
        [drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
        [drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        [UIView beginAnimations:nil context:context];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.7];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:[[AppDelegate instance] window] cache:YES];
        NSUInteger tview1 = [[self.view subviews] indexOfObject:[[AppDelegate instance] window]];
        NSUInteger tview2 = [[self.view subviews] indexOfObject:drawerController.view];
        [self.view exchangeSubviewAtIndex:tview2 withSubviewAtIndex:tview1];
        [UIView setAnimationDelegate:self];
        [UIView commitAnimations];

        [[AppDelegate instance] window].rootViewController = drawerController;
        [[[AppDelegate instance] window] makeKeyAndVisible];
        
    }
    else{
        if (buttonIndex ==0) {      //进行脸部识别的注册
            
            PanViewController *panVC = [[PanViewController alloc] init];
            [self.navigationController pushViewController:panVC animated:NO];
            
        }
        else if (buttonIndex ==1)         //不进行脸部识别的注册，直接登录
        {
            //跳过直接进行登录
            [self loginSuccess];
        }

    }
}
@end
