//
//  ZhuTiShiGong.m
//  programDetail
//
//  Created by 孙元侃 on 14-8-7.
//  Copyright (c) 2014年 sunyk. All rights reserved.
//

#import "ZhuTiShiGong.h"
#import "CameraModel.h"
#import "GTMBase64.h"
@implementation ZhuTiShiGong
static NSDictionary* dataDic;

static CGFloat height = 0;//统计总高
static UIView* totalView;
static __weak ProgramDetailViewController* myDelegate;
+(UIView*)zhuTiShiGongWithFirstViewHeight:(CGFloat*)firstViewHeight secondView:(CGFloat*)secondViewHeight thirdViewHeight:(CGFloat*)thirdViewHeight delegate:(ProgramDetailViewController*)delegate{
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
    *firstViewHeight=height;
    
    //获得第二个大view,桩基基坑
    [self getSecondView];
    *secondViewHeight=height;
    
    //获得第三个大view,主体施工
    [self getThirdView];
    *thirdViewHeight=height;
    
    //获得第四个大view,消防/景观绿化
    [self getFourthView];
    
    totalView.frame=CGRectMake(0, 0, 320, height);
    return totalView;
}

+(void)getImageView:(NSInteger)imageNumber imageViewSequence:(int)sequence{
    UIView* view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 215.5)];
    view.center=CGPointMake(160, height+107.75);
    [totalView addSubview:view];
    height+=215.5;
    
    //图片imageView
    
    
    UIImage *aimage;
    CameraModel *model;
    if(sequence==1&&myDelegate.horizonImageArr.count){
        if (myDelegate.isRelease) {//本地加载,则使用和网络层一样的属性的图,
            model = myDelegate.horizonImageArr[0];
            if([model.a_device isEqualToString:@"localios"]){
                aimage = [UIImage imageWithData:[GTMBase64 decodeString:model.a_body]];
            }else{
                aimage = [UIImage imageWithData:[GTMBase64 decodeString:model.a_imgCompressionContent]];
            }
        }else{
            model=myDelegate.imgDic[@"horizonImageArr"];
            aimage = [UIImage imageWithData:[GTMBase64 decodeString:model.a_body]];
        }
        
    }else if (sequence==2&&myDelegate.pilePitImageArr.count){
        if (myDelegate.isRelease) {//本地加载,则使用和网络层一样的属性的图,
            model = myDelegate.pilePitImageArr[0];
            if([model.a_device isEqualToString:@"localios"]){
                aimage = [UIImage imageWithData:[GTMBase64 decodeString:model.a_body]];
            }else{
                aimage = [UIImage imageWithData:[GTMBase64 decodeString:model.a_imgCompressionContent]];
            }
        }else{
            model=myDelegate.imgDic[@"pilePitImageArr"];
            aimage = [UIImage imageWithData:[GTMBase64 decodeString:model.a_body]];
        }
       
    }else if(sequence==3&&myDelegate.mainConstructionImageArr.count){
        NSLog(@"mainConstructionImageArr%d",myDelegate.mainConstructionImageArr.count);
        if (myDelegate.isRelease) {//本地加载,则使用和网络层一样的属性的图,
            model = myDelegate.mainConstructionImageArr[0];
            if([model.a_device isEqualToString:@"localios"]){
                aimage = [UIImage imageWithData:[GTMBase64 decodeString:model.a_body]];
            }else{
                aimage = [UIImage imageWithData:[GTMBase64 decodeString:model.a_imgCompressionContent]];
            }
        }else{
            model=myDelegate.imgDic[@"mainConstructionImageArr"];
            aimage = [UIImage imageWithData:[GTMBase64 decodeString:model.a_body]];
        }
        
    }else{
        aimage=[UIImage imageNamed:@"首页_16.png"];
    }
    UIImageView* imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 215.5)];
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
    
    if (sequence==1&&myDelegate.horizonImageArr.count) {
        myDelegate.thirdStageButton1=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 320, 215.5)];
        [myDelegate.thirdStageButton1 addTarget:myDelegate action:@selector(userChangeImageWithButtons:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:myDelegate.thirdStageButton1];
    }else if(sequence==2&&myDelegate.pilePitImageArr.count){
        myDelegate.thirdStageButton2=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 320, 215.5)];
        [myDelegate.thirdStageButton2 addTarget:myDelegate action:@selector(userChangeImageWithButtons:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:myDelegate.thirdStageButton2];
        
    }else if(sequence==3&&myDelegate.mainConstructionImageArr.count){
        myDelegate.thirdStageButton3=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 320, 215.5)];
        [myDelegate.thirdStageButton3 addTarget:myDelegate action:@selector(userChangeImageWithButtons:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:myDelegate.thirdStageButton3];
    }
}

