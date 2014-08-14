//
//  PlotTableViewCell.m
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-20.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "PlotTableViewCell.h"

@implementation PlotTableViewCell
@synthesize delegate;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier dic:(NSMutableDictionary *)dic flag:(int)flag Arr:(NSMutableArray *)Arr singleDic:(NSMutableDictionary *)singleDic
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        
        for (int i=0; i<8; i++) {
            UIImageView *lingImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 50*(i+1), 280, 1)];
            [lingImage setImage:[UIImage imageNamed:@"新建项目5_27.png"]];
            [self addSubview:lingImage];
        }
        
        UIImageView *addImage = [[UIImageView alloc] initWithFrame:CGRectMake(90,15, 20, 20)];
        [addImage setImage:[UIImage imageNamed:@"新建项目5_03.png"]];
        [self addSubview:addImage];
        
        UIButton *Owner = [UIButton buttonWithType:UIButtonTypeCustom];
        Owner.frame = CGRectMake(20,10, 140, 30);
        Owner.tag = 0;
        if(![[dic objectForKey:@"owner"] isEqualToString:@""]){//[NSString stringWithFormat:@"业主单位:      %@",[dic objectForKey:@"owner"]
            [Owner setTitle:@"业主单位" forState:UIControlStateNormal];
        }else{
            [Owner setTitle:@"业主单位" forState:UIControlStateNormal];
        }
        [Owner setTitleColor:BlueColor forState:UIControlStateNormal];
        Owner.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        Owner.titleLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:16];
        [Owner addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:Owner];
        
        UIButton *startdate = [UIButton buttonWithType:UIButtonTypeCustom];
        startdate.frame = CGRectMake(20,65, 200, 30);
        startdate.tag = 1;
        if(flag == 0){
            if(![[dic objectForKey:@"expectedStartTime"] isEqualToString:@""]){
                NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd"];
                NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[[dic objectForKey:@"expectedStartTime"] intValue]];
                NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
                [startdate setTitle:[NSString stringWithFormat:@"预计开工时间:%@",confromTimespStr] forState:UIControlStateNormal];
            }else{
                [startdate setTitle:@"预计开工时间" forState:UIControlStateNormal];
            }
        }else{
            if(![[dic objectForKey:@"expectedStartTime"] isEqualToString:@""]){
                NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd"];
                NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[[dic objectForKey:@"expectedStartTime"] intValue]];
                NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
                [startdate setTitle:[NSString stringWithFormat:@"预计开工时间:%@",confromTimespStr] forState:UIControlStateNormal];
            }else{
                if(![[singleDic objectForKey:@"expectedStartTime"] isEqualToString:@""]){
                    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
                    [formatter setDateFormat:@"yyyy-MM-dd"];
                    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[[singleDic objectForKey:@"expectedStartTime"] intValue]];
                    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
                    [startdate setTitle:[NSString stringWithFormat:@"预计开工时间:%@",confromTimespStr] forState:UIControlStateNormal];
                }else{
                    [startdate setTitle:@"预计开工时间" forState:UIControlStateNormal];
                }
            }
        }
        [startdate setTitleColor:GrayColor forState:UIControlStateNormal];
        startdate.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        startdate.titleLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:16];;
        [startdate addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:startdate];
        
        UIButton *enddate = [UIButton buttonWithType:UIButtonTypeCustom];
        enddate.frame = CGRectMake(20,115, 200, 30);
        enddate.tag = 2;
        if(flag == 0){
            if(![[dic objectForKey:@"expectedFinishTime"] isEqualToString:@""]){
                NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd"];
                NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[[dic objectForKey:@"expectedFinishTime"] intValue]];
                NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
                [enddate setTitle:[NSString stringWithFormat:@"预计竣工时间:%@",confromTimespStr] forState:UIControlStateNormal];
            }else{
                [enddate setTitle:@"预计竣工时间" forState:UIControlStateNormal];
            }
        }else{
            if(![[dic objectForKey:@"expectedFinishTime"] isEqualToString:@""]){
                NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd"];
                NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[[dic objectForKey:@"expectedFinishTime"] intValue]];
                NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
                [enddate setTitle:[NSString stringWithFormat:@"预计竣工时间:%@",confromTimespStr] forState:UIControlStateNormal];
            }else{
                if(![[singleDic objectForKey:@"expectedFinishTime"] isEqualToString:@""]){
                    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
                    [formatter setDateFormat:@"yyyy-MM-dd"];
                    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[[singleDic objectForKey:@"expectedFinishTime"] intValue]];
                    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
                    [enddate setTitle:[NSString stringWithFormat:@"预计竣工时间:%@",confromTimespStr] forState:UIControlStateNormal];
                }else{
                    [enddate setTitle:@"预计竣工时间" forState:UIControlStateNormal];
                }
            }
        }
        [enddate setTitleColor:GrayColor forState:UIControlStateNormal];
        enddate.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        enddate.titleLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:16];;
        [enddate addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:enddate];
        
        UIButton *Elevator = [UIButton buttonWithType:UIButtonTypeCustom];
        Elevator.frame = CGRectMake(20,165, 140, 30);
        [Elevator setTitle:@"电梯" forState:UIControlStateNormal];
        [Elevator setTitleColor:BlueColor forState:UIControlStateNormal];
        Elevator.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        Elevator.titleLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:16];;
        //[Elevator addTarget:self action:@selector(LotNameClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:Elevator];
        
        UIButton *Airconditioning = [UIButton buttonWithType:UIButtonTypeCustom];
        Airconditioning.frame = CGRectMake(20,215, 140, 30);
        [Airconditioning setTitle:@"空调" forState:UIControlStateNormal];
        [Airconditioning setTitleColor:BlueColor forState:UIControlStateNormal];
        Airconditioning.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        Airconditioning.titleLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:16];;
        //[Airconditioning addTarget:self action:@selector(LotNameClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:Airconditioning];
        
        UIButton *Heatingmode = [UIButton buttonWithType:UIButtonTypeCustom];
        Heatingmode.frame = CGRectMake(20,265, 140, 30);
        [Heatingmode setTitle:@"供暖方式" forState:UIControlStateNormal];
        [Heatingmode setTitleColor:BlueColor forState:UIControlStateNormal];
        Heatingmode.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        Heatingmode.titleLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:16];;
        //[zone addTarget:self action:@selector(LotNameClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:Heatingmode];
        
        UIButton *Exteriormaterials = [UIButton buttonWithType:UIButtonTypeCustom];
        Exteriormaterials.frame = CGRectMake(20,315, 140, 30);
        [Exteriormaterials setTitle:@"外墙材料" forState:UIControlStateNormal];
        [Exteriormaterials setTitleColor:BlueColor forState:UIControlStateNormal];
        Exteriormaterials.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        Exteriormaterials.titleLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:16];;
        //[Exteriormaterials addTarget:self action:@selector(LotNameClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:Exteriormaterials];
        
        UIButton *Steel = [UIButton buttonWithType:UIButtonTypeCustom];
        Steel.frame = CGRectMake(20,365, 140, 30);
        [Steel setTitle:@"刚结构" forState:UIControlStateNormal];
        [Steel setTitleColor:BlueColor forState:UIControlStateNormal];
        Steel.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        Steel.titleLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:16];;
        //[Steel addTarget:self action:@selector(LotNameClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:Steel];
        
        NSLog(@"%@",dic);
        for(int i=0;i<5;i++){
            UISwitch* mySwitch = [[ UISwitch alloc]init];
            mySwitch.tag = i;
            if(i == 0){
                [mySwitch setFrame:CGRectMake(240, 160, 0, 0)];
                if(flag == 0){
                    if([[dic objectForKey:@"propertyElevator"] isEqualToString:@"0"]){
                        [mySwitch setOn:NO];
                    }else{
                        [mySwitch setOn:YES];
                    }
                }else{
                    if([[dic objectForKey:@"propertyElevator"] isEqualToString:@""]){
                        if([[singleDic objectForKey:@"propertyElevator"] isEqualToString:@"0"]){
                            [mySwitch setOn:NO];
                        }else{
                            [mySwitch setOn:YES];
                        }
                    }else{
                        if([[dic objectForKey:@"propertyElevator"] isEqualToString:@"0"]){
                            [mySwitch setOn:NO];
                        }else{
                            [mySwitch setOn:YES];
                        }
                    }
                }
            }else if(i == 1){
                [mySwitch setFrame:CGRectMake(240, 210, 0, 0)];
                if(flag == 0){
                    if([[dic objectForKey:@"propertyAirCondition"] isEqualToString:@"0"]){
                        [mySwitch setOn:NO];
                    }else{
                        [mySwitch setOn:YES];
                    }
                }else{
                    if([[dic objectForKey:@"propertyAirCondition"] isEqualToString:@""]){
                        if([[singleDic objectForKey:@"propertyAirCondition"] isEqualToString:@"0"]){
                            [mySwitch setOn:NO];
                        }else{
                            [mySwitch setOn:YES];
                        }
                    }else{
                        if([[dic objectForKey:@"propertyAirCondition"] isEqualToString:@"0"]){
                            [mySwitch setOn:NO];
                        }else{
                            [mySwitch setOn:YES];
                        }
                    }
                }
            }else if(i==2){
                [mySwitch setFrame:CGRectMake(240, 260, 0, 0)];
                if(flag == 0){
                    if([[dic objectForKey:@"propertyHeating"] isEqualToString:@"0"]){
                        [mySwitch setOn:NO];
                    }else{
                        [mySwitch setOn:YES];
                    }
                }else{
                    if([[dic objectForKey:@"propertyHeating"] isEqualToString:@""]){
                        if([[singleDic objectForKey:@"propertyHeating"] isEqualToString:@"0"]){
                            [mySwitch setOn:NO];
                        }else{
                            [mySwitch setOn:YES];
                        }
                    }else{
                        if([[dic objectForKey:@"propertyHeating"] isEqualToString:@"0"]){
                            [mySwitch setOn:NO];
                        }else{
                            [mySwitch setOn:YES];
                        }
                    }
                }
            }else if(i ==3){
                [mySwitch setFrame:CGRectMake(240, 310, 0, 0)];
                if(flag == 0){
                    if([[dic objectForKey:@"propertyExternalWallMeterial"] isEqualToString:@"0"]){
                        [mySwitch setOn:NO];
                    }else{
                        [mySwitch setOn:YES];
                    }
                }else{
                    if([[dic objectForKey:@"propertyExternalWallMeterial"] isEqualToString:@""]){
                        if([[singleDic objectForKey:@"propertyExternalWallMeterial"] isEqualToString:@"0"]){
                            [mySwitch setOn:NO];
                        }else{
                            [mySwitch setOn:YES];
                        }
                    }else{
                        if([[dic objectForKey:@"propertyExternalWallMeterial"] isEqualToString:@"0"]){
                            [mySwitch setOn:NO];
                        }else{
                            [mySwitch setOn:YES];
                        }
                    }
                }
            }else{
                [mySwitch setFrame:CGRectMake(240, 360, 0, 0)];
                if(flag == 0){
                    if([[dic objectForKey:@"propertyStealStructure"] isEqualToString:@"0"]){
                        [mySwitch setOn:NO];
                    }else{
                        [mySwitch setOn:YES];
                    }
                }else{
                    if([[dic objectForKey:@"propertyStealStructure"] isEqualToString:@""]){
                        if([[singleDic objectForKey:@"propertyStealStructure"] isEqualToString:@"0"]){
                            [mySwitch setOn:NO];
                        }else{
                            [mySwitch setOn:YES];
                        }
                    }else{
                        if([[dic objectForKey:@"propertyStealStructure"] isEqualToString:@"0"]){
                            [mySwitch setOn:NO];
                        }else{
                            [mySwitch setOn:YES];
                        }
                    }
                }
            }
            [mySwitch addTarget: self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
            [self addSubview:mySwitch];
        }
        
        
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
                        [contactBtn setFrame:CGRectMake(130, 10, 60, 30)];
                    }else if(i == 1){
                        [contactBtn setFrame:CGRectMake(180, 10, 60, 30)];
                    }else{
                        [contactBtn setFrame:CGRectMake(230, 10, 60, 30)];
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
    if ([delegate respondsToSelector:@selector(addContactViewPlot:)]){
        [delegate addContactViewPlot:button.tag];
    }
}

-(void)contactBtn:(UIButton *)button{
    if ([delegate respondsToSelector:@selector(updataPlotOwner:index:)]){
        [delegate updataPlotOwner:[dataArr objectAtIndex:button.tag-1] index:button.tag];
    }
}

- (void) switchValueChanged:(id)sender{
    UISwitch* control = (UISwitch*)sender;
    if ([delegate respondsToSelector:@selector(addSwitchValue:value:)]){
        [delegate addSwitchValue:control.tag value:control.on];
    }
}
@end
