//
//  LoginEvent.m
//  ZpzChinaApp
//
//  Created by Jack on 14-7-16.
//  Copyright (c) 2014年 zpzchina. All rights reserved.
//

#import "LoginEvent.h"
#import "FaceppResult.h"
#import "FaceppAPI.h"
#import "GTMBase64.h"
#import "LoginSqlite.h"
@implementation LoginEvent
@synthesize faceIDArray,imagePicker;
static int chanceToLoginByFace =3;



//照片转正
- (UIImage *)fixOrientation:(UIImage *)aImage {
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}


-(void)detectWithImage:(UIImage *)image With:(int)count//已经注册开始识别
{
    

    if (count==1) {
           NSLog(@"hahahahahahahahah%%%%%%%%%%**************************%d",count);
              person_id = [[NSUserDefaults standardUserDefaults] objectForKey:@"userID"];

    
             NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    
             FaceppResult *result = [[FaceppAPI detection] detectWithURL:nil orImageData:imageData mode:FaceppDetectionModeNormal attribute:FaceppDetectionAttributeNone];
             NSLog(@"%@",result.content);
             if (result.success)
             {

                        NSArray *a = [[result content] objectForKey:@"face"];
                 NSLog(@"%d",a.count);
                        if ([a count]==0)
                        {
                            
                            [[NSNotificationCenter defaultCenter] postNotificationName:@"face" object:nil];

                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请将摄像头对准脸部进行照片采集" delegate:nil cancelButtonTitle:@"是" otherButtonTitles: nil ];
                            [alert show];
                            
                            return;

                        }
                 if ([a count]>=2){
                                          [[NSNotificationCenter defaultCenter] postNotificationName:@"face" object:nil];
                     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"屏幕中只能出现一张脸" delegate:nil cancelButtonTitle:@"是" otherButtonTitles: nil ];
                     [alert show];
                         return;
                 }
                        for(NSDictionary *item in a)
                        {
                            
                                    if (![[item objectForKey:@"face_id"] isEqualToString:@""])
                                    {
                                                  NSString * str =[item objectForKey:@"face_id"];
                                        
                                                    NSDictionary *data = [[NSDictionary alloc] initWithObjectsAndKeys:person_id,@"userID",str,@"faceID",nil];
                                                    NSMutableDictionary *parameters =[[NSMutableDictionary alloc] init];
                                                    [parameters setObject:data forKey:@"data"];
                                                    NSLog(@"nininiiinmmmmmmmmmmmm%@",parameters);
                                                    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:[NSString stringWithFormat:@"%s/users/FaceLogin",serverAddress] parameters:parameters error:nil];
                                                    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
                                                    op.responseSerializer = [AFJSONResponseSerializer serializer];
                                                    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
                                                     {
                                                             NSLog(@"11111111111111111111111JSON: %@", responseObject);
                                                             
                                                             NSNumber *statusCode = [[[responseObject objectForKey:@"d"] objectForKey:@"status"] objectForKey:@"statusCode"];
                                                             if([[NSString stringWithFormat:@"%@",statusCode] isEqualToString:@"200"])
                                                             {
                                                                 NSLog(@"登陆成功");
                                                                 
                                                                 
                                                                

                                                                 NSArray *a = [[responseObject objectForKey:@"d"] objectForKey:@"data"];
                                                                 for(NSDictionary *item in a){
                                                                     [[NSUserDefaults standardUserDefaults]setObject:[item objectForKey:@"userToken"] forKey:@"UserToken"];
                                                                     [[NSUserDefaults standardUserDefaults]synchronize];
                                                                     [[NSUserDefaults standardUserDefaults] setObject:[item objectForKey:@"faceCount"] forKey:@"currentFaceCount"];
                                                                     [[NSUserDefaults standardUserDefaults] synchronize];
                                                                     [LoginSqlite insertData:[item objectForKey:@"userToken"]  datakey:@"UserToken"];
                                                                     if([[item objectForKey:@"faceCount"] intValue] <15){
                                                                     
                                                                     //继续添加脸
                                                                         FaceppResult *result1=[[FaceppAPI person] addFaceWithPersonName:person_id orPersonId:nil andFaceId:[NSArray arrayWithObject:str]];
                                                                         
                                                                         if (result1.success) {
                                                                             
                                                                             NSLog(@"%@",result1.content);
                                                                                 int faceNumber = [[result1 content][@"added_face"] intValue];
                                                                             
                                                                             [self aloneAddFace:person_id With:YES With:faceNumber];//把当前脸的数量发给后台服务器
//                                                                             j=0;
                                                                         }

                                                                         
                                                                         
                                                                     }
                                                                 }
                                                                 [[NSNotificationCenter defaultCenter] postNotificationName:@"faceLogin" object:nil];
                                                             }
                                                             else
                                                             {
                                                                  chanceToLoginByFace--;
                                                                 if (chanceToLoginByFace ==0) {
                                                                     [[NSNotificationCenter defaultCenter] postNotificationName:@"Login" object:nil];                                                                     
                                                                 }


                                                                 [[NSNotificationCenter defaultCenter] postNotificationName:@"face" object:nil];
                                                                 
                                                                     NSString *str = [NSString stringWithFormat:@"您还有%d次机会！",chanceToLoginByFace];
                                                                     str = [@"登录失败，" stringByAppendingString:str];
                                                                     NSLog(@"登陆失败！");
                                                                     UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:str delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                                                                     [alert show];


                                                                 
                                                                 
                                                                
                                                                 
                                                             }
                                                     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
                                                     {
                                                     NSLog(@"Error: %@", error);
                                                     }];
                                                     [[NSOperationQueue mainQueue] addOperation:op];

                                        

                                    }
                            
                        }
         
     
        
            } else
            {
                // some errors occurred
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle:[NSString stringWithFormat:@"error message: %@", [result error].message]
                                      message:@""
                                      delegate:nil
                                      cancelButtonTitle:@"确定!"
                                      otherButtonTitles:nil];
                [alert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
            }
        
    }
    
    
}






