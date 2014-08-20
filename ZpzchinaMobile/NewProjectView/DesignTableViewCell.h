//
//  DesignTableViewCell.h
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-20.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DesignDelegate;
@interface DesignTableViewCell : UITableViewCell{
    NSMutableArray *dataArr;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier dic:(NSMutableDictionary *)dic flag:(int)flag Arr:(NSMutableArray *)Arr singleDic:(NSMutableDictionary *)singleDic;
@property(nonatomic ,weak) id <DesignDelegate> delegate;
@end
@protocol DesignDelegate <NSObject>
-(void)addContactViewDesign;
-(void)updataDesignInstituteContacts:(NSMutableDictionary *)dic index:(int)index;
-(void)addSinglePickerView;
@end