//
//  WeakElectricityCell.m
//  ZpzchinaMobile
//
//  Created by Jack on 14-8-14.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "WeakElectricityCell.h"

@implementation WeakElectricityCell
@synthesize delegate;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier dic:(NSMutableDictionary *)dic flag:(int)flag Arr:(NSMutableArray *)Arr singleDic:(NSMutableDictionary *)singleDic;
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
            for (int i =0; i<3; i++) {
                
                UIImageView *arrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(100,50*i+17, 10, 18)];
                [arrowImage setImage:[GetImagePath getImagePath:@"新建项目5_09"]];
                [self addSubview:arrowImage];
                
                UIImageView *lingImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 50*(i+1), 280, 1)];
                [lingImage setImage:[GetImagePath getImagePath:@"新建项目5_27"]];
                [self addSubview:lingImage];
                
                
        }
        UIFont* myFont=[UIFont systemFontOfSize:15];

        UIButton *tempBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        tempBtn1.frame = CGRectMake(15,11, 80, 30);
        [tempBtn1 setTitle:@"弱电安装" forState:UIControlStateNormal];
        [tempBtn1 setTitleColor:BlueColor forState:UIControlStateNormal];
        [tempBtn1 addTarget:self action:@selector(tempBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        tempBtn1.tag = 0;
        tempBtn1.titleLabel.font=myFont;
        [self.contentView addSubview:tempBtn1];
        
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(130,11, 120, 30)];
        if(flag == 0){
            if(![[dic objectForKey:@"electroweakInstallation"] isEqualToString:@""]){
                [label1 setText:[NSString stringWithFormat:@"%@",[dic objectForKey:@"electroweakInstallation"]]];
            }else{
                [label1 setText:@""];
            }
        }else{
            NSLog(@"==>%@",[dic objectForKey:@"electroweakInstallation"]);
            if(![[dic objectForKey:@"electroweakInstallation"] isEqualToString:@""]){
                [label1 setText:[NSString stringWithFormat:@"%@",[dic objectForKey:@"electroweakInstallation"]]];
            }else{
                if(![[singleDic objectForKey:@"electroweakInstallation"] isEqualToString:@""]){
                    [label1 setText:[NSString stringWithFormat:@"%@",[singleDic objectForKey:@"electroweakInstallation"]]];
                }else{
                    [label1 setText:@""];
                }
            }
        }
        label1.textColor = GrayColor;
        label1.font = myFont;
        label1.textAlignment = NSTextAlignmentLeft;
        [self addSubview:label1];
        
        UIButton *tempBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        tempBtn2.frame = CGRectMake(15,11+50, 80, 30);
        [tempBtn2 setTitle:@"装修情况" forState:UIControlStateNormal];
        [tempBtn2 setTitleColor:BlueColor forState:UIControlStateNormal];
        [tempBtn2 addTarget:self action:@selector(tempBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        tempBtn2.titleLabel.font=myFont;
        tempBtn2.tag = 1;
        [self.contentView addSubview:tempBtn2];
        
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(130,11+50, 120, 30)];
        label2.textColor = GrayColor;
        label2.font = myFont;
        label2.textAlignment = NSTextAlignmentLeft;

        [self addSubview:label2];
        
        if(flag == 0){
            if(![[dic objectForKey:@"decorationSituation"] isEqualToString:@""]){
                [label2 setText:[NSString stringWithFormat:@"%@",[dic objectForKey:@"decorationSituation"]]];
            }else{
                [label2 setText:@""];
            }
        }else{
            NSLog(@"==>%@",[dic objectForKey:@"decorationSituation"]);
            if(![[dic objectForKey:@"decorationSituation"] isEqualToString:@""]){
                [label2 setText:[NSString stringWithFormat:@"%@",[dic objectForKey:@"decorationSituation"]]];
            }else{
                if(![[singleDic objectForKey:@"decorationSituation"] isEqualToString:@""]){
                    [label2 setText:[NSString stringWithFormat:@"%@",[singleDic objectForKey:@"decorationSituation"]]];
                }else{
                    [label2 setText:@""];
                }
            }
        }


        
        UIButton *tempBtn3 = [UIButton buttonWithType:UIButtonTypeCustom];
        tempBtn3.frame = CGRectMake(15,10+100, 80, 30);
        [tempBtn3 setTitle:@"装修进度" forState:UIControlStateNormal];
        [tempBtn3 setTitleColor:BlueColor forState:UIControlStateNormal];
        [tempBtn3 addTarget:self action:@selector(tempBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        tempBtn3.titleLabel.font=myFont;
        tempBtn3.tag = 2;
        [self.contentView addSubview:tempBtn3];
        
        UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(130,10+100, 120, 30)];
        label3.textColor = GrayColor;
        label3.font = myFont;
        label3.textAlignment = NSTextAlignmentLeft;
        [self addSubview:label3];
        if(flag == 0){
            if(![[dic objectForKey:@"decorationProgress"] isEqualToString:@""]){
                [label3 setText:[NSString stringWithFormat:@"%@",[dic objectForKey:@"decorationProgress"]]];
            }else{
                [label3 setText:@""];
            }
        }else{
            NSLog(@"==>%@",[dic objectForKey:@"decorationProgress"]);
            if(![[dic objectForKey:@"decorationProgress"] isEqualToString:@""]){
                [label3 setText:[NSString stringWithFormat:@"%@",[dic objectForKey:@"decorationProgress"]]];
            }else{
                if(![[singleDic objectForKey:@"decorationProgress"] isEqualToString:@""]){
                    [label3 setText:[NSString stringWithFormat:@"%@",[singleDic objectForKey:@"decorationProgress"]]];
                }else{
                    [label3 setText:@""];
                }
            }
        }

        
        
        
    }
    return self;


}



-(void)tempBtnClicked:(UIButton *)button
{
    if ([delegate respondsToSelector:@selector(addContactViewFirefighting:)]){
        [delegate addContactViewFirefighting:button.tag];
    }

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
