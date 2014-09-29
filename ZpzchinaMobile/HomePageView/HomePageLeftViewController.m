//
//  HomePageLeftViewController.m
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-13.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "HomePageLeftViewController.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "LoginSqlite.h"
#import "ProjectSqlite.h"
#import "ContactSqlite.h"
#import "CameraSqlite.h"
#import "RecordSqlite.h"
#import "UserSqlite.h"
@interface HomePageLeftViewController ()

@end

@implementation HomePageLeftViewController

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
    _isLogout = NO;
    //背景图片
    UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:self.view.frame];
    [bgImgView setImage:[UIImage imageNamed:@"首页侧拉栏_01.png"]];
    [self.view addSubview:bgImgView];
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.frame = CGRectMake(25, 20, 250, 28);
    nameLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:19];
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.text = [NSString stringWithFormat:@"%@",[LoginSqlite getdata:@"userName" defaultdata:@""]];
    [self.view addSubview:nameLabel];
    
    UILabel *welcomeLabel = [[UILabel alloc] init];
    welcomeLabel.frame = CGRectMake(25, 50, 250, 28);
    welcomeLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:15];
    welcomeLabel.textColor = [UIColor whiteColor];
    welcomeLabel.text = @"Welcome!";
    [self.view addSubview:welcomeLabel];
    
    //头像
    /*UIImageView *headerImgView = [[UIImageView alloc] initWithFrame:CGRectMake(85, 105, 110, 109.5)];
    [headerImgView setImage:[UIImage imageNamed:@"首页侧拉栏_03.png"]];
    headerImgView.userInteractionEnabled = YES;
    UITapGestureRecognizer *headerImgViewtapGestureRecognizer = [[UITapGestureRecognizer alloc] init];
    [headerImgViewtapGestureRecognizer addTarget:self action:@selector(addHead)];
    [headerImgViewtapGestureRecognizer setNumberOfTapsRequired:1];
    [headerImgViewtapGestureRecognizer setNumberOfTouchesRequired:1];
    [headerImgView addGestureRecognizer:headerImgViewtapGestureRecognizer];
    [self.view addSubview:headerImgView];*/
    
    UIImageView *lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(0,250,320,1)];
    [lineImage setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:lineImage];
    lineImage.alpha = 0.5;
    
    //清除本地数据
    UIView *clearView = [[UIView alloc] initWithFrame:CGRectMake(0,252,320,50)];
    [clearView setBackgroundColor:[UIColor clearColor]];
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(15,12.5,25,25)];
    [image setImage:[UIImage imageNamed:@"DRIBBBLE-icon45-blue-drops_03.png"]];
    [clearView addSubview:image];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(55, 12.5, 120, 25)];
    label.font = [UIFont fontWithName:@"GurmukhiMN" size:17];
    label.textColor = [UIColor whiteColor];
    label.text = @"清除本地数据";
    [clearView addSubview:label];
    UIButton *btn =  [UIButton buttonWithType:UIButtonTypeCustom];
    btn.tag = 99;
    [btn setBackgroundColor:[UIColor clearColor]];
    btn.frame = CGRectMake(0, 0, 320, 50);
    [btn addTarget:self action:@selector(AllBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [clearView addSubview:btn];
    [self.view addSubview:clearView];
    
    UIImageView *lineImage1 = [[UIImageView alloc] initWithFrame:CGRectMake(0,300,320,1)];
    [lineImage1 setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:lineImage1];
    lineImage1.alpha = 0.5;
    
    //设置
   /* UIView *setView = [[UIView alloc] initWithFrame:CGRectMake(0,302,320,50)];
    [setView setBackgroundColor:[UIColor clearColor]];
    UIImageView *image1 = [[UIImageView alloc] initWithFrame:CGRectMake(15,12.5,25,25)];
    [image1 setImage:[UIImage imageNamed:@"首页侧拉栏_07.png"]];
    [setView addSubview:image1];
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(55, 12.5, 120, 25)];
    label1.font = [UIFont fontWithName:@"GurmukhiMN" size:17];
    label1.textColor = [UIColor whiteColor];
    label1.text = @"设置";
    [setView addSubview:label1];
    UIButton *btn1 =  [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.tag = 0;
    [btn1 setBackgroundColor:[UIColor clearColor]];
    btn1.frame = CGRectMake(0, 0, 320, 50);
    [btn1 addTarget:self action:@selector(AllBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [setView addSubview:btn1];
    [self.view addSubview:setView];
    
    UIImageView *lineImage2 = [[UIImageView alloc] initWithFrame:CGRectMake(0,352,320,1)];
    [lineImage2 setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:lineImage2];
    lineImage2.alpha = 0.5;
    
    //意见反馈
    UIView *opinionView = [[UIView alloc] initWithFrame:CGRectMake(0,354,320,50)];
    [opinionView setBackgroundColor:[UIColor clearColor]];
    UIImageView *image2 = [[UIImageView alloc] initWithFrame:CGRectMake(15,12.5,25,25)];
    [image2 setImage:[UIImage imageNamed:@"首页侧拉栏_10.png"]];
    [opinionView addSubview:image2];
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(55, 12.5, 120, 25)];
    label2.font = [UIFont fontWithName:@"GurmukhiMN" size:17];
    label2.textColor = [UIColor whiteColor];
    label2.text = @"意见反馈";
    [opinionView addSubview:label2];
    UIButton *btn2 =  [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.tag = 1;
    [btn2 setBackgroundColor:[UIColor clearColor]];
    btn2.frame = CGRectMake(0, 0, 320, 50);
    [btn2 addTarget:self action:@selector(AllBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [opinionView addSubview:btn2];
    [self.view addSubview:opinionView];
    
    UIImageView *lineImage3 = [[UIImageView alloc] initWithFrame:CGRectMake(0,404,320,1)];
    [lineImage3 setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:lineImage3];
    lineImage3.alpha = 0.5;
    
    //系统通知
    UIView *noticeView = [[UIView alloc] initWithFrame:CGRectMake(0,406,320,50)];
    [noticeView setBackgroundColor:[UIColor clearColor]];
    UIImageView *image3 = [[UIImageView alloc] initWithFrame:CGRectMake(15,12.5,25,25)];
    [image3 setImage:[UIImage imageNamed:@"首页侧拉栏_12.png"]];
    [noticeView addSubview:image3];
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(55, 12.5, 120, 25)];
    label3.font = [UIFont fontWithName:@"GurmukhiMN" size:17];
    label3.textColor = [UIColor whiteColor];
    label3.text = @"系统通知";
    [noticeView addSubview:label3];
    UIButton *btn3 =  [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.tag = 2;
    [btn3 setBackgroundColor:[UIColor clearColor]];
    btn3.frame = CGRectMake(0, 0, 320, 50);
    [btn3 addTarget:self action:@selector(AllBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [noticeView addSubview:btn3];
    [self.view addSubview:noticeView];
    
    UIImageView *lineImage4 = [[UIImageView alloc] initWithFrame:CGRectMake(0,456,320,1)];
    [lineImage4 setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:lineImage4];
    lineImage4.alpha = 0.5;
    
    //用户资料
    UIView *userView = [[UIView alloc] initWithFrame:CGRectMake(0,458,320,50)];
    [userView setBackgroundColor:[UIColor clearColor]];
    UIImageView *image4 = [[UIImageView alloc] initWithFrame:CGRectMake(15,12.5,25,25)];
    [image4 setImage:[UIImage imageNamed:@"首页侧拉栏_14.png"]];
    [userView addSubview:image4];
    UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(55, 12.5, 120, 25)];
    label4.font = [UIFont fontWithName:@"GurmukhiMN" size:17];
    label4.textColor = [UIColor whiteColor];
    label4.text = @"用户资料";
    [userView addSubview:label4];
    UIButton *btn4 =  [UIButton buttonWithType:UIButtonTypeCustom];
    btn4.tag = 3;
    [btn4 setBackgroundColor:[UIColor clearColor]];
    btn4.frame = CGRectMake(0, 0, 320, 50);
    [btn4 addTarget:self action:@selector(AllBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [userView addSubview:btn4];
    [self.view addSubview:userView];
    
    UIImageView *lineImage5 = [[UIImageView alloc] initWithFrame:CGRectMake(0,508,320,1)];
    [lineImage5 setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:lineImage5];
    lineImage5.alpha = 0.5;*/
    
     //退出
    UIButton *logoutBtn =  [UIButton buttonWithType:UIButtonTypeCustom];
    logoutBtn.frame = CGRectMake(60, 520, 169, 38);
    [logoutBtn setImage:[UIImage imageNamed:@"首页侧拉栏_17.png"] forState:UIControlStateNormal];
    [logoutBtn addTarget:self action:@selector(logoutBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:logoutBtn];
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

-(void)logoutBtn{
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"退出后将清除所有本地数据！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag = 3;
    [alert show];
}

-(void)logout{
    [self logoutSuccess];
//    NSDictionary *parameters = [[NSDictionary alloc] initWithObjectsAndKeys:[LoginSqlite getdata:@"UserToken" defaultdata:@"UserToken"],@"token" ,@"ios",@"deviceType",nil];
//    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:[NSString stringWithFormat:@"%s/Users/LogOut",serverAddress] parameters:parameters error:nil];
//    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
//    op.responseSerializer = [AFJSONResponseSerializer serializer];
//    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"JSON: %@", responseObject);
//        NSNumber *statusCode = [[[responseObject objectForKey:@"d"] objectForKey:@"status"] objectForKey:@"statusCode"];
//        if([[NSString stringWithFormat:@"%@",statusCode] isEqualToString:@"200"]){
//            _isLogout = YES;
//        }else{
//            _isLogout = NO;
//        }
//        NSLog(@"%d",_isLogout);
//        if(_isLogout){
//            NSLog(@"退出成功！");
//            [self logoutSuccess];
//        }else{
//            NSLog(@"退出失败！");
//            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"退出失败！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            alert.tag = 1;
//            [alert show];
//        }
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"Error: %@", error);
//    }];
//    [[NSOperationQueue mainQueue] addOperation:op];
}

-(void)AllBtnClick:(UIButton *)button{
    switch (button.tag) {
        case 0:
            NSLog(@"0");
            break;
        case 1:
            NSLog(@"1");
            break;
        case 2:
            NSLog(@"2");
            break;
        case 3:
            NSLog(@"3");
            break;
        default:
            break;
    }
    
    if(button.tag == 99){
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"是否清除所有本地数据！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.tag = 2;
        [alert show];
    }
}

-(void)addHead{
    NSLog(@"addHead");
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(alertView.tag == 0){
        LoginViewController *loginview = [[LoginViewController alloc] init];
        UINavigationController *naVC = [[UINavigationController alloc] initWithRootViewController:loginview];
        [[AppDelegate instance] window].rootViewController = naVC;
        [[[AppDelegate instance] window] makeKeyAndVisible];
    }else if(alertView.tag == 2){
        if(buttonIndex == 1){
            [ProjectSqlite delAll];
            [ContactSqlite delAll];
            [CameraSqlite delAll];
            [RecordSqlite delAll];
        }
    }else if(alertView.tag == 3){
        if(buttonIndex == 1){
            [self logout];
        }
    }
}

-(void)logoutSuccess{

    [LoginSqlite dropTable];
    [ProjectSqlite delAll];
    [ContactSqlite delAll];
    [CameraSqlite delAll];
    [RecordSqlite delAll];
    [UserSqlite delAll];
     UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"退出成功！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    alert.tag = 0;
     [alert show];
}
@end