+(void)getFourthView{
    /*
     *
     *
     *以下为第四个大view,  消防/景观绿化
     *
     *
     */
    [totalView addSubview:[self getProgramViewWithTitleImage:[UIImage imageNamed:@"XiangMuXiangQing_2/Subject_02@2x.png"] stageTitle:@"消防/景观绿化" programTitle:nil address:nil detailAddress:nil]];
    
    for (int i=0; i<2; i++) {
        //项目名称部分
        UILabel* programName=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 45)];
        programName.center=CGPointMake(320*1.0/2*(i+.5), height+22.5);
        programName.text=@[@"消防",@"景观绿化"][i];
        programName.font=[UIFont systemFontOfSize:16];
        programName.textAlignment=NSTextAlignmentCenter;
        [totalView addSubview:programName];
        
        //项目地点部分
        UILabel* areaLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 45)];
        areaLabel.center=CGPointMake(320*1.0/2*(i+.5), height+42.5);
        areaLabel.text=@[dataDic[@"fireControl"],dataDic[@"green"]][i];
        areaLabel.font=[UIFont systemFontOfSize:14];
        areaLabel.textColor=RGBCOLOR(125, 125, 125);
        areaLabel.textAlignment=NSTextAlignmentCenter;
        [totalView addSubview:areaLabel];
    }
    height+=20+45;
}

+(void)getThirdView{
    /*
     *
     *
     *以下为第三个大view,  主体施工
     *
     *
     */
    [totalView addSubview:[self getProgramViewWithTitleImage:[UIImage imageNamed:@"XiangMuXiangQing_2/Subject_02@2x.png"] stageTitle:@"主体施工" programTitle:nil address:nil detailAddress:nil]];
    
    //图片imageView
    [self getImageView:myDelegate.mainConstructionImageArr.count imageViewSequence:3];
}

