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
    [grayBgView setImage:[UIImage imageNamed:@"地图搜索1_16.png"]];
    
    NSString *stage = [ProjectStage JudgmentProjectStage:dic];
    UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(15,25,291.5,151.5)];
    [bgImgView setImage:[UIImage imageNamed:@"地图搜索1_05.png"]];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,5,160,36)];
    nameLabel.font = [UIFont fontWithName:@"GurmukhiMN-Bold" size:15];
    nameLabel.textColor = [UIColor blackColor];
    nameLabel.text = [dic objectForKey:@"projectName"];
    [bgImgView addSubview:nameLabel];
    
    UILabel *investmentLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,51,50,20)];
    investmentLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:14];
    investmentLabel.textColor = BlueColor;
    investmentLabel.text = @"投资额";
    [bgImgView addSubview:investmentLabel];
    
    UILabel *investmentcountLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,71,140,20)];
    investmentcountLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:14];
    investmentcountLabel.textColor = [UIColor blackColor];
    investmentcountLabel.text = [dic objectForKey:@"investment"];
    [bgImgView addSubview:investmentcountLabel];
    
    UILabel *areaLabel = [[UILabel alloc] initWithFrame:CGRectMake(120,51,60,20)];
    areaLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:14];
    areaLabel.textColor = BlueColor;
    areaLabel.text = @"建筑面积";
    [bgImgView addSubview:areaLabel];
    
    UILabel *areacountLabel = [[UILabel alloc] initWithFrame:CGRectMake(120,71,140,20)];
    areacountLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:14];
    areacountLabel.textColor = [UIColor blackColor];
    //areacountLabel.text = @"16,000M²";
    areacountLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"area"]];
    [bgImgView addSubview:areacountLabel];
    
    UIImageView *progressImage = [[UIImageView alloc] initWithFrame:CGRectMake(220,5,52,52)];
    if([stage isEqualToString:@"1"]){
        [progressImage setImage:[UIImage imageNamed:@"全部项目_16.png"]];
    }else if([stage isEqualToString:@"2"]){
        [progressImage setImage:[UIImage imageNamed:@"全部项目_15.png"]];
    }else if([stage isEqualToString:@"3"]){
        [progressImage setImage:[UIImage imageNamed:@"全部项目_14.png"]];
    }else{
        [progressImage setImage:[UIImage imageNamed:@"全部项目_13.png"]];
    }
    UIImageView *smailImage = [[UIImageView alloc] initWithFrame:CGRectMake(15,17,24.5,18.5)];
    [smailImage setImage:[UIImage imageNamed:@"全部项目_21.png"]];
    [progressImage addSubview:smailImage];
    [bgImgView addSubview:progressImage];
    
    UILabel *startdateLabel = [[UILabel alloc] initWithFrame:CGRectMake(210,57,65,20)];
    startdateLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:12];
    startdateLabel.textColor = GrayColor;
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/MM/dd"];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[[dic objectForKey:@"expectedStartTime"] intValue]];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    startdateLabel.text = confromTimespStr;
    [bgImgView addSubview:startdateLabel];
    
    UILabel *enddateLabel = [[UILabel alloc] initWithFrame:CGRectMake(210,71,65,20)];
    enddateLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:12];
    enddateLabel.textColor = [UIColor orangeColor];
    NSDate *confromTimesp2 = [NSDate dateWithTimeIntervalSince1970:[[dic objectForKey:@"expectedFinishTime"] intValue]];
    NSString *confromTimespStr2 = [formatter stringFromDate:confromTimesp2];
    enddateLabel.text = confromTimespStr2;
    [bgImgView addSubview:enddateLabel];
    
    UIImageView *arrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(20,115,20,20)];
    [arrowImage setImage:[UIImage imageNamed:@"全部项目_17.png"]];
    [bgImgView addSubview:arrowImage];
    
    UIImageView *lingImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 100, 250, 1)];
    [lingImage setImage:[UIImage imageNamed:@"新建项目5_27.png"]];
    [bgImgView addSubview:lingImage];
    
    UILabel *zoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(50,115,60,20)];
    zoneLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:14];
    zoneLabel.textColor = BlueColor;
    zoneLabel.text = @"华南区 - ";
    [bgImgView addSubview:zoneLabel];
    
    UILabel *addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(100,115,160,20)];
    addressLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:14];
    addressLabel.textColor = [UIColor blackColor];
    addressLabel.text = [dic objectForKey:@"landAddress"];
    [bgImgView addSubview:addressLabel];
    
    [grayBgView addSubview:bgImgView];
    [self addSubview:grayBgView];
    
    UIImageView *numberImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 28.5, 40.5)];
    [numberImageView setImage:[UIImage imageNamed:@"地图搜索1_09.png"]];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 28.5, 30)];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont fontWithName:nil size:14];
    label.text = number;
    label.textAlignment = NSTextAlignmentCenter;
    [numberImageView addSubview:label];
    [self addSubview:numberImageView];
}
@end
