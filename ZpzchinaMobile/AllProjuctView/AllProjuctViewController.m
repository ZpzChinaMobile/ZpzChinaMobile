//
//  AllProjuctViewController.m
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-18.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "AllProjuctViewController.h"
#import "ProjectModel.h"
#import "ProjectSqlite.h"
#import "LoginSqlite.h"
#import "ContactModel.h"
#import "ContactSqlite.h"
#import "ProjectStage.h"
#import "MJRefresh.h"
#import "RecordSqlite.h"
#import "AFAppDotNetAPIClient.h"
#import "ProgramDetailViewController.h"
@interface AllProjuctViewController ()

@end

@implementation AllProjuctViewController
@synthesize showArr;
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
    indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];//[[TFIndicatorView alloc]initWithFrame:CGRectMake(135, 280, 50, 50)];
    indicator.center=CGPointMake(160,305);
    indicator.color=[UIColor blackColor];
    
    //indicator = [[TFIndicatorView alloc]initWithFrame:CGRectMake(135, 280, 50, 50)];
    [indicator startAnimating];
    
    [self addBackButton];
    self.showArr = [[NSMutableArray alloc] init];
    startIndex = 0;
    [self loadServer:@"" startIndex:startIndex];
    dataArr = [[NSMutableArray alloc] init];
    
    topBgView = [[UIView alloc] initWithFrame:CGRectMake(30, 0,270, 64.5)];
    topBgView.layer.contents=(id)[GetImagePath getImagePath:@"地图搜索_01"].CGImage;
    _searchbar = [[UISearchBar alloc] initWithFrame:CGRectMake(0,27, 270, 29)];
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
    [self.view addSubview:topBgView];
    
    cancelBtn =  [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(260, 25, 60, 29);
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont fontWithName:@"GurmukhiMN-Bold" size:14];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelBtnClick2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelBtn];
    [cancelBtn setHidden:YES];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64.5, 320, 503.5) style:UITableViewStyleGrouped];
    [_tableView setBackgroundColor:[UIColor colorWithRed:(239/255.0)  green:(237/255.0)  blue:(237/255.0)  alpha:1.0]];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    //[_tableView setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:_tableView];
    
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
        [lineBgView removeFromSuperview];
        lineBgView = nil;
        toolbarView = [[toolBarView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-kbSize.height-40, 320, 40)];
        toolbarView.delegate = self;
        [self.view addSubview:toolbarView];
    }else{
        [toolbarView setFrame:CGRectMake(0, self.view.frame.size.height-kbSize.height-40, 320, 40)];
    }
}

//当键盘隐藏的时候
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    //do something
    [toolbarView removeFromSuperview];
    toolbarView = nil;
}

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
    [self.showArr removeAllObjects];
    startIndex = 0;
    [self loadServer:_searchbar.text startIndex:startIndex];
}

- (void)footerRereshing
{
    startIndex = startIndex +1;
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
    //static NSString *CellIdentifier = @"Cell";
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    if(self.showArr.count != 0){
        ProjectModel *model = [self.showArr objectAtIndex:indexPath.section];
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
    //NSLog(@"==>%@",[[dataArr objectAtIndex:indexPath.section] objectForKey:@"projectID"]);
    ProgramDetailViewController* vc=[[ProgramDetailViewController alloc]init];
    vc.url=[dataArr objectAtIndex:indexPath.section][@"url"];
    vc.isRelease=0;
    vc.fromView=1;
    vc.isFromAllProject=YES;
    vc.ID=[[dataArr objectAtIndex:indexPath.section] objectForKey:@"projectID"];
    [self.navigationController pushViewController:vc animated:YES];
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


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    NSLog(@"=====>%@",[_searchbar.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]);
    if(![[_searchbar.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""]){
        startIndex = 0;
        [self.showArr removeAllObjects];
        [self loadServer:_searchbar.text startIndex:startIndex];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *time = [dateFormatter stringFromDate:[NSDate date]];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setValue:_searchbar.text forKey:@"name"];
        [dic setValue:time forKey:@"time"];
        [RecordSqlite InsertData:dic];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"请输入搜索内容" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [cancelBtn setHidden:YES];
        [UIView animateWithDuration:0.5 animations:^{
            topBgView.frame = CGRectMake(30, 0,270, 64.5);
        }];
        _searchbar.text = @"";
        [_recordView removeFromSuperview];
        _recordView = nil;
    }
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    lineBgView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-216-40, 320, 40)];
    [lineBgView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:lineBgView];
    [UIView animateWithDuration:0.5 animations:^{
        topBgView.frame = CGRectMake(0, 0,270, 64.5);
        [cancelBtn setHidden:NO];
    }];
    if(_recordView == nil){
        _recordView = [[RecordView alloc] initWithFrame:CGRectMake(0, 64.5, 320, 287.5)];
        _recordView.delegate = self;
        [self.view addSubview:_recordView];
    }
}

