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
        // Initialization code
//        UIImageView *lingImage = [[UIImageView alloc] initWithFrame:CGRectMake(18, 0, 6, 150)];
//        [lingImage setBackgroundColor:[UIColor blackColor]];
//        [self addSubview:lingImage];
//        lingImage.alpha = 0.1;
        
        UIImageView *lingImage2 = [[UIImageView alloc] initWithFrame:CGRectMake(20, 50, 280, 1)];
        [lingImage2 setImage:[UIImage imageNamed:@"新建项目5_27.png"]];
        [self addSubview:lingImage2];
        
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
                if(i<3){
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
                    }else{
                        [contactBtn setFrame:CGRectMake(240, 10, 60, 30)];
                    }
                    [self addSubview:contactBtn];
                }
            }
        }
        
        NSLog(@"==> %@",explorationImageArr);
        UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(40, 52, 270, 98)];
        imageArr = explorationImageArr;
        if(imageArr.count !=0){
            for(int i=0;i<imageArr.count;i++){
                CameraModel *model = [imageArr objectAtIndex:i];
                UIImage *aimage = [[UIImage alloc] init];
                if(flag == 0){
                    aimage = [UIImage imageWithData:[GTMBase64 decodeString:model.a_body]];
                }else{
                    NSLog(@"a_device ==> %@",model.a_device);
                    if([model.a_device isEqualToString:@"localios"]){
                        aimage = [UIImage imageWithData:[GTMBase64 decodeString:model.a_body]];
                    }else{
                        aimage = [UIImage imageWithData:[GTMBase64 decodeString:model.a_imgCompressionContent]];
                    }
                }
                UIImageView *image = [[UIImageView alloc] init];
                image.tag = 0;
                [image setImage:aimage];
                [image setFrame:CGRectMake(270/3*i, 10, 80, 80)];
                image.userInteractionEnabled = YES;
                UITapGestureRecognizer *imagetapGestureRecognizer = [[UITapGestureRecognizer alloc] init];
                [imagetapGestureRecognizer addTarget:self action:@selector(gotoMoreExploration)];
                [imagetapGestureRecognizer setNumberOfTapsRequired:1];
                [imagetapGestureRecognizer setNumberOfTouchesRequired:1];
                [image addGestureRecognizer:imagetapGestureRecognizer];
                [view1 addSubview:image];
            }
        }else{
            for(int i=0;i<3;i++){
                UIImageView *image = [[UIImageView alloc] init];
                [image setFrame:CGRectMake(270/3*i, 10, 80, 80)];
                [image setImage:[UIImage imageNamed:@"NoImage.png"]];
                [view1 addSubview:image];
            }
        }
        [self addSubview:view1];
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
