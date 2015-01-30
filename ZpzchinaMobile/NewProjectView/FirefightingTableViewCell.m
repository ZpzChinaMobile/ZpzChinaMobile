//
//  FirefightingTableViewCell.m
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-20.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "FirefightingTableViewCell.h"
#import "CameraModel.h"
#import "CameraSqlite.h"
#import "GTMBase64.h"
@implementation FirefightingTableViewCell
@synthesize delegate;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier dic:(NSMutableDictionary *)dic flag:(int)flag singleDic:(NSMutableDictionary *)singleDic fireControlArr:(NSMutableArray *)fireControlArr
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        UIImageView *lingImage = [[UIImageView alloc] initWithFrame:CGRectMake(18, 0, 6, 150)];
        [lingImage setBackgroundColor:[UIColor blackColor]];
        [self addSubview:lingImage];
        lingImage.alpha = 0.1;
        
        UIImageView *lingImage2 = [[UIImageView alloc] initWithFrame:CGRectMake(60, 50, 250, 1)];
        [lingImage2 setImage:[GetImagePath getImagePath:@"新建项目5_27"]];
        [self addSubview:lingImage2];
        
        UIButton *fireControl = [UIButton buttonWithType:UIButtonTypeCustom];
        fireControl.frame = CGRectMake(60,15, 200, 30);
        if(flag == 0){
            if(![[dic objectForKey:@"fireControl"] isEqualToString:@""]){
                [fireControl setTitle:[NSString stringWithFormat:@"%@",[dic objectForKey:@"fireControl"]] forState:UIControlStateNormal];
            }else{
                [fireControl setTitle:@"消防" forState:UIControlStateNormal];
            }
        }else{
            if(![[dic objectForKey:@"fireControl"] isEqualToString:@""]){
                [fireControl setTitle:[NSString stringWithFormat:@"%@",[dic objectForKey:@"fireControl"]] forState:UIControlStateNormal];
            }else{
                if(![[singleDic objectForKey:@"fireControl"] isEqualToString:@""]){
                    [fireControl setTitle:[NSString stringWithFormat:@"%@",[singleDic objectForKey:@"fireControl"]] forState:UIControlStateNormal];
                }else{
                    [fireControl setTitle:@"消防" forState:UIControlStateNormal];
                }
            }
        }
        [fireControl setTitleColor:BlueColor forState:UIControlStateNormal];
        fireControl.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        fireControl.titleLabel.font = [UIFont systemFontOfSize:16];
        [fireControl addTarget:self action:@selector(fireControl) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:fireControl];
        
        UIImageView *arrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(280,20, 8, 12.5)];
        [arrowImage setImage:[GetImagePath getImagePath:@"新建项目5_09"]];
        [self addSubview:arrowImage];
        
        NSLog(@"==> %@",fireControlArr);
        UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(40, 52, 270, 98)];
        imageArr = fireControlArr;
        if(imageArr.count !=0){
            for(int i=0;i<imageArr.count;i++){
                CameraModel *model = [imageArr objectAtIndex:i];
                UIImage *aimage = nil;
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
                [imagetapGestureRecognizer addTarget:self action:@selector(gotoMorefireControl)];
                [imagetapGestureRecognizer setNumberOfTapsRequired:1];
                [imagetapGestureRecognizer setNumberOfTouchesRequired:1];
                [image addGestureRecognizer:imagetapGestureRecognizer];
                [view1 addSubview:image];
            }
        }else{
            for(int i=0;i<3;i++){
                UIImageView *image = [[UIImageView alloc] init];
                [image setFrame:CGRectMake(270/3*i, 10, 80, 80)];
                [image setImage:[GetImagePath getImagePath:@"NoImage"]];
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

-(void)fireControl{
    if ([delegate respondsToSelector:@selector(addContactViewFirefighting)]){
        [delegate addContactViewFirefighting];
    }
}

-(void)gotoMorefireControl{
    if ([delegate respondsToSelector:@selector(moreImage:)]){
        [delegate moreImage:4];
    }
}
@end
