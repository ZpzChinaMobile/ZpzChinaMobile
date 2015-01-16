//
//  ZhuTiSheJi.m
//  programDetail
//
//  Created by 孙元侃 on 14-8-7.
//  Copyright (c) 2014年 sunyk. All rights reserved.
//

#import "ZhuTiSheJi.h"
#import "CameraModel.h"
#import "GTMBase64.h"
#import "MyView.h"
#import "StringRule.h"

@implementation ZhuTiSheJi
static CGFloat height = 0;//统计总高
static __weak ProgramDetailViewController* myDelegate;
static UIView* totalView;
static NSDictionary* dataDic;

+(void)myDealloc{
    totalView=nil;
    dataDic=nil;
}

+(UIView*)zhuTiSheJiWithFirstViewHeight:(CGFloat*)firstViewHeight secondView:(CGFloat*)secondViewHeight delegate:(ProgramDetailViewController*)delegate{
    //数值初始
    height=0;
    totalView=nil;
    
    //totalView初始
    totalView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 0)];
    totalView.backgroundColor=[UIColor whiteColor];
    
    //设置委托
    myDelegate=delegate;
    dataDic=myDelegate.dataDic;
    
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
    //获取预计施工时间以及预计竣工时间
    NSMutableArray* timeArray=[NSMutableArray array];
    NSArray* timeTempArray=@[dataDic[@"expectedStartTime"],dataDic[@"expectedFinishTime"]];
    for (int i=0; i<2; i++) {
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSString *confromTimespStr ;
        if (![timeTempArray[i] isEqualToString:@""]) {
            NSDate* confromTimesp = [NSDate dateWithTimeIntervalSince1970:[@[dataDic[@"expectedStartTime"],dataDic[@"expectedFinishTime"]][i] intValue]];
            confromTimespStr = [formatter stringFromDate:confromTimesp];
        }else {
            confromTimespStr=@"";
        }
        [timeArray addObject:confromTimespStr];
    }
    
    [totalView addSubview:[self getProgramViewWithTitleImage:[GetImagePath getImagePath:@"icon02"] stageTitle:@"出图阶段" programTitle:@[@"预计施工时间",@"预计竣工时间"] address:timeArray detailAddress:nil]];
    
    //3个联系人Label
    NSArray* array1=myDelegate.ownerAry;
    for (int i=0,j=myDelegate.ownerAry.count; i<3; i++) {
        UIView* tempView;
        if (j) {
            tempView=[self personLable:array1[i][@"contactName"] job:array1[i][@"duties"] firstStr:array1[i][@"accountName"] secondStr:array1[i][@"accountAddress"] tel:array1[i][@"mobilePhone"] sequence:i contactCategory:@"业主单位："];
            j--;
        }else {
            tempView=[self personLable:@"" job:@"" firstStr:@"" secondStr:@"" tel:@"" sequence:i contactCategory:@"业主单位："];
        }
        
        [totalView addSubview:tempView];
        tempView.center=CGPointMake(160, height+tempView.frame.size.height*.5);
        height+=tempView.frame.size.height;
    }
    
    
    //电梯,空调,供暖方式,外墙材料,钢结构,yes or no的几个view
    NSArray* tempAry=@[@"电梯",@"空调",@"供暖方式",@"外墙材料",@"钢结构"];
    NSArray* tempArray=@[dataDic[@"propertyElevator"],dataDic[@"propertyAirCondition"],dataDic[@"propertyHeating"],dataDic[@"propertyExternalWallMeterial"],dataDic[@"propertyStealStructure"]];
    for (int i=0; i<tempAry.count; i++) {
        UIView* view=[[UIView alloc]initWithFrame:CGRectMake(0, height, 320, 35)];
        
        //电梯,空调,供暖方式,外墙材料,钢结构 的label
        UILabel* label=[[UILabel alloc]initWithFrame:CGRectMake(15, 0, 150, 35)];
        label.text=tempAry[i];
        label.font=[UIFont systemFontOfSize:14];
        [view addSubview:label];
        
        //yes or no的label
        UILabel* label1=[[UILabel alloc]initWithFrame:CGRectMake(255, 0, 50, 35)];
        label1.text=[tempArray[i] isEqualToString:@"1"]?@"YES":@"NO";
        label1.font=[UIFont systemFontOfSize:14];
        label1.textAlignment=NSTextAlignmentRight;
        label1.textColor=[tempArray[i] isEqualToString:@"1"]?[UIColor redColor]:[UIColor grayColor];
        [view addSubview:label1];
        
        //分割线
        UIView* separatorLine=[self getSeperatedLine];
        separatorLine.center=CGPointMake(160, 1);
        [view addSubview:separatorLine];
        
        
        [totalView addSubview:view];
        height+=35;
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
    [totalView addSubview:[self getProgramViewWithTitleImage:[GetImagePath getImagePath:@"icon02"] stageTitle:@"设计阶段" programTitle:@[@"主体设计阶段"] address:@[dataDic[@"mainDesignStage"]] detailAddress:nil]];
    
    NSArray* array1=myDelegate.designAry;
    for (int i=0,j=myDelegate.designAry.count; i<3; i++) {
        UIView* tempView;
        if (j) {
            tempView=[self personLable:array1[i][@"contactName"] job:array1[i][@"duties"] firstStr:array1[i][@"accountName"] secondStr:array1[i][@"accountAddress"] tel:array1[i][@"mobilePhone"] sequence:i contactCategory:@"设计院："];
            j--;
        }else {
            tempView=[self personLable:@"" job:@"" firstStr:@"" secondStr:@"" tel:@"" sequence:i contactCategory:@"设计院："];
        }
        
        [totalView addSubview:tempView];
        tempView.center=CGPointMake(160, height+tempView.frame.size.height*.5);
        height+=tempView.frame.size.height;
    }
}

