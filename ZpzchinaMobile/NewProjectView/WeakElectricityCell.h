//
//  WeakElectricityCell.h
//  ZpzchinaMobile
//
//  Created by Jack on 14-8-14.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol WeakElectricityDelegate <NSObject>

-(void)addContactViewFirefighting;

@end

@interface WeakElectricityCell : UITableViewCell

@property(nonatomic ,strong) id <WeakElectricityDelegate> delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier dic:(NSMutableDictionary *)dic flag:(int)flag Arr:(NSMutableArray *)Arr singleDic:(NSMutableDictionary *)singleDic;

@end
