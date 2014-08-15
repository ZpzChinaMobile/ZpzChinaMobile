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
                
                UIImageView *arrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(100,50*i+16, 10, 18)];
                [arrowImage setImage:[UIImage imageNamed:@"新建项目5_09.png"]];
                [self addSubview:arrowImage];
                
                UIImageView *lingImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 50*(i+1), 280, 1)];
                [lingImage setImage:[UIImage imageNamed:@"新建项目5_27.png"]];
                [self addSubview:lingImage];
                
                
        }
        
        UIButton *tempBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        tempBtn1.frame = CGRectMake(15,10, 80, 30);
        [tempBtn1 setTitle:@"弱电安装" forState:UIControlStateNormal];
        [tempBtn1 setTitleColor:BlueColor forState:UIControlStateNormal];
        [tempBtn1 addTarget:self action:@selector(tempBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:tempBtn1];
        
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(130,10, 120, 30)];
        [self addSubview:label1];
        
        UIButton *tempBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        tempBtn2.frame = CGRectMake(15,10+50, 80, 30);
        [tempBtn2 setTitle:@"装修情况" forState:UIControlStateNormal];
        [tempBtn2 setTitleColor:BlueColor forState:UIControlStateNormal];
        [tempBtn2 addTarget:self action:@selector(tempBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:tempBtn2];
        
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(130,10+50, 120, 30)];
        [self addSubview:label2];

        
        UIButton *tempBtn3 = [UIButton buttonWithType:UIButtonTypeCustom];
        tempBtn3.frame = CGRectMake(15,10+100, 80, 30);
        [tempBtn3 setTitle:@"装修进度" forState:UIControlStateNormal];
        [tempBtn3 setTitleColor:BlueColor forState:UIControlStateNormal];
        [tempBtn3 addTarget:self action:@selector(tempBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:tempBtn3];
        
        UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(130,10+100, 120, 30)];
        [self addSubview:label3];

        
        
        
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
