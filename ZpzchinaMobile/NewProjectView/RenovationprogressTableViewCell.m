//
//  RenovationprogressTableViewCell.m
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-20.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "RenovationprogressTableViewCell.h"

@implementation RenovationprogressTableViewCell
@synthesize delegate;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier dic:(NSMutableDictionary *)dic flag:(int)flag singleDic:(NSMutableDictionary *)singleDic
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        UIImageView *lingImage = [[UIImageView alloc] initWithFrame:CGRectMake(18, 0, 6, 50)];
        [lingImage setBackgroundColor:[UIColor blackColor]];
        [self addSubview:lingImage];
        lingImage.alpha = 0.1;
        
        UIButton *decorationProgress = [UIButton buttonWithType:UIButtonTypeCustom];
        decorationProgress.frame = CGRectMake(60,15, 200, 30);
        if(flag == 0){
            if(![[dic objectForKey:@"decorationProgress"] isEqualToString:@""]){
                [decorationProgress setTitle:[NSString stringWithFormat:@"装修进度:%@",[dic objectForKey:@"decorationProgress"]] forState:UIControlStateNormal];
            }else{
                [decorationProgress setTitle:@"装修进度" forState:UIControlStateNormal];
            }
        }else{
            if(![[dic objectForKey:@"decorationProgress"] isEqualToString:@""]){
                [decorationProgress setTitle:[NSString stringWithFormat:@"%@",[dic objectForKey:@"green"]] forState:UIControlStateNormal];
            }else{
                if(![[singleDic objectForKey:@"decorationProgress"] isEqualToString:@""]){
                    [decorationProgress setTitle:[NSString stringWithFormat:@"%@",[singleDic objectForKey:@"decorationProgress"]] forState:UIControlStateNormal];
                }else{
                    [decorationProgress setTitle:@"装修进度" forState:UIControlStateNormal];
                }
            }
        }
        [decorationProgress setTitleColor:BlueColor forState:UIControlStateNormal];
        decorationProgress.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        decorationProgress.titleLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:16];
        [decorationProgress addTarget:self action:@selector(decorationProgress) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:decorationProgress];
        
        UIImageView *arrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(280,20, 8, 12.5)];
        [arrowImage setImage:[GetImagePath getImagePath:@"新建项目5_09.png"]];
        [self addSubview:arrowImage];
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

-(void)decorationProgress{
    if ([delegate respondsToSelector:@selector(addContactViewRenovationprogress)]){
        [delegate addContactViewRenovationprogress];
    }
}
@end
