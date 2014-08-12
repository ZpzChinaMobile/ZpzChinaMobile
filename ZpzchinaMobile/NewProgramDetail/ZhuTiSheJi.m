//
//  ZhuTiSheJi.m
//  programDetail
//
//  Created by 孙元侃 on 14-8-7.
//  Copyright (c) 2014年 sunyk. All rights reserved.
//

#import "ZhuTiSheJi.h"
@implementation ZhuTiSheJi
static CGFloat height = 0;//统计总高
static ProgramDetailViewController* myDelegate;
UIView* totalView;

+(UIView*)zhuTiSheJiWithFirstViewHeight:(CGFloat*)firstViewHeight secondView:(CGFloat*)secondViewHeight delegate:(ProgramDetailViewController*)delegate{
    //totalView初始
    totalView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 0)];
    totalView.backgroundColor=[UIColor whiteColor];
    
    //设置委托
    myDelegate=delegate;
    
    //获得第一个大view, 地勘阶段
    [self getFirstView];
    *firstViewHeight=height;
    
    //获得第二个大view,设计阶段
    [self getSecondView];
    *secondViewHeight=height;
    
    //获得第三个大biew,出图阶段
    [self getThirdView];
    
    totalView.frame=CGRectMake(0, 0, 320, height);
    return totalView;
}

+(void)getThirdView{
    /*
     *
     *
     *以下为第三个大view,  出图阶段
     *
     *
     */
    [totalView addSubview:[self getProgramViewWithTitleImage:[UIImage imageNamed:@"XiangMuXiangQing_1/pen_02@2x.png"] stageTitle:@"出图阶段" programTitle:@[@"预计施工时间",@"预计竣工时间"] address:@[@"2012-12-12",@"2014-12-12"] detailAddress:nil]];

    //联系人信息3个label
    NSArray* array1=@[@"赵某某",@"孙某某",@"习某某"];
    NSArray* array2=@[@"项目经理",@"项目总监",@"项目监督"];
    NSArray* array3=@[@"00业主单位-中技桩业有限公司",@"11业主单位-中技桩业有限公司",@"22业主单位-中技桩业有限公司"];
    NSArray* array4=@[@"00地址:上海市 虹口区 汶水东路928号",@"11地址:上海市 虹口区 汶水东路928号",@"22地址:上海市 虹口区 汶水东路928号"];
    NSArray* array5=@[@"18888888888",@"13988888888",@"13888888888"];
    for (int i=0; i<3; i++) {
        UIView* tempView=[self personLable:array1[i] job:array2[i] firstStr:array3[i] secondStr:array4[i] tel:array5[i] sequence:i];
        [totalView addSubview:tempView];
        tempView.center=CGPointMake(160, height+60);
        height+=120;
    }

    
    //电梯,空调,供暖方式,外墙材料,钢结构,yes or no的几个view
    NSArray* tempAry=@[@"电梯",@"空调",@"供暖方式",@"外墙材料",@"钢结构"];
    BOOL tempArray[5]={YES,NO,NO,YES,YES};
    for (int i=0; i<tempAry.count; i++) {
        UIView* view=[[UIView alloc]initWithFrame:CGRectMake(0, height, 320, 30)];
        
        //电梯,空调,供暖方式,外墙材料,钢结构 的label
        UILabel* label=[[UILabel alloc]initWithFrame:CGRectMake(20, 5, 150, 20)];
        label.text=tempAry[i];
        label.font=[UIFont systemFontOfSize:14];
        [view addSubview:label];
        
        //yes or no的label
        UILabel* label1=[[UILabel alloc]initWithFrame:CGRectMake(250, 5, 50, 20)];
        label1.text=tempArray[i]?@"YES":@"NO";
        label1.font=[UIFont systemFontOfSize:14];
        label1.textAlignment=NSTextAlignmentRight;
        label1.textColor=tempArray[i]?[UIColor redColor]:[UIColor grayColor];
        [view addSubview:label1];
        
        //分割线
        UIView* separatorLine=[self getSeperatedLine];
        separatorLine.center=CGPointMake(160, 1);
        [view addSubview:separatorLine];
        
        
        [totalView addSubview:view];
        height+=30;
    }
    
}

