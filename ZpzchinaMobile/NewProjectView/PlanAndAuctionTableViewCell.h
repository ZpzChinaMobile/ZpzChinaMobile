//
//  PlanAndAuctionTableViewCell.h
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-20.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PlanAndAuctionDelegate;
@interface PlanAndAuctionTableViewCell : UITableViewCell<UITextFieldDelegate>{
    UITextField *textfield;
    NSMutableArray *dataArr;
    UIView *closeView;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier dic:(NSMutableDictionary *)dic singleDic:(NSMutableDictionary *)singleDic flag:(int)flag contactArr:(NSMutableArray *)contactArr;
-(void)updateContent:(BOOL)openRow;
@property(nonatomic ,weak) id <PlanAndAuctionDelegate> delegate;
@property(nonatomic,retain)NSMutableArray *dataArr;
-(void)closeKeyBoard;
@end
@protocol PlanAndAuctionDelegate <NSObject>
-(void)addContactView:(int)index;
-(void)addContent:(NSString *)str index:(int)index;
-(void)updataContact:(NSMutableDictionary *)dic index:(int)index;
-(void)beginEditWithHeight:(CGFloat)height;
-(void)endEdit;
@end