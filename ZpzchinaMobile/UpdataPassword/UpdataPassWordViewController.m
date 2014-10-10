//
//  UpdataPassWordViewController.m
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-10-10.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "UpdataPassWordViewController.h"
#import "HomePageCenterViewController.h"
@interface UpdataPassWordViewController ()

@end

@implementation UpdataPassWordViewController

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
    // Do any additional setup after loading the view.
    [self addBackButton];
    [self addtittle:@"修改密码"];
    
    UILabel *oldPassWord = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, 60, 30)];
    oldPassWord.textColor = BlueColor;
    oldPassWord.text = @"原密码";
    oldPassWord.font = [UIFont fontWithName:@"GurmukhiMN" size:14];
    [self.contentView addSubview:oldPassWord];
    
    oldPassWordTextField = [[UITextField alloc] initWithFrame:CGRectMake(75, 20, 200, 30)];
    oldPassWordTextField.placeholder = @"原密码";
    oldPassWordTextField.font = [UIFont fontWithName:@"GurmukhiMN" size:14];
    oldPassWordTextField.delegate = self;
    [oldPassWordTextField setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    [self.contentView addSubview:oldPassWordTextField];
    
    UIImageView *lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, 55, 290, 1)];
    [lineImage setBackgroundColor:[UIColor blackColor]];
    [self.contentView addSubview:lineImage];
    lineImage.alpha = 0.2;
    
    UILabel *newPassWord = [[UILabel alloc] initWithFrame:CGRectMake(15, 65, 60, 30)];
    newPassWord.textColor = BlueColor;
    newPassWord.text = @"新密码";
    newPassWord.font = [UIFont fontWithName:@"GurmukhiMN" size:14];
    [self.contentView addSubview:newPassWord];
    
    newAgainPassWordTextField = [[UITextField alloc] initWithFrame:CGRectMake(75, 65, 200, 30)];
    newAgainPassWordTextField.placeholder = @"新密码";
    newAgainPassWordTextField.font = [UIFont fontWithName:@"GurmukhiMN" size:14];
    newAgainPassWordTextField.delegate = self;
    [newAgainPassWordTextField setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    [self.contentView addSubview:newAgainPassWordTextField];
    
    UIImageView *lineImage2 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 100, 290, 1)];
    [lineImage2 setBackgroundColor:[UIColor blackColor]];
    [self.contentView addSubview:lineImage2];
    lineImage2.alpha = 0.2;
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

@end
