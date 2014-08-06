//
//  Album.h
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-7-14.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Album : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    UIImagePickerController *pickerController;
    UIButton *btn;
    //图片2进制路径
    NSString* filePath;
}
-(void)getCameraView:(UIViewController *)viewController button:(UIButton *)button;
@end
