//
//  CameraModel.h
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-7-1.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CameraModel : NSObject
@property (nonatomic,strong) NSString *a_id;
@property (nonatomic,strong) NSString *a_baseCameraID;
@property (nonatomic,strong) NSString *a_name;
@property (nonatomic,strong) NSString *a_body;
@property (nonatomic,strong) NSString *a_type;
@property (nonatomic,strong) NSString *a_projectName;
@property (nonatomic,strong) NSString *a_projectID;
@property (nonatomic,strong) NSString *a_localProjectId;
@property (nonatomic,strong) NSString *a_device;
@property (nonatomic,strong) NSString *a_imgCompressionContent;
@property(nonatomic)CGFloat imageHeight;
@property(nonatomic)CGFloat imageWidth;
-(void)loadWithDictionary:(NSDictionary*)dic;
-(void)loadWithDB:(NSDictionary*)dic;
+ (void)globalPostWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block parameters:(NSMutableDictionary *)parameters aid:(NSString *)aid;
@end
