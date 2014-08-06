//
//  ProjectTableViewCell.h
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-20.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIDropDown.h"
@protocol ProjectDelegate;
@interface ProjectTableViewCell : UITableViewCell<UITextFieldDelegate,NIDropDownDelegate>{
    id<ProjectDelegate>delegate;
    UITextField *textfield;
    NIDropDown *dropDown;
    NSMutableArray *dataArr;
    UIButton *ProjectAddress;
    UIView *closeView;
    NSMutableDictionary *dataDic;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier dic:(NSMutableDictionary *)dic flag:(int)flag ownerArr:(NSMutableArray *)ownerArr singleDic:(NSMutableDictionary *)singleDic;
@property(nonatomic ,strong) id <ProjectDelegate> delegate;
@property(retain,nonatomic)NIDropDown *dropDown;
@property(nonatomic,retain)NSMutableArray *dataArr;
@end
@protocol ProjectDelegate <NSObject>
-(void)addContactViewProject:(int)index;
-(void)addContentProject:(NSString *)str index:(int)index;
-(void)addforeignInvestment:(NSString *)str;
-(void)updataOwner:(NSMutableDictionary *)dic index:(int)index;
-(void)gotoMap:(NSString *)address city:(NSString *)city;
@end