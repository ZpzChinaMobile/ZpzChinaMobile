//
//  ISRViewController.m
//  MSCDemo
//
//  Created by iflytek on 13-6-6.
//  Copyright (c) 2013年 iflytek. All rights reserved.
//

#import "ISRViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "iflyMSC/IFlyContact.h"
#import "iflyMSC/IFlyDataUploader.h"
#import "Definition.h"
#import "iflyMSC/IFlyUserWords.h"
#import "RecognizerFactory.h"
#import "UIPlaceHolderTextView.h"
#import "iflyMSC/IFlySpeechUtility.h"
#import "iflyMSC/IFlySpeechRecognizer.h"
#import "PopupView.h"
#import "iflyMSC/IFlySpeechConstant.h"
#import "iflyMSC/IFlyResourceUtil.h"
#import "JSONKit.h"
#define FirstTouch 1
#define SecondTouch 2
@implementation ISRViewController

@synthesize delegate;
static int touchCount =1;
static int timeCount =0;

- (instancetype) init
{
    self = [super init];
    if (self) {
        //创建识别
        _iFlySpeechRecognizer = [RecognizerFactory CreateRecognizer:self Domain:@"iat"];
        _iFlySpeechRecognizer.delegate = self;
        
    }
    
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}





// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //LeftButton设置属性
    [self addBackButton];
    
    //RightButton设置属性
    UIButton *completeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [completeBtn setFrame:CGRectMake(280, 25, 30, 30)];
    [completeBtn setBackgroundImage:[UIImage imageNamed:@"icon__09"] forState:UIControlStateNormal];
    completeBtn.titleLabel.textColor = [UIColor whiteColor];
    [completeBtn addTarget:self action:@selector(completeBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:completeBtn];
    
    
    self.title = @"语音搜索";
    
    
    UIPlaceHolderTextView *resultView = [[UIPlaceHolderTextView alloc] initWithFrame:
                                         CGRectMake(Margin*2, Margin*2+3.5+56.5, self.view.frame.size.width-Margin*4, 300)];
    resultView.layer.cornerRadius = 8;
    [self.view addSubview:resultView];
    resultView.font = [UIFont systemFontOfSize:25.0f];
    resultView.editable = NO;
    resultView.layer.borderWidth = 0;
    _textView = resultView;
    _textView.text =@"";
    label = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 140, 40)];
    label.font = [UIFont systemFontOfSize:25.0f];
    label.textColor = [UIColor colorWithRed:(151/255.0)  green:(151/255.0)  blue:(151/255.0)  alpha:1.0];
    label.text =@"请开始说话";
    [resultView addSubview:label];
    UIImage *image = [UIImage imageNamed:@"语音搜索_04"];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(90, resultView.frame.origin.y+resultView.frame.size.height+103.5-56.5, 149, 149)];
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

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.view = nil;
}

-(void)leftBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewWillAppear:(BOOL)animated
{
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [_iFlySpeechRecognizer cancel];
    _iFlySpeechRecognizer.delegate = nil;
    //设置回非语义识别
    [_iFlySpeechRecognizer destroy];
}

- (void)startListening1
{
    
    
    label.hidden =NO;
    label.text =@"正在接收中...";
    if (touchCount ==FirstTouch) {
        _textView.text =@"";
        bool ret = [_iFlySpeechRecognizer startListening];
        
        if (ret) {
            timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(circleBtn) userInfo:nil repeats:YES];
            touchCount++;
        }
        else
        {
            [_popView setText: @"启动识别服务失败，请稍后重试"];//可能是上次请求未结束
            [self.view addSubview:_popView];
            touchCount++;
        }
        
        
    }
    else if(touchCount==SecondTouch) {
        touchCount--;
        label.hidden =YES;
        [timer invalidate];
        [_iFlySpeechRecognizer stopListening];
        return;
    }
    
}

-(void)circleBtn
{
    
    if (timeCount==5) {
        timeCount=0;
        touchCount--;
        label.hidden =YES;
        [timer invalidate];
        [_iFlySpeechRecognizer stopListening];
        return;
        
    }
    timeCount++;
    [button blink];
}


- (void)completeBtnAction{
    
    
    NSString *string = [_textView.text stringByReplacingOccurrencesOfString:@"。" withString:@""];
    
    NSLog(@"nijiosdfopskopd   %@",string);
    
    if ([delegate respondsToSelector:@selector(getSearchContent:)]){
        [delegate getSearchContent:string];
    }
    [self.navigationController popViewControllerAnimated:YES];
}




#pragma mark - IFlySpeechRecognizerDelegate


- (void) onResults:(NSArray *) results isLast:(BOOL)isLast
{
    [_iFlySpeechRecognizer stopListening];
    
    NSMutableString *resultString = [[NSMutableString alloc] init];
    NSDictionary *dic = results [0];
    NSString *jsonStr=nil;
    for (NSString *key in dic) {
        jsonStr =[NSString stringWithFormat:@"%@",key];
        NSData *data = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *tempResult  = [data objectFromJSONData];
        NSArray *array = [tempResult objectForKey:@"ws"];
        
        for (NSDictionary *tempDic in array) {
            NSString *tempStr =[[[tempDic objectForKey:@"cw"] objectAtIndex:0] objectForKey:@"w"];
            [resultString appendString:tempStr];
            NSLog(@"听写wwwwwww结果：%@",resultString);
        }
        
    }
    NSString  *str =  [resultString stringByReplacingOccurrencesOfString:@" (置信度:100)\n" withString:@""];
    str =  [str stringByReplacingOccurrencesOfString:@"。" withString:@""];
    str =  [str stringByReplacingOccurrencesOfString:@"！" withString:@""];
    str =  [str stringByReplacingOccurrencesOfString:@"？" withString:@""];
    str =  [str stringByReplacingOccurrencesOfString:@"，" withString:@""];
    if (![str isEqualToString:@""]) {
        _textView.text =str;
    }
    
    
    
}

- (void) onError:(IFlySpeechError *) errorCode{
    NSLog(@"***%@",errorCode);
}
@end
