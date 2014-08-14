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
    cell.backgroundColor=[UIColor clearColor];
    
    //被点击的底色back
    UIView* selectedBack=[[UIView alloc]initWithFrame:CGRectMake( 0, 0, 320, 34)];
    selectedBack.backgroundColor=RGBCOLOR(234, 234, 234);
    cell.selectedBackgroundView=selectedBack;
    
    //被点击后左边的蓝色图
    UIView* selectedIcon=[[UIView alloc]initWithFrame:CGRectMake( 0, 0, 2.5, 34+1)];//被选中后蓝的图片会稍微短1个坐标点，不知道原因
    selectedIcon.backgroundColor=RGBCOLOR(82, 125, 237);
    [selectedBack addSubview:selectedIcon];
    
    
    NSArray* ary0=@[@"土地规划/拍卖",@"项目立项"];
    NSArray* ary1=@[@"地勘阶段",@"设计阶段",@"出图阶段"];
    NSArray* ary2=@[@"地平",@"桩基基坑",@"主体施工",@"消防/景观绿化"];
    NSArray* ary3=@[@"装修阶段"];
    NSArray* arrayTotal=@[ary0,ary1,ary2,ary3];
    
    //小阶段名称label
    cell.stageLabel=[[UILabel alloc]initWithFrame:CGRectMake(47, 4, 150, 20)];
    cell.stageLabel.text=arrayTotal[indexPath.section][indexPath.row];
    cell.stageLabel.font=[UIFont systemFontOfSize:14];
    [cell.contentView addSubview:cell.stageLabel];
    
    //右边三个小icon的最右边那个，必显示，但是图不同
    int a[4]={2,3,4,1};
    for (int i=0; i<4; i++) {
        if(number-a[i]<=0){
            break;
        }
        number-=a[i];
    }
    
    UIImageView* imageView=[[UIImageView alloc]initWithFrame:CGRectMake(270, 4, 16, 16)];
    imageView.image=[UIImage imageNamed:@"XiangMuXiangQing_ShaiXuan/right@2x.png"];//1则是勾的图，0则是没勾的图
    [cell.contentView addSubview:imageView];
    
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
