//
//  NineTableViewController.m
//  ZpzchinaMobile
//
//  Created by 孙元侃 on 14-8-14.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "NineTableViewController.h"
#import "CameraModel.h"
#import "GTMBase64.h"
@interface NineTableViewController ()

@end

@implementation NineTableViewController
//消防/景观绿化
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

-(instancetype)initWithSingle:(NSMutableDictionary*)singleDic dataDic:(NSMutableDictionary*)dataDic images:(NSMutableArray*)images{
    if ([super init]) {
        self.singleDic=singleDic;
        self.dataDic=dataDic;
        self.images=[NSMutableArray array];
        
        for (int i=0; i<images.count; i++) {
            CameraModel* model= images[i];
            UIImage *aimage=[UIImage imageWithData:[GTMBase64 decodeString:model.a_imgCompressionContent]];
            [self.images addObject:aimage];
        }
        
        [self.images addObject:[UIImage imageNamed:@"新建项目1_06.png"]];
        
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.separatorStyle=NO;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *stringcell = @"ClearFireCell";
    ClearFireCell *cell = [tableView dequeueReusableCellWithIdentifier:stringcell];
    //if(!cell){
        cell = [[ClearFireCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stringcell dic:self.dataDic flag:1 Arr:nil singleDic:self.singleDic];
    //}
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.delegate =self;
   
    // Configure the cell...
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

-(void)addContactViewFirefighting:(int)index{
    flag = index;
    [singlepickerview removeFromSuperview];
    singlepickerview = nil;
    NSArray *arr = [[NSArray alloc] initWithObjects:@"招标",@"正在施工",@"施工完成",nil];
    singlepickerview = [[SinglePickerView alloc] initWithTitle:CGRectMake(0, 0, 320, 260) title:nil Arr:arr delegate:self];
    [singlepickerview showInView:self.tableView.superview];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    singlepickerview = (SinglePickerView *)actionSheet;
    NSLog(@"%@",singlepickerview.selectStr);
    if(buttonIndex == 0) {
        NSLog(@"Cancel");
    }else {
        if(flag == 0){
            [self.dataDic setObject:singlepickerview.selectStr forKey:@"fireControl"];
        }else if(flag == 1){
            [self.dataDic setObject:singlepickerview.selectStr forKey:@"green"];
        }
    }
    [self.tableView reloadData];
}


@end
