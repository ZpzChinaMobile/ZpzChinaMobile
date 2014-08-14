//
//  RegistViewController.m
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-18.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "RegistViewController.h"
#import "MMDrawerController.h"
#import "HomePageCenterViewController.h"
#import "HomePageLeftViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "FaceViewController.h"
#import "LoginSqlite.h"
#import "PanViewController.h"
#import "ContactModel.h"

@interface RegistViewController ()

@end

@implementation RegistViewController

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

    self.navigationController.navigationBar.hidden =YES;
    UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:self.view.frame];
    [bgImgView setImage:[UIImage imageNamed:@"注册.png"]];
    bgImgView.userInteractionEnabled =YES;
    [self.view addSubview:bgImgView];
    
    UIView *panView = [[UIView alloc] initWithFrame:CGRectMake(28,140,264,260)];
    panView.tag = 2014080103;
    [self.view addSubview:panView];
    
    UIImageView *bgImgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,264,91)];
    [bgImgView2 setImage:[UIImage imageNamed:@"登录_07.png"]];
    [panView addSubview:bgImgView2];
    _phoneNumberTextField = [[UITextField alloc] initWithFrame:CGRectMake(10,0,255,45)];
    _phoneNumberTextField.delegate = self;
    _phoneNumberTextField.textAlignment=NSTextAlignmentLeft;
    _phoneNumberTextField.placeholder=@"请填写手机号";
    _phoneNumberTextField.returnKeyType=UIReturnKeyDone;
    _phoneNumberTextField.keyboardType =UIKeyboardTypePhonePad;
    //_phoneNumberTextField.clearButtonMode =YES;
    [panView addSubview:_phoneNumberTextField];
    _yzmTextField = [[UITextField alloc] initWithFrame:CGRectMake(10,45,255,45)];
    _yzmTextField.delegate = self;
    _yzmTextField.textAlignment=NSTextAlignmentLeft;
    _yzmTextField.placeholder=@"请填输入验证码";
    _yzmTextField.returnKeyType=UIReturnKeyDone;
    [panView addSubview:_yzmTextField];
    
    UIButton *getCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    getCodeBtn.frame = CGRectMake(200,50,50,40);
    [getCodeBtn setImage:[UIImage imageNamed:@"注册_03"] forState:UIControlStateNormal];
    [getCodeBtn addTarget:self action:@selector(getVerifitionCode) forControlEvents:UIControlEventTouchUpInside];
    [panView addSubview:getCodeBtn];
    
    UIImageView *bgImgView3 = [[UIImageView alloc] initWithFrame:CGRectMake(0,110,264,91)];
    [bgImgView3 setImage:[UIImage imageNamed:@"登录_07.png"]];
    [panView addSubview:bgImgView3];
    passWordField = [[UITextField alloc] initWithFrame:CGRectMake(10,110,255,45)];
    passWordField.delegate = self;
    passWordField.textAlignment=NSTextAlignmentLeft;
    passWordField.placeholder=@"请填写密码";
    passWordField.returnKeyType=UIReturnKeyDone;
    //passWordField.clearButtonMode =YES;
    passWordField.secureTextEntry = YES;
    [panView addSubview:passWordField];
    
    verifyPassWordField = [[UITextField alloc] initWithFrame:CGRectMake(10,155,255,45)];
    verifyPassWordField.delegate = self;
    verifyPassWordField.textAlignment=NSTextAlignmentLeft;
    verifyPassWordField.placeholder=@"请重复填写密码";
    verifyPassWordField.returnKeyType=UIReturnKeyDone;
    //verifyPassWordField.clearButtonMode =YES;
    verifyPassWordField.secureTextEntry = YES;
    [panView addSubview:verifyPassWordField];

    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    registerBtn.frame = CGRectMake(0, 220, 128, 40);
    [registerBtn setBackgroundImage:[UIImage imageNamed:@"注册_07"] forState:UIControlStateNormal];
    [registerBtn setTitle:@"注   册" forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(beginToCollect) forControlEvents:UIControlEventTouchUpInside];
    registerBtn.tag =2014072401;
    [panView addSubview:registerBtn];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(134, 220, 128, 40);
    [cancelBtn setBackgroundImage:[UIImage imageNamed:@"注册_09"] forState:UIControlStateNormal];
    [cancelBtn setTitle:@"取   消" forState:UIControlStateNormal];
    [cancelBtn setTitle:@"取   消" forState:UIControlStateHighlighted];
    [cancelBtn setTitle:@"取   消" forState:UIControlStateSelected];
    cancelBtn.titleLabel.textColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"注册_07"]];
    [cancelBtn addTarget:self action:@selector(cancelRegister) forControlEvents:UIControlEventTouchUpInside];
    [panView addSubview:cancelBtn];
    
}


#pragma UITextFieldDelegate

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [textField becomeFirstResponder];


    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
        if ([textField.text length]==0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"输入不能为空"delegate:nil cancelButtonTitle:@"是"otherButtonTitles: nil];
        [alert show];
        
    }
   
    [textField resignFirstResponder];
    return YES;
}
#pragma UIResponder
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    if (_phoneNumberTextField.isEditing) {
        [self phoneNoErr:_phoneNumberTextField.text];
        [_phoneNumberTextField resignFirstResponder];
    }
    
    [passWordField resignFirstResponder];
    [verifyPassWordField resignFirstResponder];

   
}


