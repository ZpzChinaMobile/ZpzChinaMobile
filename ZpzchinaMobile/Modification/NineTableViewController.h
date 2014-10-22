//
//  NineTableViewController.h
//  ZpzchinaMobile
//
//  Created by 孙元侃 on 14-8-14.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SinglePickerView.h"
#import "ClearFireCell.h"
#import "ModificationViewController.h"

@interface NineTableViewController : UIViewController<ClearFireDelegate,UIActionSheetDelegate,UITableViewDataSource,UITableViewDelegate>
{
    SinglePickerView *singlepickerview;
 int flag;//0.消防  1.景观绿化
    
}
@property(nonatomic,strong)NSMutableArray* images;
@property(nonatomic,strong)NSMutableDictionary* dataDic;//新建用字典
@property(nonatomic,strong)NSMutableDictionary* singleDic;//修改用字典
@property(nonatomic)NSInteger fromView;//判断是新建还是修改 新建是0 修改是1
@property(nonatomic,weak)ModificationViewController* superVC;
@property(nonatomic,strong)UITableView* tableView;
@property(nonatomic,strong)NSIndexPath* indexPath;

-(instancetype)initWithSingle:(NSMutableDictionary*)singleDic dataDic:(NSMutableDictionary*)dataDic images:(NSMutableArray*)images;

@end
