//
//  TenTableViewController.h
//  ZpzchinaMobile
//
//  Created by 孙元侃 on 14-8-14.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SinglePickerView.h"
#import "WeakElectricityCell.h"
@interface TenTableViewController : UITableViewController<WeakElectricityDelegate,UIActionSheetDelegate>
{
    SinglePickerView *singlepickerview;
    int flag;//0弱电安装，1装修情况 2装卸进度
}
@property(nonatomic,strong)NSMutableArray* images;
@property(nonatomic,strong)NSMutableDictionary* dataDic;//新建用字典
@property(nonatomic,strong)NSMutableDictionary* singleDic;//修改用字典
@property(nonatomic)NSInteger fromView;//判断是新建还是修改 新建是0 修改是1
@property(nonatomic,weak)UIViewController* superVC;

-(instancetype)initWithSingle:(NSMutableDictionary*)singleDic dataDic:(NSMutableDictionary*)dataDic images:(NSMutableArray*)images;
@end
