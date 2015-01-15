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
#import "MyView.h"
#import "StringRule.h"

@implementation ZhuangXiu

static CGFloat height = 0;//统计总高
static __weak ProgramDetailViewController* myDelegate;
static UIView* totalView;
static NSDictionary* dataDic;

+(void)myDealloc{
    totalView=nil;
    dataDic=nil;
}

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
    
    if (myDelegate.electroweakImageArr.count) {
        CameraModel *model= myDelegate.electroweakImageArr[0];
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
@end
