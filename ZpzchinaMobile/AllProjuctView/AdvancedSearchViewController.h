//
//  AdvancedSearchViewController.h
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-23.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "BaseViewController.h"
#import "ResultsViewController.h"
#import "SinglePickerView.h"
@interface AdvancedSearchViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIActionSheetDelegate>{
    UITableView *_tableView;
    NSMutableArray *titleArr;
    NSMutableDictionary *dataDic;
    ResultsViewController *resultsview;
    UITextField *textfield;
    UIButton *btn;
    SinglePickerView *singlepickerview;
}
@property(retain,nonatomic)NSMutableArray *titleArr;
@end
