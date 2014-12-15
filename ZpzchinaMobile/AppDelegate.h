//
//  AppDelegate.h
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-13.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"
#import "MMDrawerController.h"
#import "LocationViewController.h"
#import <AVFoundation/AVFoundation.h>
#define KAPI_KEY @"7057bbc57c1f842fa8f8355cab2941c3"
#define KAPI_SECRET @"R-6gNM2XsmWENxtDQjm87jm_JzWNH74X"
@interface AppDelegate : UIResponder <UIApplicationDelegate,BMKGeneralDelegate>{
    BMKMapManager* _mapManager;
    MMDrawerController * drawerController;
    AVAudioPlayer *player;
    NSTimer *timer;
}

@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,strong)LocationViewController* locationView;
+ (AppDelegate *)instance;
@end