+(UIImage*)saveImage:(UIView*)view{
    UIGraphicsBeginImageContext(CGSizeMake(view.bounds.size.width, view.bounds.size.height));
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return viewImage;
}


+(void)getImageView:(NSInteger)imageNumber{
    UIView* view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 215.5)];
    view.center=CGPointMake(160, height+107.75);
    [totalView addSubview:view];
    height+=215.5;
    
    //图片imageView
    MyView* imageView=[[MyView alloc]init];
    imageView.frame=CGRectMake(0, 0, 320, 215.5);
    imageView.layer.masksToBounds=YES;
    imageView.backgroundColor=[UIColor grayColor];
    [imageView observeImage];
    if (myDelegate.explorationImageArr.count) {
        CameraModel *model= myDelegate.explorationImageArr[0];
        if (model.isNewImage) {
            imageView.myImageView.image=[UIImage imageWithData:[GTMBase64 decodeString:model.a_body]];
        }else{
            imageView.myImageView.imageURL=[NSURL URLWithString:[NSString stringWithFormat:@"%s%@",imageAddress,model.a_body]];
        }
    }

    [view addSubview:imageView];
    
    //图片数量label
    UILabel* label=[[UILabel alloc]initWithFrame:CGRectMake(0, 160, 70, 30)];
    label.text=[NSString stringWithFormat:@"%d张",imageNumber];
    label.textAlignment=NSTextAlignmentCenter;
    label.textColor=[UIColor whiteColor];
    label.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:.7];
    [view addSubview:label];
    
    //添加选中图片时的触发
    if (myDelegate.explorationImageArr.count) {
        myDelegate.secondStageButton1=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 320, 215.5)];
        [myDelegate.secondStageButton1 addTarget:myDelegate action:@selector(userChangeImageWithButtons:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:myDelegate.secondStageButton1];
    }
    
}

