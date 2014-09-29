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
@class IFlySpeechUnderstander;

/**
 语音理解demo
 */

@protocol UnderstandViewControllerDelegate <NSObject>

- (void)getSearchContent:(NSString *)searchContent;

@end

@interface UnderstandViewController : BaseViewController<IFlySpeechRecognizerDelegate>
{
    UILabel *label;
    DKCircleButton *button;
    NSTimer *timer;
}
@property (nonatomic,strong) IFlySpeechUnderstander *iFlySpeechUnderstander;
@property (nonatomic,strong) PopupView          * popView;
@property (nonatomic,weak)   UITextView         * textView;
@property (nonatomic,strong) NSString               *result;
@property (nonatomic)         BOOL                  isCanceled;
@property (nonatomic,strong)id<UnderstandViewControllerDelegate> delegate;

@end
