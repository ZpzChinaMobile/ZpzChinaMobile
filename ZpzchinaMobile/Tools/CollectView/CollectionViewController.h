//
//  CollectionViewController.h
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-7-8.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface CollectionViewController : BaseViewController<UICollectionViewDataSource,UICollectionViewDelegate>{
    UICollectionView *_collectionview;
    NSMutableArray *showArr;
    int flag;
    NSString *title;
    UIImageView *imageview;
}
@property(retain,nonatomic)NSString *title;
@property(retain,nonatomic)NSMutableArray *showArr;
@property(assign,nonatomic)int flag;
@end
