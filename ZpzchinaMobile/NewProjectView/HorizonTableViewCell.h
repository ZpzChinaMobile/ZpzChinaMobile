//
//  HorizonTableViewCell.h
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-20.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HorizonDelegate;
@interface HorizonTableViewCell : UITableViewCell{
    id<HorizonDelegate>delegate;
    NSMutableArray *dataArr;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier dic:(NSMutableDictionary *)dic flag:(int)flag Arr:(NSMutableArray *)Arr singleDic:(NSMutableDictionary *)singleDic;
@property(nonatomic ,strong) id <HorizonDelegate> delegate;
@end
@protocol HorizonDelegate <NSObject>
-(void)addContactViewHorizon:(int)index;
-(void)updataContractorUnitContacts:(NSMutableDictionary *)dic index:(int)index;
@end