+(void)getSecondView{
    /*
     *
     *
     *以下为第二个大view,  桩基基坑
     *
     *
     */
    [totalView addSubview:[self getProgramViewWithTitleImage:[UIImage imageNamed:@"XiangMuXiangQing_2/Subject_02@2x.png"] stageTitle:@"桩基基坑" programTitle:nil address:nil detailAddress:nil]];
    
    //图片imageView
    [self getImageView:myDelegate.pilePitImageArr.count imageViewSequence:2];
    
    
    //联系人信息3个label
    NSArray* array1=myDelegate.pileAry;
    for (int i=0,j=myDelegate.pileAry.count; i<3; i++) {
        UIView* tempView;
        if (j) {
            tempView=[self personLable:array1[i][@"contactName"] job:array1[i][@"duties"] firstStr:array1[i][@"accountName"] secondStr:array1[i][@"accountAddress"] tel:array1[i][@"mobilePhone"] sequence:i];
            j--;
        }else {
            tempView=[self personLable:@[@"联系人",@"联系人",@"联系人"][i] job:@[@"职位",@"职位",@"职位"][i] firstStr:@[@"单位名称",@"单位名称",@"单位名称"][i] secondStr:@[@"单位地址",@"单位地址",@"单位地址"][i] tel:@[@"",@"",@""][i] sequence:i];
        }
        
        [totalView addSubview:tempView];
        tempView.center=CGPointMake(160, height+60);
        height+=120;
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
    //获取预计施工时间以及预计竣工时间
    NSString *confromTimespStr;
    if (![dataDic[@"actualStartTime"] isEqualToString:@""]) {
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSDate* confromTimesp = [NSDate dateWithTimeIntervalSince1970:[dataDic[@"actualStartTime"] intValue]];
        confromTimespStr = [formatter stringFromDate:confromTimesp];
    }else{
        confromTimespStr=@"";
    }
    
    
    [totalView addSubview:[self getProgramViewWithTitleImage:[UIImage imageNamed:@"XiangMuXiangQing_2/Subject_02@2x.png"] stageTitle:@"地平阶段" programTitle:@[@"实际开工时间"] address:@[confromTimespStr] detailAddress:nil]];
    
    //图片view
    [self getImageView:myDelegate.horizonImageArr.count imageViewSequence:1];
    
    //联系人信息3个label
    NSArray* array1=myDelegate.horizonAry;
    for (int i=0,j=myDelegate.horizonAry.count; i<3; i++) {
        UIView* tempView;
        if (j) {
            tempView=[self personLable:array1[i][@"contactName"] job:array1[i][@"duties"] firstStr:array1[i][@"accountName"] secondStr:array1[i][@"accountAddress"] tel:array1[i][@"mobilePhone"] sequence:i];
            j--;
        }else {
            tempView=[self personLable:@[@"联系人",@"联系人",@"联系人"][i] job:@[@"职位",@"职位",@"职位"][i] firstStr:@[@"单位名称",@"单位名称",@"单位名称"][i] secondStr:@[@"单位地址",@"单位地址",@"单位地址"][i] tel:@[@"",@"",@""][i] sequence:i];
        }
        
        [totalView addSubview:tempView];
        tempView.center=CGPointMake(160, height+60);
        height+=120;
    }}

+(UIView*)getSeperatedLine{
    UIView* view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 290, 1)];
    view.backgroundColor=RGBCOLOR(206, 206, 206);
    
    return view;
}

//竖着的3个view,联系人,职位,地点,单位,手机
+(UIView*)personLable:(NSString*)name job:(NSString*)job firstStr:(NSString*)firstStr secondStr:(NSString*)secondStr tel:(NSString*)tel sequence:(int)sequence{
    UIView* view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 120)];
    
    //分割线1
    if (sequence!=0) {
        UIView* line1=[self getSeperatedLine];
        line1.center=CGPointMake(160, 1);
        [view addSubview:line1];
    }
    
    //名字
    UILabel* labelName=[[UILabel alloc]initWithFrame:CGRectMake(20, 10, 200, 40)];
    labelName.text=name;
    labelName.textAlignment=NSTextAlignmentLeft;
    labelName.textColor=RGBCOLOR(82, 125, 237);
    labelName.font=[UIFont systemFontOfSize:15];
    [view addSubview:labelName];
    
    //职位
    UILabel* jobLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 40, 150, 30)];
    jobLabel.text=job;
    jobLabel.font=[UIFont systemFontOfSize:14];
    [view addSubview:jobLabel];
    
    //单位名称
    UILabel* companyNameLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 60, 250, 30)];
    companyNameLabel.text=firstStr;
    companyNameLabel.textColor=[UIColor grayColor];
    companyNameLabel.textAlignment=NSTextAlignmentLeft;
    companyNameLabel.font=[UIFont systemFontOfSize:14];
    [view addSubview:companyNameLabel];
    
    //地址
    UILabel* addressLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 80, 250, 30)];
    addressLabel.text=secondStr;
    addressLabel.textColor=[UIColor grayColor];
    addressLabel.textAlignment=NSTextAlignmentLeft;
    addressLabel.font=[UIFont systemFontOfSize:14];
    [view addSubview:addressLabel];
    
    //电话图标
    UIImageView* imageView=[[UIImageView alloc]initWithFrame:CGRectMake(197, 46, 12.5, 12.5)];
    imageView.image=[UIImage imageNamed:@"XiangMuXiangQing/phone@2x.png"];
    [view addSubview:imageView];
    
    //电话号码
    UILabel* label=[[UILabel alloc]initWithFrame:CGRectMake(215, 41, 100, 25)];
    label.text=tel;
    label.font=[UIFont systemFontOfSize:14];
    label.textColor=[UIColor grayColor];
    [view addSubview:label];
    
    return view;
}


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
//    jobLabel.font=[UIFont boldSystemFontOfSize:15];
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
//    UIImageView* imageView=[[UIImageView alloc]initWithFrame:CGRectMake(197, 46, 12.5, 12.5)];
//    imageView.image=[UIImage imageNamed:@"XiangMuXiangQing_2/phone@2x.png"];
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

