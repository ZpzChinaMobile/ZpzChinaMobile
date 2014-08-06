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
    UIColor *ballColor = [UIColor colorWithRed:0.47 green:0.60 blue:0.89 alpha:1];
    pendulum = [[PendulumView alloc] initWithFrame:CGRectMake(0, 55, 320, 513) ballColor:ballColor];
    [self addBackButton];
    [self addtittle:@"高级搜索结果"];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 55, 320, 513) style:UITableViewStyleGrouped];
    [_tableView setBackgroundColor:[UIColor colorWithRed:(239/255.0)  green:(237/255.0)  blue:(237/255.0)  alpha:1.0]];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:_tableView];
    [self loadServer:self.dataDic startIndex:startIndex];
    //集成刷新控件
    [self setupRefresh];
    [self.view addSubview:pendulum];
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
    NSString *CellWithIdentifier = [NSString stringWithFormat:@"Cell%d",indexPath.section];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellWithIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        ProjectModel *model = [showArr objectAtIndex:indexPath.section];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        dic = [ProjectStage JudgmentStr:model];
        _cellContent = [[CellContentView alloc] initWithFrame:CGRectMake(14, 0, 291.5, 260) dic:dic];
        _cellContent.delegate = self;
        [cell.contentView addSubview:_cellContent];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
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
        countLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:12];
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
    ProjectModel *model = [showArr objectAtIndex:indexPath.section];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    dic = [ProjectStage JudgmentStr:model];
    
    _newProject = [[NewProjectViewController alloc] init];
    _newProject.fromView = 1;
    _newProject.SingleDataDic = dic;
    [self.navigationController pushViewController:_newProject animated:YES];
}


-(void)loadServer:(NSMutableDictionary *)dic startIndex:(int)startIndex{
    NSString *urlStr = [NSString stringWithFormat:@"%s/projects/%@?startIndex=%d&pageSize=5&keywords=%@&company=%@&projectStage=%@&district=%@&province=%@&category=%@",serverAddress,[LoginSqlite getdata:@"UserToken" defaultdata:@"UserToken"],startIndex,[dic objectForKey:@"keyStr"],[dic objectForKey:@"companyName"],[dic objectForKey:@"projectStage"],[dic objectForKey:@"district"],[dic objectForKey:@"province"],[dic objectForKey:@"projectCategory"]];
    NSLog(@"%@",urlStr);
    NSString * encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)urlStr, NULL, NULL,  kCFStringEncodingUTF8 ));
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
        }else{
            NSLog(@"%@",[[[responseObject objectForKey:@"d"] objectForKey:@"status"] objectForKey:@"errors"]);
        }
        
        //NSLog(@"%@",self.showArr);
        [_tableView reloadData];
        [pendulum removeFromSuperview];
        pendulum = nil;
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
