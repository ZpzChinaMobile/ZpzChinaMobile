//
//  HomePageCenterViewController.h
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-13.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewProjectViewController.h"
#import "MyTaskViewController.h"
#import "AllProjuctViewController.h"
#import "Album.h"
#import "ModificationViewController.h"
@interface HomePageCenterViewController : UIViewController<UIActionSheetDelegate>{
    NewProjectViewController *_newProject;
    MyTaskViewController *_myTask;
    AllProjuctViewController *_allProjuct;
    UIActionSheet *_myActionSheet;
    UIView *bgView;
    UIButton *btn;
    Album *album;
}
@end
