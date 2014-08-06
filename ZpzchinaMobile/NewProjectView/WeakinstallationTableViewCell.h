//
//  WeakinstallationTableViewCell.h
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-20.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol WeakinstallationDelegate;
@interface WeakinstallationTableViewCell : UITableViewCell{
    id<WeakinstallationDelegate>delegate;
    NSMutableArray *imageArr;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier dic:(NSMutableDictionary *)dic flag:(int)flag singleDic:(NSMutableDictionary *)singleDic electroweakArr:(NSMutableArray *)electroweakArr;
@property(nonatomic ,strong) id <WeakinstallationDelegate> delegate;
@end
@protocol WeakinstallationDelegate <NSObject>
-(void)addContactViewWeakinstallation;
-(void)moreImage:(int)index;
@end