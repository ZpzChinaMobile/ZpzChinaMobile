//
//  ZhuangXiu.m
//  programDetail
//
//  Created by 孙元侃 on 14-8-7.
//  Copyright (c) 2014年 sunyk. All rights reserved.
//

#import "ZhuangXiu.h"
#import "CameraModel.h"
#import "GTMBase64.h"
@implementation ZhuangXiu

static CGFloat height = 0;//统计总高
static __weak ProgramDetailViewController* myDelegate;
static UIView* totalView;
static NSDictionary* dataDic;

+(UIView*)zhuangXiuWithdelegate:(ProgramDetailViewController*)delegate{
    //数值初始
    height=0;
    totalView=nil;
    
    //totalView初始
    totalView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 0)];
    totalView.backgroundColor=[UIColor whiteColor];
    
    myDelegate=delegate;
    dataDic=myDelegate.dataDic;
    
    //获得第一个大view, 地平阶段
    [self getFirstView];
    
    totalView.frame=CGRectMake(0, 0, 320, height);
    return totalView;
}

+(void)getImageView:(NSInteger)imageNumber{
    UIView* view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 215.5)];
    view.center=CGPointMake(160, height+107.75);
    [totalView addSubview:view];
    height+=215.5;
    
    //图片imageView
    UIImage *aimage;
    if (myDelegate.electroweakImageArr.count) {
        CameraModel* model;
        if (myDelegate.isRelease) {//本地加载,则使用和网络层一样的属性的图,
            model = myDelegate.electroweakImageArr[0];
            if([model.a_device isEqualToString:@"localios"]){
                aimage = [UIImage imageWithData:[GTMBase64 decodeString:model.a_body]];
            }else{
                aimage = [UIImage imageWithData:[GTMBase64 decodeString:model.a_imgCompressionContent]];
            }

        }else{
            model=myDelegate.imgDic[@"electroweakImageArr"];
            aimage = [UIImage imageWithData:[GTMBase64 decodeString:model.a_body]];
        }

//        if([model.a_device isEqualToString:@"localios"]){
//            aimage = [UIImage imageWithData:[GTMBase64 decodeString:model.a_body]];
//        }else{
//            aimage = [UIImage imageWithData:[GTMBase64 decodeString:model.a_imgCompressionContent]];
//        }
    }else{
        aimage=[UIImage imageNamed:@"首页_16.png"];
    }
    UIImageView* imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 215.5)];
    //myDelegate.horizonImageArr;
    imageView.image=aimage;
    [view addSubview:imageView];
    
    
    //图片数量label
    UILabel* label=[[UILabel alloc]initWithFrame:CGRectMake(0, 160, 70, 30)];
    label.text=[NSString stringWithFormat:@"%d张",imageNumber];
    label.textAlignment=NSTextAlignmentCenter;
    label.textColor=[UIColor whiteColor];
    label.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:.7];
    [view addSubview:label];
    
    //添加选中图片时的触发
    if (myDelegate.electroweakImageArr.count) {
        myDelegate.fourthStageButton1=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 320, 215.5)];
        [myDelegate.fourthStageButton1 addTarget:myDelegate action:@selector(userChangeImageWithButtons:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:myDelegate.fourthStageButton1];
    }
}

+(void)getFirstView{
    /*
     *
     *
     *以下为第一个大view,  地平阶段
     *
     *
     */
    //图片imageView
    [self getImageView:myDelegate.electroweakImageArr.count];
    
    for (int i=0; i<3; i++) {
        //项目名称部分
        UILabel* programName=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320*1.0/3, 45)];
        programName.center=CGPointMake(320*1.0/3*(i+.5), height+22.5);
        programName.text=@[@"弱电安装",@"装修情况",@"装修进度"][i];
        programName.font=[UIFont systemFontOfSize:16];
        programName.textAlignment=NSTextAlignmentCenter;
        [totalView addSubview:programName];
        
        //项目地点部分
        UILabel* areaLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320*1.0/3, 45)];
        areaLabel.center=CGPointMake(320*1.0/3*(i+.5), height+42.5);
        areaLabel.text=@[dataDic[@"electroweakInstallation"],dataDic[@"decorationSituation"],dataDic[@"decorationProgress"]][i];
        areaLabel.font=[UIFont systemFontOfSize:14];
        areaLabel.textColor=RGBCOLOR(125, 125, 125);
        areaLabel.textAlignment=NSTextAlignmentCenter;
        [totalView addSubview:areaLabel];
    }
    height+=20+45;
    //3个小2行label
    
}

//+(UIView*)getSeperatedLine{
//    UIView* view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 290, 1)];
//    view.backgroundColor=[UIColor grayColor];
//
//    return view;
//}

