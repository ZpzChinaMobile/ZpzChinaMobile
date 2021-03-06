//
//  AppDelegate.m
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-13.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "AppDelegate.h"
#import "networkConnect.h"
#import "MMDrawerController.h"
#import "HomePageCenterViewController.h"
#import "HomePageLeftViewController.h"
#import "MMDrawerVisualState.h"
#import "MMExampleDrawerVisualStateManager.h"
#import "LoginViewController.h"
#import "LoginSqlite.h"
#import "ProjectSqlite.h"
#import "ContactSqlite.h"
#import "CameraSqlite.h"
#import "ProjectLogSqlite.h"
#import "RecordSqlite.h"
#import "FaceppAPI.h"
#import "FaceLoginViewController.h"

#import "iflyMSC/iflySetting.h"
#import "Definition.h"
#import "iflyMSC/IFlySpeechUtility.h"
#import "UserSqlite.h"
#import "UserModel.h"
@implementation AppDelegate
//static int j;
+ (AppDelegate *)instance {
	return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name: kReachabilityChangedNotification
                                               object: nil];
    hostReach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    [hostReach startNotifier];
    
    
    if ([CLLocationManager locationServicesEnabled]) {
        self.locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        [_locationManager startUpdatingLocation];
        
        //在ios 8.0下要授权
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
            [_locationManager requestWhenInUseAuthorization];  //调用了这句,就会弹出允许框了.
    }
    
    
    NSString *API_KEY = KAPI_KEY;
    NSString *API_SECRET = KAPI_SECRET;
    
    // initialize
    [FaceppAPI initWithApiKey:API_KEY andApiSecret:API_SECRET andRegion:APIServerRegionCN];
    
    // turn on the debug mode
    [FaceppAPI setDebugMode:TRUE];
    
    
    //设置log等级，此处log为默认在documents目录下的msc.log文件
    [IFlySetting setLogFile:LVL_NONE];
    
    //输出在console的log开关
    [IFlySetting showLogcat:NO];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [paths objectAtIndex:0];
    //设置msc.log的保存路径
    [IFlySetting setLogFilePath:cachePath];
    
    
    //创建语音配置
    NSString *initString = [[NSString alloc] initWithFormat:@"appid=%@,timeout=%@",APPID_VALUE,TIMEOUT_VALUE];
    
    //所有服务启动前，需要确保执行createUtility
    [IFlySpeechUtility createUtility:initString];
    
    //屏幕常亮
    //[[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    // 要使用百度地图，请先启动BaiduMapManager
	_mapManager = [[BMKMapManager alloc]init];
	BOOL ret = [_mapManager start:@"MecXvKFw99hZYi9i4eGs2IMf" generalDelegate:self];
	if (!ret) {
		NSLog(@"manager start failed!");
	}
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    [LoginSqlite opensql];
    [ProjectSqlite opensql];
    [ContactSqlite opensql];
    [CameraSqlite opensql];
    [RecordSqlite opensql];
    [ProjectLogSqlite opensql];
    [UserSqlite opensql];
    
    if(![[NSUserDefaults standardUserDefaults] objectForKey:@"firstLaunch"]){
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
        NSLog(@"第一次启动");
        LoginViewController *loginview = [[LoginViewController alloc] init];
        UINavigationController *naVC = [[UINavigationController alloc] initWithRootViewController:loginview];
        
        [self.window setRootViewController:naVC];
        self.window.backgroundColor = [UIColor whiteColor];
        [self.window makeKeyAndVisible];
    }else{
        NSLog(@"已经不是第一次启动了");
        NSLog(@"===>%@",[LoginSqlite getdata:@"UserToken" defaultdata:@""]);
        
        if(![[LoginSqlite getdata:@"UserToken" defaultdata:@""] isEqualToString:@""]){
            UIViewController * leftViewController = [[HomePageLeftViewController alloc] init];
            UIViewController * centerViewController = [[HomePageCenterViewController alloc] init];
            UINavigationController * navigationController = [[UINavigationController alloc] initWithRootViewController:centerViewController];
            navigationController.navigationBarHidden = YES;
            //[navigationController setEnableBackGesture:true];
            drawerController = [[MMDrawerController alloc]
                                initWithCenterViewController:navigationController
                                leftDrawerViewController:leftViewController
                                rightDrawerViewController:nil];
            [drawerController setMaximumRightDrawerWidth:320-62];
            [drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
            [drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
            [self.window setRootViewController:drawerController];
            self.window.backgroundColor = [UIColor whiteColor];
            [self.window makeKeyAndVisible];
        }else{
            LoginViewController *loginview = [[LoginViewController alloc] init];
            UINavigationController *naVC = [[UINavigationController alloc] initWithRootViewController:loginview];
            
            [self.window setRootViewController:naVC];
            self.window.backgroundColor = [UIColor whiteColor];
            [self.window makeKeyAndVisible];
        }
        
    }
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{

}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    NSLog(@"applicationDidBecomeActive");
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    NSLog(@"applicationWillTerminate");
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)onGetNetworkState:(int)iError
{
    if (0 == iError) {
        NSLog(@"联网成功");
    }
    else{
        NSLog(@"onGetNetworkState %d",iError);
    }
    
}

- (void)onGetPermissionState:(int)iError
{
    if (0 == iError) {
        NSLog(@"授权成功");
    }
    else {
        NSLog(@"onGetPermissionState %d",iError);
    }
}

//网络链接改变时会调用的方法
-(void)reachabilityChanged:(NSNotification *)note
{
    Reachability *currReach = [note object];
    //对连接改变做出响应处理动作
    NetworkStatus status = [currReach currentReachabilityStatus];
    //如果没有连接到网络就弹出提醒实况
    if(status == NotReachable){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NotReachable" object:nil];
    }else{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"IsReachable" object:nil];
    }
}
@end
