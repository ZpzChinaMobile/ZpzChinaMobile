//
//  ProjectContentCell.m
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-7-24.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "ProjectContentCell.h"
#import "ProjectStage.h"
@implementation ProjectContentCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self addContent];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)addContent{
    UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(14,0,291.5,260)];
    [bgImgView setImage:[GetImagePath getImagePath:@"全部项目_10"]];
    [self addSubview:bgImgView];
    
    nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(34,5,160,36)];
    nameLabel.font = [UIFont fontWithName:@"GurmukhiMN-Bold" size:15];
    nameLabel.textColor = [UIColor blackColor];
    //nameLabel.text = @"上海中技桩业项目名称";
    [self addSubview:nameLabel];
    
    investmentLabel = [[UILabel alloc] initWithFrame:CGRectMake(34,51,50,20)];
    investmentLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:14];
    investmentLabel.textColor = BlueColor;
    investmentLabel.text = @"投资额";
    [self addSubview:investmentLabel];
    
    investmentcountLabel = [[UILabel alloc] initWithFrame:CGRectMake(34,71,140,20)];
    investmentcountLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:14];
    investmentcountLabel.textColor = [UIColor blackColor];
    [self addSubview:investmentcountLabel];
    
    areaLabel = [[UILabel alloc] initWithFrame:CGRectMake(134,51,60,20)];
    areaLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:14];
    areaLabel.textColor = BlueColor;
    areaLabel.text = @"建筑面积";
    [self addSubview:areaLabel];
    
    areacountLabel = [[UILabel alloc] initWithFrame:CGRectMake(134,71,140,20)];
    areacountLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:14];
    areacountLabel.textColor = [UIColor blackColor];
    [self addSubview:areacountLabel];

    progressImage = [[UIImageView alloc] initWithFrame:CGRectMake(234,5,52,52)];
    [self addSubview:progressImage];
    
    startdateLabel = [[UILabel alloc] initWithFrame:CGRectMake(234,57,65,20)];
    startdateLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:12];
    startdateLabel.textColor = GrayColor;
    [self addSubview:startdateLabel];
    
    enddateLabel = [[UILabel alloc] initWithFrame:CGRectMake(234,71,65,20)];
    enddateLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:12];
    enddateLabel.textColor = [UIColor orangeColor];
    [self addSubview:enddateLabel];
    
    UIImageView *bigImage = [[UIImageView alloc] initWithFrame:CGRectMake(16.5,100,286.5,109.5)];
    [bigImage setImage:[GetImagePath getImagePath:@"全部项目_37"]];
    [self addSubview:bigImage];
    
    UIImageView *arrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(34,225,20,20)];
    [arrowImage setImage:[GetImagePath getImagePath:@"全部项目_17"]];
    [self addSubview:arrowImage];
    
    UIImageView *dianImage = [[UIImageView alloc] initWithFrame:CGRectMake(284,225,3.5,18)];
    [dianImage setImage:[GetImagePath getImagePath:@"全部项目_19"]];
    dianImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *dianImagetapGestureRecognizer = [[UITapGestureRecognizer alloc] init];
    //[dianImagetapGestureRecognizer addTarget:self action:@selector(dianImageClick)];
    [dianImagetapGestureRecognizer setNumberOfTapsRequired:1];
    [dianImagetapGestureRecognizer setNumberOfTouchesRequired:1];
    [dianImage addGestureRecognizer:dianImagetapGestureRecognizer];
    [self addSubview:dianImage];
    
    zoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(64,225,60,20)];
    zoneLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:14];
    zoneLabel.textColor = BlueColor;
    [self addSubview:zoneLabel];
    
    addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(114,225,160,20)];
    addressLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:14];
    addressLabel.textColor = [UIColor blackColor];
    [self addSubview:addressLabel];
}

-(void)setDic:(NSMutableDictionary *)dic{
    NSLog(@"%@",dic);
    nameLabel.text = [dic objectForKey:@"projectName"];
    if([[dic objectForKey:@"investment"] isEqualToString:@"null"]){
        investmentcountLabel.text = @"0";
    }else{
        investmentcountLabel.text = [dic objectForKey:@"investment"];
    }
    if([dic[@"projectStage"] isEqualToString:@"1"]||[dic[@"projectStage"] isEqualToString:@"0"]){
        [progressImage setImage:[GetImagePath getImagePath:@"全部项目_16"]];
    }else if([dic[@"projectStage"] isEqualToString:@"2"]){
        [progressImage setImage:[GetImagePath getImagePath:@"全部项目_15"]];
    }else if([dic[@"projectStage"] isEqualToString:@"3"]){
        [progressImage setImage:[GetImagePath getImagePath:@"全部项目_14"]];
    }else{
        [progressImage setImage:[GetImagePath getImagePath:@"全部项目_13"]];
    }
    
    if([[NSString stringWithFormat:@"%@",[dic objectForKey:@"area"]] isEqualToString:@"null"]){
        areacountLabel.text = @"0";
    }else{
        areacountLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"area"]];
    }
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/MM/dd"];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[[dic objectForKey:@"expectedStartTime"] intValue]];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    startdateLabel.text = confromTimespStr;
    
    NSDate *confromTimesp2 = [NSDate dateWithTimeIntervalSince1970:[[dic objectForKey:@"expectedFinishTime"] intValue]];
    NSString *confromTimespStr2 = [formatter stringFromDate:confromTimesp2];
    enddateLabel.text = confromTimespStr2;
    zoneLabel.text = [NSString stringWithFormat:@"%@ -",dic[@"district"]];
    addressLabel.text = [dic objectForKey:@"landAddress"];
}
@end
