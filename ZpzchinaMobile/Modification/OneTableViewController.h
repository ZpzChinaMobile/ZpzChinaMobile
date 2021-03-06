//
//  OneTableViewController.h
//  ZpzchinaMobile
//
//  Created by 孙元侃 on 14-8-14.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModificationViewController.h"
#import "ModifiBaseViewController.h"
@protocol OneTVCDelegate <NSObject>

-(void)upTVCSpaceWithHeight:(CGFloat)height;
-(void)downTVCSpace;
@end

@interface OneTableViewController :ModifiBaseViewController
@property(nonatomic,strong)NSMutableArray* images;
@property(nonatomic,strong)NSMutableDictionary* dataDic;//新建用字典
@property(nonatomic,strong)NSMutableDictionary* singleDic;//修改用字典
@property(nonatomic,strong)NSMutableArray* contacts;
@property(nonatomic)NSInteger fromView;//判断是新建还是修改 新建是0 修改是1
@property(nonatomic,weak)ModificationViewController* superVC;
@property(nonatomic,weak)id<OneTVCDelegate>delegate;
//@property(nonatomic,strong)UITableView* tableView;
@property(nonatomic,strong)NSIndexPath* indexPath;
-(void)cellTextFieldResignFirstResponder;
-(instancetype)initWithSingle:(NSMutableDictionary*)singleDic dataDic:(NSMutableDictionary*)dataDic contacts:(NSMutableArray*)contacts images:(NSMutableArray*)images;
-(void)addContactView:(int)index;
-(void)addContent:(NSString *)str index:(int)index;
-(void)updataContact:(NSMutableDictionary *)dic index:(int)index;
@end
