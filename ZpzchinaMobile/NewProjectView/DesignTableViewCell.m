//
//  DesignTableViewCell.m
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-20.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "DesignTableViewCell.h"

@implementation DesignTableViewCell
@synthesize delegate;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier dic:(NSMutableDictionary *)dic flag:(int)flag Arr:(NSMutableArray *)Arr singleDic:(NSMutableDictionary *)singleDic
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code

        for (int i=0; i<2; i++) {
            UIImageView *lingImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 50*(i+1), 280, 1)];
            [lingImage setImage:[UIImage imageNamed:@"新建项目5_27.png"]];
            [self addSubview:lingImage];
        }
        
        UIImageView *addImage = [[UIImageView alloc] initWithFrame:CGRectMake(90,15, 20, 20)];
        [addImage setImage:[UIImage imageNamed:@"新建项目5_03.png"]];
        [self addSubview:addImage];
        
        UIButton *Company = [UIButton buttonWithType:UIButtonTypeCustom];
        Company.frame = CGRectMake(20,10, 140, 30);
        [Company setTitle:@"地勘公司" forState:UIControlStateNormal];
        [Company setTitleColor:BlueColor forState:UIControlStateNormal];
        Company.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        Company.titleLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:16];
        [Company addTarget:self action:@selector(Company) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:Company];
        
               dataArr = [NSMutableArray arrayWithArray:Arr];
        if(Arr.count != 0){
            for(int i=0; i<Arr.count;i++){
                if(i<2){
                    UIButton *contactBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                    [contactBtn setTitle:[[Arr objectAtIndex:i] objectForKey:@"contactName"] forState:UIControlStateNormal];
                    contactBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                    contactBtn.tag = i+1;
                    [contactBtn setTitleColor:BlueColor forState:UIControlStateNormal];
                    contactBtn.titleLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:16];
                    [contactBtn addTarget:self action:@selector(contactBtn:) forControlEvents:UIControlEventTouchUpInside];
                    if(i == 0){
                        [contactBtn setFrame:CGRectMake(120, 10, 60, 30)];
                    }else if(i == 1){
                        [contactBtn setFrame:CGRectMake(180, 10, 60, 30)];
                    }
                        else{
                        [contactBtn setFrame:CGRectMake(240, 10, 60, 30)];
                    }
                    [self addSubview:contactBtn];
                }
            }
        }
        
        UIButton *Bodydesign = [UIButton buttonWithType:UIButtonTypeCustom];
        Bodydesign.frame = CGRectMake(20,65, 200, 30);
        if(flag == 0){
            //NSLog(@"========");
            if(![[dic objectForKey:@"mainDesignStage"] isEqualToString:@""]){
                [Bodydesign setTitle:[NSString stringWithFormat:@"%@",[dic objectForKey:@"mainDesignStage"]] forState:UIControlStateNormal];
            }else{
                [Bodydesign setTitle:@"主体设计阶段" forState:UIControlStateNormal];
            }
        }else{
            if(![[dic objectForKey:@"mainDesignStage"] isEqualToString:@""]){
                [Bodydesign setTitle:[NSString stringWithFormat:@"%@",[dic objectForKey:@"mainDesignStage"]] forState:UIControlStateNormal];
            }else{
                if(![[singleDic objectForKey:@"mainDesignStage"] isEqualToString:@""]){
                    [Bodydesign setTitle:[NSString stringWithFormat:@"%@",[singleDic objectForKey:@"mainDesignStage"]] forState:UIControlStateNormal];
                }else{
                    [Bodydesign setTitle:@"主体设计阶段" forState:UIControlStateNormal];
                }
            }
        }
        [Bodydesign setTitleColor:BlueColor forState:UIControlStateNormal];
        Bodydesign.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        Bodydesign.titleLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:16];
        [Bodydesign addTarget:self action:@selector(Bodydesign) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:Bodydesign];
        
        UIImageView *arrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(130,70, 10, 18)];
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

-(void)Company{
    if ([delegate respondsToSelector:@selector(addContactViewDesign)]){
        [delegate addContactViewDesign];
    }
}

-(void)contactBtn:(UIButton *)button{
    if ([delegate respondsToSelector:@selector(updataDesignInstituteContacts:index:)]){
        [delegate updataDesignInstituteContacts:[dataArr objectAtIndex:button.tag-1] index:button.tag];
    }
}

-(void)Bodydesign{
    if ([delegate respondsToSelector:@selector(addSinglePickerView)]){
        [delegate addSinglePickerView];
    }
}
@end
