//
//  SearchCellView.m
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-19.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "SearchCellView.h"

@implementation SearchCellView
- (id)initWithFrame:(CGRect)frame contentStr:(NSString *)contentStr
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self addContent:contentStr];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
-(void)addContent:(NSString *)contentStr{
    UIImageView *smallImage = [[UIImageView alloc] initWithFrame:CGRectMake(20,12.5, 20, 20)];
    [smallImage setImage:[GetImagePath getImagePath:@"搜索1_03"]];
    [self addSubview:smallImage];
    
    UILabel *countLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 10, 100, 20)];
    countLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:16];
    countLabel.textColor = [UIColor blackColor];
    countLabel.text = contentStr;
    [self addSubview:countLabel];
}
@end
