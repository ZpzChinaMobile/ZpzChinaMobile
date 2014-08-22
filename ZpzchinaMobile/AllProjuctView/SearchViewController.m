//
//  SearchViewController.m
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-19.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "SearchViewController.h"
#import "LoginSqlite.h"
#import "ProjectModel.h"
#import "ProjectSqlite.h"
#import "ProjectStage.h"
#import "MJRefresh.h"
@interface SearchViewController ()

@end

@implementation SearchViewController
@synthesize showArr;
@synthesize searchCellView,toolbarView;
@synthesize mapView,ADsearchVIew;
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
    self.showArr = [[NSMutableArray alloc] init];
    self.dataDic = [[NSMutableDictionary alloc] init];
    startIndex = 0;
    UIView *topBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,kScreenWidth, 64.5)];
    //[topBgView setBackgroundColor:[UIColor colorWithRed:(248/255.0)  green:(248/255.0)  blue:(249/255.0)  alpha:1.0]];
    topBgView.layer.contents=(id)[UIImage imageNamed:@"地图搜索_01.png"].CGImage;
    _searchbar = [[UISearchBar alloc] initWithFrame:CGRectMake(0,25, self.topView.frame.size.width-100, 29)];
    _searchbar.delegate =self;
    _searchbar.placeholder = @"请输入搜索内容";
	_searchbar.tintColor = [UIColor lightGrayColor];
	_searchbar.autocorrectionType = UITextAutocorrectionTypeNo;
    _searchbar.searchBarStyle = UISearchBarStyleMinimal;
	_searchbar.autocapitalizationType = UITextAutocapitalizationTypeNone;
	_searchbar.keyboardType = UIKeyboardTypeDefault;
    // Get the instance of the UITextField of the search bar
    UITextField *searchField = [_searchbar valueForKey:@"_searchField"];
    // Change search bar text color
    searchField.textColor = [UIColor whiteColor];
    // Change the search bar placeholder text color
    [searchField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [topBgView addSubview:_searchbar];
    
    UIButton *cancelBtn =  [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(self.topView.frame.size.width-100, 25, 60, 29);
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont fontWithName:@"GurmukhiMN-Bold" size:14];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [topBgView addSubview:cancelBtn];
    [self.view addSubview:topBgView];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 503.5) style:UITableViewStyleGrouped];
    [_tableView setBackgroundColor:[UIColor colorWithRed:(239/255.0)  green:(237/255.0)  blue:(237/255.0)  alpha:1.0]];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:_tableView];
    [self setupRefresh];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [self registerForKeyboardNotifications];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)registerForKeyboardNotifications
{
    //使用NSNotificationCenter 鍵盤出現時
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWasShown:)
     
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    //使用NSNotificationCenter 鍵盤隐藏時
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWillBeHidden:)
     
                                                 name:UIKeyboardWillHideNotification object:nil];
    
    
}

//实现当键盘出现的时候计算键盘的高度大小。用于输入框显示位置
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    //kbSize即為鍵盤尺寸 (有width, height)
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;//得到鍵盤的高度
    if(toolbarView == nil){
        NSLog(@"keyboardWasShown");
        toolbarView = [[toolBarView alloc] initWithFrame:CGRectMake(0, self.contentView.frame.size.height-kbSize.height-50, 320, 40)];
        //toolbarView = [[toolBarView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
        toolbarView.delegate = self;
        [self.contentView addSubview:toolbarView];
        _bgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _bgBtn.frame = CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height);
        [_bgBtn addTarget:self action:@selector(closeKeyBoard) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_bgBtn];
    }else{
        [toolbarView setFrame:CGRectMake(0, self.contentView.frame.size.height-kbSize.height-50, 320, 40)];
    }
}

//当键盘隐藏的时候
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    //do something
    [toolbarView removeFromSuperview];
    [_bgBtn removeFromSuperview];
    toolbarView = nil;
    _bgBtn = nil;
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
    NSLog(@"_searchbar ==> %@",_searchbar.text);
    [self.showArr removeAllObjects];
    startIndex = 0;
    [self loadServer:_searchbar.text startIndex:startIndex];
}

- (void)footerRereshing
{
    startIndex = startIndex +5;
    [self loadServer:_searchbar.text startIndex:startIndex];
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
    return [self.showArr count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *CellWithIdentifier = [NSString stringWithFormat:@"Cell%d",indexPath.section];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellWithIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        ProjectModel *model = [self.showArr objectAtIndex:indexPath.section];
        NSMutableDictionary *dic = [ProjectStage JudgmentStr:model];
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
        UILabel *countLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 10, 160, 20)];
        countLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:12];
        countLabel.textColor = GrayColor;
        countLabel.textAlignment = NSTextAlignmentCenter;
        countLabel.text = [NSString stringWithFormat:@"共计%d条",[self.showArr count]];
        [bgView addSubview:countLabel];
        return bgView;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //新建项目页面
    ProjectModel *model = [self.showArr objectAtIndex:indexPath.section];
    NSMutableDictionary *dic = [ProjectStage JudgmentStr:model];
    
    _newProject = [[NewProjectViewController alloc] init];
    _newProject.fromView = 1;
    _newProject.SingleDataDic = dic;
    [self.navigationController pushViewController:_newProject animated:YES];
}

-(void)cancelBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    startIndex = 0;
    [searchBar resignFirstResponder];
    [self loadServer:_searchbar.text startIndex:startIndex];
    [_recordView removeFromSuperview];
    _recordView = nil;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    _recordView = [[RecordView alloc] initWithFrame:CGRectMake(0, 64.5, 320, 287.5)];
    [self.view addSubview:_recordView];
}

-(void)gotoView:(NSInteger)index{
    switch (index) {
        case 0:
            ASRDialogview = [[ASRDialogViewController alloc] init];
            ASRDialogview.delegate = self;
            [self.navigationController pushViewController:ASRDialogview animated:YES];
            break;
        case 1:
            ADsearchVIew = [[AdvancedSearchViewController alloc] init];
            [self.navigationController pushViewController:ADsearchVIew animated:YES];
            break;
        case 2:
            mapView = [[BaiDuMapViewController alloc] init];
            [self.navigationController pushViewController:mapView animated:YES];
            break;
        default:
            break;
    }
}

-(void)closeKeyBoard{
    NSLog(@"closeKeyBoard");
    [_searchbar resignFirstResponder];
}

-(void)loadServer:(NSString *)text startIndex:(int)startIndex{
    [self.showArr removeAllObjects];
    NSString *urlStr = [NSString stringWithFormat:@"%s/projects/%@?keywords=%@&startIndex=%d&pageSize=5",serverAddress,[LoginSqlite getdata:@"UserToken" defaultdata:@"UserToken"],text,startIndex];
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
                [self.showArr addObject:model];
            }
        }else{
            NSLog(@"%@",[[[responseObject objectForKey:@"d"] objectForKey:@"status"] objectForKey:@"errors"]);
        }
        
        //NSLog(@"%@",self.showArr);
        [_tableView reloadData];
        if(startIndex !=0){
            [_tableView footerEndRefreshing];
        }else{
            [_tableView headerEndRefreshing];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [_tableView reloadData];
        if(startIndex !=0){
            [_tableView footerEndRefreshing];
        }else{
            [_tableView headerEndRefreshing];
        }
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

-(void)getSearchContent:(NSString *)searchContent{
    NSString *string = [searchContent stringByReplacingOccurrencesOfString:@"。" withString:@""];
    [_searchbar setText:string];
    [self loadServer:_searchbar.text startIndex:0];
}
@end
