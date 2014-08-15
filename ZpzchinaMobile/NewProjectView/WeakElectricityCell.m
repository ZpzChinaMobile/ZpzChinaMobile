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
            NSArray *titleArray = @[@"弱电安装",@"装修情况",@"装修进度"];
            for (int i =0; i<3; i++) {
                
                UIImageView *arrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(100,50*i+16, 10, 18)];
                [arrowImage setImage:[UIImage imageNamed:@"新建项目5_09.png"]];
                [self addSubview:arrowImage];
                
                UIImageView *lingImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 50*(i+1), 280, 1)];
                [lingImage setImage:[UIImage imageNamed:@"新建项目5_27.png"]];
                [self addSubview:lingImage];
                
                UIButton *tempBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                tempBtn.frame = CGRectMake(15,10+50*i, 80, 30);
                tempBtn.tag = i;
                
                [tempBtn setTitle:[titleArray objectAtIndex:i] forState:UIControlStateNormal];
                [tempBtn setTitleColor:BlueColor forState:UIControlStateNormal];
                [tempBtn addTarget:self action:@selector(tempBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
                [self.contentView addSubview:tempBtn];
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
