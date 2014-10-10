//
//  GeologicalSurveyTableViewCell.m
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-20.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "GeologicalSurveyTableViewCell.h"
#import "CameraModel.h"
#import "CameraSqlite.h"
#import "GTMBase64.h"
@implementation GeologicalSurveyTableViewCell
@synthesize delegate;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier flag:(int)flag Arr:(NSMutableArray *)Arr explorationImageArr:(NSMutableArray *)explorationImageArr
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIFont* myFont=[UIFont fontWithName:@"GurmukhiMN" size:15];
        
        UIImageView *lingImage2 = [[UIImageView alloc] initWithFrame:CGRectMake(20, 50, 280, 1)];
        [lingImage2 setImage:[GetImagePath getImagePath:@"新建项目5_27"]];
        [self addSubview:lingImage2];
        
        UIImageView *addImage = [[UIImageView alloc] initWithFrame:CGRectMake(90,15, 20, 20)];
        [addImage setImage:[GetImagePath getImagePath:@"新建项目5_03"]];
        [self addSubview:addImage];
        
        UIButton *Company = [UIButton buttonWithType:UIButtonTypeCustom];
        Company.frame = CGRectMake(20,11, 140, 30);
        [Company setTitle:@"地勘公司" forState:UIControlStateNormal];
        [Company setTitleColor:BlueColor forState:UIControlStateNormal];
        Company.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        Company.titleLabel.font = myFont;
        [Company addTarget:self action:@selector(Company) forControlEvents:UIControlEventTouchUpInside];
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
                        [contactBtn setFrame:CGRectMake(120, 11, 60, 30)];
                    }else if(i == 1){
                        [contactBtn setFrame:CGRectMake(180, 11, 60, 30)];
                    }else{
                        [contactBtn setFrame:CGRectMake(240, 11, 60, 30)];
                    }
                    [self addSubview:contactBtn];
                }
            }
        }
        
        NSLog(@"==> %@",explorationImageArr);
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
    if ([delegate respondsToSelector:@selector(addContactViewGeologicalSurvey)]){
        [delegate addContactViewGeologicalSurvey];
    }
}

-(void)contactBtn:(UIButton *)button{
    if ([delegate respondsToSelector:@selector(updataExplorationUnitContacts:index:)]){
        [delegate updataExplorationUnitContacts:[dataArr objectAtIndex:button.tag-1] index:button.tag];
    }
}

-(void)gotoMoreExploration{
//    if ([delegate respondsToSelector:@selector(moreImage:)]){
//        [delegate moreImage:3];
//    }
}
@end