+(void)getFirstView{
    /*
     *
     *
     *以下为第一个大view,  地勘阶段
     *
     *
     */
    
    [totalView addSubview:[self getProgramViewWithTitleImage:[GetImagePath getImagePath:@"icon02"] stageTitle:@"地勘阶段" programTitle:nil address:nil detailAddress:nil]];
    
    //图片imageView
    [self getImageView:myDelegate.explorationImageArr.count];
    
    //联系人信息3个label
    NSArray* array1=myDelegate.explorationAry;
    for (int i=0,j=myDelegate.explorationAry.count; i<3; i++) {
        UIView* tempView;
        if (j) {
            tempView=[self personLable:array1[i][@"contactName"] job:array1[i][@"duties"] firstStr:array1[i][@"accountName"] secondStr:array1[i][@"accountAddress"] tel:array1[i][@"mobilePhone"] sequence:i contactCategory:@"地勘公司："];
            j--;
        }else {
            tempView=[self personLable:@"" job:@"" firstStr:@"" secondStr:@"" tel:@"" sequence:i contactCategory:@"地勘公司："];
        }
        
        [totalView addSubview:tempView];
        tempView.center=CGPointMake(160, height+tempView.frame.size.height*.5);
        height+=tempView.frame.size.height;
    }
    
    
}

+(UIView*)getSeperatedLine{
    UIView* view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 295, 1)];
    view.backgroundColor=RGBCOLOR(206, 206, 206);
    
    return view;
}


//竖着的3个view,联系人,职位,地点,单位,手机
+(UIView*)personLable:(NSString*)name job:(NSString*)job firstStr:(NSString*)firstStr secondStr:(NSString*)secondStr tel:(NSString*)tel sequence:(int)sequence contactCategory:(NSString*)contactCategory{
    UIView* view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 150)];
    
    //分割线1
    if (sequence!=0) {
        UIView* line1=[self getSeperatedLine];
        line1.center=CGPointMake(160, 1);
        [view addSubview:line1];
    }
    
    BOOL hasData=![name isEqualToString:@""];
    //名字
    UILabel* labelName=[[UILabel alloc]initWithFrame:CGRectMake(12.5, 10, 295, 40)];
    labelName.text=hasData?name:@"姓名";
    labelName.textAlignment=NSTextAlignmentLeft;
    labelName.textColor=hasData?RGBCOLOR(82, 125, 237):NoDataColor;
    labelName.font=titleFont;
    [view addSubview:labelName];
    
    //职位
    hasData=![job isEqualToString:@""];
    UILabel* jobLabel=[[UILabel alloc]initWithFrame:CGRectMake(12.5, 40, 130, 30)];
    jobLabel.text=hasData?job:@"职位";
    jobLabel.textColor=hasData?[UIColor blackColor]:NoDataColor;
    jobLabel.font=contentFont;
    [view addSubview:jobLabel];
    
    //单位名称
    CGSize size=[contactCategory boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:contentFont} context:nil].size;
    
    UILabel* companyName=[[UILabel alloc]initWithFrame:CGRectMake(12.5, 60, size.width, 30)];
    companyName.text=contactCategory;
    companyName.textColor=HasDataColor;
    companyName.font=contentFont;
    [view addSubview:companyName];
    
    hasData=![firstStr isEqualToString:@""];
    CGFloat orginX=companyName.frame.origin.x+companyName.frame.size.width-5;
    UITextView* companyNameLabel=[[UITextView alloc]initWithFrame:CGRectMake(orginX, 59, 317.5-orginX, 50)];
    companyNameLabel.text=hasData?firstStr:Heng;
    companyNameLabel.textColor=hasData?HasDataColor:NoDataColor;
    companyNameLabel.textAlignment=NSTextAlignmentLeft;
    companyNameLabel.textContainer.maximumNumberOfLines=2;
    companyNameLabel.selectable=NO;
    companyNameLabel.backgroundColor=[UIColor clearColor];
    companyNameLabel.contentInset=UIEdgeInsetsMake(0, 0, 0, 0);
    companyNameLabel.textContainer.lineBreakMode=NSLineBreakByTruncatingTail;
    companyNameLabel.font=contentFont;
    [view addSubview:companyNameLabel];
    
    
    //地址
    UILabel* addressName=[[UILabel alloc]initWithFrame:CGRectMake(12.5, 95, 70, 30)];
    addressName.text=@"单位地址：";
    addressName.textColor=HasDataColor;
    addressName.font=contentFont;
    [view addSubview:addressName];
    
    hasData=![firstStr isEqualToString:@""];
    UITextView* addressLabel=[[UITextView alloc]initWithFrame:CGRectMake(77.5, 94, 240, 50)];
    addressLabel.text=hasData?secondStr:Heng;
    addressLabel.textColor=hasData?HasDataColor:NoDataColor;
    addressLabel.textAlignment=NSTextAlignmentLeft;
    addressLabel.textContainer.maximumNumberOfLines=2;
    addressLabel.selectable=NO;
    addressLabel.backgroundColor=[UIColor clearColor];
    addressLabel.contentInset=UIEdgeInsetsMake(0, 0, 0, 0);
    addressLabel.textContainer.lineBreakMode=NSLineBreakByTruncatingTail;
    addressLabel.font=contentFont;
    [view addSubview:addressLabel];
    
    //电话图标
    UIImageView* imageView=[[UIImageView alloc]initWithFrame:CGRectMake(148, 49, 12.5, 12.5)];
    imageView.image=[GetImagePath getImagePath:@"021"];
    [view addSubview:imageView];
    
    //电话号码
    hasData=![tel isEqualToString:@""];
    UILabel* label=[[UILabel alloc]initWithFrame:CGRectMake(163, 43, 150, 25)];
    label.text=hasData?tel:Heng;
    label.font=contentFont;
    label.textColor=hasData?HasDataColor:NoDataColor;
    [view addSubview:label];
    
    return view;
}

