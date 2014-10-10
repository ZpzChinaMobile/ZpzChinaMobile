//
//  PilePitTableViewCell.m
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-20.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "PilePitTableViewCell.h"

@implementation PilePitTableViewCell
@synthesize delegate;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier flag:(int)flag Arr:(NSMutableArray *)Arr
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIFont* myFont=[UIFont fontWithName:@"GurmukhiMN" size:15];
        
        UIImageView *lingImage2 = [[UIImageView alloc] initWithFrame:CGRectMake(20, 50, 280, 1)];
        [lingImage2 setImage:[GetImagePath getImagePath:@"新建项目5_27"]];
        [self addSubview:lingImage2];
        
        UIImageView *addImage = [[UIImageView alloc] initWithFrame:CGRectMake(115,15, 20, 20)];
        [addImage setImage:[GetImagePath getImagePath:@"新建项目5_03"]];
        [self addSubview:addImage];
        
        UIButton *Company = [UIButton buttonWithType:UIButtonTypeCustom];
        Company.frame = CGRectMake(20,10, 140, 30);
        [Company setTitle:@"桩基分包单位" forState:UIControlStateNormal];
        [Company setTitleColor:BlueColor forState:UIControlStateNormal];
        Company.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        Company.titleLabel.font = myFont;
        [Company addTarget:self action:@selector(CompanyClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:Company];
        
        dataArr = [NSMutableArray arrayWithArray:Arr];
        if(Arr.count != 0){
            for(int i=0; i<Arr.count;i++){
                if(i<3){
                    UIButton *contactBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                    [contactBtn setTitle:[[Arr objectAtIndex:i] objectForKey:@"contactName"] forState:UIControlStateNormal];
                    contactBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                    contactBtn.tag = i+1;
                    [contactBtn setTitleColor:BlueColor forState:UIControlStateNormal];
                    contactBtn.titleLabel.font = myFont;
                    [contactBtn addTarget:self action:@selector(contactBtn:) forControlEvents:UIControlEventTouchUpInside];
                    if(i == 0){
                        [contactBtn setFrame:CGRectMake(140, 10, 60, 30)];
                    }else if(i == 1){
                        [contactBtn setFrame:CGRectMake(200, 10, 60, 30)];
                    }else{
                        [contactBtn setFrame:CGRectMake(260, 10, 60, 30)];
                    }
                    [self addSubview:contactBtn];
                }
            }
        }
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

-(void)CompanyClick{
    if ([delegate respondsToSelector:@selector(addContactViewPilePit)]){
        [delegate addContactViewPilePit];
    }
}

-(void)contactBtn:(UIButton *)button{
    if ([delegate respondsToSelector:@selector(updataPileFoundationUnitContacts:index:)]){
        [delegate updataPileFoundationUnitContacts:[dataArr objectAtIndex:button.tag-1] index:button.tag];
    }
}
@end
