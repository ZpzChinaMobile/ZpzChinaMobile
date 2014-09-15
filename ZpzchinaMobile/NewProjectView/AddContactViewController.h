//
//  AddContactViewController.h
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-24.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIDropDown.h"
@protocol AddContactViewDelegate;
@interface AddContactViewController : UIViewController<UITextFieldDelegate,NIDropDownDelegate>{
    NSMutableDictionary *dataDic;
    NSString *localProjectId;
    UITextField *addName;
    UITextField *addPhone;
    UIButton *title;
    UITextField *accountName;
    UITextField *address;
    UIButton *saveBtn;
    int btnTag;
    NIDropDown *dropDown;
    UITextField *textfield;
    UIView *closeView;
    NSString *contactType;
}
@property(nonatomic ,weak) id <AddContactViewDelegate> delegate;
@property(retain,nonatomic)NSMutableDictionary *dataDic;
@property(retain,nonatomic)NIDropDown *dropDown;
@property(retain,nonatomic)NSString *contactType;
@property(assign,nonatomic)int btnTag;
-(void)setlocalProjectId:(NSString *)aid;
-(void)updataContact:(NSMutableDictionary *)dic index:(int)index;
-(void)setenabled:(NSMutableArray *)dataArr;
@end
@protocol AddContactViewDelegate <NSObject>
-(void)back:(NSMutableDictionary *)dic btnTag:(int)btnTag;
@end