////竖着的3个view,联系人,职位,地点,单位,手机
//+(UIView*)personLable:(NSString*)name job:(NSString*)job firstStr:(NSString*)firstStr secondStr:(NSString*)secondStr tel:(NSString*)tel sequence:(int)sequence{
//    UIView* view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 150)];
//
//    //分割线1
//    if (sequence!=0) {
//        UIView* line1=[self getSeperatedLine];
//        line1.center=CGPointMake(160, 10);
//        [view addSubview:line1];
//    }
//
//    //名字
//    UILabel* labelName=[[UILabel alloc]initWithFrame:CGRectMake(20, 20, 200, 40)];
//    labelName.text=name;
//    labelName.textAlignment=NSTextAlignmentLeft;
//    labelName.textColor=RGBCOLOR(82, 125, 237);
//    labelName.font=[UIFont systemFontOfSize:17];
//    [view addSubview:labelName];
//
//    //职位
//    UILabel* jobLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 50, 150, 30)];
//    jobLabel.text=job;
//    jobLabel.font=[UIFont systemFontOfSize:14];
//    [view addSubview:jobLabel];
//
//    //单位名称
//    UILabel* companyNameLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 70, 250, 30)];
//    companyNameLabel.text=firstStr;
//    companyNameLabel.textColor=[UIColor grayColor];
//    companyNameLabel.textAlignment=NSTextAlignmentLeft;
//    companyNameLabel.font=[UIFont systemFontOfSize:14];
//    [view addSubview:companyNameLabel];
//
//    //地址
//    UILabel* addressLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 90, 250, 30)];
//    addressLabel.text=secondStr;
//    addressLabel.textColor=[UIColor grayColor];
//    addressLabel.textAlignment=NSTextAlignmentLeft;
//    addressLabel.font=[UIFont systemFontOfSize:14];
//    [view addSubview:addressLabel];
//
//    //电话图标
//    UIImageView* imageView=[[UIImageView alloc]initWithFrame:CGRectMake(190, 40, 25, 25)];
//    imageView.image=[UIImage imageNamed:@"地图搜索_01.png"];
//    [view addSubview:imageView];
//
//    //电话号码
//    UILabel* label=[[UILabel alloc]initWithFrame:CGRectMake(215, 40, 100, 25)];
//    label.text=tel;
//    label.font=[UIFont systemFontOfSize:14];
//    label.textColor=[UIColor grayColor];
//    [view addSubview:label];
//
//    return view;
//}

//显示一个2行字的label
+(UIView*)twoLineLable:(NSString*)firstStr secondStr:(NSString*)secondStr{
    UIView* view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320*1.0/3, 50)];
    
    UILabel* firstLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320*1.0/3, 25)];
    firstLabel.text=firstStr;
    firstLabel.textColor=RGBCOLOR(82, 125, 237);
    firstLabel.textAlignment=NSTextAlignmentCenter;
    [view addSubview:firstLabel];
    
    UILabel* secondLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 25, 320*1.0/3, 25)];
    secondLabel.text=secondStr;
    secondLabel.textColor=[UIColor grayColor];
    secondLabel.textAlignment=NSTextAlignmentCenter;
    [view addSubview:secondLabel];
    
    return view;
}

//+(UIView*)getProgramViewWithTitleImage:(UIImage*)titleImage stageTitle:(NSString*)stageTitle programTitle:(NSArray*)programTitle address:(NSArray*)address detailAddress:(NSArray*)detailAddress{
//
//    //项目title及项目名称的画布
//    CGFloat  tempHeight=175;
//    if (!detailAddress) {
//        tempHeight-=50;
//    }
//    if (!programTitle) {
//        tempHeight-=65;
//    }
//    UIView* titleView=[[UIView alloc]initWithFrame:CGRectMake(0, height, 320, tempHeight)];
//    titleView.backgroundColor=RGBCOLOR(229, 229, 229);
//    height+=tempHeight;
//
//    ///title部分
//    //图片
//    UIImageView* imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 18.5, 18.5)];
//    imageView.center=CGPointMake(160, 9.25+10);
//    imageView.image=titleImage;
//    [titleView addSubview:imageView];
//    //title部分
//    UILabel* tuDiLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 50)];
//    tuDiLabel.center=CGPointMake(160, 45);
//    tuDiLabel.text=stageTitle;
//    tuDiLabel.font=[UIFont systemFontOfSize:16];
//    tuDiLabel.textAlignment=NSTextAlignmentCenter;
//    tuDiLabel.textColor=RGBCOLOR(82, 125, 237);
//    [titleView addSubview:tuDiLabel];
//    //==================================
//
//    if (programTitle) {
//        //分割线1
//        UIView* line1=[self getSeperatedLine];
//        line1.center=CGPointMake(160, 65);
//        [titleView addSubview:line1];
//
//        for (int i=0; i<programTitle.count; i++) {
//            //项目名称部分
//            UILabel* programName=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 50)];
//            programName.center=CGPointMake(320*1.0/programTitle.count*(i+.5), 85);
//            programName.text=programTitle[i];
//            programName.font=[UIFont systemFontOfSize:16];
//            programName.textAlignment=NSTextAlignmentCenter;
//            [titleView addSubview:programName];
//
//            //项目地点部分
//            UILabel* areaLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 50)];
//            areaLabel.center=CGPointMake(320*1.0/programTitle.count*(i+.5), 115);
//            areaLabel.text=address[i];
//            areaLabel.font=[UIFont systemFontOfSize:14];
//            areaLabel.textColor=RGBCOLOR(125, 125, 125);
//            areaLabel.textAlignment=NSTextAlignmentCenter;
//            [titleView addSubview:areaLabel];
//        }
//    }
//
//    //项目详细地点
//    if (detailAddress) {
//        UILabel* areaDetailLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 70)];
//        areaDetailLabel.text=detailAddress[0];
//        areaDetailLabel.center=CGPointMake(160, 155);
//        areaDetailLabel.numberOfLines=2;
//        areaDetailLabel.textColor=[UIColor grayColor];
//        areaDetailLabel.font=[UIFont systemFontOfSize:15];
//        areaDetailLabel.textAlignment=NSTextAlignmentCenter;
//        [titleView addSubview:areaDetailLabel];
//    }
//    return titleView;
//}
@end
