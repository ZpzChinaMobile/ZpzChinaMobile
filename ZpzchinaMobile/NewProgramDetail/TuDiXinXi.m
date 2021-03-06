//
//  TuDiXinXi.m
//  programDetail
//
//  Created by 孙元侃 on 14-8-7.
//  Copyright (c) 2014年 sunyk. All rights reserved.
//

#import "TuDiXinXi.h"
#import "CameraModel.h"
#import "GTMBase64.h"
#import "EGOImageView.h"
#import "MyView.h"
#import "StringRule.h"
@interface TuDiXinXi(){
    CGFloat height;
    NSDictionary* dataDic;
}

//@property(nonatomic)CGFloat height;
@property(nonatomic,weak)ProgramDetailViewController* myDelegate;
//@property(nonatomic,strong)NSDictionary* dataDic;
@end

@implementation TuDiXinXi
//static CGFloat height;//统计总高
//static UIView* totalView;
//static __weak ProgramDetailViewController* myDelegate;
//static NSDictionary* dataDic;

+(void)myDealloc{

}

-(void)dealloc{
    NSLog(@"tudixinxi Dealloc");
}

+(TuDiXinXi*)tuDiXinXiWithFirstViewHeight:(CGFloat*)firstViewHeight delegate:(ProgramDetailViewController*)delegate{
    TuDiXinXi* view=[[TuDiXinXi alloc]initWithFrame:CGRectMake(0, 0, 320, 0)];
    return [view getWithFirstViewHeight:firstViewHeight delegate:delegate];
}

-(TuDiXinXi*)getWithFirstViewHeight:(CGFloat*)firstViewHeight delegate:(ProgramDetailViewController*)delegate {
    self.backgroundColor=[UIColor whiteColor];
    
    //数值初始
    height=0;
    
    //把programVC掉过来给属性赋值，用于知道是哪个imageView被点击了
    self.myDelegate=delegate;
    
    dataDic=self.myDelegate.dataDic;
    
    //获得第一个大view,  土地规划/拍卖模块
    [self getFirstView];
    *firstViewHeight=height;
    [self getSecondView];

    
    self.frame=CGRectMake(0, 0, 320, height);
    return self;
}

-(void)getSecondView{
    UIImageView* shadow=[[UIImageView alloc]initWithFrame:CGRectMake(0, height, 320, 3.5)];
    shadow.image=[GetImagePath getImagePath:@"Shadow-bottom"];
    [self addSubview:shadow];
    
    [self addSubview:[self getProgramViewWithTitleImage:[GetImagePath getImagePath:@"icon01"] stageTitle:@"项目立项" programTitle:dataDic[@"projectName"] address:[NSString stringWithFormat:@"%@ %@ %@",dataDic[@"city"],dataDic[@"district"],dataDic[@"landAddress"]] detailAddress:dataDic[@"description"]]];
    [self bringSubviewToFront:shadow];
    
    
    //获取预计施工时间以及预计竣工时间
    NSMutableArray* tempAry=[NSMutableArray array];
    NSArray* timeTempArray=@[dataDic[@"expectedStartTime"],dataDic[@"expectedFinishTime"]];
    for (int i=0; i<2; i++) {
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSString *confromTimespStr ;
        NSDate* confromTimesp = [NSDate dateWithTimeIntervalSince1970:[timeTempArray[i] intValue]];
        if([timeTempArray[i] isEqualToString:@""]||[timeTempArray[i] isEqualToString:@"/Date(0+0800)/"]){
            confromTimespStr = @"";
        }else{
            confromTimespStr = [formatter stringFromDate:confromTimesp];
        }
        [tempAry addObject:confromTimespStr];
    }
    
    //建立6个共2行的label
    NSArray* ary1=@[@[@"预计开工时间",@"建筑层高(层)",@"外资参与"],@[@"预计竣工时间",@"投资额(百万)",@"建筑面积(㎡)"]];
    NSArray* ary2=@[@[tempAry[0],[NSString stringWithFormat:@"%@",dataDic[@"storeyHeight"]],[dataDic[@"foreignInvestment"] isEqualToString:@"1"]?@"Yes":@"No"],@[tempAry[1],[NSString stringWithFormat:@"%@",dataDic[@"investment"]],[NSString stringWithFormat:@"%@",dataDic[@"areaOfStructure"]]]];
    
    for (int k=0; k<2; k++) {
        for (int i=0; i<3; i++) {
            UIView* tempView=[self twoLineLable:ary1[k][i] secondStr:ary2[k][i] line:k sequence:i];
            tempView.center=CGPointMake(tempView.frame.size.width*(i+.5), height+30) ;
            [self addSubview:tempView];
        }
        height+=60;
    }
    
    //联系人信息3个label
    NSArray* array1=self.myDelegate.ownerAry;
    for (int i=0,j=self.myDelegate.ownerAry.count; i<3; i++) {
        UIView* tempView;
        if (j) {
            tempView=[self personLable:array1[i][@"contactName"] job:array1[i][@"duties"] firstStr:array1[i][@"accountName"] secondStr:array1[i][@"accountAddress"] tel:array1[i][@"mobilePhone"] contactCategory:@"业主单位："];
            j--;
        }else {
            tempView=[self personLable:@"" job:@"" firstStr:@"" secondStr:@"" tel:@"" contactCategory:@"业主单位："];
        }
        
        [self addSubview:tempView];
        tempView.center=CGPointMake(160, height+tempView.frame.size.height*.5);
        height+=tempView.frame.size.height;
    }
    
    
    UIView* tempView=[self getOwnerTypeViewWithImage:[GetImagePath getImagePath:@"07"] owners:[dataDic[@"ownerType"] componentsSeparatedByString:@","]];
    CGRect frame=tempView.frame;
    frame.origin.y=height;
    tempView.frame=frame;
    
    [self addSubview:tempView];
    height+=tempView.frame.size.height;
}

