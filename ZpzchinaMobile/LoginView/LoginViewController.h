//
//  LoginViewController.h
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-17.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
@interface LoginViewController : UIViewController<UITextFieldDelegate,UIAlertViewDelegate,MBProgressHUDDelegate>{
    UITextField *_userNameTextField;
    UITextField *_passWordTextField;
    NSString *userToken;
    UIButton *bgBtn;
    BOOL _isSelect;
    UIImageView *rememberView;
    NSMutableArray *imgArr;
    UIButton* loginBtn;
    MBProgressHUD *HUD;
}
@property(retain,nonatomic)NSString *userToken;
@property(nonatomic, assign) BOOL isLogin;
@end
