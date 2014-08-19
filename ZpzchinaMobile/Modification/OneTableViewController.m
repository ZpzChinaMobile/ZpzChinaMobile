//
//  OneTableViewController.m
//  ZpzchinaMobile
//
//  Created by 孙元侃 on 14-8-14.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "OneTableViewController.h"
#import "PlanAndAuctionTableViewCell.h"
#import "CameraModel.h"
#import "GTMBase64.h"
#import "LocateView.h"
#import "MultipleChoiceViewController.h"
#import "UIViewController+MJPopupViewController.h"
#import "AddContactViewController.h"
#import "Camera.h"
#import "CameraSqlite.h"
#import "AppModel.h"
@interface OneTableViewController ()<PlanAndAuctionDelegate,MChoiceViewDelegate,AddContactViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,CameraDelegate,UIScrollViewDelegate>{
    LocateView* locateview;
    MultipleChoiceViewController* muview;
    AddContactViewController* addcontactView;
    Camera* camera;
    // BOOL _isUpdata;
}
@end

@implementation OneTableViewController
//土地规划/拍卖

//测试代码
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"%d",scrollView==self.tableView);
    NSLog(@"22");
}


//选择框
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0) {
        NSLog(@"Cancel");
    }else {
        //_isUpdata = YES;
        locateview = (LocateView *)actionSheet;
        [self.dataDic setObject:[locateview.proviceDictionary objectForKey:@"provice"] forKey:@"province"];
        [self.dataDic setObject:[locateview.proviceDictionary objectForKey:@"city"] forKey:@"city"];
        [self.dataDic setObject:[locateview.proviceDictionary objectForKey:@"county"] forKey:@"district"];
    }
    [self.tableView reloadData];
}

-(void)backMChoiceViewController{
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationSlideBottomBottom];
}

-(void)back:(NSMutableDictionary *)dic btnTag:(int)btnTag{
    [dic setValue:@"auctionUnitContacts" forKeyPath:@"category"];
    if(btnTag !=0){
        [self.contacts replaceObjectAtIndex:btnTag-1 withObject:dic];
    }else{
        [self.contacts addObject:dic];
    }
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationSlideBottomBottom];
    [self.tableView reloadData];
}

-(void)choiceData:(NSMutableArray *)arr{
    NSMutableString *string = [[NSMutableString alloc] init];
    for(int i=0;i<arr.count;i++){
        if(![[arr objectAtIndex:i] isEqualToString:@""]){
            [string appendString:[NSString stringWithFormat:@"%@,",[arr objectAtIndex:i]]];
        }
    }
    
    if(string.length !=0){
        NSString *aStr=[string substringToIndex:([string length]-1)];
        [self.dataDic setObject:aStr forKey:@"usage"];
    }else{
        [self.dataDic setObject:@"" forKey:@"usage"];
    }
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationSlideBottomTop];
    [self.tableView reloadData];
}

