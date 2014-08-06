//
//  CellContentView.m
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-18.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "CellContentView.h"
#import "ProjectStage.h"
@implementation CellContentView
@synthesize delegate;
- (id)initWithFrame:(CGRect)frame dic:(NSMutableDictionary *)dic
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self addContent:dic];
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

-(void)addContent:(NSMutableDictionary *)dic{
    //NSLog(@"dic ===> %@",dic);
    //NSLog(@"%@",[ProjectStage JudgmentProjectStage:dic]);
    stage = [ProjectStage JudgmentProjectStage:dic];
    UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,291.5,260)];
    [bgImgView setImage:[UIImage imageNamed:@"全部项目_10.png"]];
    [self addSubview:bgImgView];
    
    nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,5,160,36)];
    nameLabel.font = [UIFont fontWithName:@"GurmukhiMN-Bold" size:15];
    nameLabel.textColor = [UIColor blackColor];
    //nameLabel.text = @"上海中技桩业项目名称";
    nameLabel.text = [dic objectForKey:@"projectName"];
    [self addSubview:nameLabel];
    
    investmentLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,51,50,20)];
    investmentLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:14];
    investmentLabel.textColor = BlueColor;
    investmentLabel.text = @"投资额";
    [self addSubview:investmentLabel];
    
    investmentcountLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,71,140,20)];
    investmentcountLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:14];
    investmentcountLabel.textColor = [UIColor blackColor];
    investmentcountLabel.text = [dic objectForKey:@"investment"];
    [self addSubview:investmentcountLabel];
    
    areaLabel = [[UILabel alloc] initWithFrame:CGRectMake(120,51,60,20)];
    areaLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:14];
    areaLabel.textColor = BlueColor;
    areaLabel.text = @"建筑面积";
    [self addSubview:areaLabel];
    
    areacountLabel = [[UILabel alloc] initWithFrame:CGRectMake(120,71,140,20)];
    areacountLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:14];
    areacountLabel.textColor = [UIColor blackColor];
    //areacountLabel.text = @"16,000M²";
    areacountLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"area"]];
    [self addSubview:areacountLabel];
    
    progressImage = [[UIImageView alloc] initWithFrame:CGRectMake(220,5,52,52)];
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
    [self addSubview:progressImage];
    
    startdateLabel = [[UILabel alloc] initWithFrame:CGRectMake(220,57,65,20)];
    startdateLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:12];
    startdateLabel.textColor = GrayColor;
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/MM/dd"];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[[dic objectForKey:@"expectedStartTime"] intValue]];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    startdateLabel.text = confromTimespStr;
    [self addSubview:startdateLabel];
    
    enddateLabel = [[UILabel alloc] initWithFrame:CGRectMake(220,71,65,20)];
    enddateLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:12];
    enddateLabel.textColor = [UIColor orangeColor];
    NSDate *confromTimesp2 = [NSDate dateWithTimeIntervalSince1970:[[dic objectForKey:@"expectedFinishTime"] intValue]];
    NSString *confromTimespStr2 = [formatter stringFromDate:confromTimesp2];
    enddateLabel.text = confromTimespStr2;
    [self addSubview:enddateLabel];
    
    UIImageView *bigImage = [[UIImageView alloc] initWithFrame:CGRectMake(2.5,100,286.5,109.5)];
    [bigImage setImage:[UIImage imageNamed:@"全部项目_37.png"]];
    [self addSubview:bigImage];
    
    UIImageView *arrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(20,225,20,20)];
    [arrowImage setImage:[UIImage imageNamed:@"全部项目_17.png"]];
    [self addSubview:arrowImage];
    
    UIImageView *dianImage = [[UIImageView alloc] initWithFrame:CGRectMake(270,225,3.5,18)];
    [dianImage setImage:[UIImage imageNamed:@"全部项目_19.png"]];
    dianImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *dianImagetapGestureRecognizer = [[UITapGestureRecognizer alloc] init];
    [dianImagetapGestureRecognizer addTarget:self action:@selector(dianImageClick)];
    [dianImagetapGestureRecognizer setNumberOfTapsRequired:1];
    [dianImagetapGestureRecognizer setNumberOfTouchesRequired:1];
    [dianImage addGestureRecognizer:dianImagetapGestureRecognizer];
    [self addSubview:dianImage];
    
    UILabel *zoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(50,225,60,20)];
    zoneLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:14];
    zoneLabel.textColor = BlueColor;
    zoneLabel.text = @"华南区 -";
    [self addSubview:zoneLabel];
    
    addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(100,225,160,20)];
    addressLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:14];
    addressLabel.textColor = [UIColor blackColor];
    addressLabel.text = [dic objectForKey:@"landAddress"];
    [self addSubview:addressLabel];
}

-(void)dianImageClick{
    if ([delegate respondsToSelector:@selector(addActionSheet)]){
        [delegate addActionSheet];
    }
}

-(void)setNewDic:(NSMutableDictionary *)dic{
    stage = [ProjectStage JudgmentProjectStage:dic];
    nameLabel.text = [dic objectForKey:@"projectName"];
    investmentcountLabel.text = [dic objectForKey:@"investment"];
    areacountLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"area"]];
    if([stage isEqualToString:@"1"]){
        [progressImage setImage:[UIImage imageNamed:@"全部项目_16.png"]];
    }else if([stage isEqualToString:@"2"]){
        [progressImage setImage:[UIImage imageNamed:@"全部项目_15.png"]];
    }else if([stage isEqualToString:@"3"]){
        [progressImage setImage:[UIImage imageNamed:@"全部项目_14.png"]];
    }else{
        [progressImage setImage:[UIImage imageNamed:@"全部项目_13.png"]];
    }
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/MM/dd"];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[[dic objectForKey:@"expectedStartTime"] intValue]];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    startdateLabel.text = confromTimespStr;
    
    NSDate *confromTimesp2 = [NSDate dateWithTimeIntervalSince1970:[[dic objectForKey:@"expectedFinishTime"] intValue]];
    NSString *confromTimespStr2 = [formatter stringFromDate:confromTimesp2];
    enddateLabel.text = confromTimespStr2;
    
    addressLabel.text = [dic objectForKey:@"landAddress"];
}
@end
