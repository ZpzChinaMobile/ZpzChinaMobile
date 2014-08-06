//
//  LocationViewController.m
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-30.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "LocationViewController.h"

@interface LocationViewController ()

@end

@implementation LocationViewController
@synthesize delegate;
@synthesize baseAddress,baseCity;
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
    //适配ios7
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
        //        self.edgesForExtendedLayout=UIRectEdgeNone;
        self.navigationController.navigationBar.translucent = NO;
    }
    [self addBackButton];
    [self addtittle:@"地图搜索"];
    [self addRightButton:CGRectMake(280, 20, 29, 28.5) title:nil iamge:[UIImage imageNamed:@"icon__09.png"]];
    _mapView = [[BMKMapView alloc] initWithFrame:self.view.frame];
    //[_mapView setShowsUserLocation:YES];//显示定位的蓝点儿
    //_mapView.showsUserLocation = YES;//可以显示用户当前位置
    _mapView.zoomEnabled = YES;//允许Zoom
    _mapView.scrollEnabled = YES;//允许Scroll
    _mapView.mapType = BMKMapTypeStandard;//地图类型为标准，可以为卫星，可以开启或关闭交通
    [_mapView setZoomLevel:15];
    [self.contentView addSubview:_mapView];
    _locService = [[BMKLocationService alloc]init];
    
    _geocodesearch = [[BMKGeocodeSearch alloc]init];
    
    CLLocationCoordinate2D coor;
    BMKCoordinateRegion viewRegion = BMKCoordinateRegionMake(coor, BMKCoordinateSpanMake(0.02f, 0));
    //调整后适合当前地图窗口显示的经纬度范围
    BMKCoordinateRegion adjusteRegion = [_mapView regionThatFits:viewRegion];
    // *设定当前地图的显示范围
    [_mapView setRegion:adjusteRegion animated:YES];
    annotationPoint = [[BMKPointAnnotation alloc]init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    NSLog(@"===>%@",baseAddress);
    NSLog(@"===>%@",baseCity);
    if([[NSString stringWithFormat:@"%@",baseAddress] isEqualToString:@"(null)"]||[[NSString stringWithFormat:@"%@",baseAddress] isEqualToString:@"<null>"]||[[NSString stringWithFormat:@"%@",baseAddress] isEqualToString:@""]){
        [_locService startUserLocationService];
    }else{
        isGeoSearch = true;
        BMKGeocodeSearchOption *geocodeSearchOption = [[BMKGeocodeSearchOption alloc]init];
        geocodeSearchOption.city= baseCity;
        geocodeSearchOption.address = baseAddress;
        BOOL flag = [_geocodesearch geocode:geocodeSearchOption];
        if(flag)
        {
            NSLog(@"geo检索发送成功");
        }
        else
        {
            NSLog(@"geo检索发送失败");
        }
    }
}

-(void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _locService.delegate = self;
    _geocodesearch.delegate = self;
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    [self.mm_drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeNone];
}