-(void)beginToRegisterFace//开始进行脸部注册
{
    
    
    
         [[FaceppAPI person] deleteWithPersonName:person_id orPersonId:nil];

         FaceppResult *result = [[FaceppAPI person] createWithPersonName:person_id andFaceId:faceIDArray andTag:nil andGroupId:nil orGroupName:nil];
    
    NSLog(@"result Json*************%@",result.content);
    
    // 对注册时一个用户的脸的张数进行记录


    int faceNumber = [[result content][@"added_face"] intValue];
   
    
    [faceIDArray removeAllObjects];
    
    if ([[result.content objectForKey:@"person_name"] isEqualToString:person_id]&&[[result.content objectForKey:@"added_face"] intValue]>0) {
        
         [[FaceppAPI train] trainAsynchronouslyWithId:nil orName:person_id andType:FaceppTrainVerify];

        NSLog(@"注册成功");
        
        bool isFaceRegisted = YES;
        
        [self aloneAddFace:person_id With:isFaceRegisted With:faceNumber];
        
       
    }
    else{
       
    [[NSNotificationCenter defaultCenter] postNotificationName:@"failRegister" object:nil userInfo:nil];//返回到Login页面
    
    }
    
}


-(void)detectWithImageArray:(NSMutableArray *)faceArray//没有进行脸部注册时候获取faceID
{
    NSLog(@"detectWithImageArray");
     person_id = [[NSUserDefaults standardUserDefaults] objectForKey:@"userID"];
    
    for (int i =0; i<faceArray.count; i++) {
        
       

        
        UIImage *image = [faceArray objectAtIndex:i];
        NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
        
        FaceppResult *result = [[FaceppAPI detection] detectWithURL:nil orImageData:imageData mode:FaceppDetectionModeNormal attribute:FaceppDetectionAttributeNone];
        //NSLog(@"%@",result.content);
        if (result.success)
        {
            
            NSArray *a = [[result content] objectForKey:@"face"];
            NSLog(@"%d",a.count);
            if ([a count]==0) {
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"registerFace" object:nil];//
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请将摄像头对准脸部进行照片采集" delegate:nil cancelButtonTitle:@"是" otherButtonTitles: nil ];
                [alert show];
                
                return;
            }
            
           if ([a count]>=2){
                [[NSNotificationCenter defaultCenter] postNotificationName:@"registerFace" object:nil];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"屏幕中只能出现一张脸" delegate:nil cancelButtonTitle:@"是" otherButtonTitles: nil ];
                [alert show];
                return;
            }

            for(NSDictionary *item in a)
            {
                
                if (![[item objectForKey:@"face_id"] isEqualToString:@""])
                {
                    NSString * str =[item objectForKey:@"face_id"];

                    
                        [faceIDArray addObject:str];
                        
                        if ([faceIDArray count]==5) {
                            [self beginToRegisterFace];
                        }
                    
                }
                
            }
            
            
            
        } else
        {
            // some errors occurred
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:[NSString stringWithFormat:@"error message: %@", [result error].message]
                                  message:@""
                                  delegate:nil
                                  cancelButtonTitle:@"确定!"
                                  otherButtonTitles:nil];
            [alert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
        }
        
    }
    
}


//给后台发送注册成功的信息

- (void)aloneAddFace:(NSString *)tempPerson_id With:(BOOL)isFaceRegisted With:(int)faceNumber
{
    NSLog(@"%d,%@,%d",isFaceRegisted,tempPerson_id,faceNumber);
       
    
    NSDictionary *data = [[NSDictionary alloc] initWithObjectsAndKeys:tempPerson_id,@"userID",[NSString stringWithFormat:@"%d",isFaceRegisted],@"isFaceRegisted",[NSString stringWithFormat:@"%d",faceNumber],@"faceCount",nil];
    NSMutableDictionary *parameters =[[NSMutableDictionary alloc] init];
    [parameters setObject:data forKey:@"data"];
    NSLog(@"nininiiinmmmmmmmmmmmm%@",parameters);
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:[NSString stringWithFormat:@"%s/Users/FaceRegister",serverAddress] parameters:parameters error:nil];
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        NSLog(@"==>%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"UserToken"]);
        NSNumber *statusCode = [[[responseObject objectForKey:@"d"] objectForKey:@"status"] objectForKey:@"statusCode"];
        if([[NSString stringWithFormat:@"%@",statusCode] isEqualToString:@"200"])
        {
            [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"isFaceRegisted"];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"faceLogin" object:nil];
        }else{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"faceRegister" object:nil];
        }
        [[NSUserDefaults standardUserDefaults] synchronize];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    [[NSOperationQueue mainQueue] addOperation:op];

}

@end
