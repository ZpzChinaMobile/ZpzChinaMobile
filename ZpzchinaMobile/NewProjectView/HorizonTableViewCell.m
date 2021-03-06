//
//  HorizonTableViewCell.m
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-20.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "HorizonTableViewCell.h"

@implementation HorizonTableViewCell
@synthesize delegate;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier dic:(NSMutableDictionary *)dic flag:(int)flag Arr:(NSMutableArray *)Arr singleDic:(NSMutableDictionary *)singleDic
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIFont* myFont=[UIFont systemFontOfSize:15];
        
        UIImageView *lingImage2 = [[UIImageView alloc] initWithFrame:CGRectMake(20, 50, 280, 1)];
        [lingImage2 setImage:[GetImagePath getImagePath:@"新建项目5_27"]];
        [self addSubview:lingImage2];
        
        UIButton *startdate = [UIButton buttonWithType:UIButtonTypeCustom];
        startdate.frame = CGRectMake(20,10, 200, 30);
        startdate.tag = 0;
        if(flag == 0){
            if(![[dic objectForKey:@"actualStartTime"] isEqualToString:@""]){
                NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd"];
                NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[[dic objectForKey:@"actualStartTime"] intValue]];
                NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
                [startdate setTitle:[NSString stringWithFormat:@"实际开工时间: %@",confromTimespStr] forState:UIControlStateNormal];
            }else{
                [startdate setTitle:@"实际开工时间" forState:UIControlStateNormal];
            }
        }else{
            if(![[dic objectForKey:@"actualStartTime"] isEqualToString:@""]){
                NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd"];
                NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[[dic objectForKey:@"actualStartTime"] intValue]];
                NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
                [startdate setTitle:[NSString stringWithFormat:@"实际开工时间: %@",confromTimespStr] forState:UIControlStateNormal];
            }else{
                if(![[singleDic objectForKey:@"actualStartTime"] isEqualToString:@""]){
                    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
                    [formatter setDateFormat:@"yyyy-MM-dd"];
                    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[[singleDic objectForKey:@"actualStartTime"] intValue]];
                    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
                    [startdate setTitle:[NSString stringWithFormat:@"实际开工时间: %@",confromTimespStr] forState:UIControlStateNormal];
                }else{
                    [startdate setTitle:@"实际开工时间" forState:UIControlStateNormal];
                }
            }
        }
        [startdate setTitleColor:GrayColor forState:UIControlStateNormal];
        startdate.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        startdate.titleLabel.font = myFont;
        [startdate addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:startdate];
        
        UIImageView *addImage = [[UIImageView alloc] initWithFrame:CGRectMake(105,68, 20, 20)];
        [addImage setImage:[GetImagePath getImagePath:@"新建项目5_03"]];
        [self addSubview:addImage];
        
        UIButton *contractor = [UIButton buttonWithType:UIButtonTypeCustom];
        contractor.frame = CGRectMake(20,63, 140, 30);
        contractor.tag = 1;
        [contractor setTitle:@"施工总承包" forState:UIControlStateNormal];
        [contractor setTitleColor:BlueColor forState:UIControlStateNormal];
        contractor.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        contractor.titleLabel.font = myFont;
        [contractor addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:contractor];
        
        dataArr = [NSMutableArray arrayWithArray:Arr];
        NSLog(@"%@",dataArr);
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
                        [contactBtn setFrame:CGRectMake(130, 63, 60, 30)];
                    }else if(i == 1){
                        [contactBtn setFrame:CGRectMake(190, 63, 60, 30)];
                    }else{
                        [contactBtn setFrame:CGRectMake(250, 63, 60, 30)];
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

-(void)BtnClick:(UIButton *)button{
    if ([delegate respondsToSelector:@selector(addContactViewHorizon:)]){
        [delegate addContactViewHorizon:button.tag];
    }
}

-(void)contactBtn:(UIButton *)button{
    if ([delegate respondsToSelector:@selector(updataContractorUnitContacts:index:)]){
        [delegate updataContractorUnitContacts:[dataArr objectAtIndex:button.tag-1] index:button.tag];
    }
}
@end
