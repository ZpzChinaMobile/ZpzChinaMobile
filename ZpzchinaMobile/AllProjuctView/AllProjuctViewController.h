//
//  AllProjuctViewController.h
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-18.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "CellContentView.h"
#import "SearchViewController.h"
#import "NewProjectViewController.h"
#import "toolBarView.h"
#import "BaiDuMapViewController.h"
#import "AdvancedSearchViewController.h"
#import "ASRDialogViewController.h"
#import "RecordView.h"
#import "ProjectContentCell.h"
#import "TFIndicatorView.h"
@interface AllProjuctViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,CellContentViewDelegate,UIActionSheetDelegate,UISearchBarDelegate,toolBarViewDelegate,ASRDialogViewControllerDelegate,RecordViewDelegate>{
    UITableView *_tableView;
    CellContentView *_cellContent;
    SearchViewController *_searchView;
    UIActionSheet *_myActionSheet;
    NewProjectViewController *_newProject;
    NSMutableArray *showArr;
    NSMutableArray *dataArr;
    UISearchBar *_searchbar;
    UIButton *cancelBtn;
    UIView *topBgView;
    toolBarView *toolbarView;
    BaiDuMapViewController *mapView;
    AdvancedSearchViewController *ADsearchVIew;
    ASRDialogViewController *ASRDialogview;
    RecordView *_recordView;
    UIView *lineBgView;
    TFIndicatorView *indicator;
}
@property(retain,nonatomic)NSMutableArray *showArr;
@end
