//
//  ClearFire.m
//  ZpzchinaMobile
//
//  Created by Jack on 14-8-14.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "ClearFireCell.h"

@implementation ClearFireCell
@synthesize delegate;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier dic:(NSMutableDictionary *)dic flag:(int)flag Arr:(NSMutableArray *)Arr singleDic:(NSMutableDictionary *)singleDic;
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        
        
        UIImageView *arrowImage1 = [[UIImageView alloc] initWithFrame:CGRectMake(63,16, 10, 18)];
        [arrowImage1 setImage:[UIImage imageNamed:@"新建项目5_09.png"]];
        [self addSubview:arrowImage1];
        
        UIImageView *arrowImage2 = [[UIImageView alloc] initWithFrame:CGRectMake(95,50+16, 10, 18)];
        [arrowImage2 setImage:[UIImage imageNamed:@"新建项目5_09.png"]];
        [self addSubview:arrowImage2];
        
        NSArray *titleArray = @[@"消防",@"景观绿化"];
        for (int i =0; i<2; i++) {
            
            
            
            UIImageView *lingImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 50*(i+1), 280, 1)];
            [lingImage setImage:[UIImage imageNamed:@"新建项目5_27.png"]];
            [self addSubview:lingImage];
            
            UIButton *tempBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            if (i==0) {
                tempBtn.frame = CGRectMake(0,10+50*i, 80, 30);
            }else{
                tempBtn.frame = CGRectMake(15,10+50*i, 80, 30);

            }


            tempBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
            [tempBtn setTitle:[titleArray objectAtIndex:i] forState:UIControlStateNormal];
            [tempBtn setTitleColor:BlueColor forState:UIControlStateNormal];
            [tempBtn addTarget:self action:@selector(tempBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:tempBtn];
            
            
        }
        
        
        
    }
    return self;
    
    
}

-(void)tempBtnClicked:(UIButton *)button
{
        if ([delegate respondsToSelector:@selector(addContactViewFirefighting)]){
            [delegate addContactViewFirefighting];
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