-(UIView*)getOwnerTypeViewWithImage:(UIImage*)image owners:(NSArray*)owners{
    UIView* view=[[UIView alloc]initWithFrame:CGRectZero];
    view.backgroundColor=[UIColor whiteColor];
    
    UIImageView* imageView=[[UIImageView alloc]initWithFrame:CGRectMake(15, 0, 20, 20)];//CGRectMake(15, height+5, 21, 21)];
    imageView.image=image;
    [view addSubview:imageView];
    
    for (int i=0; i<owners.count; i++) {
        UILabel* label=[[UILabel alloc]initWithFrame:CGRectMake(45+i%4*((307.5-45)*1.0/4), i/4*18+2, 200, 18)];//CGRectMake(45, height+5, 200, 25)];
        label.textColor=[owners[0] isEqualToString:@""]?NoDataColor:[UIColor blackColor];
        label.text=[StringRule hasUserTypeContent:(i==owners.count-1)?owners[i]:[owners[i] stringByAppendingString:@"，"]];
        label.font=contentFont;
        [view addSubview:label];
    }
    
    view.frame=CGRectMake(0, 0, 320, 38+2);//35+(owners.count>0?(owners.count-1)/3*30:0));
    return view;
}

-(UIImage*)saveImage:(UIView*)view{
    UIGraphicsBeginImageContext(CGSizeMake(view.bounds.size.width, view.bounds.size.height));
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return viewImage;
}

-(void)getImageView:(NSInteger)imageNumber{
    UIView* view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 215.5)];
    view.center=CGPointMake(160, height+107.75);
    [self addSubview:view];
    height+=215.5;
    
    //图片imageView
    MyView* imageView=[[MyView alloc]init];
    imageView.frame=CGRectMake(0, 0, 320, 215.5);
    imageView.layer.masksToBounds=YES;
    imageView.backgroundColor=[UIColor grayColor];
    [imageView observeImage];
    if (self.myDelegate.planImageArr.count) {
        CameraModel *model= self.myDelegate.planImageArr[0];
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
    if (self.myDelegate.planImageArr.count) {
        self.myDelegate.firstStageButton1=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 320, 215.5)];
        self.myDelegate.firstStageButton1.tag=0;
        [self.myDelegate.firstStageButton1 addTarget:self.myDelegate action:@selector(userChangeImageWithButtons:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:self.myDelegate.firstStageButton1];
    }
}

