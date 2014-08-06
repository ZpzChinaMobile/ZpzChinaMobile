//
//  LandscapingTableViewCell.m
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-20.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "LandscapingTableViewCell.h"

@implementation LandscapingTableViewCell
@synthesize delegate;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier dic:(NSMutableDictionary *)dic flag:(int)flag singleDic:(NSMutableDictionary *)singleDic
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        UIImageView *lingImage = [[UIImageView alloc] initWithFrame:CGRectMake(18, 0, 6, 150)];
        [lingImage setBackgroundColor:[UIColor blackColor]];
        [self addSubview:lingImage];
        lingImage.alpha = 0.1;
        
        UIImageView *lingImage2 = [[UIImageView alloc] initWithFrame:CGRectMake(60, 50, 250, 1)];
        [lingImage2 setImage:[UIImage imageNamed:@"新建项目5_27.png"]];
        [self addSubview:lingImage2];
        
        UIButton *green = [UIButton buttonWithType:UIButtonTypeCustom];
        green.frame = CGRectMake(60,15, 200, 30);
        if(flag == 0){
            if(![[dic objectForKey:@"green"] isEqualToString:@""]){
                [green setTitle:[NSString stringWithFormat:@"景观绿化:%@",[dic objectForKey:@"green"]] forState:UIControlStateNormal];
            }else{
                [green setTitle:@"景观绿化" forState:UIControlStateNormal];
            }
        }else{
            if(![[dic objectForKey:@"green"] isEqualToString:@""]){
                [green setTitle:[NSString stringWithFormat:@"%@",[dic objectForKey:@"green"]] forState:UIControlStateNormal];
            }else{
                if(![[singleDic objectForKey:@"green"] isEqualToString:@""]){
                    [green setTitle:[NSString stringWithFormat:@"%@",[singleDic objectForKey:@"green"]] forState:UIControlStateNormal];
                }else{
                    [green setTitle:@"景观绿化" forState:UIControlStateNormal];
                }
            }
        }
        [green setTitleColor:BlueColor forState:UIControlStateNormal];
        green.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        green.titleLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:16];
        [green addTarget:self action:@selector(green) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:green];
        
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

-(void)green{
    if ([delegate respondsToSelector:@selector(addContactViewLandscaping)]){
        [delegate addContactViewLandscaping];
    }
}

@end
