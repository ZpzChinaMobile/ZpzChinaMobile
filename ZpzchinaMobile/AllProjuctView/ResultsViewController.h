//
//  ResultsViewController.h
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-7-3.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "BaseViewController.h"
#import "ProjectContentCell.h"
#import "TFIndicatorView.h"
@interface ResultsViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate>{
    NSMutableArray *showArr;
    UITableView *_tableView;
    UIActivityIndicatorView *indicator;
    NSMutableDictionary *dataDic;
    UIActionSheet *_myActionSheet;
}
@property(nonatomic,retain)NSMutableDictionary *dataDic;
@end
