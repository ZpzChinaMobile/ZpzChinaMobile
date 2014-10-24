//
//  BesideViewAlert.m
//  ZpzchinaMobile
//
//  Created by 孙元侃 on 14/10/24.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "BesideViewAlert.h"
@interface BesideViewAlert()
@property(nonatomic,strong)UILabel* leftLabel;
@property(nonatomic,strong)UILabel* rightLabel;
@property(nonatomic,strong)UIImageView* left;
@property(nonatomic,strong)UIImageView* right;
@end
@implementation BesideViewAlert
-(instancetype)init{
    if (self=[super init]) {
        self.frame=CGRectMake(0, 0, 320, 45);
        self.backgroundColor=RGBCOLOR(243, 243, 243);
        
        UIFont* font=[UIFont systemFontOfSize:15];
        self.leftLabel=[[UILabel alloc]initWithFrame:CGRectMake(30, 12.5, 120, 20)];
        self.leftLabel.textColor=GrayColor;
        self.leftLabel.font=font;
        [self addSubview:self.leftLabel];
        self.rightLabel=[[UILabel alloc]initWithFrame:CGRectMake(170, 12.5, 120, 20)];
        self.rightLabel.textColor=GrayColor;
        self.rightLabel.font=font;
        self.rightLabel.textAlignment=NSTextAlignmentRight;
        [self addSubview:self.rightLabel];
        
        self.left=[[UIImageView alloc]initWithImage:[GetImagePath getImagePath:@"新建项目_210a"]];
        self.left.center=CGPointMake(20, 22);
        [self addSubview:self.left];
        self.right=[[UIImageView alloc]initWithImage:[GetImagePath getImagePath:@"新建项目_211a"]];
        self.right.center=CGPointMake(300, 22);
        [self addSubview:self.right];
    }
    return self;
}

-(void)setLeftText:(NSString*)leftStr rigthText:(NSString*)rightStr{
    self.leftLabel.text=leftStr;
    self.rightLabel.text=rightStr;
    self.left.hidden=leftStr?NO:YES;
    self.right.hidden=rightStr?NO:YES;
}
@end
