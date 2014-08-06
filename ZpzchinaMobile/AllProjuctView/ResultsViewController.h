//
//  ResultsViewController.h
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-7-3.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "BaseViewController.h"
#import "PendulumView.h"
#import "CellContentView.h"
#import "NewProjectViewController.h"
@interface ResultsViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,CellContentViewDelegate,UIActionSheetDelegate>{
    NSMutableArray *showArr;
    UITableView *_tableView;
    PendulumView *pendulum;
    NSMutableDictionary *dataDic;
    CellContentView *_cellContent;
    UIActionSheet *_myActionSheet;
    NewProjectViewController *_newProject;
}
@property(nonatomic,retain)NSMutableDictionary *dataDic;
@end
