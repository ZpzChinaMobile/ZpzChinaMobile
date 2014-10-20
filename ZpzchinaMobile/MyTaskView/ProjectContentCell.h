//
//  ProjectContentCell.h
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-7-24.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ProjectContentCell : UITableViewCell{
    NSString *stage;
    UILabel *nameLabel;
    UILabel *investmentLabel;
    UILabel *investmentcountLabel;
    UILabel *areaLabel;
    UILabel *areacountLabel;
    UIImageView *progressImage;
    UILabel *startdateLabel;
    UILabel *enddateLabel;
    UILabel *addressLabel;
    UILabel *zoneLabel;
}
@property(nonatomic,strong)NSMutableDictionary *dic;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
