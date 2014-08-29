//
//  PanViewController.m
//  ZpzchinaMobile
//
//  Created by Jack on 14-8-1.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "PanViewController.h"


#import "MMDrawerController.h"
#import "HomePageCenterViewController.h"
#import "HomePageLeftViewController.h"
#import "AppDelegate.h"

#import "LoginViewController.h"
@interface PanViewController ()

@end

@implementation PanViewController

static int j =0;


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
    self.navigationController.navigationBar.hidden = YES;
    
    UIImageView *naBar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 60)];
    naBar.image = [UIImage imageNamed:@"地图搜索_01"];
    [self.view addSubview:naBar];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, 320, 40)];
    textlabel.center =naBar.center;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"面部采集";
    titleLabel.font = [UIFont systemFontOfSize:22.0];
    [self.view addSubview:titleLabel];
    
    UILabel *numLabel = [[UILabel alloc] initWithFrame:CGRectMake(80,80, 320, 30)];
    numLabel.text = @"还需要采集  张照片";
    numLabel.alpha =0.6;
    [self.view addSubview:numLabel];
    
    textlabel = [[UILabel alloc] initWithFrame:CGRectMake(165,80, 30, 30)];
    textlabel.text = @"5";
    textlabel.textColor =BlueColor;
    [self.view addSubview:textlabel];

    nowIMageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 453/2, 603/2)];
    nowIMageView.center = CGPointMake(160, kScreenHeight/2-10);
    UIImage *defaultImg =[UIImage imageNamed:@"面部采集_03"];
    nowIMageView.image = defaultImg;
    [self.view addSubview:nowIMageView];
    
    UIButton *collectBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    collectBtn.frame = CGRectMake(0, 0, 100, 40);
    collectBtn.center = CGPointMake(160, kScreenHeight-100);
    collectBtn.titleLabel.font = [UIFont systemFontOfSize:18.0];
    [collectBtn setTitle:@"照片采集" forState:UIControlStateNormal];
    [collectBtn setBackgroundImage:[UIImage imageNamed:@"面部采集_07"] forState:UIControlStateNormal];
    [collectBtn addTarget:self action:@selector(addmMoreImage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:collectBtn];
    
    UIButton *jumpBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    jumpBtn.frame = CGRectMake(0, 0, 100, 40);
    jumpBtn.center = CGPointMake(155, kScreenHeight-30);
    jumpBtn.titleLabel.font = [UIFont systemFontOfSize:18.0];
    [jumpBtn setTitle:@"跳过" forState:UIControlStateNormal];
    [jumpBtn addTarget:self action:@selector(jumpToLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:jumpBtn];
    UIImageView *tempImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 12, 12)];
    tempImgView.center = CGPointMake(185, kScreenHeight-30);
    tempImgView.image = [UIImage imageNamed:@"面部采集_11"];
    [self.view addSubview:tempImgView];
   
    event = [[LoginEvent alloc] init];
    event.faceIDArray = [[NSMutableArray alloc] init];
    imgArr = [[NSMutableArray alloc] init];
    
}



#pragma mark  采集照片－－－－－－－－－－
-(void)addmMoreImage
{
    
        j= 0;
            if(imgArr.count < 5){
            faceVC = [[FaceViewController alloc] init];
            faceVC.delegate = self;
            [self.view addSubview:faceVC.view];
            
        }
    
}


#pragma mark 跳过－－－－－－－－－－
-(void)jumpToLogin
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
    [[AppDelegate instance] window].rootViewController = drawerController;
    [[[AppDelegate instance] window] makeKeyAndVisible];
    
}


-(void)addImage:(UIImage *)image{   //将视频流中的image添加到数组中去
    NSLog(@"%d",j);
    [faceVC.view removeFromSuperview];
    faceVC = nil;
    if(j == 1){
        [imgArr addObject:image];
        nowIMageView.image = image;
        NSLog(@"%@",imgArr);
        textlabel.text =[NSString stringWithFormat:@"%d",(5-imgArr.count)];

        if(imgArr.count == 5){
            NSLog(@"%@",textlabel);
            indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];//[[TFIndicatorView alloc]initWithFrame:CGRectMake(135, 280, 50, 50)];
            indicator.center=CGPointMake(160,305);
            indicator.color=[UIColor blackColor];
            [indicator startAnimating];

            
            //indicator = [[TFIndicatorView alloc]initWithFrame:CGRectMake(135, 280, 50, 50)];
            //[indicator startAnimating];
            [self.view addSubview:indicator];
            [NSTimer scheduledTimerWithTimeInterval:0.5f target:self selector: @selector(startLunch)  userInfo:nil repeats:NO];
        }
    }
    j++;
}

-(void)startLunch{
    [event detectWithImageArray:imgArr];
}

-(void)recognizeSuccess           //注册成功后登录跳转的界面
{
    NSLog(@"asdfasdfasdfasdf");
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
    
    j=0;

    [imgArr removeAllObjects];
    
}

- (void)failToRegister      //注册失败
{
    NSLog(@"failToRegister");
        [indicator stopAnimating];
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"提示"
                          message:@"注册失败"
                          delegate:nil
                          cancelButtonTitle:@"确定!"
                          otherButtonTitles:nil];
    [alert show];
    
    j=0;

    [imgArr removeAllObjects];
    [faceVC.view removeFromSuperview];
    faceVC = nil;
    textlabel.text =[NSString stringWithFormat:@"%d",(5-imgArr.count)];
}


-(void)viewDidAppear:(BOOL)animated{        // 添加观察者
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backToFormerVC) name:@"registerFace" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recognizeSuccess) name:@"faceLogin" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(failToRegister) name:@"failRegister" object:nil];
    
    
}

-(void)viewDidDisappear:(BOOL)animated{        //移除观察者
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"registerFace" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"faceLogin" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"failRegister" object:nil];
}

-(void)backToFormerVC{                // 返回到panViewController
    [indicator stopAnimating];
    [faceVC.view removeFromSuperview];
    [imgArr removeAllObjects];
    faceVC = nil;
    textlabel.text =[NSString stringWithFormat:@"%d",(5-imgArr.count)];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
