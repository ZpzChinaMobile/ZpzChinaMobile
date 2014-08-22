//
//  MainConstructionTableViewCell.m
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-20.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "MainConstructionTableViewCell.h"
#import "CameraSqlite.h"
#import "CameraModel.h"
#import "GTMBase64.h"
@implementation MainConstructionTableViewCell
@synthesize delegate;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier flag:(int)flag HorizonArr:(NSMutableArray *)HorizonArr PilePitArr:(NSMutableArray *)PilePitArr MainConstructionArr:(NSMutableArray *)MainConstructionArr isRelease:(int)isRelease
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [horizonArr removeAllObjects];
        [pilePitArr removeAllObjects];
        [mainConstructionArr removeAllObjects];
        UIImageView *lingImage = [[UIImageView alloc] initWithFrame:CGRectMake(18, 0, 6, 500)];
        [lingImage setBackgroundColor:[UIColor blackColor]];
        [self addSubview:lingImage];
        lingImage.alpha = 0.1;
        
        UILabel *titleName = [[UILabel alloc] initWithFrame:CGRectMake(40, 5, 50, 30)];
        titleName.font = [UIFont fontWithName:@"GurmukhiMN" size:16];
        titleName.text = @"地平";
        [titleName setTextColor:BlueColor];
        [self addSubview:titleName];
        
        UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(40, 40, 270, 140)];
        horizonArr = HorizonArr;
        NSLog(@"==>%@",horizonArr);
        if(horizonArr.count !=0){
            for(int i=0;i<horizonArr.count;i++){
                CameraModel *model = [horizonArr objectAtIndex:i];
                UIImage *aimage = nil;
                if(flag == 0){
                    aimage = [UIImage imageWithData:[GTMBase64 decodeString:model.a_body]];
                }else{
                    if([model.a_device isEqualToString:@"localios"]){
                        aimage = [UIImage imageWithData:[GTMBase64 decodeString:model.a_body]];
                    }else{
                        aimage = [UIImage imageWithData:[GTMBase64 decodeString:model.a_imgCompressionContent]];
                    }
                }
                UIImageView *image = [[UIImageView alloc] init];
                image.tag = 0;
                [image setImage:aimage];
                [image setFrame:CGRectMake(270/3*i, 0, 80, 80)];
                image.userInteractionEnabled = YES;
                UITapGestureRecognizer *imagetapGestureRecognizer = [[UITapGestureRecognizer alloc] init];
                [imagetapGestureRecognizer addTarget:self action:@selector(gotoMoreHorizon)];
                [imagetapGestureRecognizer setNumberOfTapsRequired:1];
                [imagetapGestureRecognizer setNumberOfTouchesRequired:1];
                [image addGestureRecognizer:imagetapGestureRecognizer];
                [view1 addSubview:image];
            }
        }else{
            for(int i=0;i<3;i++){
                UIImageView *image = [[UIImageView alloc] init];
                [image setFrame:CGRectMake(270/3*i, 0, 80, 80)];
                [image setImage:[UIImage imageNamed:@"NoImage.png"]];
                [view1 addSubview:image];
            }
        }
        [self addSubview:view1];
        
        UILabel *titleName2 = [[UILabel alloc] initWithFrame:CGRectMake(40, 135, 100, 30)];
        titleName2.font = [UIFont fontWithName:@"GurmukhiMN" size:16];
        titleName2.text = @"桩基基坑";
        [titleName2 setTextColor:BlueColor];
        [self addSubview:titleName2];
        
        UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(40, 170, 270, 140)];
        pilePitArr = PilePitArr;
        NSLog(@"pilePitArr==> %@",PilePitArr);
        if(pilePitArr.count !=0){
            for(int i=0;i<pilePitArr.count;i++){
                CameraModel *model = [pilePitArr objectAtIndex:i];
                UIImage *aimage = nil;
                if(flag == 0){
                    aimage = [UIImage imageWithData:[GTMBase64 decodeString:model.a_body]];
                }else{
                    if([model.a_device isEqualToString:@"localios"]){
                        aimage = [UIImage imageWithData:[GTMBase64 decodeString:model.a_body]];
                    }else{
                        aimage = [UIImage imageWithData:[GTMBase64 decodeString:model.a_imgCompressionContent]];
                    }
                }
                UIImageView *image = [[UIImageView alloc] init];
                [image setImage:aimage];
                [image setFrame:CGRectMake(270/3*i, 0, 80, 80)];
                image.userInteractionEnabled = YES;
                UITapGestureRecognizer *imagetapGestureRecognizer = [[UITapGestureRecognizer alloc] init];
                [imagetapGestureRecognizer addTarget:self action:@selector(gotoMorePilePit)];
                [imagetapGestureRecognizer setNumberOfTapsRequired:1];
                [imagetapGestureRecognizer setNumberOfTouchesRequired:1];
                [image addGestureRecognizer:imagetapGestureRecognizer];
                [view2 addSubview:image];
            }
        }else{
            for(int i=0;i<3;i++){
                UIImageView *image = [[UIImageView alloc] init];
                [image setFrame:CGRectMake(270/3*i, 0, 80, 80)];
                [image setImage:[UIImage imageNamed:@"NoImage.png"]];
                [view2 addSubview:image];
            }
        }
        [self addSubview:view2];
        
        UILabel *titleName3 = [[UILabel alloc] initWithFrame:CGRectMake(40, 265, 100, 30)];
        titleName3.font = [UIFont fontWithName:@"GurmukhiMN" size:16];
        titleName3.text = @"主体施工";
        [titleName3 setTextColor:BlueColor];
        [self addSubview:titleName3];
        
        UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(40, 300, 270, 140)];
        mainConstructionArr = MainConstructionArr;
        if(mainConstructionArr.count !=0){
            for(int i=0;i<mainConstructionArr.count;i++){
                CameraModel *model = [mainConstructionArr objectAtIndex:i];
                UIImage *aimage = nil;
                if(flag == 0){
                    aimage = [UIImage imageWithData:[GTMBase64 decodeString:model.a_body]];
                }else{
                    if([model.a_device isEqualToString:@"localios"]){
                        aimage = [UIImage imageWithData:[GTMBase64 decodeString:model.a_body]];
                    }else{
                        aimage = [UIImage imageWithData:[GTMBase64 decodeString:model.a_imgCompressionContent]];
                    }
                }
                UIImageView *image = [[UIImageView alloc] init];
                [image setImage:aimage];
                [image setFrame:CGRectMake(270/3*i, 0, 80, 80)];
                image.userInteractionEnabled = YES;
                UITapGestureRecognizer *imagetapGestureRecognizer = [[UITapGestureRecognizer alloc] init];
                [imagetapGestureRecognizer addTarget:self action:@selector(gotoMoreMainConstruction)];
                [imagetapGestureRecognizer setNumberOfTapsRequired:1];
                [imagetapGestureRecognizer setNumberOfTouchesRequired:1];
                [image addGestureRecognizer:imagetapGestureRecognizer];
                [view3 addSubview:image];
            }
        }else{
            for(int i=0;i<3;i++){
                UIImageView *image = [[UIImageView alloc] init];
                [image setFrame:CGRectMake(270/3*i, 0, 80, 80)];
                [image setImage:[UIImage imageNamed:@"NoImage.png"]];
                [view3 addSubview:image];
            }
        }
        [self addSubview:view3];
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

-(void)gotoMoreHorizon{
    if ([delegate respondsToSelector:@selector(moreImage:)]){
        [delegate moreImage:0];
    }
}

-(void)gotoMorePilePit{
    if ([delegate respondsToSelector:@selector(moreImage:)]){
        [delegate moreImage:1];
    }
}

-(void)gotoMoreMainConstruction{
    if ([delegate respondsToSelector:@selector(moreImage:)]){
        [delegate moreImage:2];
    }
}
@end
