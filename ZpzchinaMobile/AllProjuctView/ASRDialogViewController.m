//
//  ASRDialogViewController.m
//  MSCDemo
//
//  Created by junmei on 14-1-20.
//  Copyright (c) 2014年 iflytek. All rights reserved.
//

#import "ASRDialogViewController.h"


//#import "iflyMSC/IFlySpeechConstant.h"
//#import "iflyMSC/IFlySpeechUtility.h"
//#import "iflyMSC/IFlyRecognizerView.h"
#import "PopupView.h"
#import "SearchViewController.h"
#import "DKCircleButton.h"
#define IOS7_OR_LATER   ( [[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending )
#define Margin  5
#define APPID_VALUE @"539e6aef"

//#import "ZCNoneiFLYTEK.h"

#define FirstTouch 1
#define SecondTouch 2
@interface ASRDialogViewController ()
{
    DKCircleButton *button;
    NSTimer *timer;
}
@property (nonatomic,retain) SearchViewController *searchVC;
@end

@implementation ASRDialogViewController
@synthesize delegate;

static int touchCount =2;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self addBackButton];
    [self addtittle:@"语音搜索"];
    [self addRightButton:CGRectMake(280, 20, 29, 28.5) title:nil iamge:[UIImage imageNamed:@"icon__09.png"]];
   
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
    if ( IOS7_OR_LATER )
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
        self.navigationController.navigationBar.translucent = NO;
    }
#endif
    
    UIPlaceHolderTextView *resultView = [[UIPlaceHolderTextView alloc] initWithFrame:
                                         CGRectMake(Margin*2, Margin*2+68, self.view.frame.size.width-Margin*4, 300)];
    resultView.layer.cornerRadius = 8;
    resultView.layer.borderWidth = 1;
    [self.view addSubview:resultView];
    resultView.font = [UIFont systemFontOfSize:25.0f];
//    resultView.placeholder = @"识别结果";
    resultView.editable = NO;
    resultView.layer.borderColor = (__bridge CGColorRef)([UIColor clearColor]);
    _textView = resultView;
    _textView.text =@"";
    label = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 140, 40)];
    label.font = [UIFont systemFontOfSize:25.0f];
    label.textColor = [UIColor colorWithRed:(151/255.0)  green:(151/255.0)  blue:(151/255.0)  alpha:1.0];
    label.text =@"请开始说话";
    [resultView addSubview:label];
    UIImage *image = [UIImage imageNamed:@"语音搜索_04.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(90, resultView.frame.origin.y+resultView.frame.size.height+40, 149, 149)];
//    imageView.center = CGPointMake(160, resultView.frame.origin.y+resultView.frame.size.height+60);
    imageView.image = image;
    [self.view addSubview:imageView];
    button = [[DKCircleButton alloc] initWithFrame:CGRectMake(0, 0, 140, 140)];
    button.center = imageView.center;
    button.titleLabel.font = [UIFont systemFontOfSize:22];
    [button setBorderColor:[UIColor clearColor]];
    
    

    [button setBackgroundImage:[UIImage imageNamed:@"语音搜索1_05"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"语音搜索1_05"] forState:UIControlStateSelected];
    [button setBackgroundImage:[UIImage imageNamed:@"语音搜索1_05"] forState:UIControlStateHighlighted];
    
    [button addTarget:self action:@selector(startListening1) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:button];
    
    [resultView setNeedsDisplay];
}

- (void)startListening1
{
    
    
    touchCount--;
    [button blink];
    label.hidden =NO;
    label.text =@"正在接收中...";
    if (touchCount ==FirstTouch) {
        _textView.text =@"";
    manager=[ZCNoneiFLYTEK shareManager];
       timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(startListening1) userInfo:nil repeats:YES];
        
        
        [manager discernBlock:^(NSString *str) {
            str =  [str stringByReplacingOccurrencesOfString:@" (置信度:100)\n" withString:@""];
            str =  [str stringByReplacingOccurrencesOfString:@"。" withString:@""];
            str =  [str stringByReplacingOccurrencesOfString:@"！" withString:@""];
 
           
            if (![str  isEqual:@""]) {
                label.hidden =YES;
                [timer invalidate];
                [manager stopListening];
                _textView.text = str;
                touchCount=2;
                return;
            }
            
            
            
        }];
        
        
        touchCount = touchCount+5;
    }
    else if(touchCount==SecondTouch) {
        label.hidden =YES;
        [timer invalidate];
        [manager stopListening];
        return;
    }
    
}

//-(void)rollButton
//{
//[button blink];
//}

- (void)rightAction{
    if ([delegate respondsToSelector:@selector(getSearchContent:)]){
        [delegate getSearchContent:_textView.text];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated
{

}



@end
