//
//  DecorationTableViewCell.h
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-20.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DecorationDelegate;
@interface DecorationTableViewCell : UITableViewCell{
    id<DecorationDelegate>delegate;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier dic:(NSMutableDictionary *)dic flag:(int)flag singleDic:(NSMutableDictionary *)singleDic;
@property(nonatomic ,strong) id <DecorationDelegate> delegate;
@end
@protocol DecorationDelegate <NSObject>
-(void)addContactViewDecoration;
@end
