//
//  PilePitTableViewCell.h
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-20.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PilePitDelegate;
@interface PilePitTableViewCell : UITableViewCell{
    id<PilePitDelegate>delegate;
    NSMutableArray *dataArr;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier flag:(int)flag Arr:(NSMutableArray *)Arr;
@property(nonatomic ,strong) id <PilePitDelegate> delegate;
@end
@protocol PilePitDelegate <NSObject>
-(void)addContactViewPilePit;
-(void)updataPileFoundationUnitContacts:(NSMutableDictionary *)dic index:(int)index;
@end