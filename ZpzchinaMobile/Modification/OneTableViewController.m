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
#import "EGOImageView.h"
@interface OneTableViewController ()<PlanAndAuctionDelegate,MChoiceViewDelegate,AddContactViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,CameraDelegate,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>{
    LocateView* locateview;
    MultipleChoiceViewController* muview;
    AddContactViewController* addcontactView;
    Camera* camera;
    NSInteger newImageCount;
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
    [dic setValue:@"auctionUnitContacts" forKey:@"category"];
    if(btnTag !=0){
        [self.contacts replaceObjectAtIndex:btnTag-1 withObject:dic];
    }else{
        [self.contacts addObject:dic];
    }
    [self.view.window.rootViewController dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    [self.tableView reloadData];
    addcontactView = nil;
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
            [[self.superVC.tvcArray[1] tableView]reloadData];
            break;
        case 2:
//            if([str isEqualToString:@""]){
//                if(self.fromView == 0){
//                    [self.dataDic setObject:@"0" forKey:@"area"];
//                }else{
//                    [self.dataDic setObject:@"0" forKey:@"area"];
//                }
//            }else{
//                if([str floatValue]<=999999999){
//                    [self.dataDic setObject:[NSString stringWithFormat:@"%.0f",[str floatValue]] forKey:@"area"];
//                }else{
//                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"数字过大" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//                    [alertView show];
//                    [self.dataDic setObject:@"0" forKey:@"area"];
//                }
//            }
            if(![str isEqualToString:@""]){
                if([str floatValue]<=999999999){
                    [self.dataDic setObject:[NSString stringWithFormat:@"%.0f",[str floatValue]] forKey:@"area"];
                }else{
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"数字过大" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alertView show];
                    [self.dataDic setObject:@"0" forKey:@"area"];
                }
            }
            break;
        case 3:
//            if([str isEqualToString:@""]){
//                if(self.fromView == 0){
//                    [self.dataDic setObject:@"0" forKey:@"plotRatio"];
//                }else{
//                    [self.dataDic setObject:@"0" forKey:@"plotRatio"];
//                }
//            }else{
//                if([str floatValue]<=999999999){
//                    [self.dataDic setObject:[NSString stringWithFormat:@"%.2f",[str floatValue]] forKey:@"plotRatio"];
//                }else{
//                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"数字过大" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//                    [alertView show];
//                    [self.dataDic setObject:@"0" forKey:@"plotRatio"];
//                }
//            }
            if(![str isEqualToString:@""]){
                if([str floatValue]<=999999999){
                    [self.dataDic setObject:[NSString stringWithFormat:@"%.2f",[str floatValue]] forKey:@"plotRatio"];
                }else{
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"数字过大" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alertView show];
                    [self.dataDic setObject:@"0" forKey:@"plotRatio"];
                }
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
    NSLog(@"======%@,%d",[self.contacts objectAtIndex:index-1],index);
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
        newImageCount=0;
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
        if (!cell) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        }
        [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [cell.contentView addSubview:[self getImageViewsWithImages:[self.images copy]]];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        return cell;
    }else{
        PlanAndAuctionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlanAndAuctionTableViewCell"];
        [cell removeFromSuperview];
        cell = nil;
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
    CGFloat a=height+((self.images.count)/3+1)*120-self.tableView.contentOffset.y+45;//+45是因为需求改动后加入的左右阶段提示栏的高度
    if (a>=210) {
        [self.delegate upTVCSpaceWithHeight:a-210];
    }
}

-(void)endEdit{
    [self.delegate downTVCSpace];
}

-(UIImage*)saveImage:(UIView*)view{
    UIGraphicsBeginImageContext(CGSizeMake(view.bounds.size.width, view.bounds.size.height));
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return viewImage;
}

-(UIView*)getImageViewsWithImages:(NSArray*)images{
    CGFloat cellHeight=120;
    UIView* view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, cellHeight*(images.count/3+1))];
    view.backgroundColor=RGBCOLOR(229, 229, 229);
    
    for (int i=0; i<images.count+1; i++) {
        EGOImageView* imageView=[[EGOImageView alloc]initWithPlaceholderImage:[GetImagePath getImagePath:i==images.count?@"018":@"imgDefault"]];
        imageView.frame=CGRectMake(0, 0, 80, 80);
        imageView.center=CGPointMake(320*1.0/3*(i%3+.5), cellHeight*(i/3+.5));
        [view addSubview:imageView];
        
        if (i==images.count) {
            UIButton* button=[[UIButton alloc]initWithFrame:imageView.frame];
            [button addTarget:self action:@selector(tap:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:button];
        }else{
            if ([images[i] isKindOfClass:[CameraModel class]]) {
                CameraModel* model= images[i];
                if (model.isNewImage) {
                    imageView.image=[UIImage imageWithData:[GTMBase64 decodeString:model.a_body]];
                }else{
                    imageView.imageURL=[NSURL URLWithString:[NSString stringWithFormat:@"%s%@",imageAddress,model.a_body]];
                }
            }else{
                imageView.imageURL=[NSURL URLWithString:[NSString stringWithFormat:@"%s%@",imageAddress,images[i]]];
            }
        }
    }
    return view;
}

-(void)backCamera:(CameraModel *)cameraModel{
    if (!self.images) {
        self.images=[NSMutableArray array];
    }
    if (!cameraModel) return;
    newImageCount++;
    [self.images addObject:cameraModel];
    [self.tableView reloadData];

    return;
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

-(void)cellTextFieldResignFirstResponder{
    PlanAndAuctionTableViewCell* cell=(PlanAndAuctionTableViewCell*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    [cell closeKeyBoard];
}

-(void)dealloc{
    locateview=nil;
    muview=nil;
    addcontactView=nil;
    camera=nil;
    for (int i=0; i<newImageCount; i++) {
        [self.images removeLastObject];
    }
    NSLog(@"oneDealloc");
}

@end