//第一行蓝，第二行黑，专门为土地信息做的view
-(UIView*)getBlueThreeTypesTwoLinesWithFirstStr:(NSArray*)firstStrs secondStr:(NSArray*)secondStrs{
    UIView* view=[[UIView alloc]initWithFrame:CGRectZero];
    view.backgroundColor=[UIColor whiteColor];
    
    CGRect bounds;
    
    for (int i=0; i<2; i++) {
        NSInteger count=i?2:i;
        
        UILabel* firstLabel=[[UILabel alloc]initWithFrame:CGRectMake(12.5, 10+i*60, 84, 20)];
        firstLabel.text=i?firstStrs[count]:[StringRule isZero:firstStrs[count]];
        firstLabel.textColor=RGBCOLOR(82, 125, 237);
        firstLabel.font=titleFont;
        firstLabel.textAlignment=NSTextAlignmentLeft;
        [view addSubview:firstLabel];
        
        if (i) {
            bounds=[secondStrs[count] boundingRectWithSize:CGSizeMake( 280, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:contentFont} context:nil];
        }
        BOOL hasData=![secondStrs[count] isEqualToString:i?@"":@"0"];
        UILabel* secondLabel=[[UILabel alloc]initWithFrame:CGRectMake(12.5, 30+i*60, i?280:84, i?bounds.size.height+5:20)];
        secondLabel.text=i?[StringRule hasContent:secondStrs[count]]:[StringRule isZero:secondStrs[count]];
        secondLabel.numberOfLines=0;
        secondLabel.textColor=hasData?HasDataColor:NoDataColor;
        secondLabel.font=contentFont;
        secondLabel.textAlignment=i?NSTextAlignmentLeft:NSTextAlignmentCenter;
        [view addSubview:secondLabel];
    }
    UILabel* firstLabel=[[UILabel alloc]initWithFrame:CGRectMake(180, 10, 160, 20)];
    firstLabel.text=firstStrs[1];
    firstLabel.textColor=RGBCOLOR(82, 125, 237);
    firstLabel.font=titleFont;
    firstLabel.textAlignment=NSTextAlignmentCenter;
    [view addSubview:firstLabel];
    
    BOOL hasData=![secondStrs[1] isEqualToString:@""];
    UILabel* secondLabel=[[UILabel alloc]initWithFrame:CGRectZero];
    secondLabel.text=[StringRule isZero:secondStrs[1]];
    secondLabel.numberOfLines=0;
    secondLabel.textColor=hasData?HasDataColor:NoDataColor;
    secondLabel.font=contentFont;
    secondLabel.textAlignment=NSTextAlignmentCenter;
   
    secondLabel.frame=CGRectMake(180, 30, 160, 20);
    [view addSubview:secondLabel];
    
    view.frame=CGRectMake(0, 0, 320, 120+bounds.size.height-15);
    return view;
}


-(void)getFirstView{
    /*
     *
     *
     *以下为第一个大view,  土地规划/拍卖模块
     *
     *
     */
    //项目名称view
    [self addSubview:[self getProgramViewWithTitleImage:[GetImagePath getImagePath:@"icon01"] stageTitle:@"土地规划/拍卖" programTitle:dataDic[@"landName"] address:[NSString stringWithFormat:@"%@ %@ %@",dataDic[@"province"],dataDic[@"city"],dataDic[@"district"]] detailAddress:dataDic[@"landAddress"]]];
    
    NSLog(@"city=%@ description=%@ district=%@ landAddress=%@ landName=%@ ownerType=%@ projectName=%@ usage=%@ province=%@",dataDic[@"city"],dataDic[@"description"],dataDic[@"district"],dataDic[@"landAddress"],dataDic[@"landName"],dataDic[@"ownerType"],dataDic[@"projectName"],dataDic[@"usage"],dataDic[@"province"]);
    //图片imageView
    [self getImageView:self.myDelegate.planImageArr.count];
    
    //建立3个2行的label
    NSArray* ary1=@[@"土地面积(㎡)",@"土地容积率",@"地块用途"];
    NSArray* ary2=@[dataDic[@"area"],dataDic[@"plotRatio"],dataDic[@"usage"]];
    UIView* tempViewNew=[self getBlueThreeTypesTwoLinesWithFirstStr:ary1 secondStr:ary2];
    CGRect tempFrame=tempViewNew.frame;
    tempFrame.origin.y=height;
    tempViewNew.frame=tempFrame;
    [self addSubview:tempViewNew];
    height+=tempViewNew.frame.size.height;
    
    NSArray* array1=self.myDelegate.contactAry;
    for (int i=0,j=self.myDelegate.contactAry.count; i<3; i++) {
        UIView* tempView;
        if (j) {
            tempView=[self personLable:array1[i][@"contactName"] job:array1[i][@"duties"] firstStr:array1[i][@"accountName"] secondStr:array1[i][@"accountAddress"] tel:array1[i][@"mobilePhone"] contactCategory:@"拍卖单位："];
            j--;
        }else{
            tempView=[self personLable:@"" job:@"" firstStr:@"" secondStr:@"" tel:@"" contactCategory:@"拍卖单位："];
        }
        
        [self addSubview:tempView];
        tempView.center=CGPointMake(160, height+tempView.frame.size.height*.5);
        height+=tempView.frame.size.height;
    }
}

-(UIView*)getSeperatedLine{
    UIView* view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 295, 1)];
    view.backgroundColor=RGBCOLOR(206, 206, 206);
    
    return view;
}

