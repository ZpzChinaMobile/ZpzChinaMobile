//
//  BaseViewController.m
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-17.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //为解决掉页面而加的view
    UIView* tempView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth, 64.5)];
    [self.view addSubview:tempView];
    
    UIView *contentView=[[UIView alloc] initWithFrame:CGRectMake(0,64.5,kScreenWidth,kContentHeight)];
    contentView.backgroundColor=[UIColor whiteColor];
    self.contentView=contentView;
    [self.view addSubview:contentView];

    
    UIView *topView=[[UIView alloc] initWithFrame:CGRectMake(0, 0,kScreenWidth, 64.5)];
    topView.layer.contents=(id)[UIImage imageNamed:@"地图搜索_01.png"].CGImage;
    [self.view addSubview:topView];
    self.topView=topView;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)addBackButton
{
    UIButton* backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(5,27,25,22);
    [backButton setImage:[UIImage imageNamed:@"013"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:backButton];
}

-(void)leftAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)addtittle:(NSString *)title{
    UILabel *topLabel = [[UILabel alloc] init];
    topLabel.frame = CGRectMake(100, 25, 120, 28);
    topLabel.font = [UIFont fontWithName:@"GurmukhiMN-Bold" size:19];
    topLabel.textColor = [UIColor whiteColor];
    topLabel.text = title;
    topLabel.textAlignment = NSTextAlignmentCenter;
    [self.topView addSubview:topLabel];
}

- (void)addRightButton:(CGRect)frame title:(NSString *)title iamge:(UIImage *)image
{
    rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame  = frame;
    if(image){
        [rightButton setImage:image forState:UIControlStateNormal];
    }
    if(title){
        [rightButton setTitle:title forState:UIControlStateNormal];
        rightButton.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    [rightButton addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:rightButton];
}

-(void)removeRightBtn{
    [rightButton removeFromSuperview];
    rightButton = nil;
}

-(void)rightAction{

}

-(void)setBgColor:(UIColor *)color{
    [self.contentView setBackgroundColor:color];
}

- (void)presentPopupViewController:(UIViewController*)popupViewController{
    [self presentPopupViewController:popupViewController animationType:MJPopupViewAnimationSlideBottomBottom];
}

- (void)dismissPopupViewController{
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationSlideBottomTop];
}


@end
