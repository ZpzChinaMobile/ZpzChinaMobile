//
//  OwnerTypeViewController.m
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-28.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "OwnerTypeViewController.h"
#import "OwnerTypeTableViewCell.h"
@interface Item2 : NSObject

@property (retain, nonatomic) NSString *title;

@property (assign, nonatomic) BOOL isChecked;

@end

@implementation Item2

@end
@interface OwnerTypeViewController ()

@end

@implementation OwnerTypeViewController
@synthesize showArr,dataArr;
@synthesize delegate;
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
    UIImageView *bgimageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 262, 431)];
    [bgimageView setImage:[UIImage imageNamed:@"新建项目1_03.png"]];
    [self.view addSubview:bgimageView];
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 262, 40)];
    [topView setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:topView];
    
    UIButton *cancel = [UIButton buttonWithType:UIButtonTypeCustom];
    cancel.frame = CGRectMake(10,7, 50, 30);
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    [cancel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    cancel.titleLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:16];
    [cancel addTarget:self action:@selector(CancelClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancel];
    
    UIButton *complated = [UIButton buttonWithType:UIButtonTypeCustom];
    complated.frame = CGRectMake(200,7, 50, 30);
    [complated setTitle:@"完成" forState:UIControlStateNormal];
    [complated setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    complated.titleLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:16];
    [complated addTarget:self action:@selector(complatedClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:complated];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, 262, 431-40)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 44;
    _tableView.allowsSelectionDuringEditing = YES;
    [self.view addSubview:_tableView];
    self.dataArr = [[NSMutableArray alloc] init];
    self.showArr = [NSMutableArray arrayWithCapacity:0];
    NSArray *arr = [[NSArray alloc] initWithObjects:@"外商独资",@"中外合资",@"私人企业",@"政府机关",@"国有企业",@"其他",nil];
    for (int i=0; i<arr.count; i++) {
        Item2 *item = [[Item2 alloc] init];
        item.title = [arr objectAtIndex:i];
        item.isChecked = NO;
        [self.showArr addObject:item];
        [self.dataArr addObject:@""];
    }
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.showArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    OwnerTypeTableViewCell *cell = (OwnerTypeTableViewCell*)[_tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[OwnerTypeTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
	
	cell.accessoryType = UITableViewCellAccessoryNone;
	cell.textLabel.textColor = [UIColor blackColor];
	
    Item2* item = [self.showArr objectAtIndex:indexPath.row];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(49, 10, 200, 30)];
    title.text = item.title;
	[cell addSubview:title];
	[cell setChecked:item.isChecked];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Item2* item = [self.showArr objectAtIndex:indexPath.row];
	OwnerTypeTableViewCell *cell = (OwnerTypeTableViewCell*)[_tableView cellForRowAtIndexPath:indexPath];
    item.isChecked = !item.isChecked;
    [cell setChecked:item.isChecked];
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(item.isChecked){
        [self.dataArr insertObject:item.title atIndex:indexPath.row];
    }else{
        [self.dataArr removeObjectAtIndex:indexPath.row];
    }
}

-(void)CancelClick{
    if ([delegate respondsToSelector:@selector(backOwnerTypeViewController)]){
        [delegate backOwnerTypeViewController];
    }
}

-(void)complatedClick{
    if(self.dataArr.count !=0){
        if ([delegate respondsToSelector:@selector(choiceDataOwnerType:)]){
            [delegate choiceDataOwnerType:self.dataArr];
        }
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"请选择类型！"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil,nil];
        [alert show];
    }
}
@end
