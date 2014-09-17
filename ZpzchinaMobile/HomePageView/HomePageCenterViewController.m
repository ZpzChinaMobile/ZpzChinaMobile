//
//  HomePageCenterViewController.m
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-13.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "HomePageCenterViewController.h"
#import "MMExampleDrawerVisualStateManager.h"
#import "UIViewController+MMDrawerController.h"
#import "MMDrawerBarButtonItem.h"
#import "HomePageLeftViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "GradientView.h"
#import "networkConnect.h"

@interface HomePageCenterViewController ()

@end

@implementation HomePageCenterViewController
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
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    if(![[networkConnect sharedInstance] connectedToNetwork]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"当前网络不可用请检查连接"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil,nil];
        [alert show];
    }
    
    album = [[Album alloc] init];
    //nav
    UIView *topView = [[UIView alloc] init];
    [topView setFrame:CGRectMake(0, 0, 320, 55)];
    UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,320,55)];
    [bgImgView setImage:[UIImage imageNamed:@"地图搜索_01.png"]];
    [topView addSubview:bgImgView];
    
    //nav左边按钮
    UIButton *leftBtn =  [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(20, 28, 26.5, 14.5);
    [leftBtn setImage:[UIImage imageNamed:@"icon__13.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:leftBtn];
    
    //nav title
    UILabel *topLabel = [[UILabel alloc] init];
    topLabel.frame = CGRectMake(100, 20, 120, 28);
    topLabel.font = [UIFont fontWithName:@"GurmukhiMN-Bold" size:19];
    topLabel.textColor = [UIColor whiteColor];
    topLabel.text = @"信息采集";
    topLabel.textAlignment = NSTextAlignmentCenter;
    [topView addSubview:topLabel];
    [self.view addSubview:topView];
    
    //上半部分背景
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSFileManager *fileManage = [NSFileManager defaultManager];
    NSString *myDirectory = [documentsDirectory stringByAppendingPathComponent:@"image.png"];
    NSData *data = [fileManage contentsAtPath:myDirectory];
    UIImage *image = [UIImage imageWithData:data];
    UIView *bannerView = [[UIView alloc] init];
    bannerView.frame = CGRectMake(0, 55, 320, 265);
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, bannerView.frame.size.width, bannerView.frame.size.height);
    if(image == nil){
        [btn setImage:[UIImage imageNamed:@"首页_16.png"] forState:UIControlStateNormal];
    }else{
        [btn setImage:image forState:UIControlStateNormal];
    }
    //退出长按事件
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(openCamera:)];
    longPress.minimumPressDuration = 0.8; //定义按的时间
    [btn addGestureRecognizer:longPress];
    [bannerView addSubview:btn];
    
    //上半部分背景上的叠加图
    NSArray *colorArray = [@[[UIColor colorWithRed:(10/255.0)  green:(32/255.0)  blue:(64/255.0)  alpha:0.0],[UIColor colorWithRed:(10/255.0)  green:(32/255.0)  blue:(64/255.0)  alpha:1.0]] mutableCopy];
    GradientView *footView = [[GradientView alloc] initWithFrame:CGRectMake(0, 185, 320, 80) colorArr:colorArray];
    [bannerView addSubview:footView];
    
    UILabel *userNameLabel = [[UILabel alloc] init];
    userNameLabel.frame = CGRectMake(10, 195, 200, 28);
    userNameLabel.font = [UIFont fontWithName:@"GurmukhiMN-Bold" size:17];
    userNameLabel.textColor = [UIColor whiteColor];
    userNameLabel.text = [NSString stringWithFormat:@"用户名：%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userName"]];
    [bannerView addSubview:userNameLabel];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(10, 228, 140, 28);
    titleLabel.font = [UIFont fontWithName:@"GurmukhiMN-Bold" size:12];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"职位区域经理";
    [bannerView addSubview:titleLabel];
    
    UIImageView *cityImgView = [[UIImageView alloc] initWithFrame:CGRectMake(200,234,12,17)];
    [cityImgView setImage:[UIImage imageNamed:@"首页_10.png"]];
    [bannerView addSubview:cityImgView];
    
    UILabel *cityLabel = [[UILabel alloc] init];
    cityLabel.frame = CGRectMake(220, 228, 140, 28);
    cityLabel.font = [UIFont fontWithName:@"GurmukhiMN-Bold" size:12];
    cityLabel.textColor = [UIColor whiteColor];
    cityLabel.text = @"上海，中国";
    [bannerView addSubview:cityLabel];
    [self.view addSubview:bannerView];
    
    //新建项目
    UIView *newProjectView = [[UIView alloc] init];
    [newProjectView setFrame:CGRectMake(0, 320, 106, 122)];
    [newProjectView setBackgroundColor:[UIColor colorWithRed:(74/255.0)  green:(100/255.0)  blue:(176/255.0)  alpha:1.0]];
    
    UIImageView *contentImage1 = [[UIImageView alloc] initWithFrame:CGRectMake(40,16,25,25)];
    [contentImage1 setImage:[UIImage imageNamed:@"首页_03.png"]];
    [newProjectView addSubview:contentImage1];
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.frame = CGRectMake(25, 60, 140, 28);
    label1.font = [UIFont fontWithName:@"GurmukhiMN-Bold" size:14];
    label1.textColor = [UIColor whiteColor];
    label1.text = @"新建项目";
    [newProjectView addSubview:label1];
    
    UILabel *intlabel1 = [[UILabel alloc] init];
    intlabel1.frame = CGRectMake(43, 85, 30, 28);
    intlabel1.font = [UIFont fontWithName:@"GurmukhiMN-Bold" size:13];
    intlabel1.textColor = [UIColor whiteColor];
    intlabel1.text = @"32";
    //[newProjectView addSubview:intlabel1];
    
    UIButton *newProjectBtn =  [UIButton buttonWithType:UIButtonTypeCustom];
    newProjectBtn.tag = 0;
    [newProjectBtn setBackgroundColor:[UIColor clearColor]];
    newProjectBtn.frame = CGRectMake(0, 0, 106, 122);
    [newProjectBtn addTarget:self action:@selector(AllBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [newProjectView addSubview:newProjectBtn];
    [self.view addSubview:newProjectView];
    
    UIImageView *lineImage1 = [[UIImageView alloc] initWithFrame:CGRectMake(106,320,2,122)];
    [lineImage1 setBackgroundColor:[UIColor colorWithRed:(109/255.0)  green:(131/255.0)  blue:(192/255.0)  alpha:1.0]];
    [self.view addSubview:lineImage1];
    
    //全部项目
    UIView *allProjectView = [[UIView alloc] init];
    [allProjectView setFrame:CGRectMake(108, 320, 106, 122)];
    [allProjectView setBackgroundColor:[UIColor colorWithRed:(74/255.0)  green:(100/255.0)  blue:(176/255.0)  alpha:1.0]];
    
    UIImageView *contentImage2 = [[UIImageView alloc] initWithFrame:CGRectMake(40,16,25,25)];
    [contentImage2 setImage:[UIImage imageNamed:@"首页_05.png"]];
    [allProjectView addSubview:contentImage2];
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.frame = CGRectMake(25, 60, 140, 28);
    label2.font = [UIFont fontWithName:@"GurmukhiMN-Bold" size:14];
    label2.textColor = [UIColor whiteColor];
    label2.text = @"全部项目";
    [allProjectView addSubview:label2];
    
    UILabel *intlabel2 = [[UILabel alloc] init];
    intlabel2.frame = CGRectMake(43, 85, 30, 28);
    intlabel2.font = [UIFont fontWithName:@"GurmukhiMN-Bold" size:13];
    intlabel2.textColor = [UIColor whiteColor];
    intlabel2.text = @"25";
    //[allProjectView addSubview:intlabel2];
    
    UIButton *allProjectBtn =  [UIButton buttonWithType:UIButtonTypeCustom];
    allProjectBtn.tag = 1;
    [allProjectBtn setBackgroundColor:[UIColor clearColor]];
    allProjectBtn.frame = CGRectMake(0, 0, 106, 122);
    [allProjectBtn addTarget:self action:@selector(AllBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [allProjectView addSubview:allProjectBtn];
    [self.view addSubview:allProjectView];
    
    UIImageView *lineImage2 = [[UIImageView alloc] initWithFrame:CGRectMake(214,320,2,122)];
    [lineImage2 setBackgroundColor:[UIColor colorWithRed:(109/255.0)  green:(131/255.0)  blue:(192/255.0)  alpha:1.0]];
    [self.view addSubview:lineImage2];
    
    //我的任务
    UIView *myTask = [[UIView alloc] init];
    [myTask setFrame:CGRectMake(216, 320, 106, 122)];
    [myTask setBackgroundColor:[UIColor colorWithRed:(74/255.0)  green:(100/255.0)  blue:(176/255.0)  alpha:1.0]];
    
    UIImageView *contentImage3 = [[UIImageView alloc] initWithFrame:CGRectMake(40,16,25,25)];
    [contentImage3 setImage:[UIImage imageNamed:@"首页_07.png"]];
    [myTask addSubview:contentImage3];
    
    UILabel *label3 = [[UILabel alloc] init];
    label3.frame = CGRectMake(25, 60, 140, 28);
    label3.font = [UIFont fontWithName:@"GurmukhiMN-Bold" size:14];
    label3.textColor = [UIColor whiteColor];
    label3.text = @"我的任务";
    [myTask addSubview:label3];
    
    UILabel *intlabel3 = [[UILabel alloc] init];
    intlabel3.frame = CGRectMake(43, 85, 30, 28);
    intlabel3.font = [UIFont fontWithName:@"GurmukhiMN-Bold" size:13];
    intlabel3.textColor = [UIColor whiteColor];
    intlabel3.text = @"25";
    //[myTask addSubview:intlabel3];
    
    UIButton *myTaskBtn =  [UIButton buttonWithType:UIButtonTypeCustom];
    myTaskBtn.tag = 2;
    [myTaskBtn setBackgroundColor:[UIColor clearColor]];
    myTaskBtn.frame = CGRectMake(0, 0, 106, 122);
    [myTaskBtn addTarget:self action:@selector(AllBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [myTask addSubview:myTaskBtn];
    [self.view addSubview:myTask];
    
    UIImageView *lineImage3 = [[UIImageView alloc] initWithFrame:CGRectMake(0,442,320,2)];
    [lineImage3 setBackgroundColor:[UIColor colorWithRed:(103/255.0)  green:(138/255.0)  blue:(192/255.0)  alpha:1.0]];
    [self.view addSubview:lineImage3];
    
    //email
    UIView *emailView = [[UIView alloc] init];
    emailView.frame = CGRectMake(0, 444, 320, 63);
    [emailView setBackgroundColor:[UIColor colorWithRed:(41/255.0)  green:(87/255.0)  blue:(165/255.0)  alpha:1.0]];
    
    UILabel *label4 = [[UILabel alloc] init];
    label4.frame = CGRectMake(20, 8, 140, 28);
    label4.font = [UIFont fontWithName:@"GurmukhiMN-Bold" size:14];
    label4.textColor = [UIColor whiteColor];
    label4.text = @"Email";
    [emailView addSubview:label4];
    
    UILabel *intlabel4 = [[UILabel alloc] init];
    intlabel4.frame = CGRectMake(20, 27, 250, 28);
    intlabel4.font = [UIFont fontWithName:@"GurmukhiMN-Bold" size:13];
    intlabel4.textColor = [UIColor whiteColor];
    intlabel4.text = @"yourname@website.com";
    [emailView addSubview:intlabel4];
    
    UIButton *emailBtn =  [UIButton buttonWithType:UIButtonTypeCustom];
    emailBtn.tag = 3;
    [emailBtn setBackgroundColor:[UIColor clearColor]];
    emailBtn.frame = CGRectMake(0, 0, 320, 63);
    [emailBtn addTarget:self action:@selector(AllBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [emailView addSubview:emailBtn];
    [self.view addSubview:emailView];
    
    UIImageView *lineImage4 = [[UIImageView alloc] initWithFrame:CGRectMake(0,507,320,2)];
    [lineImage4 setBackgroundColor:[UIColor colorWithRed:(103/255.0)  green:(138/255.0)  blue:(192/255.0)  alpha:1.0]];
    [self.view addSubview:lineImage4];
    
    //website
    UIView *websiteView = [[UIView alloc] init];
    websiteView.frame = CGRectMake(0, 509, 320, 63);
    [websiteView setBackgroundColor:[UIColor colorWithRed:(41/255.0)  green:(87/255.0)  blue:(165/255.0)  alpha:1.0]];
    
    UILabel *label5 = [[UILabel alloc] init];
    label5.frame = CGRectMake(20, 8, 140, 28);
    label5.font = [UIFont fontWithName:@"GurmukhiMN-Bold" size:14];
    label5.textColor = [UIColor whiteColor];
    label5.text = @"Website";
    [websiteView addSubview:label5];
    
    UILabel *intlabel5 = [[UILabel alloc] init];
    intlabel5.frame = CGRectMake(20, 27, 250, 28);
    intlabel5.font = [UIFont fontWithName:@"GurmukhiMN-Bold" size:13];
    intlabel5.textColor = [UIColor whiteColor];
    intlabel5.text = @"http://www.baidu.com";
    [websiteView addSubview:intlabel5];
    
    UIButton *websiteBtn =  [UIButton buttonWithType:UIButtonTypeCustom];
    websiteBtn.tag = 4;
    [websiteBtn setBackgroundColor:[UIColor clearColor]];
    websiteBtn.frame = CGRectMake(0, 0, 320, 63);
    [websiteBtn addTarget:self action:@selector(AllBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [websiteView addSubview:websiteBtn];
    [self.view addSubview:websiteView ];
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
//打开左边设置页
-(void)leftBtnClick{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

-(void)AllBtnClick:(UIButton *)button{
    ModificationViewController* modifiVC;
    switch (button.tag) {
        case 0:
            //新建项目页面
//            _newProject = [[NewProjectViewController alloc] init];
//            _newProject.fromView = 0;
//            [self.navigationController pushViewController:_newProject animated:YES];
            modifiVC=[[ModificationViewController alloc] init];
            modifiVC.fromView=0;
            //modifiVC.isRelease=;
            [self.navigationController pushViewController:modifiVC animated:YES];
            break;
        case 1:
            //全部项目
            _allProjuct = [[AllProjuctViewController alloc] init];
            [self.navigationController pushViewController:_allProjuct animated:YES];
            _allProjuct=nil;
            break;
        case 2:
            //我的任务
            _myTask = [[MyTaskViewController alloc] init];
            [self.navigationController pushViewController:_myTask animated:YES];
            _myTask=nil;
            break;
        case 3:
            NSLog(@"3");
            break;
        case 4:
            NSLog(@"4");
            break;
        default:
            break;
    }
}

-(void)openCamera:(UILongPressGestureRecognizer *)gestureRecognizer{
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan) {
        NSLog(@"长按事件");
        _myActionSheet = [[UIActionSheet alloc]
                          initWithTitle:nil
                          delegate:self
                          cancelButtonTitle:@"取消"
                          destructiveButtonTitle:nil
                          otherButtonTitles: @"打开相册",nil];
        _myActionSheet.destructiveButtonIndex=1;
        [_myActionSheet showInView:self.view];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"%d",buttonIndex);
    if(buttonIndex == 0){
        [album getCameraView:self button:btn];
    }
}
@end