+(UIView*)getProgramViewWithTitleImage:(UIImage*)titleImage stageTitle:(NSString*)stageTitle programTitle:(NSArray*)programTitle address:(NSArray*)address detailAddress:(NSArray*)detailAddress{
    
    //项目title及项目名称的画布
    CGFloat  tempHeight=190;
    if (!detailAddress) {
        tempHeight-=60;
    }
    if (!programTitle) {
        tempHeight-=65;
    }
    UIView* titleView=[[UIView alloc]initWithFrame:CGRectMake(0, height, 320, tempHeight)];
    titleView.backgroundColor=RGBCOLOR(229, 229, 229);
    height+=tempHeight;
    
    ///title部分
    //图片
    UIImageView* imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 18.5, 18.5)];
    imageView.center=CGPointMake(160, 9.25+10);
    imageView.image=titleImage;
    [titleView addSubview:imageView];
    //title部分
    UILabel* tuDiLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 50)];
    tuDiLabel.center=CGPointMake(160, 45);
    tuDiLabel.text=stageTitle;
    tuDiLabel.font=[UIFont systemFontOfSize:16];
    tuDiLabel.textAlignment=NSTextAlignmentCenter;
    tuDiLabel.textColor=RGBCOLOR(82, 125, 237);
    [titleView addSubview:tuDiLabel];
    //==================================
    
    if (programTitle) {
        //分割线1
        UIView* line1=[self getSeperatedLine];
        line1.center=CGPointMake(160, 65);
        [titleView addSubview:line1];
        
        for (int i=0; i<programTitle.count; i++) {
            //项目名称部分
            UILabel* programName=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 50)];
            programName.center=CGPointMake(320*1.0/programTitle.count*(i+.5), 85);
            programName.text=programTitle[i];
            programName.font=[UIFont systemFontOfSize:16];
            programName.textAlignment=NSTextAlignmentCenter;
            [titleView addSubview:programName];
            
            //项目地点部分
            UILabel* areaLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 50)];
            areaLabel.center=CGPointMake(320*1.0/programTitle.count*(i+.5), 105);
            areaLabel.text=address[i];
            areaLabel.font=[UIFont systemFontOfSize:14];
            areaLabel.textColor=RGBCOLOR(125, 125, 125);
            areaLabel.textAlignment=NSTextAlignmentCenter;
            [titleView addSubview:areaLabel];
        }
    }
    
    //项目详细地点
    if (detailAddress) {
        UILabel* areaDetailLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 70)];
        areaDetailLabel.text=detailAddress[0];
        areaDetailLabel.center=CGPointMake(160, 155);
        areaDetailLabel.numberOfLines=2;
        areaDetailLabel.textColor=[UIColor grayColor];
        areaDetailLabel.font=[UIFont systemFontOfSize:15];
        areaDetailLabel.textAlignment=NSTextAlignmentCenter;
        [titleView addSubview:areaDetailLabel];
    }
    return titleView;
}

@end
