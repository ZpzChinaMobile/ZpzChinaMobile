//
//  DecorationTableViewCell.m
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-20.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "DecorationTableViewCell.h"

@implementation DecorationTableViewCell
@synthesize delegate;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier dic:(NSMutableDictionary *)dic flag:(int)flag singleDic:(NSMutableDictionary *)singleDic
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        UIImageView *lingImage = [[UIImageView alloc] initWithFrame:CGRectMake(18, 0, 6, 100)];
        [lingImage setBackgroundColor:[UIColor blackColor]];
        [self addSubview:lingImage];
        lingImage.alpha = 0.1;
        
        UIImageView *lingImage2 = [[UIImageView alloc] initWithFrame:CGRectMake(60, 50, 250, 1)];
        [lingImage2 setImage:[UIImage imageNamed:@"新建项目5_27.png"]];
        [self addSubview:lingImage2];
        
        UIButton *decorationSituation = [UIButton buttonWithType:UIButtonTypeCustom];
        decorationSituation.frame = CGRectMake(60,15, 200, 30);
        if(flag == 0){
            if(![[dic objectForKey:@"decorationSituation"] isEqualToString:@""]){
                [decorationSituation setTitle:[NSString stringWithFormat:@"装修情况:%@",[dic objectForKey:@"decorationSituation"]] forState:UIControlStateNormal];
            }else{
                [decorationSituation setTitle:@"装修情况" forState:UIControlStateNormal];
            }
        }else{
            if(![[dic objectForKey:@"decorationSituation"] isEqualToString:@""]){
                [decorationSituation setTitle:[NSString stringWithFormat:@"%@",[dic objectForKey:@"decorationSituation"]] forState:UIControlStateNormal];
            }else{
                if(![[singleDic objectForKey:@"decorationSituation"] isEqualToString:@""]){
                    [decorationSituation setTitle:[NSString stringWithFormat:@"%@",[singleDic objectForKey:@"decorationSituation"]] forState:UIControlStateNormal];
                }else{
                    [decorationSituation setTitle:@"装修情况" forState:UIControlStateNormal];
                }
            }
        }
        [decorationSituation setTitleColor:BlueColor forState:UIControlStateNormal];
        decorationSituation.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        decorationSituation.titleLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:16];
        [decorationSituation addTarget:self action:@selector(decorationSituation) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:decorationSituation];
        
        UIImageView *arrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(280,20, 8, 12.5)];
        [arrowImage setImage:[UIImage imageNamed:@"新建项目5_09.png"]];
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

-(void)decorationSituation{
    if ([delegate respondsToSelector:@selector(addContactViewDecoration)]){
        [delegate addContactViewDecoration];
    }
}
@end
