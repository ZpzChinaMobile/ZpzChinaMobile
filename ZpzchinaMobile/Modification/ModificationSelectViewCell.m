//
//  ModificationSelectViewCell.m
//  ZpzchinaMobile
//
//  Created by 孙元侃 on 14-8-14.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "ModificationSelectViewCell.h"

@implementation ModificationSelectViewCell
+(ModificationSelectViewCell*)dequeueReusableCellWithTabelView:(UITableView*)tableView identifier:(NSString*)identifier indexPath:(NSIndexPath*)indexPath nowTableView:(NSInteger)number{
    
    ModificationSelectViewCell* cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    cell.backgroundColor=[UIColor clearColor];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    NSArray* ary0=@[@"土地规划/拍卖",@"项目立项"];
    NSArray* ary1=@[@"地勘阶段",@"设计阶段",@"出图阶段"];
    NSArray* ary2=@[@"地平",@"桩基基坑",@"主体施工",@"消防/景观绿化"];
    NSArray* ary3=@[@"装修阶段"];
    NSArray* arrayTotal=@[ary0,ary1,ary2,ary3];
    
    //小阶段名称label
    cell.stageLabel=[[UILabel alloc]initWithFrame:CGRectMake(47, 6, 150, 20)];
    cell.stageLabel.text=arrayTotal[indexPath.section][indexPath.row];
    cell.stageLabel.font=[UIFont systemFontOfSize:14];
    cell.stageLabel.textColor=RGBCOLOR(50, 50, 50);
    [cell.contentView addSubview:cell.stageLabel];
    
    //右边三个小icon的最右边那个，必显示，但是图不同
    int a[4]={0,2,5,9};
    number=number-a[indexPath.section];
    
    //cell.sureImageView=nil;
    if (indexPath.row==number) {
        cell.sureImageView=[[UIImageView alloc]initWithFrame:CGRectMake(270, 9, 16, 16)];
        cell.sureImageView.image=[GetImagePath getImagePath:@"016"];
        [cell.contentView addSubview:cell.sureImageView];
    }
    return cell;
}



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
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

@end
