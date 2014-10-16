//
//  ProjectModel.h
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-25.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProjectModel : NSObject
@property (nonatomic,strong) NSString *a_id;
//项目ID
@property (nonatomic,strong) NSString *a_projectId;
//项目编号
@property (nonatomic,strong) NSString *a_projectCode;
//版本号
@property (nonatomic,strong) NSString *a_projectVersion;
//地块名称
@property (nonatomic,strong) NSString *a_landName;
//所在区域
@property (nonatomic,strong) NSString *a_district;
//所在省市
@property (nonatomic,strong) NSString *a_province;
//市区县
@property (nonatomic,strong) NSString *a_city;
//地块地址（项目地址）
@property (nonatomic,strong) NSString *a_landAddress;
//土地面积
@property (nonatomic,strong) NSString *a_area;
//土地容积率
@property (nonatomic,strong) NSString *a_plotRatio;
//地块用途
@property (nonatomic,strong) NSString *a_usage;
//拍卖单位
@property (nonatomic,strong) NSString *a_auctionUnit;
//项目名称
@property (nonatomic,strong) NSString *a_projectName;
//项目描述
@property (nonatomic,strong) NSString *a_description;
//业主单位
@property (nonatomic,strong) NSString *a_owner;
//预计开工时间
@property (nonatomic,strong) NSString *a_expectedStartTime;
//预计竣工时间
@property (nonatomic,strong) NSString *a_expectedFinishTime;
//投资额
@property (nonatomic,strong) NSString *a_investment;
//建筑面积
@property (nonatomic,strong) NSString *a_areaOfStructure;
//建筑层高
@property (nonatomic,strong) NSString *a_storeyHeight;
//外资参与
@property (nonatomic,strong) NSString *a_foreignInvestment;
//业主类型
@property (nonatomic,strong) NSString *a_ownerType;
//经度
@property (nonatomic,strong) NSString *a_longitude;
//纬度
@property (nonatomic,strong) NSString *a_latitude;
//主体设计阶段
@property (nonatomic,strong) NSString *a_mainDesignStage;
//电梯
@property (nonatomic,strong) NSString *a_propertyElevator;
//空调
@property (nonatomic,strong) NSString *a_propertyAirCondition;
//供暖
@property (nonatomic,strong) NSString *a_propertyHeating;
//外墙材料
@property (nonatomic,strong) NSString *a_propertyExternalWallMeterial;
//钢结构
@property (nonatomic,strong) NSString *a_propertyStealStructure;
//实际开工时间
@property (nonatomic,strong) NSString *a_actualStartTime;
//消防
@property (nonatomic,strong) NSString *a_fireControl;
//景观绿化
@property (nonatomic,strong) NSString *a_green;
//弱电安装
@property (nonatomic,strong) NSString *a_electroweakInstallation;
//装修情况
@property (nonatomic,strong) NSString *a_decorationSituation;
//装修进度
@property (nonatomic,strong) NSString *a_decorationProgress;
//url
@property (nonatomic,strong) NSString *a_url;
-(void)loadWithDictionary:(NSDictionary*)dic;
-(void)loadWithDB:(NSDictionary*)dic;
+ (NSURLSessionDataTask *)globalSearchWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block str:(NSString *)str index:(int)index;
+ (NSURLSessionDataTask *)globalMyProjectWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block index:(int)index;
+ (NSURLSessionDataTask *)globalProjectValueWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block url:(NSString *)url;
+ (void)globalPostWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block parameters:(NSMutableDictionary *)parameters aid:(NSString *)aid;
+ (void)globalPutWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block parameters:(NSMutableDictionary *)parameters aid:(NSString *)aid;

//地图搜索 精度,维度
+ (NSURLSessionDataTask *)GetMapSearchWithBlock:(void (^)(NSMutableArray *posts, NSError *error))block longitude:(NSString*)longitude latitude:(NSString*)latitude;
@end
