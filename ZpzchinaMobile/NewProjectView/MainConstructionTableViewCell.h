//
//  MainConstructionTableViewCell.h
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-20.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MainConstructionDelegate;
@interface MainConstructionTableViewCell : UITableViewCell{
    NSMutableArray *horizonArr;
    NSMutableArray *pilePitArr;
    NSMutableArray *mainConstructionArr;
    id<MainConstructionDelegate>delegate;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier flag:(int)flag HorizonArr:(NSMutableArray *)HorizonArr PilePitArr:(NSMutableArray *)PilePitArr MainConstructionArr:(NSMutableArray *)MainConstructionArr isRelease:(int)isRelease;
@property(nonatomic ,strong) id <MainConstructionDelegate> delegate;
@end
@protocol MainConstructionDelegate <NSObject>
-(void)moreImage:(int)index;
@end