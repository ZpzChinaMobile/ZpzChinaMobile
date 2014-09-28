//
//  ISRViewController.h
//  MSCDemo
//
//  Created by iflytek on 13-6-6.
//  Copyright (c) 2013年 iflytek. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "iflyMSC/IFlySpeechRecognizerDelegate.h"
#import "DKCircleButton.h"
#import "BaseViewController.h"
//forward declare
@class PopupView;
@class IFlyDataUploader;
@class IFlySpeechRecognizer;

/**
 无UI语音识别demo
 使用该功能仅仅需要四步
 1.创建识别对象；
 2.设置识别参数；
 3.有选择的实现识别回调；
 4.启动识别
 */

@protocol ISRViewControllerDelegate <NSObject>

- (void)getSearchContent:(NSString *)searchContent;

@end
@interface ISRViewController : BaseViewController<IFlySpeechRecognizerDelegate,UIActionSheetDelegate>
{
    UILabel *label;
    DKCircleButton *button;
    NSTimer *timer;
}

//识别对象
@property (nonatomic, strong) IFlySpeechRecognizer * iFlySpeechRecognizer;
@property (nonatomic,strong) PopupView          * popView;
@property (nonatomic,weak)   UITextView         * textView;
@property (nonatomic,strong) NSString               *result;
@property (nonatomic)         BOOL                  isCanceled;
@property (nonatomic,assign) id<ISRViewControllerDelegate>  delegate;



@end
