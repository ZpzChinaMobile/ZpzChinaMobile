//
//  ModificationSelectViewCell.h
//  ZpzchinaMobile
//
//  Created by 孙元侃 on 14-8-14.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ModificationSelectViewCell : UITableViewCell
@property(nonatomic,strong)UILabel* stageLabel;
+(ModificationSelectViewCell*)dequeueReusableCellWithTabelView:(UITableView*)tableView identifier:(NSString*)identifier indexPath:(NSIndexPath*)indexPath nowTableView:(NSInteger)number;
@end