-(BOOL)phoneNoErr:(NSString *)phone // 利用正则表达式判断用户输入的是否为手机号码
{
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\b(1)[23458][0-9]{9}\\b" options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:phone options:0 range:NSMakeRange(0, [phone length])];
    if (numberOfMatches!=1) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"手机号码不正确，请重新输入" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
    return YES;
    
}


-(void)getVerifitionCode{    //验证码的获取

    NSLog(@"获取验证码！！");
}

-(void)cancelRegister   //取消注册
{
    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"取消注册");
}


#pragma mark 注册－－－－－－－－－－
-(void)beginToCollect//点击注册按钮触发的事件
{
    
    [self commomRegister];

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex==0) {       //选择是开始进行脸部注册的采集

            [self faceCollect];//开始采集照片

    }
    else if (buttonIndex==1){        //选择否，直接进行登录
        [self recognizeSuccess];

    }
    
}

-(void)faceCollect         //进入到脸部信息采集到界面
{

    PanViewController *panVC = [[PanViewController alloc] init];
    [self.navigationController pushViewController:panVC animated:NO];

}

- (void)commomRegister    //进行注册
{
    NSLog(@"共同注册部分");
    if (![passWordField.text isEqualToString:verifyPassWordField.text]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"两次输入的密码不一致，请重新输入！" delegate:nil cancelButtonTitle:@"是" otherButtonTitles: nil];
        [alert show];
        return;
    }
    
    if([passWordField.text isEqualToString:@""]||[_phoneNumberTextField.text isEqualToString:@""]||[verifyPassWordField.text isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"输入不完整请检查你的输入！" delegate:nil cancelButtonTitle:@"是" otherButtonTitles: nil];
        [alert show];
        return;
    }
    
    //通过网络请求判断验证码是否正确
    //*****************************

    //进行注册
    //**********************************

    NSMutableDictionary *parameters =[[NSMutableDictionary alloc] initWithObjectsAndKeys:_phoneNumberTextField.text,@"userName",passWordField.text,@"password",@"ios",@"deviceType",nil];
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:[NSString stringWithFormat:@"%s/Users/Register",serverAddress] parameters:parameters error:nil];
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"register＊＊＊＊＊＊＊＊********JSON: %@", responseObject);
        
        NSNumber *statusCode = [[[responseObject objectForKey:@"d"] objectForKey:@"status"] objectForKey:@"statusCode"];
       if([[NSString stringWithFormat:@"%@",statusCode] isEqualToString:@"200"])
        {
            NSLog(@"账号密码注册成功");
            
            NSArray *a = [[responseObject objectForKey:@"d"] objectForKey:@"data"];
            for(NSDictionary *item in a){
                [[NSUserDefaults standardUserDefaults]setObject:_phoneNumberTextField.text forKey:@"userName"];
                [[NSUserDefaults standardUserDefaults]setObject:passWordField.text forKey:@"passWord"];
                [[NSUserDefaults standardUserDefaults]setObject:[item objectForKey:@"userToken"] forKey:@"UserToken"];
                NSString *isFaceRegisted = [item objectForKey:@"isFaceRegisted"];
                [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",isFaceRegisted]forKey:@"isFaceRegisted"];
                [[NSUserDefaults standardUserDefaults] setObject:[item objectForKey:@"faceCount"] forKey:@"currentFaceCount"];
                [[NSUserDefaults standardUserDefaults] setObject:[item objectForKey:@"userID"] forKey:@"userID"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [LoginSqlite insertData:[item objectForKey:@"userToken"] datakey:@"UserToken"];
                [LoginSqlite insertData:_phoneNumberTextField.text datakey:@"userName"];
                [LoginSqlite insertData:passWordField.text datakey:@"passWord"];

            }
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"注册成功，是否进行脸部识别的注册" delegate:self cancelButtonTitle:@"是" otherButtonTitles:@"否", nil];
            [alert show];
            
        }
        else{
            
            NSLog(@"账号密码注册失败");
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"注册失败，账号已存在" delegate:nil cancelButtonTitle:@"是" otherButtonTitles: nil];
            [alert show];
            
        }
        
    }
   failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"账号密码注册Error: %@", error);
    }];

     [[NSOperationQueue mainQueue] addOperation:op];
}


-(void)recognizeSuccess      //账号密码注册成功后进行登录的界面
{
    UIViewController * leftViewController = [[HomePageLeftViewController alloc] init];
    UIViewController * centerViewController = [[HomePageCenterViewController alloc] init];
    
    UINavigationController * navigationController = [[UINavigationController alloc] initWithRootViewController:centerViewController];
    navigationController.navigationBarHidden = YES;
    MMDrawerController * drawerController = [[MMDrawerController alloc]
                                             initWithCenterViewController:navigationController
                                             leftDrawerViewController:leftViewController
                                             rightDrawerViewController:nil];
    [drawerController setMaximumRightDrawerWidth:320-62];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
