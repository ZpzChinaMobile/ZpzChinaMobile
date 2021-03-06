//
//  PlanAndAuctionTableViewCell.m
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-20.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "PlanAndAuctionTableViewCell.h"
@implementation PlanAndAuctionTableViewCell
@synthesize dataArr;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier dic:(NSMutableDictionary *)dic singleDic:(NSMutableDictionary *)singleDic flag:(int)flag contactArr:(NSMutableArray *)contactArr
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
      
        for (int i=0; i<6; i++) {
            UIImageView *lingImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 50*(i+1), 280, 1)];
            [lingImage setImage:[GetImagePath getImagePath:@"新建项目5_27"]];
            [self addSubview:lingImage];
        }
        
        UIFont* myFont=[UIFont systemFontOfSize:15];
        
        UITextField *LotName = [[UITextField alloc] initWithFrame:CGRectMake(20,15, 280, 30)];
        LotName.delegate = self;
        LotName.textAlignment=NSTextAlignmentLeft;
        LotName.font=myFont;
        LotName.placeholder=@"地块名称";

        if(flag == 0){
            if(![[dic objectForKey:@"landName"] isEqualToString:@""]){
                [LotName setText:[dic objectForKey:@"landName"]];
            }
        }else{
            if([dic objectForKey:@"landName"]){
                [LotName setText:[dic objectForKey:@"landName"]];
            }else{
                if(![[singleDic objectForKey:@"landName"] isEqualToString:@""]){
                    [LotName setText:[singleDic objectForKey:@"landName"]];
                }
            }
        }
        LotName.returnKeyType=UIReturnKeyDone;
        LotName.tag = 0;
        //[LotName setClearButtonMode:UITextFieldViewModeWhileEditing];
        [self addSubview:LotName];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFiledEditChanged:)
                                                    name:@"UITextFieldTextDidChangeNotification"
                                                  object:LotName];
        
        UIButton *zone = [UIButton buttonWithType:UIButtonTypeCustom];
        zone.frame = CGRectMake(20,64, 220, 30);
        [zone setTitle:@"所在区域/省市" forState:UIControlStateNormal];
        [zone setTitleColor:BlueColor forState:UIControlStateNormal];
        zone.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        zone.titleLabel.font = myFont;
        zone.tag = 0;
        [zone addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:zone];
        
        UILabel *zoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(145, 64, 135, 30)];
        zoneLabel.textColor = GrayColor;
        zoneLabel.font = myFont;
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
        [arrowImage setImage:[GetImagePath getImagePath:@"新建项目5_09"]];
        [self addSubview:arrowImage];
        
        UITextField *address = [[UITextField alloc] initWithFrame:CGRectMake(20,113, 280, 30)];
        address.delegate = self;
        address.textAlignment=NSTextAlignmentLeft;
        address.font=myFont;
        address.placeholder=@"地块地址(限35个字)";
        if(flag == 0){
            if(![[dic objectForKey:@"landAddress"] isEqualToString:@""]){
                [address setText:[dic objectForKey:@"landAddress"]];
            }
        }else{
            if([dic objectForKey:@"landAddress"]){
                [address setText:[dic objectForKey:@"landAddress"]];
            }else{
                if(![[singleDic objectForKey:@"landAddress"] isEqualToString:@""]){
                    [address setText:[singleDic objectForKey:@"landAddress"]];
                }
            }
        }
        
        address.returnKeyType=UIReturnKeyDone;
        address.tag = 1;
        [self addSubview:address];
        
        UILabel *landareaLabe = [[UILabel alloc] initWithFrame:CGRectMake(20,161, 70, 30)];
        landareaLabe.font = myFont;
        landareaLabe.textColor = BlueColor;
        landareaLabe.text = @"土地面积:";
        [self addSubview:landareaLabe];
        
        UITextField *landarea = [[UITextField alloc] initWithFrame:CGRectMake(90,161, 150, 30)];
        landarea.delegate = self;
        landarea.textAlignment=NSTextAlignmentLeft;
        landarea.keyboardType = UIKeyboardTypeDecimalPad;
        landarea.font=myFont;
        if(flag == 0){
            if(![[NSString stringWithFormat:@"%@",[dic objectForKey:@"area"]] isEqualToString:@""]){
                if([[NSString stringWithFormat:@"%@",[dic objectForKey:@"area"]] isEqualToString:@"null"]){
                    [landarea setText:@"0"];
                }else{
                    [landarea setText:[NSString stringWithFormat:@"%@",[dic objectForKey:@"area"]]];
                }
            }
        }else{
            if(![[NSString stringWithFormat:@"%@",[dic objectForKey:@"area"]] isEqualToString:@""]){
                if([[NSString stringWithFormat:@"%@",[dic objectForKey:@"area"]] isEqualToString:@"null"]){
                    [landarea setText:@"0"];
                }else{
                    [landarea setText:[NSString stringWithFormat:@"%@",[dic objectForKey:@"area"]]];
                }
            }else{
                if(![[NSString stringWithFormat:@"%@",[singleDic objectForKey:@"area"]] isEqualToString:@""]){
                    if([[NSString stringWithFormat:@"%@",[singleDic objectForKey:@"area"]] isEqualToString:@"null"]){
                        [landarea setText:@"0"];
                    }else{
                        [landarea setText:[NSString stringWithFormat:@"%@",[singleDic objectForKey:@"area"]]];
                    }
                }
            }
        }
        landarea.returnKeyType=UIReturnKeyDone;
        landarea.tag = 2;
        //[landarea setClearButtonMode:UITextFieldViewModeWhileEditing];
        [self addSubview:landarea];
        
        UILabel *volumerateLabe = [[UILabel alloc] initWithFrame:CGRectMake(20,213, 85, 30)];
        volumerateLabe.font = myFont;
        volumerateLabe.textColor = BlueColor;
        volumerateLabe.text = @"土地容积率:";
        [self addSubview:volumerateLabe];
        
        UITextField *volumerate = [[UITextField alloc] initWithFrame:CGRectMake(110,213, 150, 30)];
        volumerate.delegate = self;
        volumerate.font=myFont;
        volumerate.keyboardType = UIKeyboardTypeDecimalPad;
        volumerate.textAlignment=NSTextAlignmentLeft;
        if(flag == 0){
            if(![[NSString stringWithFormat:@"%@",[dic objectForKey:@"plotRatio"]] isEqualToString:@""]){
                if([[NSString stringWithFormat:@"%@",[dic objectForKey:@"plotRatio"]] isEqualToString:@"null"]){
                    [volumerate setText:@"0"];
                }else{
                    [volumerate setText:[NSString stringWithFormat:@"%@",[dic objectForKey:@"plotRatio"]]];
                }
            }
        }else{
            if(![[NSString stringWithFormat:@"%@",[dic objectForKey:@"plotRatio"]] isEqualToString:@""]){
                if([[NSString stringWithFormat:@"%@",[dic objectForKey:@"plotRatio"]] isEqualToString:@"null"]){
                    [volumerate setText:@"0"];
                }else{
                    [volumerate setText:[NSString stringWithFormat:@"%@",[dic objectForKey:@"plotRatio"]]];
                }
            }else{
                if(![[singleDic objectForKey:@"plotRatio"] isEqualToString:@""]){
                    if([[NSString stringWithFormat:@"%@",[singleDic objectForKey:@"plotRatio"]] isEqualToString:@"null"]){
                        [volumerate setText:@"0"];
                    }else{
                        [volumerate setText:[NSString stringWithFormat:@"%@",[singleDic objectForKey:@"plotRatio"]]];
                    }
                }
            }
        }
        volumerate.returnKeyType=UIReturnKeyDone;
        volumerate.tag = 3;
        //[volumerate setClearButtonMode:UITextFieldViewModeWhileEditing];
        [self addSubview:volumerate];
        
        UIButton *landuse = [UIButton buttonWithType:UIButtonTypeCustom];
        landuse.frame = CGRectMake(20,261, 220, 30);
        landuse.tag = 1;
        [landuse setTitle:@"地块用途" forState:UIControlStateNormal];
        [landuse setTitleColor:BlueColor forState:UIControlStateNormal];
        landuse.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        landuse.titleLabel.font = myFont;;
        [landuse addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:landuse];
        
        UILabel *landuseLabel = [[UILabel alloc] initWithFrame:CGRectMake(105, 261, 195, 30)];
        landuseLabel.textColor = GrayColor;
        landuseLabel.font = myFont;
        landuseLabel.textAlignment = NSTextAlignmentLeft;
        if(flag == 0){
            if(![[dic objectForKey:@"usage"] isEqualToString:@""]){
                [landuseLabel setText:[NSString stringWithFormat:@"%@",[dic objectForKey:@"usage"]] ];
            }else{
                [landuseLabel setText:@""];
            }
        }else{
            /*
             if([dic objectForKey:@"landAddress"]){
             [address setText:[dic objectForKey:@"landAddress"]];
             }else{
             if(![[singleDic objectForKey:@"landAddress"] isEqualToString:@""]){
             [address setText:[singleDic objectForKey:@"landAddress"]];
             }
             }
             */
            if([dic objectForKey:@"usage"]){
                [landuseLabel setText:[dic objectForKey:@"usage"]];
            }else{
                if(![[singleDic objectForKey:@"usage"] isEqualToString:@""]){
                    [landuseLabel setText:[singleDic objectForKey:@"usage"]];
                }
            }
        }
        [self addSubview:landuseLabel];
        
        UIImageView *arrowImage2 = [[UIImageView alloc] initWithFrame:CGRectMake(90,268, 8, 12.5)];
        [arrowImage2 setImage:[GetImagePath getImagePath:@"新建项目5_09"]];
        [self addSubview:arrowImage2];
        
        UIButton *auctionunit = [UIButton buttonWithType:UIButtonTypeCustom];
        auctionunit.frame = CGRectMake(20,314, 140, 30);
        auctionunit.tag = 2;
        [auctionunit setTitle:@"拍卖单位" forState:UIControlStateNormal];
        [auctionunit setTitleColor:BlueColor forState:UIControlStateNormal];
        auctionunit.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        auctionunit.titleLabel.font = myFont;
        [auctionunit addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:auctionunit];
        
        UIImageView *addImage = [[UIImageView alloc] initWithFrame:CGRectMake(90,319, 20, 20)];
        [addImage setImage:[GetImagePath getImagePath:@"新建项目5_03"]];
        [self addSubview:addImage];
        
        self.dataArr = [NSMutableArray arrayWithArray:contactArr];
        if(contactArr.count != 0){
            for(int i=0; i<contactArr.count;i++){
                if(i<3){
                    UIButton *contactBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                    [contactBtn setTitle:[[contactArr objectAtIndex:i] objectForKey:@"contactName"] forState:UIControlStateNormal];
                    contactBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                    contactBtn.tag = i+1;
                    [contactBtn setTitleColor:BlueColor forState:UIControlStateNormal];
                    contactBtn.titleLabel.font = myFont;
                    [contactBtn addTarget:self action:@selector(contactBtn:) forControlEvents:UIControlEventTouchUpInside];
                    if(i == 0){
                        [contactBtn setFrame:CGRectMake(120, 314, 60, 30)];
                    }else if(i == 1){
                        [contactBtn setFrame:CGRectMake(180, 314, 60, 30)];
                    }else if(i == 2){
                        [contactBtn setFrame:CGRectMake(240, 314, 60, 30)];
                    }
                    [self addSubview:contactBtn];
                }
            }
        }
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

