//
//  SearchViewController.h
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-19.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "SearchCellView.h"
#import "toolBarView.h"
#import "BaiDuMapViewController.h"
#import "AdvancedSearchViewController.h"
#import "CellContentView.h"
#import "NewProjectViewController.h"
#import "ASRDialogViewController.h"
#import "RecordView.h"
@interface SearchViewController : BaseViewController<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource,toolBarViewDelegate,CellContentViewDelegate,UIActionSheetDelegate,ASRDialogViewControllerDelegate>{
    UISearchBar *_searchbar;
    NSMutableArray *showArr;
    SearchCellView *searchCellView;
    toolBarView *toolbarView;
    UIButton *_bgBtn;
    BaiDuMapViewController *mapView;
    AdvancedSearchViewController *ADsearchVIew;
    CellContentView *_cellContent;
    UIActionSheet *_myActionSheet;
    UITableView *_tableView;
    NewProjectViewController *_newProject;
    NSMutableDictionary *dataDic;
    ASRDialogViewController *ASRDialogview;
    RecordView *_recordView;
}
@property (nonatomic,retain) NSMutableArray *showArr;
@property (nonatomic,retain) SearchCellView *searchCellView;
@property (nonatomic,retain) toolBarView *toolbarView;
@property (nonatomic,retain) BaiDuMapViewController *mapView;
@property (nonatomic,retain) AdvancedSearchViewController *ADsearchVIew;
@property(retain,nonatomic)NSMutableDictionary *dataDic;
@end
