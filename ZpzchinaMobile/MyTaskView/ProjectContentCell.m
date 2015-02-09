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
    UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(14,0,291.5,270)];
    [bgImgView setImage:[GetImagePath getImagePath:@"矩形-5"]];
    [self addSubview:bgImgView];
    
    nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(34,15,160,36)];
    nameLabel.font = [UIFont boldSystemFontOfSize:15];
    nameLabel.textColor = [UIColor blackColor];
    //nameLabel.text = @"上海中技桩业项目名称";
    [self addSubview:nameLabel];
    
    investmentLabel = [[UILabel alloc] initWithFrame:CGRectMake(34,61,85,20)];
    investmentLabel.font = [UIFont systemFontOfSize:14];
    investmentLabel.textColor = BlueColor;
    investmentLabel.text = @"投资额(百万)";
    [self addSubview:investmentLabel];
    
    investmentcountLabel = [[UILabel alloc] initWithFrame:CGRectMake(34,81,90,20)];
    investmentcountLabel.font = [UIFont systemFontOfSize:14];
    //investmentcountLabel.backgroundColor = [UIColor yellowColor];
    investmentcountLabel.textColor = [UIColor blackColor];
    [self addSubview:investmentcountLabel];
    
    areaLabel = [[UILabel alloc] initWithFrame:CGRectMake(134,61,81,20)];
    areaLabel.font = [UIFont systemFontOfSize:14];
    areaLabel.textColor = BlueColor;
    areaLabel.text = @"建筑面积(㎡)";
    [self addSubview:areaLabel];
    
    areacountLabel = [[UILabel alloc] initWithFrame:CGRectMake(134,81,90,20)];
    //areacountLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:14];
    areacountLabel.font = [UIFont systemFontOfSize:14];
    areacountLabel.textColor = [UIColor blackColor];
    //areacountLabel.backgroundColor = [UIColor redColor];
    [self addSubview:areacountLabel];

    progressImage = [[UIImageView alloc] initWithFrame:CGRectMake(234,15,52,52)];
    [self addSubview:progressImage];
    
    startdateLabel = [[UILabel alloc] initWithFrame:CGRectMake(227.5,67,65,20)];
    startdateLabel.font = [UIFont systemFontOfSize:12];
    startdateLabel.textAlignment=NSTextAlignmentCenter;
    startdateLabel.textColor = GrayColor;
    [self addSubview:startdateLabel];
    
    enddateLabel = [[UILabel alloc] initWithFrame:CGRectMake(227.5,81,65,20)];
    enddateLabel.font = [UIFont systemFontOfSize:12];
    enddateLabel.textAlignment=NSTextAlignmentCenter;
    enddateLabel.textColor = [UIColor orangeColor];
    [self addSubview:enddateLabel];
    
    bigImage = [[EGOImageView alloc] initWithPlaceholderImage:[GetImagePath getImagePath:@"mapdef"]];
    bigImage.frame = CGRectMake(2.2,110,288,110);
    bigImage.delegate = self;
    [bgImgView addSubview:bigImage];
    
    UIImageView *arrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(34,235,20,20)];
    [arrowImage setImage:[GetImagePath getImagePath:@"全部项目_17"]];
    [self addSubview:arrowImage];
    
    UIImageView *dianImage = [[UIImageView alloc] initWithFrame:CGRectMake(284,235,3.5,18)];
    [dianImage setImage:[GetImagePath getImagePath:@"全部项目_19"]];
    dianImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *dianImagetapGestureRecognizer = [[UITapGestureRecognizer alloc] init];
    //[dianImagetapGestureRecognizer addTarget:self action:@selector(dianImageClick)];
    [dianImagetapGestureRecognizer setNumberOfTapsRequired:1];
    [dianImagetapGestureRecognizer setNumberOfTouchesRequired:1];
    [dianImage addGestureRecognizer:dianImagetapGestureRecognizer];
    [self addSubview:dianImage];
    
    zoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(64,235,60,20)];
    zoneLabel.font = [UIFont systemFontOfSize:14];
    zoneLabel.textColor = BlueColor;
    [self addSubview:zoneLabel];
    
    addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(120,235,160,20)];
    addressLabel.font = [UIFont systemFontOfSize:14];
    addressLabel.textColor = [UIColor blackColor];
    [self addSubview:addressLabel];
}

-(void)setDic:(NSMutableDictionary *)dic{
    NSLog(@"%@",dic);
    if([dic[@"projectName"] isEqualToString:@""]){
        nameLabel.text = @"项目名称";
        nameLabel.textColor = RGBCOLOR(166, 166, 166);
    }else{
        nameLabel.text = [dic objectForKey:@"projectName"];
        nameLabel.textColor = [UIColor blackColor];
    }
    
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
    if([dic[@"projectStage"] isEqualToString:@"1"]||[dic[@"projectStage"] isEqualToString:@"0"]){
        [progressImage setImage:[GetImagePath getImagePath:@"+项目-首页_21a"]];
    }else if([dic[@"projectStage"] isEqualToString:@"2"]){
        [progressImage setImage:[GetImagePath getImagePath:@"+项目-首页_23a"]];
    }else if([dic[@"projectStage"] isEqualToString:@"3"]){
        [progressImage setImage:[GetImagePath getImagePath:@"+项目-首页_25a"]];
    }else{
        [progressImage setImage:[GetImagePath getImagePath:@"+项目-首页_27a"]];
    }
    
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
    
    NSDate *confromTimesp2 = [NSDate dateWithTimeIntervalSince1970:[[dic objectForKey:@"expectedFinishTime"] intValue]];
    NSString *confromTimespStr2 = [formatter stringFromDate:confromTimesp2];
    if([[dic objectForKey:@"expectedFinishTime"] isEqualToString:@""]||[[dic objectForKey:@"expectedFinishTime"] isEqualToString:@"/Date(0+0800)/"]){
        enddateLabel.text = @"竣工日期";
        enddateLabel.textColor = RGBCOLOR(166, 166, 166);
    }else{
        enddateLabel.text = confromTimespStr2;
        enddateLabel.textColor = [UIColor orangeColor];
    }
    
    
    if([dic[@"city"] isEqualToString:@""]){
        zoneLabel.text = @"区域 -";
        zoneLabel.textColor = RGBCOLOR(166, 166, 166);
    }else{
        zoneLabel.text = [NSString stringWithFormat:@"%@ - ",dic[@"city"]];
        zoneLabel.textColor = BlueColor;
    }
    
    if([[dic objectForKey:@"landAddress"] isEqualToString:@""]){
        addressLabel.text = @"地址";
        addressLabel.textColor = RGBCOLOR(166, 166, 166);
    }else{
        addressLabel.text = [dic objectForKey:@"landAddress"];
        addressLabel.textColor = [UIColor blackColor];
    }
    
    imageHight = [dic[@"CompressImageHeight"] floatValue];
    imageWidth = [dic[@"CompressImageWidth"] floatValue];
    bigImage.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%s%@",imageAddress,dic[@"CompressImage"]]];
}

- (void)imageViewLoadedImage:(EGOImageView*)imageView{
    //图片裁剪
    UIImage *srcimg = imageView.image;
    CGRect rect =  CGRectMake((imageWidth-288)/2, (imageHight-110)/2, 288, 110);//要裁剪的图片区域，按照原图的像素大小来，超过原图大小的边自动适配
    CGImageRef cgimg = CGImageCreateWithImageInRect([srcimg CGImage], rect);
    bigImage.image = [UIImage imageWithCGImage:cgimg];
    CGImageRelease(cgimg);//用完一定要释放，否则内存泄露
}
@end
