//
//  PlanAndAuctionTableViewCell.m
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-20.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "PlanAndAuctionTableViewCell.h"
@implementation PlanAndAuctionTableViewCell
@synthesize delegate;
@synthesize dataArr;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier dic:(NSMutableDictionary *)dic singleDic:(NSMutableDictionary *)singleDic flag:(int)flag contactArr:(NSMutableArray *)contactArr
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        for (int i=0; i<6; i++) {
            UIImageView *lingImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 50*(i+1), 280, 1)];
            [lingImage setImage:[UIImage imageNamed:@"新建项目5_27.png"]];
            [self addSubview:lingImage];
        }
        
        UITextField *LotName = [[UITextField alloc] initWithFrame:CGRectMake(20,15, 200, 30)];
        LotName.delegate = self;
        LotName.textAlignment=NSTextAlignmentLeft;
        LotName.placeholder=@"地块名称";
        NSLog(@"%d",flag);
        NSLog(@"%@",dic);
        if(flag == 0){
            if(![[dic objectForKey:@"landName"] isEqualToString:@""]){
                [LotName setText:[NSString stringWithFormat:@"%@",[dic objectForKey:@"landName"]]];
            }
        }else{
            if(![[dic objectForKey:@"landName"] isEqualToString:@""]){
                [LotName setText:[NSString stringWithFormat:@"%@",[dic objectForKey:@"landName"]]];
            }else{
                if(![[singleDic objectForKey:@"landName"] isEqualToString:@""]){
                    [LotName setText:[NSString stringWithFormat:@"%@",[singleDic objectForKey:@"landName"]]];
                }
            }
        }
        LotName.returnKeyType=UIReturnKeyDone;
        LotName.tag = 0;
        //[LotName setClearButtonMode:UITextFieldViewModeWhileEditing];
        [self addSubview:LotName];
        
        UIButton *zone = [UIButton buttonWithType:UIButtonTypeCustom];
        zone.frame = CGRectMake(20,65, 220, 30);
        [zone setTitle:@"所在区域/省市" forState:UIControlStateNormal];
        [zone setTitleColor:BlueColor forState:UIControlStateNormal];
        zone.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        zone.titleLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:16];
        zone.tag = 0;
        [zone addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:zone];
        
        UILabel *zoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(145, 62, 220, 30)];
        zoneLabel.textColor = GrayColor;
        zoneLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:16];
        zoneLabel.textAlignment = NSTextAlignmentLeft;
        if(flag == 0){
            if(![[dic objectForKey:@"city"] isEqualToString:@""]){
                [zoneLabel setText:[NSString stringWithFormat:@"%@,%@",[dic objectForKey:@"district"],[dic objectForKey:@"city"]]];
            }else{
                [zoneLabel setText:@""];
            }
        }else{
            if(![[dic objectForKey:@"city"] isEqualToString:@""]){
                [zoneLabel setText:[NSString stringWithFormat:@"%@,%@",[dic objectForKey:@"district"],[dic objectForKey:@"city"]]];
            }else{
                if(![[singleDic objectForKey:@"city"] isEqualToString:@""]){
                    [zoneLabel setText:[NSString stringWithFormat:@"%@,%@",[singleDic objectForKey:@"district"],[singleDic objectForKey:@"city"]]];
                }else{
                    [zoneLabel setText:@""];
                }
            }
        }
        [self addSubview:zoneLabel];
        
        UIImageView *arrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(125,73, 8, 12.5)];
        [arrowImage setImage:[UIImage imageNamed:@"新建项目5_09.png"]];
        [self addSubview:arrowImage];
        
        UITextField *address = [[UITextField alloc] initWithFrame:CGRectMake(20,115, 200, 30)];
        address.delegate = self;
        address.textAlignment=NSTextAlignmentLeft;
        address.placeholder=@"地块地址";
        if(flag == 0){
            if(![[dic objectForKey:@"landAddress"] isEqualToString:@""]){
                [address setText:[NSString stringWithFormat:@"%@",[dic objectForKey:@"landAddress"]]];
            }
        }else{
            if(![[dic objectForKey:@"landAddress"] isEqualToString:@""]){
                [address setText:[NSString stringWithFormat:@"%@",[dic objectForKey:@"landAddress"]]];
            }else{
                if(![[singleDic objectForKey:@"landAddress"] isEqualToString:@""]){
                    [address setText:[NSString stringWithFormat:@"%@",[singleDic objectForKey:@"landAddress"]]];
                }
            }
        }
        address.returnKeyType=UIReturnKeyDone;
        address.tag = 1;
        //[address setClearButtonMode:UITextFieldViewModeWhileEditing];
        [self addSubview:address];
        
        UILabel *landareaLabe = [[UILabel alloc] initWithFrame:CGRectMake(20,160, 70, 30)];
        landareaLabe.font = [UIFont fontWithName:@"GurmukhiMN" size:16];
        landareaLabe.textColor = BlueColor;
        landareaLabe.text = @"土地面积:";
        [self addSubview:landareaLabe];
        
        UITextField *landarea = [[UITextField alloc] initWithFrame:CGRectMake(90,160, 150, 30)];
        landarea.delegate = self;
        landarea.textAlignment=NSTextAlignmentLeft;
        landarea.keyboardType = UIKeyboardTypeDecimalPad;
        if(flag == 0){
            if(![[NSString stringWithFormat:@"%@",[dic objectForKey:@"area"]] isEqualToString:@""]){
                [landarea setText:[NSString stringWithFormat:@"%@",[dic objectForKey:@"area"]]];
            }
        }else{
            if(![[NSString stringWithFormat:@"%@",[dic objectForKey:@"area"]] isEqualToString:@""]){
                [landarea setText:[NSString stringWithFormat:@"%@",[dic objectForKey:@"area"]]];
            }else{
                if(![[NSString stringWithFormat:@"%@",[singleDic objectForKey:@"area"]] isEqualToString:@""]){
                    [landarea setText:[NSString stringWithFormat:@"%@",[singleDic objectForKey:@"area"]]];
                }
            }
        }
        landarea.returnKeyType=UIReturnKeyDone;
        landarea.tag = 2;
        //[landarea setClearButtonMode:UITextFieldViewModeWhileEditing];
        [self addSubview:landarea];
        
        UILabel *volumerateLabe = [[UILabel alloc] initWithFrame:CGRectMake(20,215, 85, 30)];
        volumerateLabe.font = [UIFont fontWithName:@"GurmukhiMN" size:16];
        volumerateLabe.textColor = BlueColor;
        volumerateLabe.text = @"土地容积率:";
        [self addSubview:volumerateLabe];
        
        UITextField *volumerate = [[UITextField alloc] initWithFrame:CGRectMake(110,215, 150, 30)];
        volumerate.delegate = self;
        volumerate.keyboardType = UIKeyboardTypeDecimalPad;
        volumerate.textAlignment=NSTextAlignmentLeft;
        if(flag == 0){
            if(![[NSString stringWithFormat:@"%@",[dic objectForKey:@"plotRatio"]] isEqualToString:@""]){
                [volumerate setText:[NSString stringWithFormat:@"%@",[dic objectForKey:@"plotRatio"]]];
            }
        }else{
            if(![[NSString stringWithFormat:@"%@",[dic objectForKey:@"plotRatio"]] isEqualToString:@""]){
                [volumerate setText:[NSString stringWithFormat:@"%@",[dic objectForKey:@"plotRatio"]]];
            }else{
                if(![[singleDic objectForKey:@"plotRatio"] isEqualToString:@""]){
                    [volumerate setText:[NSString stringWithFormat:@"%@",[singleDic objectForKey:@"plotRatio"]]];
                }
            }
        }
        volumerate.returnKeyType=UIReturnKeyDone;
        volumerate.tag = 3;
        //[volumerate setClearButtonMode:UITextFieldViewModeWhileEditing];
        [self addSubview:volumerate];
        
        UIButton *landuse = [UIButton buttonWithType:UIButtonTypeCustom];
        landuse.frame = CGRectMake(20,260, 220, 30);
        landuse.tag = 1;
        [landuse setTitle:@"地块用途" forState:UIControlStateNormal];
        [landuse setTitleColor:BlueColor forState:UIControlStateNormal];
        landuse.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        landuse.titleLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:16];;
        [landuse addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:landuse];
        
        UILabel *landuseLabel = [[UILabel alloc] initWithFrame:CGRectMake(105, 257, 220, 30)];
        landuseLabel.textColor = GrayColor;
        landuseLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:16];
        landuseLabel.textAlignment = NSTextAlignmentLeft;
        if(flag == 0){
            if(![[dic objectForKey:@"usage"] isEqualToString:@""]){
                [landuseLabel setText:[NSString stringWithFormat:@"%@",[dic objectForKey:@"usage"]] ];
            }else{
                [landuseLabel setText:@"地块用途"];
            }
        }else{
            if(![[dic objectForKey:@"usage"] isEqualToString:@""]){
                [landuseLabel setText:[NSString stringWithFormat:@"%@",[dic objectForKey:@"usage"]]];
            }else{
                if(![[singleDic objectForKey:@"usage"] isEqualToString:@""]){
                    [landuseLabel setText:[NSString stringWithFormat:@"%@",[singleDic objectForKey:@"usage"]]];
                }else{
                    [landuseLabel setText:@"地块用途"];
                }
            }
        }
        [self addSubview:landuseLabel];
        
        UIImageView *arrowImage2 = [[UIImageView alloc] initWithFrame:CGRectMake(90,268, 8, 12.5)];
        [arrowImage2 setImage:[UIImage imageNamed:@"新建项目5_09.png"]];
        [self addSubview:arrowImage2];
        
        UIButton *auctionunit = [UIButton buttonWithType:UIButtonTypeCustom];
        auctionunit.frame = CGRectMake(20,315, 140, 30);
        auctionunit.tag = 2;
        [auctionunit setTitle:@"拍卖单位" forState:UIControlStateNormal];
        [auctionunit setTitleColor:BlueColor forState:UIControlStateNormal];
        auctionunit.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        auctionunit.titleLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:16];
        [auctionunit addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:auctionunit];
        
        UIImageView *addImage = [[UIImageView alloc] initWithFrame:CGRectMake(90,318, 20, 20)];
        [addImage setImage:[UIImage imageNamed:@"新建项目5_03.png"]];
        [self addSubview:addImage];
        
        //NSLog(@"%@",contactArr);
        
        self.dataArr = [NSMutableArray arrayWithArray:contactArr];
        if(contactArr.count != 0){
            for(int i=0; i<contactArr.count;i++){
                if(i<3){
                    UIButton *contactBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                    [contactBtn setTitle:[[contactArr objectAtIndex:i] objectForKey:@"contactName"] forState:UIControlStateNormal];
                    contactBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                    contactBtn.tag = i+1;
                    [contactBtn setTitleColor:BlueColor forState:UIControlStateNormal];
                    contactBtn.titleLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:16];
                    [contactBtn addTarget:self action:@selector(contactBtn:) forControlEvents:UIControlEventTouchUpInside];
                    if(i == 0){
                        [contactBtn setFrame:CGRectMake(120, 315, 60, 30)];
                    }else if(i == 1){
                        [contactBtn setFrame:CGRectMake(180, 315, 60, 30)];
                    }else if(i == 2){
                        [contactBtn setFrame:CGRectMake(240, 315, 60, 30)];
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

-(void)updateContent:(BOOL)openRow{
    NSLog(@"%d",openRow);
}

-(void)BtnClick:(UIButton *)button{
    [textfield resignFirstResponder];
    if ([delegate respondsToSelector:@selector(addContactView:)]){
        [delegate addContactView:button.tag];
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    textfield = nil;
    textfield = textField;
    closeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 310, 350)];
    closeView.userInteractionEnabled = YES;
    UITapGestureRecognizer *closeViewtapGestureRecognizer = [[UITapGestureRecognizer alloc] init];
    [closeViewtapGestureRecognizer addTarget:self action:@selector(closeKeyBoard)];
    [closeViewtapGestureRecognizer setNumberOfTapsRequired:1];
    [closeViewtapGestureRecognizer setNumberOfTouchesRequired:1];
    [closeView addGestureRecognizer:closeViewtapGestureRecognizer];
    [self addSubview:closeView];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if ([delegate respondsToSelector:@selector(addContent:index:)]){
        [delegate addContent:textField.text index:textField.tag];
    }
}

-(void)contactBtn:(UIButton *)button{
    //NSLog(@"button ===> %@",[self.dataArr objectAtIndex:button.tag-1]);
    if ([delegate respondsToSelector:@selector(updataContact:index:)]){
        [delegate updataContact:[self.dataArr objectAtIndex:button.tag-1] index:button.tag];
    }
}

-(void)closeKeyBoard{
    [textfield resignFirstResponder];
    [closeView removeFromSuperview];
    closeView = nil;
}
@end
