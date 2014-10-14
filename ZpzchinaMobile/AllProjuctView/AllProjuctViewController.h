//
//  AllProjuctViewController.h
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-18.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "toolBarView.h"
#import "BaiDuMapViewController.h"
#import "AdvancedSearchViewController.h"
#import "UnderstandViewController.h"
#import "RecordView.h"
#import "ProjectContentCell.h"
#import "TFIndicatorView.h"
@interface AllProjuctViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,toolBarViewDelegate,RecordViewDelegate,UnderstandViewControllerDelegate,UISearchBarDelegate>{
    UITableView *_tableView;
    UIActionSheet *_myActionSheet;
    NSMutableArray *showArr;
    NSMutableArray *dataArr;
    UISearchBar *_searchbar;
    UIButton *cancelBtn;
    UIView *topBgView;
    toolBarView *toolbarView;
    //BaiDuMapViewController *mapView;
    AdvancedSearchViewController *ADsearchVIew;
    UnderstandViewController *underStandVC;
    RecordView *_recordView;
    UIView *lineBgView;
    UIActivityIndicatorView *indicator;
}
@property(retain,nonatomic)NSMutableArray *showArr;
@end
