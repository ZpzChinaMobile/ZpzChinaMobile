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
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier dic:(NSMutableDictionary *)dic
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        NSLog(@"%@",dic);
        stage = [ProjectStage JudgmentProjectStage:dic];
        UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(14,0,291.5,260)];
        [bgImgView setImage:[GetImagePath getImagePath:@"全部项目_10"]];
        [self addSubview:bgImgView];
        
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(34,5,160,36)];
        nameLabel.font = [UIFont fontWithName:@"GurmukhiMN-Bold" size:15];
        nameLabel.textColor = [UIColor blackColor];
        //nameLabel.text = @"上海中技桩业项目名称";
        nameLabel.text = [dic objectForKey:@"projectName"];
        [self addSubview:nameLabel];
        
        investmentLabel = [[UILabel alloc] initWithFrame:CGRectMake(34,51,50,20)];
        investmentLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:14];
        investmentLabel.textColor = BlueColor;
        investmentLabel.text = @"投资额";
        [self addSubview:investmentLabel];
        
        investmentcountLabel = [[UILabel alloc] initWithFrame:CGRectMake(34,71,140,20)];
        investmentcountLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:14];
        investmentcountLabel.textColor = [UIColor blackColor];
        investmentcountLabel.text = [dic objectForKey:@"investment"];
        [self addSubview:investmentcountLabel];
        
        areaLabel = [[UILabel alloc] initWithFrame:CGRectMake(134,51,60,20)];
        areaLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:14];
        areaLabel.textColor = BlueColor;
        areaLabel.text = @"建筑面积";
        [self addSubview:areaLabel];
        
        areacountLabel = [[UILabel alloc] initWithFrame:CGRectMake(134,71,140,20)];
        areacountLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:14];
        areacountLabel.textColor = [UIColor blackColor];
        //areacountLabel.text = @"16,000M²";
        areacountLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"area"]];
        [self addSubview:areacountLabel];
        NSLog(@"stage ===== > %@",stage);
        progressImage = [[UIImageView alloc] initWithFrame:CGRectMake(234,5,52,52)];
        if([stage isEqualToString:@"1"]||[stage isEqualToString:@"0"]){
            [progressImage setImage:[GetImagePath getImagePath:@"全部项目_16"]];
        }else if([stage isEqualToString:@"2"]){
            [progressImage setImage:[GetImagePath getImagePath:@"全部项目_15"]];
        }else if([stage isEqualToString:@"3"]){
            [progressImage setImage:[GetImagePath getImagePath:@"全部项目_14"]];
        }else{
            [progressImage setImage:[GetImagePath getImagePath:@"全部项目_13"]];
        }
        [self addSubview:progressImage];
        
        startdateLabel = [[UILabel alloc] initWithFrame:CGRectMake(234,57,65,20)];
        startdateLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:12];
        startdateLabel.textColor = GrayColor;
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy/MM/dd"];
        NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[[dic objectForKey:@"expectedStartTime"] intValue]];
        NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
        startdateLabel.text = confromTimespStr;
        [self addSubview:startdateLabel];
        
        enddateLabel = [[UILabel alloc] initWithFrame:CGRectMake(234,71,65,20)];
        enddateLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:12];
        enddateLabel.textColor = [UIColor orangeColor];
        NSDate *confromTimesp2 = [NSDate dateWithTimeIntervalSince1970:[[dic objectForKey:@"expectedFinishTime"] intValue]];
        NSString *confromTimespStr2 = [formatter stringFromDate:confromTimesp2];
        enddateLabel.text = confromTimespStr2;
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
        
        UILabel *zoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(64,225,60,20)];
        zoneLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:14];
        zoneLabel.textColor = BlueColor;
        zoneLabel.text = @"华南区 -";
        [self addSubview:zoneLabel];
        
        addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(114,225,160,20)];
        addressLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:14];
        addressLabel.textColor = [UIColor blackColor];
        addressLabel.text = [dic objectForKey:@"landAddress"];
        [self addSubview:addressLabel];
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

@end
