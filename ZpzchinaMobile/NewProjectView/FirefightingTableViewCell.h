//
//  FirefightingTableViewCell.h
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-20.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol FirefightingDelegate;
@interface FirefightingTableViewCell : UITableViewCell{
    id<FirefightingDelegate>delegate;
    NSMutableArray *imageArr;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier dic:(NSMutableDictionary *)dic flag:(int)flag singleDic:(NSMutableDictionary *)singleDic fireControlArr:(NSMutableArray *)fireControlArr;
@property(nonatomic ,strong) id <FirefightingDelegate> delegate;
@end
@protocol FirefightingDelegate <NSObject>
-(void)addContactViewFirefighting;
-(void)moreImage:(int)index;
@end