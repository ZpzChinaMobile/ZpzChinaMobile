//
//  ProgramDetailViewController.h
//  programDetail
//
//  Created by 孙元侃 on 14-8-7.
//  Copyright (c) 2014年 sunyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgramDetailViewController : UIViewController
@property(nonatomic,strong)UIButton* firstStageButton1;//11 第1大阶段第一个imageView的触发
@property(nonatomic,strong)UIButton* secondStageButton1;//21 第2大阶段第1个imageView的触发
@property(nonatomic,strong)UIButton* thirdStageButton1;//31 第3大阶段第1个imageView的触发
@property(nonatomic,strong)UIButton* thirdStageButton2;//32 第3大阶段第2个imageView的触发
@property(nonatomic,strong)UIButton* thirdStageButton3;//33 第3大阶段第3个imageView的触发
@property(nonatomic,strong)UIButton* fourthStageButton1;//41 第4大阶段第1个imageView的触发
-(void)userChangeImageWithButtons:(UIButton *)button;
@end