//竖着的3个view,联系人,职位,地点,单位,手机
-(UIView*)personLable:(NSString*)name job:(NSString*)job firstStr:(NSString*)firstStr secondStr:(NSString*)secondStr tel:(NSString*)tel contactCategory:(NSString*)contactCategory
{
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
-(UIView*)twoLineLable:(NSString*)firstStr secondStr:(NSString*)secondStr line:(NSInteger)line sequence:(NSInteger)sequence{
    UIView* view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320*1.0/3, 60)];
    
    UILabel* firstLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 10, 320*1.0/3, 25)];
    firstLabel.text=firstStr;
    firstLabel.textColor=RGBCOLOR(82, 125, 237);
    firstLabel.font=[UIFont systemFontOfSize:15];
    firstLabel.textAlignment=NSTextAlignmentCenter;
    [view addSubview:firstLabel];
    
    
    UILabel* secondLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 33, 320*1.0/3, 20)];
    BOOL hasData=YES;
    if ((line==0&&sequence==0)||(line==1&&sequence==0)) {
        secondLabel.text=[StringRule hasContent:secondStr];
        hasData=![secondStr isEqualToString:@""];
    }else if ((line==0&&sequence==1)||(line==1&&sequence==1)||(line==1&&sequence==2)){
        secondLabel.text=[StringRule isZero:secondStr];
        hasData=![secondStr isEqualToString:@"0"];
    }else{
        secondLabel.text=secondStr;
    }
    secondLabel.textColor=hasData?HasDataColor:NoDataColor;
    secondLabel.font=[UIFont systemFontOfSize:14];
    secondLabel.textAlignment=NSTextAlignmentCenter;
    [view addSubview:secondLabel];
    
    return view;
}

-(UIView*)getProgramViewWithTitleImage:(UIImage*)titleImage stageTitle:(NSString*)stageTitle programTitle:(NSString*)programTitle address:(NSString*)address detailAddress:(NSString*)detailAddress{
    
    BOOL isFirst=[stageTitle isEqualToString:@"土地规划/拍卖"];
    
    //项目title及项目名称的画布
    UIView* titleView=[[UIView alloc]initWithFrame:CGRectMake(0, height, 320, 145)];
    titleView.backgroundColor=RGBCOLOR(229, 229, 229);
    NSLog(@"%f",height);
    height+=145;
    
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
    
    //分割线1
    UIView* line1=[self getSeperatedLine];
    line1.center=CGPointMake(160, 65);
    [titleView addSubview:line1];
    
    //用来控制自适应的高度变化的累加
    CGFloat tempHeight=0;
    
    //项目名称部分
    CGRect bounds=[programTitle boundingRectWithSize:CGSizeMake(280, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil];
    
    UILabel* programName=[[UILabel alloc]initWithFrame:CGRectMake(20, 75, 280, bounds.size.height)];
    programName.text=isFirst?[StringRule hasAreaName:programTitle]:[StringRule hasProgramName:programTitle];
    programName.numberOfLines=0;
    programName.font=[UIFont systemFontOfSize:18];
    programName.textAlignment=NSTextAlignmentCenter;
    programName.textColor=[programTitle isEqualToString:@""]?NoDataColor:[UIColor blackColor];
    [titleView addSubview:programName];
    tempHeight+=bounds.size.height-18;
    
    //项目地点部分
    bounds=[address boundingRectWithSize:CGSizeMake(280, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    
    UILabel* areaLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 106+tempHeight, 280, bounds.size.height>=18?36:bounds.size.height)];
    areaLabel.text=isFirst?[StringRule hasAreaPart:address]:[StringRule hasProgramAddress:address];
    areaLabel.numberOfLines=2;
    areaLabel.font=[UIFont systemFontOfSize:14];
    areaLabel.textAlignment=NSTextAlignmentCenter;
    areaLabel.textColor=[address isEqualToString:@"  "]?NoDataColor:[UIColor blackColor];
    [titleView addSubview:areaLabel];
    tempHeight+=bounds.size.height>=18?36-14:bounds.size.height-14;
    
    
    //项目详细地点
    bounds=[detailAddress boundingRectWithSize:CGSizeMake(280, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    
    //CGFloat temp=bounds.size.height>
    UILabel* areaDetailLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 125+tempHeight, 280, isFirst&&bounds.size.height>=17?34:bounds.size.height)];
    areaDetailLabel.text=isFirst?[StringRule hasAreaAddress:detailAddress]:[StringRule hasProgramDescribe:detailAddress];
    areaDetailLabel.numberOfLines=0;
    areaDetailLabel.textColor=[detailAddress isEqualToString:@""]?NoDataColor:RGBCOLOR(125, 125, 125);
    areaDetailLabel.font=[UIFont systemFontOfSize:14];
    areaDetailLabel.textAlignment=NSTextAlignmentCenter;
    [titleView addSubview:areaDetailLabel];
    tempHeight+=bounds.size.height-13;
    //areaDetailLabel.backgroundColor=[UIColor redColor];
    
    CGRect frame=titleView.frame;
    frame.size.height+=tempHeight;
    titleView.frame=frame;
    height+=tempHeight;
    return titleView;
}
@end
