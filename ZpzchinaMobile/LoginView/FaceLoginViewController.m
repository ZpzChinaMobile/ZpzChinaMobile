//
//  FaceLoginViewController.m
//  ZpzchinaMobile
//
//  Created by Jack on 14-7-23.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "FaceLoginViewController.h"
#import "LoginViewController.h"
#import "AppDelegate.h"


#import "MMDrawerController.h"
#import "HomePageCenterViewController.h"
#import "HomePageLeftViewController.h"


@interface FaceLoginViewController ()

@end

@implementation FaceLoginViewController
//static int j =0;

//static int People =0;
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
    UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:self.view.frame];
    [bgImgView setImage:[UIImage imageNamed:@"面部识别登录.png"]];
    bgImgView.userInteractionEnabled =YES;
    [self.view addSubview:bgImgView];
    
    
    self.navigationController.navigationBar.hidden =YES;
    UIImageView *iconBgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 190, 190)];
    iconBgImgView.center = CGPointMake(160.5, 200);
    iconBgImgView.image = [UIImage imageNamed:@"面部识别登录_03"];
    [bgImgView addSubview:iconBgImgView];
    
    UIImageView *faceImageView = [[UIImageView alloc] initWithFrame:CGRectMake(120, 220, 180, 180)];
    faceImageView.image =[UIImage imageNamed:@"面部识别登录1_03"];
        faceImageView.center = CGPointMake(160, 205);
    [bgImgView addSubview:faceImageView];
    
    [NSTimer scheduledTimerWithTimeInterval:0.2f target:self selector: @selector(beginFaceRecoginzer)  userInfo:nil repeats:NO];
    
    UIImageView *squareImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    squareImageView.center = CGPointMake(159.5, 205);
    squareImageView.image = [UIImage imageNamed:@"面部识别登录_07"];
    [bgImgView addSubview:squareImageView];

    
    UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 220, 50)];
    detailLabel.center = CGPointMake(160, 330);
    detailLabel.numberOfLines =2;
    detailLabel.font = [UIFont systemFontOfSize:15.0f];
    
   detailLabel.text = @"        请在光线充足的地方进行识别登录，保持正面对准摄像头。";
    detailLabel.textColor = [UIColor whiteColor];
    [bgImgView addSubview:detailLabel];
    
    
    
    
//    event = [[LoginEvent alloc] init];
//    event.faceIDArray = [[NSMutableArray alloc] init];
    
//    imgArr = [[NSMutableArray alloc] init];
}

-(void)viewDidAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backToFormerVC) name:@"face" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backToLogin) name:@"Login" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recognizeSuccess) name:@"faceLogin" object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(failToRegister) name:@"failLogin" object:nil];


}

-(void)viewDidDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"faceRegister" object:nil];
     [[NSNotificationCenter defaultCenter] removeObserver:self name:@"Login" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"faceLogin" object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"failLogin" object:nil];
}



-(void)beginFaceRecoginzer
{


    faceVC = [[FaceViewController alloc] init];

    [self.view addSubview:faceVC.view];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{

    faceVC = [[FaceViewController alloc] init];

    [self.view addSubview:faceVC.view];

}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backToFormerVC{
    [faceVC.view removeFromSuperview];
//    [imgArr removeAllObjects];
    faceVC = nil;
}


-(void)backToLogin{//返回到登录界面
    NSLog(@"noninininoilnkkljjk");
    
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    UINavigationController *naVC = [[UINavigationController alloc] initWithRootViewController:loginVC];
    [[AppDelegate instance] window].rootViewController = naVC;
    [[[AppDelegate instance] window] makeKeyAndVisible];
    
    
}


-(void)recognizeSuccess
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
//- (void)failToRegister
//{
//    UIAlertView *alert = [[UIAlertView alloc]
//                          initWithTitle:@"提示"
//                          message:@"注册失败"
//                          delegate:nil
//                          cancelButtonTitle:@"确定!"
//                          otherButtonTitles:nil];
//    [alert show];
//    
//    [faceVC.view removeFromSuperview];
//    [imgArr removeAllObjects];
//    faceVC = nil;
//    
//}


@end
