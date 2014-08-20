//
//  GeologicalSurveyTableViewCell.h
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-20.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol GeologicalSurveyDelegate;
@interface GeologicalSurveyTableViewCell : UITableViewCell{
    NSMutableArray *dataArr;
    NSMutableArray *imageArr;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier flag:(int)flag Arr:(NSMutableArray *)Arr explorationImageArr:(NSMutableArray *)explorationImageArr;
@property(nonatomic ,weak) id <GeologicalSurveyDelegate> delegate;
@end
@protocol GeologicalSurveyDelegate <NSObject>
-(void)addContactViewGeologicalSurvey;
-(void)updataExplorationUnitContacts:(NSMutableDictionary *)dic index:(int)index;
//-(void)moreImage:(int)index;
@end