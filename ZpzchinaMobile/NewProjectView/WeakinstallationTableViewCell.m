//
//  WeakinstallationTableViewCell.m
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-20.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "WeakinstallationTableViewCell.h"
#import "CameraSqlite.h"
#import "CameraModel.h"
#import "GTMBase64.h"
@implementation WeakinstallationTableViewCell
@synthesize delegate;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier dic:(NSMutableDictionary *)dic flag:(int)flag singleDic:(NSMutableDictionary *)singleDic electroweakArr:(NSMutableArray *)electroweakArr
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        UIImageView *lingImage = [[UIImageView alloc] initWithFrame:CGRectMake(18, 0, 6, 150)];
        [lingImage setBackgroundColor:[UIColor blackColor]];
        [self addSubview:lingImage];
        lingImage.alpha = 0.1;
        
        UIImageView *lingImage2 = [[UIImageView alloc] initWithFrame:CGRectMake(60, 50, 250, 1)];
        [lingImage2 setImage:[UIImage imageNamed:@"新建项目5_27.png"]];
        [self addSubview:lingImage2];
        
        UIButton *electroweakInstallation = [UIButton buttonWithType:UIButtonTypeCustom];
        electroweakInstallation.frame = CGRectMake(60,15, 200, 30);
        if(flag == 0){
            if(![[dic objectForKey:@"electroweakInstallation"] isEqualToString:@""]){
                [electroweakInstallation setTitle:[NSString stringWithFormat:@"弱电安装:%@",[dic objectForKey:@"electroweakInstallation"]] forState:UIControlStateNormal];
            }else{
                [electroweakInstallation setTitle:@"弱电安装" forState:UIControlStateNormal];
            }
        }else{
            if(![[dic objectForKey:@"electroweakInstallation"] isEqualToString:@""]){
                [electroweakInstallation setTitle:[NSString stringWithFormat:@"%@",[dic objectForKey:@"green"]] forState:UIControlStateNormal];
            }else{
                if(![[singleDic objectForKey:@"electroweakInstallation"] isEqualToString:@""]){
                    [electroweakInstallation setTitle:[NSString stringWithFormat:@"%@",[singleDic objectForKey:@"electroweakInstallation"]] forState:UIControlStateNormal];
                }else{
                    [electroweakInstallation setTitle:@"弱电安装" forState:UIControlStateNormal];
                }
            }
        }
        [electroweakInstallation setTitleColor:BlueColor forState:UIControlStateNormal];
        electroweakInstallation.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        electroweakInstallation.titleLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:16];
        [electroweakInstallation addTarget:self action:@selector(electroweakInstallation) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:electroweakInstallation];
        
        UIImageView *arrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(280,20, 8, 12.5)];
        [arrowImage setImage:[UIImage imageNamed:@"新建项目5_09.png"]];
        [self addSubview:arrowImage];
        
        NSLog(@"==> %@",electroweakArr);
        UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(40, 52, 270, 98)];
        imageArr = electroweakArr;
        if(imageArr.count !=0){
            for(int i=0;i<imageArr.count;i++){
                CameraModel *model = [imageArr objectAtIndex:i];
                UIImage *aimage = [[UIImage alloc] init];
                if(flag == 0){
                    aimage = [UIImage imageWithData:[GTMBase64 decodeString:model.a_body]];
                }else{
                    //NSLog(@"===> %@",[[NSString alloc] initWithData:[GTMBase64 decodeString:model.a_body]  encoding:NSUTF8StringEncoding]);
                    NSLog(@"a_device ==> %@",model.a_device);
                    if([model.a_device isEqualToString:@"localios"]){
                        aimage = [UIImage imageWithData:[GTMBase64 decodeString:model.a_body]];
                    }else{
                        aimage = [UIImage imageWithData:[GTMBase64 decodeString:model.a_imgCompressionContent]];
                    }
                }
                UIImageView *image = [[UIImageView alloc] init];
                image.tag = 0;
                [image setImage:aimage];
                [image setFrame:CGRectMake(270/3*i, 10, 80, 80)];
                image.userInteractionEnabled = YES;
                UITapGestureRecognizer *imagetapGestureRecognizer = [[UITapGestureRecognizer alloc] init];
                [imagetapGestureRecognizer addTarget:self action:@selector(gotoMoreElectroweak)];
                [imagetapGestureRecognizer setNumberOfTapsRequired:1];
                [imagetapGestureRecognizer setNumberOfTouchesRequired:1];
                [image addGestureRecognizer:imagetapGestureRecognizer];
                [view1 addSubview:image];
            }
        }else{
            for(int i=0;i<3;i++){
                UIImageView *image = [[UIImageView alloc] init];
                [image setFrame:CGRectMake(270/3*i, 10, 80, 80)];
                [image setImage:[UIImage imageNamed:@"NoImage.png"]];
                [view1 addSubview:image];
            }
        }
        [self addSubview:view1];
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

-(void)electroweakInstallation{
    if ([delegate respondsToSelector:@selector(addContactViewWeakinstallation)]){
        [delegate addContactViewWeakinstallation];
    }
}

-(void)gotoMoreElectroweak{
    if ([delegate respondsToSelector:@selector(moreImage:)]){
        [delegate moreImage:5];
    }
}
@end
