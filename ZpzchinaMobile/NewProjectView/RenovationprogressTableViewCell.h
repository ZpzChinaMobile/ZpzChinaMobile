//
//  RenovationprogressTableViewCell.h
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-20.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol RenovationprogressDelegate;
@interface RenovationprogressTableViewCell : UITableViewCell{
    id<RenovationprogressDelegate>delegate;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier dic:(NSMutableDictionary *)dic flag:(int)flag singleDic:(NSMutableDictionary *)singleDic;
@property(nonatomic ,strong) id <RenovationprogressDelegate> delegate;
@end
@protocol RenovationprogressDelegate <NSObject>
-(void)addContactViewRenovationprogress;
@end
