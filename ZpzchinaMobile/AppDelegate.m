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

@implementation AppDelegate
+ (AppDelegate *)instance {
	return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSString *API_KEY = KAPI_KEY;
    NSString *API_SECRET = KAPI_SECRET;
    
    // initialize
    [FaceppAPI initWithApiKey:API_KEY andApiSecret:API_SECRET andRegion:APIServerRegionCN];
    
    // turn on the debug mode
    [FaceppAPI setDebugMode:TRUE];
    
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
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]){
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
        NSLog(@"第一次启动");
        LoginViewController *loginview = [[LoginViewController alloc] init];
        UINavigationController *naVC = [[UINavigationController alloc] initWithRootViewController:loginview];
        
        [self.window setRootViewController:naVC];
        self.window.backgroundColor = [UIColor whiteColor];
        [self.window makeKeyAndVisible];
    }else{
        NSLog(@"已经不是第一次启动了");
        NSLog(@"==>%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"UserToken"]);
        if (![[NSUserDefaults standardUserDefaults]objectForKey:@"UserToken"]) {
            LoginViewController *loginview = [[LoginViewController alloc] init];
            UINavigationController *naVC = [[UINavigationController alloc] initWithRootViewController:loginview];
            
            [self.window setRootViewController:naVC];
            self.window.backgroundColor = [UIColor whiteColor];
            [self.window makeKeyAndVisible];
        }else{
            
            #if TARGET_IPHONE_SIMULATOR
            
            UIViewController * leftViewController = [[HomePageLeftViewController alloc] init];
            UIViewController * centerViewController = [[HomePageCenterViewController alloc] init];
            UINavigationController * navigationController = [[UINavigationController alloc] initWithRootViewController:centerViewController];
            navigationController.navigationBarHidden = YES;
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
            
            #elif TARGET_OS_IPHONE
            
            if([[networkConnect sharedInstance] connectedToNetwork]){
                NSLog(@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"isFaceRegisted"]);
                if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"isFaceRegisted"] isEqualToString:@"0"]) {
                    LoginViewController *loginview = [[LoginViewController alloc] init];
                    UINavigationController *naVC = [[UINavigationController alloc] initWithRootViewController:loginview];
                    [self.window setRootViewController:naVC];
                    self.window.backgroundColor = [UIColor whiteColor];
                    [self.window makeKeyAndVisible];
                }else{
                    FaceLoginViewController *faceVC = [[FaceLoginViewController alloc] init];
                    UINavigationController *naVC = [[UINavigationController alloc] initWithRootViewController:faceVC];
                    [self.window setRootViewController:naVC];
                    self.window.backgroundColor = [UIColor whiteColor];
                    [self.window makeKeyAndVisible];
                }
            }else{
                UIViewController * leftViewController = [[HomePageLeftViewController alloc] init];
                UIViewController * centerViewController = [[HomePageCenterViewController alloc] init];
                UINavigationController * navigationController = [[UINavigationController alloc] initWithRootViewController:centerViewController];
                navigationController.navigationBarHidden = YES;
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
            }
            
            #endif
            
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
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
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


@end
