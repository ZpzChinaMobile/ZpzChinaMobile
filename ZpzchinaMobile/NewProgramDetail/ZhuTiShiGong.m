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
#import "MyView.h"
#import "StringRule.h"

@implementation ZhuTiShiGong
static NSDictionary* dataDic;

static CGFloat height = 0;//统计总高
static UIView* totalView;
static __weak ProgramDetailViewController* myDelegate;

+(void)myDealloc{
    totalView=nil;
    dataDic=nil;
}

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

+(UIImage*)saveImage:(UIView*)view{
    UIGraphicsBeginImageContext(CGSizeMake(view.bounds.size.width, view.bounds.size.height));
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return viewImage;
}


+(void)getImageView:(NSInteger)imageNumber imageViewSequence:(int)sequence{
    UIView* view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 215.5)];
    view.center=CGPointMake(160, height+107.75);
    [totalView addSubview:view];
    height+=215.5;
    
    //图片imageView
    NSMutableArray* tempImageArr;
    if(sequence==1&&myDelegate.horizonImageArr.count){
        tempImageArr=myDelegate.horizonImageArr;
    }else if (sequence==2&&myDelegate.pilePitImageArr.count){
        tempImageArr=myDelegate.pilePitImageArr;
    }else if(sequence==3&&imageNumber){
        tempImageArr=[[myDelegate.mainConstructionImageArr arrayByAddingObjectsFromArray:myDelegate.fireControlImageArr] mutableCopy];
    }

    MyView* imageView=[[MyView alloc]init];
    imageView.frame=CGRectMake(0, 0, 320, 215.5);
    imageView.layer.masksToBounds=YES;
    imageView.backgroundColor=[UIColor grayColor];
    [imageView observeImage];
    
    if (tempImageArr.count) {
        CameraModel *model= tempImageArr[0];
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
    
    if (sequence==1&&myDelegate.horizonImageArr.count) {
        myDelegate.thirdStageButton1=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 320, 215.5)];
        [myDelegate.thirdStageButton1 addTarget:myDelegate action:@selector(userChangeImageWithButtons:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:myDelegate.thirdStageButton1];
    }else if(sequence==2&&myDelegate.pilePitImageArr.count){
        myDelegate.thirdStageButton2=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 320, 215.5)];
        [myDelegate.thirdStageButton2 addTarget:myDelegate action:@selector(userChangeImageWithButtons:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:myDelegate.thirdStageButton2];
        
    }else if(sequence==3&&tempImageArr.count){
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
    [totalView addSubview:[self getProgramViewWithTitleImage:[GetImagePath getImagePath:@"icon03"] stageTitle:@"消防/景观绿化" programTitle:nil address:nil detailAddress:nil]];
    
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
        areaLabel.text=@[[StringRule hasContent:dataDic[@"fireControl"]],[StringRule hasContent:dataDic[@"green"]]][i];
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
    [totalView addSubview:[self getProgramViewWithTitleImage:[GetImagePath getImagePath:@"icon03"] stageTitle:@"主体施工" programTitle:nil address:nil detailAddress:nil]];
    
    //图片imageView
    [self getImageView:myDelegate.mainConstructionImageArr.count+myDelegate.fireControlImageArr.count imageViewSequence:3];
}

+(void)getSecondView{
    /*
     *
     *
     *以下为第二个大view,  桩基基坑
     *
     *
     */
    [totalView addSubview:[self getProgramViewWithTitleImage:[GetImagePath getImagePath:@"icon03"] stageTitle:@"桩基基坑" programTitle:nil address:nil detailAddress:nil]];
    
    //图片imageView
    [self getImageView:myDelegate.pilePitImageArr.count imageViewSequence:2];
    
    
    //联系人信息3个label
    NSArray* array1=myDelegate.pileAry;
    for (int i=0,j=myDelegate.pileAry.count; i<3; i++) {
        UIView* tempView;
        if (j) {
            tempView=[self personLable:array1[i][@"contactName"] job:array1[i][@"duties"] firstStr:array1[i][@"accountName"] secondStr:array1[i][@"accountAddress"] tel:array1[i][@"mobilePhone"] sequence:i contactCategory:@"桩基分包单位："];
            j--;
        }else {
            tempView=[self personLable:@"" job:@"" firstStr:@"" secondStr:@"" tel:@"" sequence:i contactCategory:@"桩基分包单位："];
        }
        
        [totalView addSubview:tempView];
        tempView.center=CGPointMake(160, height+tempView.frame.size.height*.5);
        height+=tempView.frame.size.height;
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
    if ([dataDic[@"actualStartTime"] isEqualToString:@""]||[dataDic[@"actualStartTime"] isEqualToString:@"/Date(0+0800)/"]) {
        confromTimespStr=@"";
    }else{
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSDate* confromTimesp = [NSDate dateWithTimeIntervalSince1970:[dataDic[@"actualStartTime"] intValue]];
        confromTimespStr = [formatter stringFromDate:confromTimesp];
    }
    
    
    [totalView addSubview:[self getProgramViewWithTitleImage:[GetImagePath getImagePath:@"icon03"] stageTitle:@"地平阶段" programTitle:@[@"实际开工时间"] address:@[confromTimespStr] detailAddress:nil]];
    
    //图片view
    [self getImageView:myDelegate.horizonImageArr.count imageViewSequence:1];
    
    //联系人信息3个label
    NSArray* array1=myDelegate.horizonAry;
    for (int i=0,j=myDelegate.horizonAry.count; i<3; i++) {
        UIView* tempView;
        if (j) {
            tempView=[self personLable:array1[i][@"contactName"] job:array1[i][@"duties"] firstStr:array1[i][@"accountName"] secondStr:array1[i][@"accountAddress"] tel:array1[i][@"mobilePhone"] sequence:i contactCategory:@"施工总承包单位："];
            j--;
        }else {
            tempView=[self personLable:@"" job:@"" firstStr:@"" secondStr:@"" tel:@"" sequence:i contactCategory:@"施工总承包单位："];
        }
        
        [totalView addSubview:tempView];
        tempView.center=CGPointMake(160, height+tempView.frame.size.height*.5);
        height+=tempView.frame.size.height;
    }}

+(UIView*)getSeperatedLine{
    UIView* view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 295, 1)];
    view.backgroundColor=RGBCOLOR(206, 206, 206);
    
    return view;
}

//竖着的3个view,联系人,职位,地点,单位,手机
+(UIView*)personLable:(NSString*)name job:(NSString*)job firstStr:(NSString*)firstStr secondStr:(NSString*)secondStr tel:(NSString*)tel sequence:(int)sequence contactCategory:(NSString*)contactCategory{
    UIView* view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 150)];
    
    //分割线1
    UIView* line1=[self getSeperatedLine];
    line1.center=CGPointMake(160, 1);
    [view addSubview:line1];
    
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
            BOOL hasData=![address[i] isEqualToString:@""];
            UILabel* areaLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 50)];
            areaLabel.center=CGPointMake(320*1.0/programTitle.count*(i+.5), 105);
            areaLabel.text=[StringRule hasContent:address[i]];
            areaLabel.font=[UIFont systemFontOfSize:14];
            areaLabel.textColor=hasData?HasDataColor:NoDataColor;
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
