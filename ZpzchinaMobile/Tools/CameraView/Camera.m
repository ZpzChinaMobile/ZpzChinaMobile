//
//  Camera.m
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-30.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "Camera.h"
#import "CameraSqlite.h"
#import "GTMBase64.h"
@implementation Camera
@synthesize delegate;
-(void)getCameraView:(UIViewController *)viewController flag:(int)flag aid:(NSString *)aid{
    if(flag == 0){
        type = @"horizon";
    }else if(flag == 1){
        type = @"pileFoundation";
    }else if(flag == 2){
        type = @"mainPart";
    }else if(flag == 3){
        type = @"exploration";
    }else if(flag == 4){
        type = @"fireControl";
    }else{
        type = @"electroweak";
    }
    projectID = aid;
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        pickerController = [[UIImagePickerController alloc] init];
        pickerController.delegate = self;
        //设置拍照后的图片可被编辑
        pickerController.allowsEditing = YES;
        pickerController.sourceType = sourceType;
    
        [viewController presentViewController:pickerController animated:YES completion:Nil];
    }else{
        NSLog(@"模拟其中无法打开照相机,请在真机中使用");
    }
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    if ([delegate respondsToSelector:@selector(backCamera)]){
        [delegate backCamera];
    }
    [picker dismissViewControllerAnimated:YES completion:Nil];
    
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:@"public.image"]) {
        
        UIImage *photo = [info objectForKey:UIImagePickerControllerEditedImage];
        //[self.preview setImage:photo];
        //photo = [self convertViewAsImage:self.preview];
        
        UIImageWriteToSavedPhotosAlbum(photo, self, nil, nil);
        
        
        //压缩图片
        float kCompressionQuality = 0.4;
        NSData *photo2 = UIImageJPEGRepresentation(photo, kCompressionQuality);
        NSString* encoded = [[NSString alloc] initWithData:[GTMBase64 encodeData:photo2] encoding:NSUTF8StringEncoding];
        
        //NSLog(@"encoded : %@",encoded);
        [self setImage:encoded];
    }
}

-(void)setImage:(NSString *)imageStr{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd/HH/mm/ss"];
    NSString *name = [dateFormatter stringFromDate:[NSDate date]];
    NSLog(@"projectID ==> %@",projectID);
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    int value = (arc4random() % 9999999) + 1000000;
    [dic setValue:[NSString stringWithFormat:@"%d",value] forKey:@"id"];
    [dic setValue:name forKey:@"name"];
    [dic setValue:imageStr forKey:@"body"];
    [dic setValue:type forKey:@"type"];
    [dic setValue:@"" forKey:@"baseCameraID"];
    [dic setValue:@"" forKey:@"projectName"];
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^[0-9]*$" options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:projectID options:0 range:NSMakeRange(0, [projectID length])];
    if(numberOfMatches !=1 ){
        //服务器数据
        [dic setValue:projectID forKey:@"projectID"];
    }else{
        //本地数据
        [dic setValue:@"" forKey:@"projectID"];
    }
    [dic setValue:projectID forKey:@"localProjectId"];
    [dic setValue:@"localios" forKey:@"device"];
    [CameraSqlite InsertData:dic];
    if ([delegate respondsToSelector:@selector(backCamera)]){
        [delegate backCamera];
    }
    [pickerController dismissViewControllerAnimated:YES completion:Nil];
}

- (UIImage *)convertViewAsImage:(UIView *)aview {
    UIGraphicsBeginImageContext(aview.bounds.size);
    [aview.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
