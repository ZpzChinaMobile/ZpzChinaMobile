//
//  TuDiXinXi.m
//  programDetail
//
//  Created by 孙元侃 on 14-8-7.
//  Copyright (c) 2014年 sunyk. All rights reserved.
//

#import "TuDiXinXi.h"
@implementation TuDiXinXi
static CGFloat height = 0;//统计总高
static UIView* totalView;
static ProgramDetailViewController* myDelegate;

+(UIView*)tuDiXinXiWithFirstViewHeight:(CGFloat*)firstViewHeight delegate:(ProgramDetailViewController*)delegate {
    //totalView初始
    totalView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 0)];
    totalView.backgroundColor=[UIColor whiteColor];
    
    //把programVC掉过来给属性赋值，用于知道是哪个imageView被点击了
    myDelegate=delegate;
    
    //获得第一个大view,  土地规划/拍卖模块
    [self getFirstView];
    *firstViewHeight=height;
    [self getSecondView];
    
    
    totalView.frame=CGRectMake(0, 0, 320, height);
    return totalView;
}

+(void)getSecondView{
    [totalView addSubview:[self getProgramViewWithTitleImage:[UIImage imageNamed:@"XiangMuXiangQing/map_01.png"] stageTitle:@"项目立项" programTitle:@"项目名称显示在这里" address:@"上海 虹口 广粤路汶水东路路口" detailAddress:@"项目描述写在这里,项目描述写在这里,项目描述写在这里,项目描述写在这里"]];
    

    //建立6个共2行的label
    NSArray* ary1=@[@[@"预计开工时间",@"建筑层高",@"外资参与"],@[@"预计竣工时间",@"投资额",@"建筑面积"]];
    NSArray* ary2=@[@[@"2012-12-12",@"10023M",@"Yes"],@[@"2014-12-12",@"10023.000",@"12345㎡"]];
    for (int k=0; k<2; k++) {
        for (int i=0; i<3; i++) {
            UIView* tempView=[self twoLineLable:ary1[k][i] secondStr:ary2[k][i]];
            tempView.center=CGPointMake(tempView.frame.size.width*(i+.5), height+30) ;
            [totalView addSubview:tempView];
        }
        height+=60;
    }
    
    //联系人信息3个label
    NSArray* array1=@[@"赵某某",@"孙某某",@"习某某"];
    NSArray* array2=@[@"项目经理",@"项目总监",@"项目监督"];
    NSArray* array3=@[@"00业主单位-中技桩业有限公司",@"11业主单位-中技桩业有限公司",@"22业主单位-中技桩业有限公司"];
    NSArray* array4=@[@"00地址:上海市 虹口区 汶水东路928号",@"11地址:上海市 虹口区 汶水东路928号",@"22地址:上海市 虹口区 汶水东路928号"];
    NSArray* array5=@[@"18888888888",@"13988888888",@"13888888888"];
    for (int i=0; i<3; i++) {
        UIView* tempView=[self personLable:array1[i] job:array2[i] firstStr:array3[i] secondStr:array4[i] tel:array5[i]];
        [totalView addSubview:tempView];
        tempView.center=CGPointMake(160, height+60);
        height+=120;
    }

    UIImageView* imageView=[[UIImageView alloc]initWithFrame:CGRectMake(15, height+5, 21, 21)];
    imageView.image=[UIImage imageNamed:@"XiangMuXiangQing/logo@2x.png"];
    [totalView addSubview:imageView];
    
    UILabel* label=[[UILabel alloc]initWithFrame:CGRectMake(45, height+5, 200, 25)];
    label.text=@"外商独资";
    label.font=[UIFont systemFontOfSize:17];
    [totalView addSubview:label];
    height+=40;
    
}

+(void)getImageView:(NSInteger)imageNumber{
    UIView* view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 215.5)];
    view.center=CGPointMake(160, height+107.75);
    [totalView addSubview:view];
    height+=215.5;

    //图片imageView
    UIImageView* imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 215.5)];
    imageView.image=[UIImage imageNamed:@"XiangMuXiangQing/picture.png"];
    [view addSubview:imageView];
    
    //图片数量label
    UILabel* label=[[UILabel alloc]initWithFrame:CGRectMake(0, 120, 70, 30)];
    label.text=[NSString stringWithFormat:@"%ld张",imageNumber];
    label.textAlignment=NSTextAlignmentCenter;
    label.textColor=[UIColor whiteColor];
    label.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:.3];
    [view addSubview:label];
    
    //添加选中图片时的触发
    myDelegate.firstStageButton1=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 320, 215.5)];
    [myDelegate.firstStageButton1 addTarget:myDelegate action:@selector(userChangeImageWithButtons:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:myDelegate.firstStageButton1];
}