-(void)addContactView:(int)index{
    NSLog(@"1");
    [locateview removeFromSuperview];
    locateview = nil;
    
    if(index == 0){
        if(locateview == nil){
            locateview = [[LocateView alloc] initWithTitle:CGRectMake(0, 0, 320, 260) title:@"定位城市" delegate:self];
            locateview.tag = 0;
            [locateview showInView:self.tableView.superview];
        }
    }else if(index == 1){
        muview = [[MultipleChoiceViewController alloc] init];
        [muview.view setFrame:CGRectMake(0, 0, 262, 431)];
        muview.delegate = self;
        [self presentPopupViewController:muview animationType:MJPopupViewAnimationSlideBottomBottom];
    }else{
        if(self.contacts.count <3){
            addcontactView = [[AddContactViewController alloc] init];
            [addcontactView.view setFrame:CGRectMake(0, 0, 262, 431)];
            addcontactView.delegate = self;
            if(self.fromView == 0){
                [addcontactView setlocalProjectId:[self.dataDic objectForKey:@"id"]];
            }else{
                [addcontactView setlocalProjectId:[self.singleDic objectForKey:@"projectID"]];
            }
            [self presentPopupViewController:addcontactView animationType:MJPopupViewAnimationSlideBottomBottom];
        }else{
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"名额已经满了！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    
}

-(void)addContent:(NSString *)str index:(int)index{
    switch (index) {
        case 0:
            [self.dataDic setObject:str forKey:@"landName"];
            break;
        case 1:
            [self.dataDic setObject:str forKey:@"landAddress"];
            break;
        case 2:
            if([str isEqualToString:@""]){
                if(self.fromView == 0){
                    [self.dataDic setObject:@"0" forKey:@"area"];
                }else{
                    [self.dataDic setObject:@"" forKey:@"area"];
                }
            }else{
                [self.dataDic setObject:[NSString stringWithFormat:@"%d",[str intValue]] forKey:@"area"];
            }
            break;
        case 3:
            if([str isEqualToString:@""]){
                if(self.fromView == 0){
                    [self.dataDic setObject:@"0" forKey:@"plotRatio"];
                }else{
                    [self.dataDic setObject:@"" forKey:@"plotRatio"];
                }
            }else{
                [self.dataDic setObject:[NSString stringWithFormat:@"%d",[str intValue]] forKey:@"plotRatio"];
            }
            break;
        default:
            break;
    }
    [self.tableView reloadData];
}

-(void)updataContact:(NSMutableDictionary *)dic index:(int)index{
    addcontactView = [[AddContactViewController alloc] init];
    [addcontactView.view setFrame:CGRectMake(0, 0, 262, 431)];
    addcontactView.delegate = self;
    //[addcontactView updataContact:dic index:index];
    [addcontactView updataContact:[self.contacts objectAtIndex:index-1] index:index];
    //    if(self.fromView == 1){
    //        if(self.isRelease == 0){
    //            [addcontactView setenabled:self.contacts];
    //        }
    //    }
    [self presentPopupViewController:addcontactView animationType:MJPopupViewAnimationSlideBottomBottom];
}


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

-(instancetype)initWithSingle:(NSMutableDictionary*)singleDic dataDic:(NSMutableDictionary*)dataDic contacts:(NSMutableArray*)contacts images:(NSMutableArray*)images{
    if ([super init]) {
        self.singleDic=singleDic;
        self.dataDic=dataDic;
        self.contacts=contacts;
        self.images=images;
        NSLog(@"******%@\n************%@",dataDic,singleDic);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //    if (self.fromView==0) {
    //        AppModel* appModel=[AppModel sharedInstance];
    //       appModel.contactAry =[NSMutableArray array];
    //        [appModel.planImageArr removeAllObjects];
    //        self.contacts=appModel.contactAry;
    //    }
    
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
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        // if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        //}
        [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [cell.contentView addSubview:[self getImageViewsWithImages:[self.images copy]]];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        // Configure the cell...
        
        return cell;
    }else{
        PlanAndAuctionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlanAndAuctionTableViewCell"];
        // if (!cell) {
        
        if(self.fromView == 0){
            //AppModel* appModel=[AppModel sharedInstance];
            cell = [[PlanAndAuctionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PlanAndAuctionTableViewCell" dic:self.dataDic singleDic:nil flag:self.fromView contactArr:self.contacts] ;
        }else{
            cell=[[PlanAndAuctionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PlanAndAuctionTableViewCell" dic:self.dataDic singleDic:self.singleDic flag:1 contactArr:self.contacts];
            NSLog(@"9999999999999%@",self.contacts);
        }
        
        cell.delegate=self;
        //  }
        NSLog(@"cell被调 %d",cell.subviews.count);
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
}

-(void)beginEditWithHeight:(CGFloat)height{
    NSLog(@"beginEdit");
    CGFloat a=height+((self.images.count)/3+1)*120-self.tableView.contentOffset.y;
    if (a>=250) {
        [self.delegate upTVCSpaceWithHeight:a-250+50];
    }
}

-(void)endEdit{
    [self.delegate downTVCSpace];
}

-(UIView*)getImageViewsWithImages:(NSArray*)images{
    NSMutableArray* imageAry=[NSMutableArray array];
    for (int i=0; i<images.count; i++) {
        CameraModel* model= images[i];
        UIImage *aimage;
        if ([model.a_device isEqualToString:@"localios"]) {
            aimage=[UIImage imageWithData:[GTMBase64 decodeString:model.a_body]];
        }else{
            aimage=[UIImage imageWithData:[GTMBase64 decodeString:model.a_imgCompressionContent]];
        }
        [imageAry addObject:aimage];
    }
    [imageAry addObject:[UIImage imageNamed:@"新建项目－6_03.png"]];
    
    CGFloat cellHeight=120;
    UIView* view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, cellHeight*((imageAry.count-1)/3+1))];
    
    for (int i=0; i<imageAry.count; i++) {
        UIImageView* imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
        imageView.center=CGPointMake(320*1.0/3*(i%3+.5), cellHeight*(i/3+.5));
        imageView.image=imageAry[i];
        [view addSubview:imageView];
        
        if (i==imageAry.count-1) {
            UIButton* button=[[UIButton alloc]initWithFrame:imageView.frame];
            [button addTarget:self action:@selector(tap:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:button];
        }
    }
    return view;
}

-(void)backCamera{
    if (!self.images.count) {
        self.images=[NSMutableArray array];
    }
    
    NSLog(@"%d",self.fromView);
    if(self.fromView == 0){
        [self.images removeAllObjects];
        self.images = [CameraSqlite loadAllPlanList:[self.dataDic objectForKey:@"id"]];
    }else{
        if(self.superVC.isRelease==0){
            // if(cameraflag == 0){
            if([CameraSqlite loadPlanSingleList:[self.singleDic objectForKey:@"projectID"]].count!=0){
                [self.images insertObject:[[CameraSqlite loadAllPlanList:[self.singleDic objectForKey:@"projectID"]] objectAtIndex:0] atIndex:0];
            }
        }else{
            [self.images removeAllObjects];
            if([[self.singleDic objectForKey:@"projectID"] isEqualToString:@""]){
                self.images = [CameraSqlite loadAllPlanList:[self.singleDic objectForKey:@"id"]];
            }else{
                self.images = [CameraSqlite loadAllPlanList:[self.singleDic objectForKey:@"projectID"]];
            }
        }
        
    }
    NSLog(@"%d",self.images.count);
    [self.tableView reloadData];
}

-(void)tap:(UIButton*)button{
    camera=[[Camera alloc]init];
    camera.delegate=self;
    if(self.fromView == 1){
        if([[self.singleDic objectForKey:@"projectID"] isEqualToString:@""]){
            [camera getCameraView:self.superVC flag:6 aid:[self.singleDic objectForKey:@"id"]];
        }else{
            [camera getCameraView:self.superVC flag:6 aid:[self.singleDic objectForKey:@"projectID"]];
        }
    }else{
        [camera getCameraView:self.superVC flag:6 aid:[self.dataDic objectForKey:@"id"]];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        return (self.images.count/3+1)*120;
    }
    return 350;
}
-(void)dealloc{
    NSLog(@"oneDealloc");
}
@end
