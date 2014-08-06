//
//  LandscapingTableViewCell.h
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-20.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LandscapingDelegate;
@interface LandscapingTableViewCell : UITableViewCell{
    id<LandscapingDelegate>delegate; 
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier dic:(NSMutableDictionary *)dic flag:(int)flag singleDic:(NSMutableDictionary *)singleDic;
@property(nonatomic ,strong) id <LandscapingDelegate> delegate;
@end
@protocol LandscapingDelegate <NSObject>
-(void)addContactViewLandscaping;
@end