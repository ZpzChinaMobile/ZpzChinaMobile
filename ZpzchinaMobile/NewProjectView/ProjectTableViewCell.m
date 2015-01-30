//
//  ProjectTableViewCell.m
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-20.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "ProjectTableViewCell.h"

@implementation ProjectTableViewCell
@synthesize dropDown;
@synthesize dataArr;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier dic:(NSMutableDictionary *)dic flag:(int)flag ownerArr:(NSMutableArray *)ownerArr singleDic:(NSMutableDictionary *)singleDic
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        if(flag==0){
            dataDic = dic;
        }else{
            dataDic = singleDic;
        }

        for (int i=0; i<10; i++) {
            UIImageView *lingImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 50*(i+1), 280, 1)];
            [lingImage setImage:[GetImagePath getImagePath:@"新建项目5_27"]];
            [self addSubview:lingImage];
        }
        
        UIFont* myFont=[UIFont systemFontOfSize:15];
        
        UITextField *ProjectName = [[UITextField alloc] initWithFrame:CGRectMake(20,15, 280, 30)];
        ProjectName.delegate = self;
        ProjectName.textAlignment=NSTextAlignmentLeft;
        ProjectName.placeholder=@"项目名称";
        ProjectName.font=myFont;
        if(flag == 0){
            if(![[dic objectForKey:@"projectName"] isEqualToString:@""]){
                [ProjectName setText:[dic objectForKey:@"projectName"]];
            }
        }else{
            if([dic objectForKey:@"projectName"]){
                [ProjectName setText:[dic objectForKey:@"projectName"]];
            }else{
                if(![[singleDic objectForKey:@"projectName"] isEqualToString:@""]){
                    [ProjectName setText:[singleDic objectForKey:@"projectName"]];
                }
            }
        }
        ProjectName.returnKeyType=UIReturnKeyDone;
        ProjectName.tag = 0;
        //[ProjectName setClearButtonMode:UITextFieldViewModeWhileEditing];
        [self addSubview:ProjectName];
        
        ProjectAddress = [UIButton buttonWithType:UIButtonTypeCustom];
        ProjectAddress.tag = 0;
        ProjectAddress.frame = CGRectMake(20,63, 260, 30);
        
        if(flag == 0){
            if(![[dic objectForKey:@"landAddress"] isEqualToString:@""]){
                [ProjectAddress setTitle:[NSString stringWithFormat:@"%@",[dic objectForKey:@"landAddress"]] forState:UIControlStateNormal];
            }else{
                [ProjectAddress setTitle:@"项目地址" forState:UIControlStateNormal];
            }
        }else{
            if([dic objectForKey:@"landAddress"]){
                [ProjectAddress setTitle:[NSString stringWithFormat:@"%@",[dic objectForKey:@"landAddress"]] forState:UIControlStateNormal];
            }else{
                if(![[singleDic objectForKey:@"landAddress"] isEqualToString:@""]){
                    [ProjectAddress setTitle:[singleDic objectForKey:@"landAddress"] forState:UIControlStateNormal];
                }else{
                    [ProjectAddress setTitle:@"项目地址" forState:UIControlStateNormal];
                }
            }
        }
        [ProjectAddress setTitleColor:GrayColor forState:UIControlStateNormal];
        ProjectAddress.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        ProjectAddress.titleLabel.font = myFont;
        //[ProjectAddress addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:ProjectAddress];
        
        UIImageView *mapImage = [[UIImageView alloc] initWithFrame:CGRectMake(280,65, 22.5, 22.5)];
        [mapImage setImage:[GetImagePath getImagePath:@"新建项目3_03"]];
        mapImage.userInteractionEnabled = YES;
        UITapGestureRecognizer *mapImagetapGestureRecognizer = [[UITapGestureRecognizer alloc] init];
        [mapImagetapGestureRecognizer addTarget:self action:@selector(gotoMap)];
        [mapImagetapGestureRecognizer setNumberOfTapsRequired:1];
        [mapImagetapGestureRecognizer setNumberOfTouchesRequired:1];
        [mapImage addGestureRecognizer:mapImagetapGestureRecognizer];
        [self addSubview:mapImage];
        
        UITextField *ProjectMark = [[UITextField alloc] initWithFrame:CGRectMake(20,114, 280, 30)];
        ProjectMark.delegate = self;
        ProjectMark.textAlignment=NSTextAlignmentLeft;
        ProjectMark.placeholder=@"项目描述";
        ProjectMark.font=myFont;
        if(flag == 0){
            if(![[dic objectForKey:@"description"] isEqualToString:@""]){
                [ProjectMark setText:[NSString stringWithFormat:@"%@",[dic objectForKey:@"description"]]];
            }
        }else{
            if([dic objectForKey:@"description"]){
                [ProjectMark setText:[dic objectForKey:@"description"]];
            }else{
                if(![[singleDic objectForKey:@"description"] isEqualToString:@""]){
                    [ProjectMark setText:[singleDic objectForKey:@"description"]];
                }
            }
        }
        ProjectMark.returnKeyType=UIReturnKeyDone;
        ProjectMark.tag = 1;
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFiledEditChanged:)
                                                    name:@"UITextFieldTextDidChangeNotification"
                                                  object:ProjectMark];
        //[ProjectMark setClearButtonMode:UITextFieldViewModeWhileEditing];
        [self addSubview:ProjectMark];
        
        UIButton *Owner = [UIButton buttonWithType:UIButtonTypeCustom];
        Owner.frame = CGRectMake(20,163, 140, 30);
        Owner.tag = 1;
        [Owner setTitle:@"业主单位" forState:UIControlStateNormal];
        [Owner setTitleColor:BlueColor forState:UIControlStateNormal];
        Owner.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        Owner.titleLabel.font = myFont;
        [Owner addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:Owner];
        
        UIImageView *addImage = [[UIImageView alloc] initWithFrame:CGRectMake(90,168, 20, 20)];//添加按钮
        [addImage setImage:[GetImagePath getImagePath:@"新建项目5_03"]];
        [self addSubview:addImage];
        
        UIButton *startdate = [UIButton buttonWithType:UIButtonTypeCustom];
        startdate.frame = CGRectMake(20,213, 200, 30);
        startdate.tag = 2;
        if(flag == 0){
            if(![[dic objectForKey:@"expectedStartTime"] isEqualToString:@""]){
                NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd"];
                NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[[dic objectForKey:@"expectedStartTime"] intValue]];
                NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
                [startdate setTitle:[NSString stringWithFormat:@"预计开工时间: %@",confromTimespStr] forState:UIControlStateNormal];
            }else{
                [startdate setTitle:@"预计开工时间" forState:UIControlStateNormal];
            }
        }else{
            if(![[dic objectForKey:@"expectedStartTime"] isEqualToString:@""]){
                NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd"];
                NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[[dic objectForKey:@"expectedStartTime"] intValue]];
                NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
                [startdate setTitle:[NSString stringWithFormat:@"预计开工时间: %@",confromTimespStr] forState:UIControlStateNormal];
            }else{
                if(![[singleDic objectForKey:@"expectedStartTime"] isEqualToString:@""]){
                    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
                    [formatter setDateFormat:@"yyyy-MM-dd"];
                    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[[singleDic objectForKey:@"expectedStartTime"] intValue]];
                    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
                    NSLog(@"==> %@",[singleDic objectForKey:@"expectedStartTime"]);
                    [startdate setTitle:[NSString stringWithFormat:@"预计开工时间: %@",confromTimespStr] forState:UIControlStateNormal];
                }else{
                    [startdate setTitle:@"预计开工时间" forState:UIControlStateNormal];
                }
            }
        }
        [startdate setTitleColor:GrayColor forState:UIControlStateNormal];
        startdate.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        startdate.titleLabel.font = myFont;
        [startdate addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:startdate];
        
        UIButton *enddate = [UIButton buttonWithType:UIButtonTypeCustom];
        enddate.frame = CGRectMake(20,264, 200, 30);
        enddate.tag = 3;
        if(flag == 0){
            if(![[dic objectForKey:@"expectedFinishTime"] isEqualToString:@""]){
                NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd"];
                NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[[dic objectForKey:@"expectedFinishTime"] intValue]];
                NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
                [enddate setTitle:[NSString stringWithFormat:@"预计竣工时间: %@",confromTimespStr] forState:UIControlStateNormal];
            }else{
                [enddate setTitle:@"预计竣工时间" forState:UIControlStateNormal];
            }
        }else{
            if(![[dic objectForKey:@"expectedFinishTime"] isEqualToString:@""]){
                NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd"];
                NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[[dic objectForKey:@"expectedFinishTime"] intValue]];
                NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
                [enddate setTitle:[NSString stringWithFormat:@"预计竣工时间: %@",confromTimespStr] forState:UIControlStateNormal];
            }else{
                if(![[singleDic objectForKey:@"expectedFinishTime"] isEqualToString:@""]){
                    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
                    [formatter setDateFormat:@"yyyy-MM-dd"];
                    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[[singleDic objectForKey:@"expectedFinishTime"] intValue]];
                    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
                    [enddate setTitle:[NSString stringWithFormat:@"预计竣工时间: %@",confromTimespStr] forState:UIControlStateNormal];
                }else{
                    [enddate setTitle:@"预计竣工时间" forState:UIControlStateNormal];
                }
            }
        }
        [enddate setTitleColor:GrayColor forState:UIControlStateNormal];
        enddate.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        enddate.titleLabel.font = myFont;
        [enddate addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:enddate];
        
        UILabel *InvestmentLabe = [[UILabel alloc] initWithFrame:CGRectMake(20,314, 60, 30)];
        InvestmentLabe.font = myFont;
        InvestmentLabe.textColor = GrayColor;
        InvestmentLabe.text = @"投资额:";
        [self addSubview:InvestmentLabe];
        
        UILabel *unitLabel = [[UILabel alloc] initWithFrame:CGRectMake(270,314, 60, 30)];
        unitLabel.font = myFont;
        unitLabel.textColor = GrayColor;
        unitLabel.text = @"百万";
        [self addSubview:unitLabel];
        
        UITextField *Investment = [[UITextField alloc] initWithFrame:CGRectMake(75,314, 150, 30)];
        Investment.delegate = self;
        Investment.textAlignment=NSTextAlignmentLeft;
        Investment.keyboardType = UIKeyboardTypeDecimalPad;
        Investment.font=myFont;
        if(flag == 0){
            if(![[dic objectForKey:@"investment"] isEqualToString:@""]){
                if([[dic objectForKey:@"investment"] isEqualToString:@"null"]){
                    [Investment setText:@"0"];
                }else{
                    [Investment setText:[NSString stringWithFormat:@"%@",[dic objectForKey:@"investment"]]];
                }
            }
        }else{
            if(![[NSString stringWithFormat:@"%@",[dic objectForKey:@"investment"]] isEqualToString:@""]){
                if([[dic objectForKey:@"investment"] isEqualToString:@"null"]){
                    [Investment setText:@"0"];
                }else{
                    [Investment setText:[NSString stringWithFormat:@"%@",[dic objectForKey:@"investment"]]];
                }
            }else{
                if(![[NSString stringWithFormat:@"%@",[singleDic objectForKey:@"investment"]] isEqualToString:@""]){
                    if([[NSString stringWithFormat:@"%@",[singleDic objectForKey:@"investment"]] isEqualToString:@"null"]){
                        [Investment setText:@"0"];
                    }else{
                        [Investment setText:[NSString stringWithFormat:@"%@",[singleDic objectForKey:@"investment"]]];
                    }
                }
            }
        }
        Investment.returnKeyType=UIReturnKeyDone;
        Investment.tag = 2;
        //[Investment setClearButtonMode:UITextFieldViewModeWhileEditing];
        [self addSubview:Investment];
        
        UILabel *GFALabe = [[UILabel alloc] initWithFrame:CGRectMake(20,364, 70, 30)];
        GFALabe.font = myFont;
        GFALabe.textColor = GrayColor;
        GFALabe.text = @"建筑面积:";
        [self addSubview:GFALabe];
        
        UITextField *GFA = [[UITextField alloc] initWithFrame:CGRectMake(90,364, 150, 30)];
        GFA.delegate = self;
        GFA.keyboardType = UIKeyboardTypeDecimalPad;
        GFA.textAlignment=NSTextAlignmentLeft;
        GFA.font=myFont;
        if(flag == 0){
            if(![[dic objectForKey:@"areaOfStructure"] isEqualToString:@""]){
                if([[dic objectForKey:@"areaOfStructure"] isEqualToString:@"null"]){
                    [GFA setText:@"0"];
                }else{
                    [GFA setText:[NSString stringWithFormat:@"%@",[dic objectForKey:@"areaOfStructure"]]];
                }
            }
        }else{
            if(![[dic objectForKey:@"areaOfStructure"] isEqualToString:@""]){
                if([[dic objectForKey:@"areaOfStructure"] isEqualToString:@"null"]){
                    [GFA setText:@"0"];
                }else{
                    [GFA setText:[NSString stringWithFormat:@"%@",[dic objectForKey:@"areaOfStructure"]]];
                }
            }else{
                if(![[singleDic objectForKey:@"areaOfStructure"] isEqualToString:@""]){
                    if([[singleDic objectForKey:@"areaOfStructure"] isEqualToString:@"null"]){
                        [GFA setText:@"0"];
                    }else{
                        [GFA setText:[NSString stringWithFormat:@"%@",[singleDic objectForKey:@"areaOfStructure"]]];
                    }
                }
            }
        }
        GFA.returnKeyType=UIReturnKeyDone;
        GFA.tag = 3;
        //[GFA setClearButtonMode:UITextFieldViewModeWhileEditing];
        [self addSubview:GFA];
        
        UILabel *StoreybuildingLabe = [[UILabel alloc] initWithFrame:CGRectMake(20,414, 70, 30)];
        StoreybuildingLabe.font = myFont;
        StoreybuildingLabe.textColor = GrayColor;
        StoreybuildingLabe.text = @"建筑层高:";
        [self addSubview:StoreybuildingLabe];
        
        UITextField *Storeybuilding = [[UITextField alloc] initWithFrame:CGRectMake(90,414, 150, 30)];
        Storeybuilding.delegate = self;
        Storeybuilding.textAlignment=NSTextAlignmentLeft;
        Storeybuilding.keyboardType = UIKeyboardTypeDecimalPad;
        Storeybuilding.font=myFont;
        if(flag == 0){
            if(![[dic objectForKey:@"storeyHeight"] isEqualToString:@""]){
                if([[dic objectForKey:@"storeyHeight"] isEqualToString:@"null"]){
                    [Storeybuilding setText:@"0"];
                }else{
                    [Storeybuilding setText:[NSString stringWithFormat:@"%@",[dic objectForKey:@"storeyHeight"]]];
                }
            }
        }else{
            if(![[dic objectForKey:@"storeyHeight"] isEqualToString:@""]){
                if([[dic objectForKey:@"storeyHeight"] isEqualToString:@"null"]){
                    [Storeybuilding setText:@"0"];
                }else{
                    [Storeybuilding setText:[NSString stringWithFormat:@"%@",[dic objectForKey:@"storeyHeight"]]];
                }
            }else{
                if(![[singleDic objectForKey:@"storeyHeight"] isEqualToString:@""]){
                    if([[singleDic objectForKey:@"storeyHeight"] isEqualToString:@"null"]){
                        [Storeybuilding setText:@"0"];
                    }else{
                        [Storeybuilding setText:[NSString stringWithFormat:@"%@",[singleDic objectForKey:@"storeyHeight"]]];
                    }
                }
            }
        }
        Storeybuilding.returnKeyType=UIReturnKeyDone;
        Storeybuilding.tag = 4;
        //[Storeybuilding setClearButtonMode:UITextFieldViewModeWhileEditing];
        [self addSubview:Storeybuilding];
        
        UIButton *Foreignparticipation = [UIButton buttonWithType:UIButtonTypeCustom];
        Foreignparticipation.tag = 4;
        Foreignparticipation.frame = CGRectMake(20,464, 100, 30);
        [Foreignparticipation setTitle:@"外资参与" forState:UIControlStateNormal];
        [Foreignparticipation setTitleColor:BlueColor forState:UIControlStateNormal];
        Foreignparticipation.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        Foreignparticipation.titleLabel.font = myFont;
        [Foreignparticipation addTarget:self action:@selector(ForeignparticipationClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:Foreignparticipation];
        
        foreignparticipationLabel = [[UILabel alloc] initWithFrame:CGRectMake(105,464, 100, 30)];
        foreignparticipationLabel.textColor = GrayColor;
        foreignparticipationLabel.font = myFont;
        foreignparticipationLabel.textAlignment = NSTextAlignmentLeft;
        if(flag == 0){
            if(![[dic objectForKey:@"foreignInvestment"] isEqualToString:@"null"]){
                [foreignparticipationLabel setText:@"参与"];
            }else{
                [foreignparticipationLabel setText:@"不参与"];
            }
        }else{
            if([[dic objectForKey:@"foreignInvestment"] isEqualToString:@""]){
                if([[singleDic objectForKey:@"foreignInvestment"] isEqualToString:@"0"]){
                    [foreignparticipationLabel setText:@"不参与"];
                }else if ([[singleDic objectForKey:@"foreignInvestment"] isEqualToString:@"null"]){
                    [foreignparticipationLabel setText:@"不参与"];
                }else{
                    [foreignparticipationLabel setText:@"参与"];
                }
            }else{
                if([[dic objectForKey:@"foreignInvestment"] isEqualToString:@"0"]){
                    [foreignparticipationLabel setText:@"不参与"];
                }else{
                    [foreignparticipationLabel setText:@"参与"];
                }
            }
        }
        [self addSubview:foreignparticipationLabel];
        
        
        UIImageView *arrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(90,472, 8, 12.5)];
        [arrowImage setImage:[GetImagePath getImagePath:@"新建项目5_09"]];
        [self addSubview:arrowImage];
        
        UIButton *OwnerType = [UIButton buttonWithType:UIButtonTypeCustom];
        OwnerType.tag = 5;
        OwnerType.frame = CGRectMake(20,513, 100, 30);
        [OwnerType setTitle:@"业主类型" forState:UIControlStateNormal];
        if(flag == 0){
            if(![[dic objectForKey:@"ownerType"] isEqualToString:@""]){
                [OwnerType setTitle:@"业主类型" forState:UIControlStateNormal];
            }else{
                [OwnerType setTitle:@"业主类型" forState:UIControlStateNormal];
            }
        }else{
            if(![[dic objectForKey:@"ownerType"] isEqualToString:@""]){
                [OwnerType setTitle:@"业主类型" forState:UIControlStateNormal];
            }else{
                if(![[singleDic objectForKey:@"ownerType"] isEqualToString:@""]){
                    [OwnerType setTitle:@"业主类型" forState:UIControlStateNormal];
                }else{
                    [OwnerType setTitle:@"业主类型" forState:UIControlStateNormal];
                }
            }
        }
        [OwnerType setTitleColor:BlueColor forState:UIControlStateNormal];
        OwnerType.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        OwnerType.titleLabel.font = myFont;
        [OwnerType addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:OwnerType];
        
        UILabel *ownerLabel = [[UILabel alloc] initWithFrame:CGRectMake(105,513, 195, 30)];
        ownerLabel.textColor = GrayColor;
        ownerLabel.font = myFont;
        ownerLabel.textAlignment = NSTextAlignmentLeft;
        if(flag == 0){
            if(![[dic objectForKey:@"ownerType"] isEqualToString:@""]){
                [ownerLabel setText:[NSString stringWithFormat:@"%@",[dic objectForKey:@"ownerType"]]];
            }else{
                [ownerLabel setText:@""];
            }
        }else{
            if([dic objectForKey:@"ownerType"]){
                [ownerLabel setText:[dic objectForKey:@"ownerType"]];
            }else{
                if(![[singleDic objectForKey:@"ownerType"] isEqualToString:@""]){
                    [ownerLabel setText:[NSString stringWithFormat:@"%@",[singleDic objectForKey:@"ownerType"]]];
                }
            }
        }
        [self addSubview:ownerLabel];
        
        UIImageView *arrowImage2 = [[UIImageView alloc] initWithFrame:CGRectMake(90,521, 8, 12.5)];
        [arrowImage2 setImage:[GetImagePath getImagePath:@"新建项目5_09"]];
        [self addSubview:arrowImage2];
        
        self.dataArr = [NSMutableArray arrayWithArray:ownerArr];
        if(ownerArr.count != 0){
            for(int i=0; i<ownerArr.count;i++){
                if(i<3){
                    UIButton *contactBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                    [contactBtn setTitle:[[ownerArr objectAtIndex:i] objectForKey:@"contactName"] forState:UIControlStateNormal];
                    contactBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                    contactBtn.tag = i+1;
                    [contactBtn setTitleColor:BlueColor forState:UIControlStateNormal];
                    contactBtn.titleLabel.font = myFont;
                    [contactBtn addTarget:self action:@selector(contactBtn:) forControlEvents:UIControlEventTouchUpInside];
                    if(i == 0){
                        [contactBtn setFrame:CGRectMake(120, 164, 60, 30)];
                    }else if(i == 1){
                        [contactBtn setFrame:CGRectMake(180, 164, 60, 30)];
                    }else{
                        [contactBtn setFrame:CGRectMake(240, 164, 60, 30)];
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [closeView removeFromSuperview];
    closeView=nil;
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if(textField.tag == 2||textField.tag ==3||textField.tag == 4){
        textField.text = @"";
    }
    CGFloat heights[5]={50,150,350,400,450};
    
    
    [self.delegate beginEditWithHeight:heights[textField.tag]];
    textfield = nil;
    textfield = textField;
    closeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 568-64.5)];//350)];
    closeView.userInteractionEnabled = YES;
    UITapGestureRecognizer *closeViewtapGestureRecognizer = [[UITapGestureRecognizer alloc] init];
    [closeViewtapGestureRecognizer addTarget:self action:@selector(closeKeyBoard)];
    [closeViewtapGestureRecognizer setNumberOfTapsRequired:1];
    [closeViewtapGestureRecognizer setNumberOfTouchesRequired:1];
    [closeView addGestureRecognizer:closeViewtapGestureRecognizer];
    [self.superview.superview.superview.superview addSubview:closeView];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if ([self.delegate respondsToSelector:@selector(addContentProject:index:)]){
        [self.delegate addContentProject:textField.text index:textField.tag];
    }
    [self.delegate endEdit];
}
#define kMaxCount 150



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
            if (toBeString.length > kMaxCount) {
                textField.text = [toBeString substringToIndex:kMaxCount];
            }
        }
        // 有高亮选择的字符串，则暂不对文字进行统计和限制
        else{
            
        }
    }else{
        // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        if (toBeString.length > kMaxCount) {
            textField.text = [toBeString substringToIndex:kMaxCount];
        }
    }
}

