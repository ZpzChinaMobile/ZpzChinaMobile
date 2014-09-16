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
@interface OneTableViewController ()<PlanAndAuctionDelegate,MChoiceViewDelegate,AddContactViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,CameraDelegate,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>{
    LocateView* locateview;
    MultipleChoiceViewController* muview;
    AddContactViewController* addcontactView;
    Camera* camera;
    // BOOL _isUpdata;
}
@end

@implementation OneTableViewController
//土地规划/拍卖


//选择框
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0) {
        NSLog(@"Cancel");
    }else {
        locateview = (LocateView *)actionSheet;
        [self.dataDic setObject:[locateview.proviceDictionary objectForKey:@"provice"] forKey:@"province"];
        [self.dataDic setObject:[locateview.proviceDictionary objectForKey:@"city"] forKey:@"city"];
        [self.dataDic setObject:[locateview.proviceDictionary objectForKey:@"county"] forKey:@"district"];
    }
    [self.tableView reloadData];
}

-(void)backMChoiceViewController{
    [self.view.window.rootViewController dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
}

-(void)back:(NSMutableDictionary *)dic btnTag:(int)btnTag{
    [dic setValue:@"auctionUnitContacts" forKeyPath:@"category"];
    if(btnTag !=0){
        [self.contacts replaceObjectAtIndex:btnTag-1 withObject:dic];
    }else{
        [self.contacts addObject:dic];
    }
    [self.view.window.rootViewController dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    [self.tableView reloadData];
}

-(void)choiceData:(NSMutableArray *)arr index:(int)index{
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
    [self.view.window.rootViewController dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    [self.tableView reloadData];
}

-(void)addContactView:(int)index{
    //NSLog(@"1");
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
        muview.arr = [[NSMutableArray alloc] initWithObjects:@"工业",@"酒店及餐饮",@"商务办公",@"住宅/经济适用房",@"公用事业设施（教育、医疗、科研、基础建设等）",@"其他", nil];
        muview.flag = 0;
        muview.delegate = self;
        [muview.view setFrame:CGRectMake(0, 0, 272, 350)];
        [self.view.window.rootViewController presentPopupViewController:muview animationType:MJPopupViewAnimationFade];
    }else{
        if(self.contacts.count <3){
            addcontactView = [[AddContactViewController alloc] init];
            addcontactView.delegate = self;
            addcontactView.contactType = @"auctionUnitContacts";
            [addcontactView.view setFrame:CGRectMake(0, 0, 262, 431)];
            if(self.fromView == 0){
                [addcontactView setlocalProjectId:[self.dataDic objectForKey:@"id"]];
            }else{
                if(self.superVC.isRelease == 0){
                    [addcontactView setlocalProjectId:[self.singleDic objectForKey:@"projectID"]];
                }else{
                    [addcontactView setlocalProjectId:[self.singleDic objectForKey:@"id"]];
                }
            }
            [self.view.window.rootViewController presentPopupViewController:addcontactView animationType:MJPopupViewAnimationFade];
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
    addcontactView.delegate = self;
    addcontactView.contactType = @"auctionUnitContacts";
    [addcontactView.view setFrame:CGRectMake(0, 0, 262, 431)];
    //[addcontactView updataContact:dic index:index];
    [addcontactView updataContact:[self.contacts objectAtIndex:index-1] index:index];
    [self.view.window.rootViewController presentPopupViewController:addcontactView animationType:MJPopupViewAnimationFade];
}

-(instancetype)initWithSingle:(NSMutableDictionary*)singleDic dataDic:(NSMutableDictionary*)dataDic contacts:(NSMutableArray*)contacts images:(NSMutableArray*)images{
    if ([super init]) {
        self.singleDic=singleDic;
        self.dataDic=dataDic;
        self.contacts=contacts;
        self.images=images;
        
        self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 568-64.5-50) style:UITableViewStylePlain];
        self.tableView.delegate=self;
        self.tableView.dataSource=self;
        self.tableView.separatorStyle=NO;
        
        [self.view addSubview:self.tableView];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];//即使没有显示在window上，也不会自动的将self.view释放。
    // Add code to clean up any of your own resources that are no longer necessary.
    
    // 此处做兼容处理需要加上ios6.0的宏开关，保证是在6.0下使用的,6.0以前屏蔽以下代码，否则会在下面使用self.view时自动加载viewDidUnLoad
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0) {
        //需要注意的是self.isViewLoaded是必不可少的，其他方式访问视图会导致它加载 ，在WWDC视频也忽视这一点。
        if (self.isViewLoaded && !self.view.window)// 是否是正在使用的视图
        {
            // Add code to preserve data stored in the views that might be
            // needed later.
            
            // Add code to clean up other strong references to the view in
            // the view hierarchy.
            self.view = nil;// 目的是再次进入时能够重新加载调用viewDidLoad函数。
        }
    }
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
         //if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        //}
        [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [cell.contentView addSubview:[self getImageViewsWithImages:[self.images copy]]];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        return cell;
    }else{
        PlanAndAuctionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlanAndAuctionTableViewCell"];
        if(self.fromView == 0){
            cell = [[PlanAndAuctionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PlanAndAuctionTableViewCell" dic:self.dataDic singleDic:nil flag:self.fromView contactArr:self.contacts] ;
        }else{
            cell=[[PlanAndAuctionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PlanAndAuctionTableViewCell" dic:self.dataDic singleDic:self.singleDic flag:1 contactArr:self.contacts];
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
    view.backgroundColor=RGBCOLOR(229, 229, 229);
    
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
    /**
     if(self.fromView == 0){
     [addcontactView setlocalProjectId:[self.dataDic objectForKey:@"id"]];
     }else{
     if(self.superVC.isRelease == 0){
     [addcontactView setlocalProjectId:[self.singleDic objectForKey:@"projectID"]];
     }else{
     [addcontactView setlocalProjectId:[self.singleDic objectForKey:@"id"]];
     }
     }
     */
    if(self.fromView == 0){
        [self.images removeAllObjects];
        self.images = [CameraSqlite loadAllPlanList:[self.dataDic objectForKey:@"id"]];
    }else{
        if(self.superVC.isRelease==0){
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

-(void)viewDidDisappear:(BOOL)animated{
    AppModel* model=[AppModel sharedInstance];
    if (self.images.count) {
        model.planImageArr=self.images;
    }
}

-(void)dealloc{
    locateview=nil;
    muview=nil;
    addcontactView=nil;
    camera=nil;

    NSLog(@"oneDealloc");
}

@end
