//
//  CollectionViewController.m
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-7-8.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "CollectionViewController.h"
#import "CameraModel.h"
#import "CameraSqlite.h"
#import "GTMBase64.h"
NSString *const MJCollectionViewCellIdentifier = @"Cell";
@interface CollectionViewController ()

@end

@implementation CollectionViewController
@synthesize showArr;
@synthesize flag;
@synthesize title;
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
    [self addBackButton];
    [self addtittle:title];
    //初始化
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(80, 80);
    layout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
    layout.minimumInteritemSpacing = 20;
    layout.minimumLineSpacing = 20;
    _collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 320, self.contentView.frame.size.height) collectionViewLayout:layout];
    //注册
    _collectionview.alwaysBounceVertical = YES;
    [_collectionview registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:MJCollectionViewCellIdentifier];
    //设置代理
    _collectionview.delegate = self;
    _collectionview.dataSource = self;
    [self.contentView addSubview:_collectionview];
    
    NSLog(@"showarr====> %@",self.showArr);
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
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSLog(@"%d",self.showArr.count);
    return self.showArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MJCollectionViewCellIdentifier forIndexPath:indexPath];
    CameraModel *model = [self.showArr objectAtIndex:indexPath.row];
    UIImage *aimage = nil;
    if(self.flag == 0){
        aimage = [UIImage imageWithData:[GTMBase64 decodeString:model.a_body]];
    }else{
        if([model.a_device isEqualToString:@"localios"]){
            aimage = [UIImage imageWithData:[GTMBase64 decodeString:model.a_body]];
        }else{
            aimage = [UIImage imageWithData:[GTMBase64 decodeString:model.a_imgCompressionContent]];
        }
    }
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    imageView.image = aimage;
    imageView.tag = indexPath.row +100;
    [cell addSubview:imageView];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [imageview removeFromSuperview];
    imageview = nil;
    CameraModel *model = [self.showArr objectAtIndex:indexPath.row];
    NSLog(@"%d",self.flag);
    if(self.flag == 0){
        UIImage *aimage = nil;
        aimage = [UIImage imageWithData:[GTMBase64 decodeString:model.a_body]];
        UIButton *secondTap = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        secondTap.frame = CGRectMake(0, 80, 320, 320);
        [secondTap setBackgroundImage:aimage forState:UIControlStateNormal];
        [secondTap addTarget:self action:@selector(scaleToFormer:) forControlEvents:UIControlEventTouchUpInside];
        UIView *panView = [[UIView alloc] initWithFrame:CGRectMake(0, 64.5, 320, 503.5)];
        panView.backgroundColor = [UIColor blackColor];
        panView.tag =110120;
        [panView addSubview:secondTap];
        [self.view addSubview:panView];
    }else{
       if([model.a_device isEqualToString:@"localios"]){
           UIImage *aimage = nil;
            aimage = [UIImage imageWithData:[GTMBase64 decodeString:model.a_body]];
           UIButton *secondTap = [UIButton buttonWithType:UIButtonTypeRoundedRect];
           secondTap.frame = CGRectMake(0, 80, 320, 320);
           [secondTap setBackgroundImage:aimage forState:UIControlStateNormal];
           [secondTap addTarget:self action:@selector(scaleToFormer:) forControlEvents:UIControlEventTouchUpInside];
           UIView *panView = [[UIView alloc] initWithFrame:CGRectMake(0, 64.5, 320, 503.5)];
           panView.backgroundColor = [UIColor blackColor];
           panView.tag =110120;
           [panView addSubview:secondTap];
           [self.view addSubview:panView];
        }else{
            [self loadImage:model.a_url];
        }
    }
}

- (void)scaleToFormer:(UIButton *)button
{
    UIView *view = [self.view viewWithTag:110120];
    [view removeFromSuperview];
}

//获取图片
-(void)loadImage:(NSString *)url{
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"GET" URLString:[NSString stringWithFormat:@"%s/%@",serverAddress,url] parameters:nil error:nil];
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSLog(@"JSON: %@", responseObject);
        NSArray *a = [[responseObject objectForKey:@"d"] objectForKey:@"data"];
        for (NSMutableDictionary *item in a) {
            CameraModel *model = [[CameraModel alloc] init];
            [model loadWithDictionary:item];
            UIImage *aimage = [UIImage imageWithData:[GTMBase64 decodeString:model.a_body]];
            UIButton *secondTap = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            secondTap.frame = CGRectMake(0, 80, 320, 320);
            [secondTap setBackgroundImage:aimage forState:UIControlStateNormal];
            [secondTap addTarget:self action:@selector(scaleToFormer:) forControlEvents:UIControlEventTouchUpInside];
            UIView *panView = [[UIView alloc] initWithFrame:CGRectMake(0, 55, 320, 480)];
            panView.backgroundColor = [UIColor blackColor];
            panView.tag =110120;
            [panView addSubview:secondTap];
            [self.view addSubview:panView];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    [[NSOperationQueue mainQueue] addOperation:op];
}
@end