-(void)btnClick:(UIButton *)button{
    [textfield resignFirstResponder];
    if ([self.delegate respondsToSelector:@selector(addContactViewProject:)]){
        [self.delegate addContactViewProject:button.tag];
    }
}

-(void)ForeignparticipationClick:(id)sender{
    [textfield resignFirstResponder];
    if(dropDown == nil) {
        NSLog(@"ForeignparticipationClick");
        NSMutableArray *dataTempArr = [[NSMutableArray alloc]initWithObjects:@"参与",@"不参与", nil];
        dropDown = [[NIDropDown alloc] initWithFrame:sender arr:dataTempArr tit:@"Foreignparticipation"];
        dropDown.delegate = self;
    }
    else {
        NSLog(@"消失");
        [dropDown hideDropDown:sender];
        dropDown = nil;
    }
    
}

- (void) niDropDownDelegateMethod: (NIDropDown *) sender text:(NSString *)text tit:(NSString *)tit{
    //NSLog(@"%@",text);
    if ([self.delegate respondsToSelector:@selector(addforeignInvestment:)]){
        [self.delegate addforeignInvestment:text];
    }
}

-(void)closeKeyBoard{
    [textfield resignFirstResponder];
    [closeView removeFromSuperview];
    closeView = nil;
}

-(void)contactBtn:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(updataOwner:index:)]){
        [self.delegate updataOwner:[self.dataArr objectAtIndex:button.tag-1] index:button.tag];
    }
}

-(void)gotoMap{
    if ([self.delegate respondsToSelector:@selector(gotoMap:city:)]){
        NSLog(@"===%@",[dataDic objectForKey:@"city"]);
        [self.delegate gotoMap:[dataDic objectForKey:@"landAddress"] city:[dataDic objectForKey:@"city"]];
    }
}
@end
