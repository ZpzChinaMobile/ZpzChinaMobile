//
//  ResultsViewController.m
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-7-3.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "ResultsViewController.h"
#import "LoginSqlite.h"
#import "ProjectSqlite.h"
#import "ProjectModel.h"
#import "MJRefresh.h"
#import "ProjectStage.h"
#import "ProgramDetailViewController.h"
@interface ResultsViewController ()

@end

@implementation ResultsViewController
@synthesize dataDic;
int startIndex;
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
    NSLog(@"%@",self.dataDic);
    startIndex = 0;
    showArr = [[NSMutableArray alloc] init];
    
    
    indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];//[[TFIndicatorView alloc]initWithFrame:CGRectMake(135, 280, 50, 50)];
    indicator.center=CGPointMake(160,305);
    indicator.color=[UIColor blackColor];
    [indicator startAnimating];
    
//    indicator = [[TFIndicatorView alloc]initWithFrame:CGRectMake(135, 280, 50, 50)];
//    [indicator startAnimating];
    [self addBackButton];
    [self addtittle:@"高级搜索结果"];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64.5, 320, kScreenHeight-55) style:UITableViewStyleGrouped];
    [_tableView setBackgroundColor:[UIColor colorWithRed:(239/255.0)  green:(237/255.0)  blue:(237/255.0)  alpha:1.0]];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:_tableView];
    [self loadServer:self.dataDic startIndex:startIndex];
    //集成刷新控件
    [self setupRefresh];
    [self.view addSubview:indicator];
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
/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [_tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    //[_tableView headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [_tableView addFooterWithTarget:self action:@selector(footerRereshing)];
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    [showArr removeAllObjects];
    startIndex = 0;
    [self loadServer:self.dataDic startIndex:startIndex];
}

- (void)footerRereshing
{
    startIndex = startIndex +5;
    [self loadServer:self.dataDic startIndex:startIndex];
    // 2.2秒后刷新表格UI
    /*dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
     // 刷新表格
     [self.tableView reloadData];
     
     // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
     [__tableView footerEndRefreshing];
     });*/
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [showArr count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    if(showArr.count != 0){
        ProjectModel *model = [showArr objectAtIndex:indexPath.section];
        dic = [ProjectStage JudgmentStr:model];
    }
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell"];
    ProjectContentCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(!cell){
        cell = [[ProjectContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.dic = dic;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return 30;
    }
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 260;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(section == 0){
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 291.5, 50)];
        [bgView setBackgroundColor:[UIColor colorWithRed:(239/255.0)  green:(237/255.0)  blue:(237/255.0)  alpha:1.0]];
        UILabel *countLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 10, 100, 20)];
        countLabel.font = [UIFont systemFontOfSize:12];
        countLabel.textColor = GrayColor;
        countLabel.text = [NSString stringWithFormat:@"共计%d条",[showArr count]];
        [bgView addSubview:countLabel];
        return bgView;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //新建项目页面
    //    ProjectModel *model = [showArr objectAtIndex:indexPath.section];
    //    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    //    dic = [ProjectStage JudgmentStr:model];
    //
    //    _newProject = [[NewProjectViewController alloc] init];
    //    _newProject.fromView = 1;
    //    _newProject.SingleDataDic = dic;
    //[self.navigationController pushViewController:_newProject animated:YES];
    //
    ProjectModel *model = [showArr objectAtIndex:indexPath.section];
    NSMutableDictionary *dic = [ProjectStage JudgmentStr:model];
    ProgramDetailViewController* vc=[[ProgramDetailViewController alloc]init];
    vc.url=dic[@"url"];
    vc.isRelease=0;
    vc.fromView=1;
    vc.ID=dic[@"projectID"];//[[showArr objectAtIndex:indexPath.section] objectForKey:@"projectID"];
    [self.navigationController pushViewController:vc animated:YES];
}


-(void)loadServer:(NSMutableDictionary *)dic startIndex:(int)startIndex{
    NSString *urlStr = [NSString stringWithFormat:@"%s/projects/%@?startIndex=%d&pageSize=5&keywords=%@&company=%@&projectStage=%@&category=%@",serverAddress,[LoginSqlite getdata:@"UserToken" defaultdata:@"UserToken"],startIndex,[dic objectForKey:@"keyStr"],[dic objectForKey:@"companyName"],[dic objectForKey:@"projectStage"],[dic objectForKey:@"projectCategory"]];
    NSLog(@"%@",urlStr);
    NSString * encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)urlStr, NULL, NULL,  kCFStringEncodingUTF8 ));
    NSLog(@"encode==%@",encodedString);
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"GET" URLString:encodedString parameters:nil error:nil];
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        NSNumber *statusCode = [[[responseObject objectForKey:@"d"] objectForKey:@"status"] objectForKey:@"statusCode"];
        if([[NSString stringWithFormat:@"%@",statusCode] isEqualToString:@"200"]){
            NSArray *a = [[responseObject objectForKey:@"d"] objectForKey:@"data"];
            for(NSDictionary *item in a){
                ProjectModel *model = [[ProjectModel alloc] init];
                [model loadWithDictionary:item];
                [showArr addObject:model];
            }
        }else if([[NSString stringWithFormat:@"%@",statusCode] isEqualToString:@"1302"]){
            NSLog(@"%@",[[[responseObject objectForKey:@"d"] objectForKey:@"status"] objectForKey:@"errors"]);
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"没有找到项目"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil,nil];
            [alert show];
        }
        
        //NSLog(@"%@",self.showArr);
        [_tableView reloadData];
        [indicator stopAnimating];
        if(startIndex !=0){
            [_tableView footerEndRefreshing];
        }else{
            [_tableView headerEndRefreshing];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    [[NSOperationQueue mainQueue] addOperation:op];
}

-(void)addActionSheet{
    NSLog(@"addActionSheet");
    _myActionSheet = [[UIActionSheet alloc]
                      initWithTitle:nil
                      delegate:self
                      cancelButtonTitle:@"取消"
                      destructiveButtonTitle:nil
                      otherButtonTitles: @"编辑本条信息", @"删除",nil];
    _myActionSheet.destructiveButtonIndex=1;
    [_myActionSheet showInView:self.view];
}
@end
