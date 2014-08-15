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
@interface NineTableViewController : UITableViewController<ClearFireDelegate>
{
    SinglePickerView *singlepickerview;
 
    
}
@property(nonatomic,strong)NSMutableArray* images;

@end
