//
//  OwnerTypeViewController.h
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-28.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol OwnerTypeViewDelegate;
@interface OwnerTypeViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    UITableView *_tableView;
    NSMutableArray *showArr;
    NSMutableArray *dataArr;
    id<OwnerTypeViewDelegate>delegate;
}

@property(retain,nonatomic)NSMutableArray *showArr;
@property(retain,nonatomic)NSMutableArray *dataArr;
@property(nonatomic ,strong)id<OwnerTypeViewDelegate>delegate;
@end
@protocol OwnerTypeViewDelegate <NSObject>
-(void)choiceDataOwnerType:(NSMutableArray *)arr;
-(void)backOwnerTypeViewController;
@end