+(UIView*)getProgramViewWithTitleImage:(UIImage*)titleImage stageTitle:(NSString*)stageTitle programTitle:(NSArray*)programTitle address:(NSArray*)address detailAddress:(NSArray*)detailAddress{
    BOOL onlyTitle=!programTitle&&!address&&!detailAddress;
    CGFloat tempHeight;
    if (onlyTitle) {
        tempHeight=65;
    }else{
        tempHeight=detailAddress?175:125;
    }
    
    //项目title及项目名称的画布
    UIView* titleView=[[UIView alloc]initWithFrame:CGRectMake(0, height, 320, tempHeight)];
    titleView.backgroundColor=RGBCOLOR(229, 229, 229);
    
    height+=tempHeight;
    
    //阴影
    UIImageView* shadow=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 3.5)];
    shadow.image=[GetImagePath getImagePath:@"Shadow-bottom"];
    [titleView addSubview:shadow];
    
    ///title部分
    //图片
    UIImageView* imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 16, 16)];
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
    
    if (!onlyTitle) {
        //分割线1
        UIView* line1=[self getSeperatedLine];
        line1.center=CGPointMake(160, 65);
        [titleView addSubview:line1];
    }
    
    for (int i=0; i<programTitle.count; i++) {
        //项目名称部分
        UILabel* programName=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 50)];
        programName.center=CGPointMake(320*1.0/programTitle.count*(i+.5), 85);
        programName.text=programTitle[i];
        programName.font=[UIFont systemFontOfSize:16];
        programName.textAlignment=NSTextAlignmentCenter;
        [titleView addSubview:programName];
        
        //项目地点部分
        BOOL hasData=![address[i] isEqualToString:@""];
        UILabel* areaLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 50)];
        areaLabel.center=CGPointMake(320*1.0/programTitle.count*(i+.5), 105);
        areaLabel.text=[StringRule hasContent:address[i]];
        areaLabel.font=[UIFont systemFontOfSize:14];
        areaLabel.textColor=hasData?HasDataColor:NoDataColor;
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
