//
//  PlotTableViewCell.h
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-20.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PlotDelegate;
@interface PlotTableViewCell : UITableViewCell{
    NSMutableArray *dataArr;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier dic:(NSMutableDictionary *)dic flag:(int)flag Arr:(NSMutableArray *)Arr singleDic:(NSMutableDictionary *)singleDic;
@property(nonatomic ,weak) id <PlotDelegate> delegate;
@end
@protocol PlotDelegate <NSObject>
-(void)addContactViewPlot:(int)index;
-(void)updataPlotOwner:(NSMutableDictionary *)dic index:(int)index;
-(void)addSwitchValue:(int)index value:(BOOL)value;
//-(void)beginEdit;
//-(void)endEdit;
@end