//
//  ClearFire.h
//  ZpzchinaMobile
//
//  Created by Jack on 14-8-14.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ClearFireDelegate <NSObject>

-(void)addContactViewFirefighting:(int)index;

@end

@interface ClearFireCell : UITableViewCell

@property(nonatomic ,strong) id <ClearFireDelegate> delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier dic:(NSMutableDictionary *)dic flag:(int)flag Arr:(NSMutableArray *)Arr singleDic:(NSMutableDictionary *)singleDic;

@end
