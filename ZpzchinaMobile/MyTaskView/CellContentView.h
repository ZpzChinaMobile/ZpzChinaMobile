//
//  CellContentView.h
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-18.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CellContentViewDelegate;
@interface CellContentView : UIView{
    id <CellContentViewDelegate> delegate;
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
}
@property(nonatomic ,strong) id <CellContentViewDelegate> delegate;
- (id)initWithFrame:(CGRect)frame dic:(NSMutableDictionary *)dic;
-(void)setNewDic:(NSMutableDictionary *)dic;
@end
@protocol CellContentViewDelegate <NSObject>
-(void)addActionSheet;
@end