+(void)getSecondView{
    /*
     *
     *
     *以下为第二个大view,  设计阶段
     *
     *
     */
    [totalView addSubview:[self getProgramViewWithTitleImage:[UIImage imageNamed:@"XiangMuXiangQing_1/pen_02@2x.png"] stageTitle:@"设计阶段" programTitle:@[@"主体设计阶段"] address:@[@"结构"] detailAddress:nil]];
    
    //联系人信息3个label
    NSArray* array1=@[@"赵某某",@"孙某某",@"习某某"];
    NSArray* array2=@[@"项目经理",@"项目总监",@"项目监督"];
    NSArray* array3=@[@"00业主单位-中技桩业有限公司",@"11业主单位-中技桩业有限公司",@"22业主单位-中技桩业有限公司"];
    NSArray* array4=@[@"00地址:上海市 虹口区 汶水东路928号",@"11地址:上海市 虹口区 汶水东路928号",@"22地址:上海市 虹口区 汶水东路928号"];
    NSArray* array5=@[@"18888888888",@"13988888888",@"13888888888"];
    for (int i=0; i<3; i++) {
        UIView* tempView=[self personLable:array1[i] job:array2[i] firstStr:array3[i] secondStr:array4[i] tel:array5[i] sequence:i];
        [totalView addSubview:tempView];
        tempView.center=CGPointMake(160, height+60);
        height+=120;
    }
}

+(void)getImageView:(NSInteger)imageNumber{
    UIView* view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 215.5)];
    view.center=CGPointMake(160, height+107.75);
    [totalView addSubview:view];
    height+=215.5;
    
    //图片imageView
    UIImageView* imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 215.5)];
    imageView.image=[UIImage imageNamed:@"XiangMuXiangQing_1/picture.png"];
    [view addSubview:imageView];
    
    //图片数量label
    UILabel* label=[[UILabel alloc]initWithFrame:CGRectMake(0, 120, 70, 30)];
    label.text=[NSString stringWithFormat:@"%ld张",imageNumber];
    label.textAlignment=NSTextAlignmentCenter;
    label.textColor=[UIColor whiteColor];
    label.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:.3];
    [view addSubview:label];
    
    //添加选中图片时的触发
    myDelegate.secondStageButton1=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 320, 215.5)];
    [myDelegate.secondStageButton1 addTarget:myDelegate action:@selector(userChangeImageWithButtons:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:myDelegate.secondStageButton1];
    
}

+(void)getFirstView{
    /*
     *
     *
     *以下为第一个大view,  地勘阶段
     *
     *
     */
    
    //图片imageView
    [self getImageView:22];
    
    //联系人信息3个label
    NSArray* array1=@[@"赵某某",@"孙某某",@"习某某"];
    NSArray* array2=@[@"项目经理",@"项目总监",@"项目监督"];
    NSArray* array3=@[@"00拍卖单位-中技桩业有限公司",@"11拍卖单位-中技桩业有限公司",@"22拍卖单位-中技桩业有限公司"];
    NSArray* array4=@[@"00地址:上海市 虹口区 汶水东路928号",@"11地址:上海市 虹口区 汶水东路928号",@"22地址:上海市 虹口区 汶水东路928号"];
    NSArray* array5=@[@"18888888888",@"13988888888",@"13888888888"];
    for (int i=0; i<3; i++) {
        UIView* tempView=[self personLable:array1[i] job:array2[i] firstStr:array3[i] secondStr:array4[i] tel:array5[i] sequence:i];
        [totalView addSubview:tempView];
        tempView.center=CGPointMake(160, height+60);
        height+=120;
    }
    
}

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

+(UIView*)getProgramViewWithTitleImage:(UIImage*)titleImage stageTitle:(NSString*)stageTitle programTitle:(NSArray*)programTitle address:(NSArray*)address detailAddress:(NSArray*)detailAddress{
    
    //项目title及项目名称的画布
    UIView* titleView=[[UIView alloc]initWithFrame:CGRectMake(0, height, 320, detailAddress?175:125)];
    titleView.backgroundColor=RGBCOLOR(229, 229, 229);
    height+=detailAddress?175:125;
    
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