-(void)cancelBtnClick2{
    [_searchbar resignFirstResponder];
    [cancelBtn setHidden:YES];
    [UIView animateWithDuration:0.5 animations:^{
        topBgView.frame = CGRectMake(30, 0,270, 64.5);
    }];
    [_recordView removeFromSuperview];
    _recordView = nil;
    _searchbar.text = @"";
    [self.showArr removeAllObjects];
    startIndex = 0;
    [self loadServer:@"" startIndex:startIndex];
    [_tableView reloadData];
}

-(void)gotoView:(NSInteger)index{
    [_recordView removeFromSuperview];
    _recordView = nil;
    [_searchbar resignFirstResponder];
    [cancelBtn setHidden:YES];
    [UIView animateWithDuration:0.5 animations:^{
        topBgView.frame = CGRectMake(30, 0,270, 64.5);
    }];
    switch (index) {
        case 0:
            underStandVC = [[UnderstandViewController alloc] init];
            underStandVC.delegate = self;
            [self.navigationController pushViewController:underStandVC animated:YES];
            break;
        case 1:
            ADsearchVIew = [[AdvancedSearchViewController alloc] init];
            [self.navigationController pushViewController:ADsearchVIew animated:YES];
            break;
        case 2:
        {
            BaiDuMapViewController*   mapView = [[BaiDuMapViewController alloc] init];
            [self.navigationController pushViewController:mapView animated:YES];
        }
            break;
            
        default:
            break;
    }
}

-(void)getSearchContent:(NSString *)searchContent{
    [_searchbar resignFirstResponder];
    NSLog(@"=====>%@",[_searchbar.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]);
    if(![[_searchbar.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""]){
        [self.showArr removeAllObjects];
        [_searchbar setText:searchContent];
        startIndex = 0;
        [self.showArr removeAllObjects];
        [self loadServer:searchContent startIndex:startIndex];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *time = [dateFormatter stringFromDate:[NSDate date]];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setValue:_searchbar.text forKey:@"name"];
        [dic setValue:time forKey:@"time"];
        [RecordSqlite InsertData:dic];
    }else{
        [_recordView removeFromSuperview];
        _recordView = nil;
    }
}

-(void)searchRecordText:(NSString *)content{
    [self.showArr removeAllObjects];
    [_searchbar setText:content];
    startIndex = 0;
    [_searchbar resignFirstResponder];
    [self.showArr removeAllObjects];
    [self loadServer:content startIndex:startIndex];
}

-(void)loadServer:(NSString *)text startIndex:(int)startIndex{
    [ProjectModel globalSearchWithBlock:^(NSMutableArray *posts, NSError *error) {
        if (!error) {
            [self.showArr addObjectsFromArray:posts];
            [dataArr removeAllObjects];
            for(int i=0;i<self.showArr.count;i++){
                ProjectModel *model = [self.showArr objectAtIndex:i];
                NSMutableDictionary *dic = [ProjectStage JudgmentStr:model];
                [dataArr addObject:dic];
            }
            [_tableView reloadData];
            [indicator stopAnimating];
            if(startIndex !=0){
                [_tableView footerEndRefreshing];
            }else{
                [_tableView headerEndRefreshing];
            }
            [_recordView removeFromSuperview];
            _recordView = nil;
        }
    } str:text index:startIndex];
}


-(void)dealloc{
    NSLog(@"dealloc");
}
@end