-(void)updateContent:(BOOL)openRow{
    NSLog(@"%d",openRow);
}

-(void)BtnClick:(UIButton *)button{
    [textfield resignFirstResponder];
    if ([self.delegate respondsToSelector:@selector(addContactView:)]){
        [self.delegate addContactView:button.tag];
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if(textField.tag == 2||textField.tag == 3){
        textField.text = @"";
    }
    CGFloat heights[4]={50,150,200,250};
    
    [self.delegate beginEditWithHeight:heights[textField.tag]];
    
    textfield = nil;
    textfield = textField;
    closeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 568-64.5)];
    closeView.userInteractionEnabled = YES;
    closeView.backgroundColor=[UIColor clearColor];

    UITapGestureRecognizer *closeViewtapGestureRecognizer = [[UITapGestureRecognizer alloc] init];
    [closeViewtapGestureRecognizer addTarget:self action:@selector(closeKeyBoard)];
    [closeViewtapGestureRecognizer setNumberOfTapsRequired:1];
    [closeViewtapGestureRecognizer setNumberOfTouchesRequired:1];
    [closeView addGestureRecognizer:closeViewtapGestureRecognizer];
    [self.superview.superview.superview.superview addSubview:closeView];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [closeView removeFromSuperview];
    closeView=nil;
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if ([self.delegate respondsToSelector:@selector(addContent:index:)]){
        NSString* tempStr=textField.text.length>35&&textField.tag==1?[textField.text substringToIndex:35]:textField.text;
        [self.delegate addContent:tempStr index:textField.tag];
    }
    [self.delegate endEdit];
}

-(void)textFiledEditChanged:(NSNotification *)obj{
    UITextField *textField = (UITextField *)obj.object;
    NSString *toBeString = textField.text;
    NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage]; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > 100) {
                textField.text = [toBeString substringToIndex:100];
            }
        }
        // 有高亮选择的字符串，则暂不对文字进行统计和限制
        else{
            
        }
    }else{
        // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        if (toBeString.length > 100) {
            textField.text = [toBeString substringToIndex:100];
        }
    }
}

-(void)contactBtn:(UIButton *)button{
    //NSLog(@"button ===> %@",[self.dataArr objectAtIndex:button.tag-1]);
    if ([self.delegate respondsToSelector:@selector(updataContact:index:)]){
        [self.delegate updataContact:[self.dataArr objectAtIndex:button.tag-1] index:button.tag];
    }
}

-(void)closeKeyBoard{
    [textfield resignFirstResponder];
    [closeView removeFromSuperview];
    closeView = nil;
}
@end
