//
//  MyTaskViewController.h
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-18.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "Reachability.h"
#import "GetProject.h"
#import "ProjectContentCell.h"
#import "TFIndicatorView.h"
@interface MyTaskViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIAlertViewDelegate>{
    UIImageView *_lineImage;
    UITableView *_tableView;
    UIActionSheet *_myActionSheet;
    NSMutableArray *showArr;
    Reachability *hostReach;
    GetProject *getproject;
    NSMutableArray *dataArr;
    NSMutableArray *contactArr;
    NSMutableArray *imageArr;
    NSMutableArray *updataProjectArr;
    NSMutableArray *updataContactArr;
    int flag;
    UIView *bgView;
    UIActivityIndicatorView *indicator;
    UIView* coverView;//当左button在加载网络时,覆盖在右button上,不让点击
    UIButton *releaseProjuctBtn;
    UIButton *localProjuctBtn;
}
@property(retain,nonatomic)NSMutableArray *showArr;
@property(retain,nonatomic)NSMutableArray *dataArr;
@property(retain,nonatomic)NSMutableArray *contactArr;
@property(nonatomic, assign) BOOL success;
@end