-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _locService.delegate = nil;
    _geocodesearch.delegate = nil;
    if (_mapView) {
        [_mapView removeFromSuperview];
        _mapView = nil;
    }
    _locService = nil;
    _geocodesearch = nil;
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [self.mm_drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
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

- (void)didUpdateUserLocation:(BMKUserLocation *)userLocation{
    NSLog(@"定位跟新");
    BMKCoordinateRegion region;
    region.center.latitude = userLocation.location.coordinate.latitude;
    region.center.longitude = userLocation.location.coordinate.longitude;
    region.span.latitudeDelta = 0.2;
    region.span.longitudeDelta = 0.2;
    if (_mapView) {
        _mapView.region = region;
        NSLog(@"当前的坐标  维度:%f,经度:%f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
        _mapView.showsUserLocation = YES;//显示定位图层
        
        isGeoSearch = false;
        CLLocationCoordinate2D pt = (CLLocationCoordinate2D){userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude};
        BMKReverseGeocodeOption *reverseGeocodeSearchOption = [[BMKReverseGeocodeOption alloc]init];
        reverseGeocodeSearchOption.reverseGeoPoint = pt;
        BOOL flag = [_geocodesearch reverseGeocode:reverseGeocodeSearchOption];
        if(flag)
        {
            NSLog(@"反geo检索发送成功");
        }
        else
        {
            NSLog(@"反geo检索发送失败");
        }
        
    }
    //_mapView.showsUserLocation = NO;
    [_locService stopUserLocationService];
}


- (void) didStopLocatingUser{
    NSLog(@"didStopLocatingUser");
}

-(void) onGetReverseGeocodeResult:(BMKGeocodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    NSLog(@"%@",result.address);
    CLLocationCoordinate2D coor;
    coor.latitude = result.location.latitude;
    coor.longitude = result.location.longitude;
    annotationPoint.coordinate = coor;
    annotationPoint.title = result.address;
    [_mapView addAnnotation:annotationPoint];
    [_mapView setZoomLevel:14];
    [_mapView selectAnnotation:annotationPoint animated:NO];
    testLocation.latitude=result.location.latitude;//设定测试点的坐标是当前位置
    testLocation.longitude=result.location.longitude;
    address = result.address;
}

- (void)onGetGeocodeResult:(BMKGeocodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    NSLog(@"%@",result.address);
    BMKCoordinateRegion region;
    region.center.latitude = result.location.latitude;
    region.center.longitude = result.location.longitude;
    region.span.latitudeDelta = 0.2;
    region.span.longitudeDelta = 0.2;
    _mapView.region = region;
    _mapView.showsUserLocation = YES;//显示定位图层
    CLLocationCoordinate2D coor;
    coor.latitude = result.location.latitude;
    coor.longitude = result.location.longitude;
    annotationPoint.coordinate = coor;
    annotationPoint.title = result.address;
    [_mapView addAnnotation:annotationPoint];
    [_mapView setZoomLevel:14];
    [_mapView selectAnnotation:annotationPoint animated:NO];
    testLocation.latitude=result.location.latitude;//设定测试点的坐标是当前位置
    testLocation.longitude=result.location.longitude;
    address = result.address;
}

/**
 *在地图View停止定位后，会调用此函数
 *@param mapView 地图View
 */
- (void)mapViewDidStopLocatingUser:(BMKMapView *)mapView
{
    NSLog(@"stop locate");
}

/**
 *定位失败后，会调用此函数
 *@param mapView 地图View
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)mapView:(BMKMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"location error");
}

// 根据anntation生成对应的View
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    NSString *AnnotationViewID = @"renameMark";
    if (newAnnotation == nil) {
        newAnnotation = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
        [newAnnotation setImage:[UIImage imageNamed:@"地图搜索1_09.png"]];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, -10, 50, 50)];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont fontWithName:nil size:14];
        label.text = @"A";
        [newAnnotation addSubview:label];
        // 设置颜色
		//((BMKPinAnnotationView*)newAnnotation).pinColor = BMKPinAnnotationColorPurple;
        // 从天上掉下效果
		((BMKPinAnnotationView*)newAnnotation).animatesDrop = NO;
        // 设置可拖拽
		((BMKPinAnnotationView*)newAnnotation).draggable = NO;
        //newAnnotation.image=[UIImage imageNamed:@"新建项目5_06.png"];
    }
    return newAnnotation;
    
}

/**
 *点中底图标注后会回调此接口
 *@param mapview 地图View
 *@param mapPoi 标注点信息
 */
- (void)mapView:(BMKMapView *)mapView onClickedMapPoi:(BMKMapPoi*)mapPoi
{
    NSLog(@"onClickedMapPoi-%f, %f",mapPoi.pt.latitude,mapPoi.pt.longitude);
    //[self removeAnnotationsOnTheMap];
    isGeoSearch = false;
    CLLocationCoordinate2D pt = (CLLocationCoordinate2D){mapPoi.pt.latitude,mapPoi.pt.longitude};
    /*if (_coordinateXText.text != nil && _coordinateYText.text != nil) {
     pt = (CLLocationCoordinate2D){[_coordinateYText.text floatValue], [_coordinateXText.text floatValue]};
     }*/
    BMKReverseGeocodeOption *reverseGeocodeSearchOption = [[BMKReverseGeocodeOption alloc]init];
    reverseGeocodeSearchOption.reverseGeoPoint = pt;
    BOOL flag = [_geocodesearch reverseGeocode:reverseGeocodeSearchOption];
    if(flag)
    {
        NSLog(@"反geo检索发送成功");
    }
    else
    {
        NSLog(@"反geo检索发送失败");
    }
    
}
/**
 *点中底图空白处会回调此接口
 *@param mapview 地图View
 *@param coordinate 空白处坐标点的经纬度
 */
- (void)mapView:(BMKMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate
{
    NSLog(@"onClickedMapBlank-latitude==%f,longitude==%f",coordinate.latitude,coordinate.longitude);
    //[self removeAnnotationsOnTheMap];
    isGeoSearch = false;
    CLLocationCoordinate2D pt = (CLLocationCoordinate2D){coordinate.latitude, coordinate.longitude};
    /*if (_coordinateXText.text != nil && _coordinateYText.text != nil) {
     pt = (CLLocationCoordinate2D){[_coordinateYText.text floatValue], [_coordinateXText.text floatValue]};
     }*/
    BMKReverseGeocodeOption *reverseGeocodeSearchOption = [[BMKReverseGeocodeOption alloc]init];
    reverseGeocodeSearchOption.reverseGeoPoint = pt;
    BOOL flag = [_geocodesearch reverseGeocode:reverseGeocodeSearchOption];
    if(flag)
    {
        NSLog(@"反geo检索发送成功");
    }
    else
    {
        NSLog(@"反geo检索发送失败");
    }
}

-(void)removeAnnotationsOnTheMap
{
    [_mapView removeAnnotation:annotationPoint];
}

-(void)rightAction{
    NSLog(@"%@,%f,%f",address,testLocation.latitude,testLocation.longitude);
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"是否保存地址？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if ([delegate respondsToSelector:@selector(locationBack:testLocation:)]){
        [delegate locationBack:address testLocation:testLocation];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
@end
