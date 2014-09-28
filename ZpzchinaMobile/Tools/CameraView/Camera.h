//
//  Camera.h
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-30.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CameraModel.h"

@protocol CameraDelegate;
@interface Camera : NSObject<UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    //图片2进制路径
    NSString* _filePath;
    UIImagePickerController *pickerController;
    NSString *type;
    NSString *projectID;
}
@property(nonatomic ,weak) id <CameraDelegate> delegate;
-(void)getCameraView:(UIViewController *)viewController flag:(int)flag aid:(NSString *)aid;
@end
@protocol CameraDelegate <NSObject>
-(void)backCamera:(CameraModel*)cameraModel;
@end