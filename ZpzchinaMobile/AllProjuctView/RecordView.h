//
//  RecordView.h
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-7-22.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol RecordViewDelegate;
@interface RecordView : UIView<UITableViewDataSource,UITableViewDelegate>{
    UITableView *_tableView;
    NSMutableArray *showArr;
    id <RecordViewDelegate> delegate;
}
@property(nonatomic ,strong) id <RecordViewDelegate> delegate;
- (id)initWithFrame:(CGRect)frame;
@end
@protocol RecordViewDelegate <NSObject>
-(void)searchRecordText:(NSString *)content;
@end