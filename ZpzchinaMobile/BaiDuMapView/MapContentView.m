//
//  MapContentView.m
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-7-14.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "MapContentView.h"
#import "ProjectStage.h"
@implementation MapContentView

- (id)initWithFrame:(CGRect)frame dic:(NSMutableDictionary *)dic number:(NSString *)number
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self addContent:dic number:number];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)addContent:(NSMutableDictionary *)dic number:(NSString *)number{
    //NSLog(@"dic ===> %@",dic);
    //NSLog(@"%@",[ProjectStage JudgmentProjectStage:dic]);
    UIImageView *grayBgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 190)];
    [grayBgView setImage:[GetImagePath getImagePath:@"地图搜索1_16"]];
    
    NSString *stage = dic[@"projectStage"];
    UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(15,25,291.5,151.5)];
    [bgImgView setImage:[GetImagePath getImagePath:@"地图搜索1_05"]];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,5,160,36)];
    nameLabel.font = [UIFont fontWithName:@"GurmukhiMN-Bold" size:15];
    if([[dic objectForKey:@"projectName"] isEqualToString:@""]){
        nameLabel.text = @"项目名称";
        nameLabel.textColor = RGBCOLOR(166, 166, 166);
    }else{
        nameLabel.textColor = [UIColor blackColor];
        nameLabel.text = [dic objectForKey:@"projectName"];
    }
    [bgImgView addSubview:nameLabel];
    
    UILabel *investmentLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,51,85,20)];
    investmentLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:14];
    investmentLabel.textColor = BlueColor;
    investmentLabel.text = @"投资额(百万)";
    [bgImgView addSubview:investmentLabel];
    
    UILabel *investmentcountLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,71,90,20)];
    investmentcountLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:14];
    if([[dic objectForKey:@"investment"] isEqualToString:@"null"]){
        investmentcountLabel.text = @"－";
        investmentcountLabel.textColor = RGBCOLOR(166, 166, 166);
    }else{
        if([[NSString stringWithFormat:@"%@",[dic objectForKey:@"investment"]] isEqualToString:@"0"]){
            investmentcountLabel.text = @"－";
            investmentcountLabel.textColor = RGBCOLOR(166, 166, 166);
        }else{
            investmentcountLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"investment"]];
            investmentcountLabel.textColor = [UIColor blackColor];
        }
    }
    [bgImgView addSubview:investmentcountLabel];
    
    UILabel *areaLabel = [[UILabel alloc] initWithFrame:CGRectMake(120,51,75,20)];
    areaLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:14];
    areaLabel.textColor = BlueColor;
    areaLabel.text = @"建筑面积㎡";
    [bgImgView addSubview:areaLabel];
    
    UILabel *areacountLabel = [[UILabel alloc] initWithFrame:CGRectMake(120,71,90,20)];
    areacountLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:14];
    if([[NSString stringWithFormat:@"%@",[dic objectForKey:@"areaOfStructure"]] isEqualToString:@"null"]){
        areacountLabel.text = @"－";
        areacountLabel.textColor = RGBCOLOR(166, 166, 166);
    }else{
        if([[NSString stringWithFormat:@"%@",[dic objectForKey:@"areaOfStructure"]] isEqualToString:@"0"]){
            areacountLabel.text = @"－";
            areacountLabel.textColor = RGBCOLOR(166, 166, 166);
        }else{
            areacountLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"areaOfStructure"]];
            areacountLabel.textColor = [UIColor blackColor];
        }
    }
    [bgImgView addSubview:areacountLabel];
    
    UIImageView *progressImage = [[UIImageView alloc] initWithFrame:CGRectMake(220,5,52,52)];
    if([stage isEqualToString:@"1"]){
        [progressImage setImage:[GetImagePath getImagePath:@"全部项目_16"]];
    }else if([stage isEqualToString:@"2"]){
        [progressImage setImage:[GetImagePath getImagePath:@"全部项目_15"]];
    }else if([stage isEqualToString:@"3"]){
        [progressImage setImage:[GetImagePath getImagePath:@"全部项目_14"]];
    }else{
        [progressImage setImage:[GetImagePath getImagePath:@"全部项目_13"]];
    }
    UIImageView *smailImage = [[UIImageView alloc] initWithFrame:CGRectMake(15,17,24.5,18.5)];
    [smailImage setImage:[GetImagePath getImagePath:@"全部项目_21"]];
    [progressImage addSubview:smailImage];
    [bgImgView addSubview:progressImage];
    
    UILabel *startdateLabel = [[UILabel alloc] initWithFrame:CGRectMake(210,57,65,20)];
    startdateLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:12];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/MM/dd"];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[[dic objectForKey:@"expectedStartTime"] intValue]];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    if([[dic objectForKey:@"expectedStartTime"] isEqualToString:@""]||[[dic objectForKey:@"expectedStartTime"] isEqualToString:@"/Date(0+0800)/"]){
        startdateLabel.text = @"开工日期";
        startdateLabel.textColor = RGBCOLOR(166, 166, 166);
    }else{
        startdateLabel.text = confromTimespStr;
        startdateLabel.textColor = GrayColor;
    }
    [bgImgView addSubview:startdateLabel];
    
    UILabel *enddateLabel = [[UILabel alloc] initWithFrame:CGRectMake(210,71,65,20)];
    enddateLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:12];
    NSDate *confromTimesp2 = [NSDate dateWithTimeIntervalSince1970:[[dic objectForKey:@"expectedFinishTime"] intValue]];
    NSString *confromTimespStr2 = [formatter stringFromDate:confromTimesp2];
    if([[dic objectForKey:@"expectedFinishTime"] isEqualToString:@""]||[[dic objectForKey:@"expectedFinishTime"] isEqualToString:@"/Date(0+0800)/"]){
        enddateLabel.text = @"竣工日期";
        enddateLabel.textColor = RGBCOLOR(166, 166, 166);
    }else{
        enddateLabel.text = confromTimespStr2;
        enddateLabel.textColor = [UIColor orangeColor];
    }
    [bgImgView addSubview:enddateLabel];
    
    UIImageView *arrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(20,115,20,20)];
    [arrowImage setImage:[GetImagePath getImagePath:@"全部项目_17"]];
    [bgImgView addSubview:arrowImage];
    
    UIImageView *lingImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 100, 250, 1)];
    [lingImage setImage:[GetImagePath getImagePath:@"新建项目5_27"]];
    [bgImgView addSubview:lingImage];
    
    UILabel *zoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(50,115,60,20)];
    zoneLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:14];
    if([dic[@"city"] isEqualToString:@""]){
        zoneLabel.text = @"区域 -";
        zoneLabel.textColor = RGBCOLOR(166, 166, 166);
    }else{
        zoneLabel.text = [NSString stringWithFormat:@"%@ - ",dic[@"city"]];
        zoneLabel.textColor = BlueColor;
    }
    [bgImgView addSubview:zoneLabel];
    
    UILabel *addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(110,115,160,20)];
    addressLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:14];
    if([[dic objectForKey:@"landAddress"] isEqualToString:@""]){
        addressLabel.text = @"地址";
        addressLabel.textColor = RGBCOLOR(166, 166, 166);
    }else{
        addressLabel.text = [dic objectForKey:@"landAddress"];
        addressLabel.textColor = [UIColor blackColor];
    }
    [bgImgView addSubview:addressLabel];
    
    [grayBgView addSubview:bgImgView];
    [self addSubview:grayBgView];
    
    UIImageView *numberImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 28.5, 40.5)];
    [numberImageView setImage:[GetImagePath getImagePath:@"地图搜索1_09"]];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 28.5, 30)];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont fontWithName:nil size:14];
    label.text = number;
    label.textAlignment = NSTextAlignmentCenter;
    [numberImageView addSubview:label];
    [self addSubview:numberImageView];
}
@end
