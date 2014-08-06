//
//  MultipleChoiceViewController.h
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-27.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MChoiceViewDelegate;
@interface MultipleChoiceViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    UITableView *_tableView;
    NSMutableArray *showArr;
    NSMutableArray *dataArr;
    id<MChoiceViewDelegate>delegate;
}
@property(retain,nonatomic)NSMutableArray *showArr;
@property(retain,nonatomic)NSMutableArray *dataArr;
@property(nonatomic ,strong)id<MChoiceViewDelegate>delegate;
@end
@protocol MChoiceViewDelegate <NSObject>
-(void)choiceData:(NSMutableArray *)arr;
-(void)backMChoiceViewController;
@end