+(void)getFirstView{
    /*
     *
     *
     *以下为第一个大view,  土地规划/拍卖模块
     *
     *
     */
    
    //项目名称view
    [totalView addSubview:[self getProgramViewWithTitleImage:[UIImage imageNamed:@"XiangMuXiangQing/map_01.png"] stageTitle:@"土地规划/拍卖" programTitle:@"上海中技桩业项目名称" address:@"华东区 上海市 虹口区" detailAddress:@"广粤路汶水东路路口 广粤路10000号2栋 麦德龙对面 显示两行限制在两行内显示"]];
    
    //图片imageView
    [self getImageView:72];
    
    //建立3个2行的label
    NSArray* ary1=@[@"土地面积",@"土地容积率",@"地图用途"];
    NSArray* ary2=@[@"20000㎡",@"78%",@"酒店及餐饮"];
    for (int i=0; i<3; i++) {
        UIView* tempView=[self twoLineLable:ary1[i] secondStr:ary2[i]];
        tempView.center=CGPointMake(tempView.frame.size.width*(i+.5), height+30) ;
        [totalView addSubview:tempView];
    }
    height+=60;
    
    //联系人信息3个label
    NSArray* array1=@[@"赵某某",@"孙某某",@"习某某"];
    NSArray* array2=@[@"项目经理",@"项目总监",@"项目监督"];
    NSArray* array3=@[@"00拍卖单位-中技桩业有限公司",@"11拍卖单位-中技桩业有限公司",@"22拍卖单位-中技桩业有限公司"];
    NSArray* array4=@[@"00地址:上海市 虹口区 汶水东路928号",@"11地址:上海市 虹口区 汶水东路928号",@"22地址:上海市 虹口区 汶水东路928号"];
    NSArray* array5=@[@"18888888888",@"13988888888",@"13888888888"];
    for (int i=0; i<3; i++) {
        UIView* tempView=[self personLable:array1[i] job:array2[i] firstStr:array3[i] secondStr:array4[i] tel:array5[i]];
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
+(UIView*)personLable:(NSString*)name job:(NSString*)job firstStr:(NSString*)firstStr secondStr:(NSString*)secondStr tel:(NSString*)tel{
    UIView* view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 120)];
    
    //分割线1
    UIView* line1=[self getSeperatedLine];
    line1.center=CGPointMake(160, 1);
    [view addSubview:line1];
    
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

//显示一个2行字的label
+(UIView*)twoLineLable:(NSString*)firstStr secondStr:(NSString*)secondStr{
    UIView* view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320*1.0/3, 60)];
    
    UILabel* firstLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 10, 320*1.0/3, 25)];
    firstLabel.text=firstStr;
    firstLabel.textColor=RGBCOLOR(82, 125, 237);
    firstLabel.font=[UIFont systemFontOfSize:14];
    firstLabel.textAlignment=NSTextAlignmentCenter;
    [view addSubview:firstLabel];
    
    
    UILabel* secondLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 33, 320*1.0/3, 20)];
    secondLabel.text=secondStr;
    secondLabel.textColor=RGBCOLOR(125, 125, 125);
    secondLabel.font=[UIFont systemFontOfSize:14];
    secondLabel.textAlignment=NSTextAlignmentCenter;
    [view addSubview:secondLabel];
    
    return view;
}

+(UIView*)getProgramViewWithTitleImage:(UIImage*)titleImage stageTitle:(NSString*)stageTitle programTitle:(NSString*)programTitle address:(NSString*)address detailAddress:(NSString*)detailAddress{

    //项目title及项目名称的画布
    UIView* titleView=[[UIView alloc]initWithFrame:CGRectMake(0, height, 320, 175)];
    titleView.backgroundColor=RGBCOLOR(229, 229, 229);
    NSLog(@"%f",height);
    height+=175;
    
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
    
    //项目名称部分
    UILabel* programName=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    programName.center=CGPointMake(160, 85);
    programName.text=programTitle;
    programName.font=[UIFont systemFontOfSize:18];
    programName.textAlignment=NSTextAlignmentCenter;
    [titleView addSubview:programName];
    
    //项目地点部分
    UILabel* areaLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    areaLabel.center=CGPointMake(160, 115);
    areaLabel.text=address;
    areaLabel.font=[UIFont systemFontOfSize:14];
    areaLabel.textAlignment=NSTextAlignmentCenter;
    [titleView addSubview:areaLabel];
    
    //项目详细地点
    UILabel* areaDetailLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 280, 50)];
    areaDetailLabel.text=detailAddress;
    areaDetailLabel.center=CGPointMake(160, 145);
    areaDetailLabel.numberOfLines=2;
    areaDetailLabel.textColor=RGBCOLOR(125, 125, 125);
    areaDetailLabel.font=[UIFont systemFontOfSize:13];
    areaDetailLabel.textAlignment=NSTextAlignmentCenter;
    [titleView addSubview:areaDetailLabel];
    
    
    return titleView;
}
@end
