//
//  BaiDuMapViewController.m
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-23.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "BaiDuMapViewController.h"
#import "LoginSqlite.h"
#import "ProjectSqlite.h"
#import "ProjectModel.h"
#import "ProjectStage.h"
#import "AppDelegate.h"
#import <MapKit/MapKit.h>

@interface BaiDuMapViewController ()

@end

@implementation BaiDuMapViewController
int j;
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
    j=0;
    numberArr = [[NSArray alloc] initWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z", nil];
    showArr = [[NSMutableArray alloc] init];
    logArr = [[NSMutableArray alloc] init];
    latArr = [[NSMutableArray alloc] init];
    pointArr = [[NSMutableArray alloc] init];
    coordinates = [[NSMutableArray alloc] init];
    [self loadServer];
    [self addBackButton];
    [self addtittle:@"地图搜索"];
    _mapView = [[BMKMapView alloc] initWithFrame:self.view.frame];
    _mapView.zoomEnabled = YES;//允许Zoom
    _mapView.scrollEnabled = YES;//允许Scroll
    _mapView.mapType = BMKMapTypeStandard;//地图类型为标准，可以为卫星，可以开启或关闭交通
    [_mapView setZoomLevel:15];
    [self.contentView addSubview:_mapView];
    
    _locService = [[BMKLocationService alloc]init];
    [_locService startUserLocationService];
    
    _geocodesearch = [[BMKGeoCodeSearch alloc]init];
    _geocodesearch.delegate = self;
    
    CLLocationCoordinate2D coor;
    BMKCoordinateRegion viewRegion = BMKCoordinateRegionMake(coor, BMKCoordinateSpanMake(0.02f, 0));
    //调整后适合当前地图窗口显示的经纬度范围
    BMKCoordinateRegion adjusteRegion = [_mapView regionThatFits:viewRegion];
    // *设定当前地图的显示范围
    [_mapView setRegion:adjusteRegion animated:YES];
    
    btnView = [[UIView alloc] initWithFrame:CGRectMake(0, 84, 66, 220)];
    drawBtn =  [UIButton buttonWithType:UIButtonTypeCustom];
    drawBtn.frame = CGRectMake(10,20, 40, 40);
    [drawBtn setBackgroundImage:[UIImage imageNamed:@"mapsearch-1.png"] forState:UIControlStateNormal];
    [drawBtn addTarget:self action:@selector(drawFunction) forControlEvents:UIControlEventTouchUpInside];
    [btnView addSubview:drawBtn];
    
    [self.contentView addSubview:btnView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    //[_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _locService.delegate = self;
    _geocodesearch.delegate = self;
    
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    [self.mm_drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeNone];
}

-(void)viewWillDisappear:(BOOL)animated {
    //[_mapView viewWillDisappear];
    NSLog(@"baidumapDis");
    _mapView.delegate = nil; // 不用时，置nil
    _locService.delegate = nil;
    _geocodesearch.delegate = nil;
    _mapView = nil;
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

/**
 *在地图View将要启动定位时，会调用此函数
 *@param mapView 地图View
 */
- (void)mapViewWillStartLocatingUser:(BMKMapView *)mapView
{
	NSLog(@"start locate");
}

/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    [_mapView updateLocationData:userLocation];
    //NSLog(@"heading is %@",userLocation.heading);
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
//6跟新用户当前位置的代理方法  (地图用的时内部子程序时定位的)
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
        //_mapView.showsUserLocation = YES;//显示定位图层
        [_mapView updateLocationData:userLocation];
        isGeoSearch = false;
        CLLocationCoordinate2D pt = (CLLocationCoordinate2D){userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude};
        /*if (_coordinateXText.text != nil && _coordinateYText.text != nil) {
            pt = (CLLocationCoordinate2D){[_coordinateYText.text floatValue], [_coordinateXText.text floatValue]};
        }*/
        BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
        reverseGeocodeSearchOption.reverseGeoPoint = pt;
        BOOL flag = [_geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
        if(flag)
        {
            NSLog(@"反geo检索发送成功");
        }
        else
        {
            NSLog(@"反geo检索发送失败");
        }
        [_locService stopUserLocationService];
    }
}

-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    annotationPoint = [[BMKPointAnnotation alloc]init];
     CLLocationCoordinate2D coor;
     coor.latitude = result.location.latitude;
     coor.longitude = result.location.longitude;
     testLocation.latitude=result.location.latitude;//设定测试点的坐标是当前位置
     testLocation.longitude=result.location.longitude;
     annotationPoint.coordinate = coor;
     annotationPoint.title = result.address;
     [_mapView addAnnotation:annotationPoint];
     [_mapView setZoomLevel:14];
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

/**
 *根据anntation生成对应的View
 *@param mapView 地图View
 *@param annotation 指定的标注
 *@return 生成的标注View
 */
- (BMKAnnotationView *)mapView:(BMKMapView *)view viewForAnnotation:(id <BMKAnnotation>)annotation
{
    // 生成重用标示identifier
    NSString *AnnotationViewID = @"xidanMark";
	
    // 检查是否有重用的缓存
    BMKAnnotationView* annotationView = [view dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    
    // 缓存没有命中，自己构造一个，一般首次添加annotation代码会运行到此处
    if (annotationView == nil) {
        annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
		[annotationView setImage:[UIImage imageNamed:@"地图搜索1_09.png"]];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 28.5, 30)];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont fontWithName:nil size:14];
        label.text = [numberArr objectAtIndex:j];
        label.textAlignment = NSTextAlignmentCenter;
        [annotationView addSubview:label];
		// 设置重天上掉下的效果(annotation)
        ((BMKPinAnnotationView*)annotationView).animatesDrop = YES;
        annotationView.tag = j;
    }
	
    // 设置位置
	annotationView.centerOffset = CGPointMake(0, -(annotationView.frame.size.height * 0.5));
    annotationView.annotation = annotation;
    // 单击弹出泡泡，弹出泡泡前提annotation必须实现title属性
	annotationView.canShowCallout = NO;
    // 设置是否可以拖拽
    annotationView.draggable = NO;
    j++;
    return annotationView;
}

-(void)drawFunction{
    j=0;
    if(imageView == nil){
        topCount = 0;
        [topBgView removeFromSuperview];
        topBgView = nil;
        [countLabel removeFromSuperview];
        countLabel = nil;
        imageView=[[UIImageView alloc] initWithFrame:_mapView.frame];
        [imageView setImage:[UIImage imageNamed:@"地图搜索_02.png"]];
        imageView.userInteractionEnabled=YES;
        [self.contentView insertSubview:imageView atIndex:1];
        UIGraphicsBeginImageContext(imageView.frame.size);
        
        [imageView.image drawInRect:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
        
        CGContextSetRGBFillColor(UIGraphicsGetCurrentContext(), 50, 79, 133, 1.0);
        
        CGContextSetFillColorWithColor(UIGraphicsGetCurrentContext(), [UIColor redColor].CGColor);
        
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 4);
        
        [coordinates removeAllObjects];
        [self removeAnnotationsOnTheMap];
    }else{
        [imageView removeFromSuperview];
        imageView = nil;
        if(topBgView == nil){
            topBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 64.5, 320,40)];
            [topBgView setBackgroundColor:[UIColor grayColor]];
            [self.view addSubview:topBgView];
            topBgView.alpha = 0.5;
            countLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 69.5, 160, 30)];
            countLabel.text = [NSString stringWithFormat:@"%d条结果",topCount];
            countLabel.textColor = [UIColor blackColor];
            countLabel.textAlignment = NSTextAlignmentCenter;
            [self.view addSubview:countLabel];
        }
    }
}


-(void)refresFunction{
    
}

-(void)resetFunction{
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    
    CGPoint location = [touch locationInView:imageView];
    
    //创建path
    
    pathRef=CGPathCreateMutable();
    
    CGPathMoveToPoint(pathRef, NULL, location.x, location.y);
    
    CLLocationCoordinate2D coordinate = [_mapView convertPoint:location toCoordinateFromView:_mapView];
    [coordinates addObject:[NSValue valueWithMKCoordinate:coordinate]];
    
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    
    CGPoint location = [touch locationInView:imageView];
    
    CGPoint pastLocation = [touch previousLocationInView:imageView];
    
    //画线
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), pastLocation.x, pastLocation.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), location.x, location.y);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 1.0, 0.0, 0.0, 1.0);  //颜色
    CGContextDrawPath(UIGraphicsGetCurrentContext(), kCGPathFillStroke);
    imageView.image=UIGraphicsGetImageFromCurrentImageContext();
    
    //更新Path
    
    CGPathAddLineToPoint(pathRef, NULL, location.x, location.y);
    
    CLLocationCoordinate2D coordinate = [_mapView convertPoint:location toCoordinateFromView:_mapView];
    [coordinates addObject:[NSValue valueWithMKCoordinate:coordinate]];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:imageView];
    CLLocationCoordinate2D coordinate = [_mapView convertPoint:location toCoordinateFromView:_mapView];
    [coordinates addObject:[NSValue valueWithMKCoordinate:coordinate]];
    CGPathCloseSubpath(pathRef);
    //NSLog(@"==>%@",pathRef);
    int count = 0;
    if(logArr.count>26){
        count = 26;
    }else{
        count = logArr.count;
    }
    //地理坐标转换成点
    for(int i=0;i<count;i++){
        testLocation.latitude = [[latArr objectAtIndex:i] floatValue];
        testLocation.longitude = [[logArr objectAtIndex:i] floatValue];
        locationConverToImage=[_mapView convertCoordinate:testLocation toPointToView:imageView];
        //NSLog(@"%f====%f",locationConverToImage.x,locationConverToImage.y);
        if (CGPathContainsPoint(pathRef, NULL, locationConverToImage, NO)) {
            
            NSLog(@"point in path!");
            ProjectModel *model = [showArr objectAtIndex:i];
            annotationPoint = [[BMKPointAnnotation alloc]init];
            CLLocationCoordinate2D coor;
            coor.latitude = testLocation.latitude;
            coor.longitude = testLocation.longitude;
            annotationPoint.coordinate = coor;
            annotationPoint.title = model.a_landName;
            annotationPoint.subtitle = model.a_landAddress;
            [_mapView addAnnotation:annotationPoint];
            topCount++;
        }
    }
    
    NSInteger numberOfPoints = [coordinates count];
    
    if (numberOfPoints > 2)
    {
        CLLocationCoordinate2D points[numberOfPoints];
        for (NSInteger i = 0; i < numberOfPoints; i++) {
            points[i] = [coordinates[i] MKCoordinateValue];
        }
        polygon = [BMKPolygon polygonWithCoordinates:points count:numberOfPoints];
        [_mapView addOverlay:polygon];
    }
}

//根据overlay生成对应的View
- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id <BMKOverlay>)overlay
{
	if ([overlay isKindOfClass:[BMKCircle class]])
    {
        BMKCircleView* circleView = [[BMKCircleView alloc] initWithOverlay:overlay];
        circleView.fillColor = [[UIColor redColor] colorWithAlphaComponent:0.5];
        circleView.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:0.5];
        circleView.lineWidth = 5.0;
		return circleView;
    }
    
    if ([overlay isKindOfClass:[BMKPolyline class]])
    {
        BMKPolylineView* polylineView = [[BMKPolylineView alloc] initWithOverlay:overlay];
        polylineView.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:1];
        polylineView.lineWidth = 3.0;
		return polylineView;
    }
	
	if ([overlay isKindOfClass:[BMKPolygon class]])
    {
        BMKPolygonView* polygonView = [[BMKPolygonView alloc] initWithOverlay:overlay];
        polygonView.strokeColor = [[UIColor redColor] colorWithAlphaComponent:1];
        polygonView.fillColor = [[UIColor cyanColor] colorWithAlphaComponent:0.2];
        polygonView.lineWidth =3.5;
		return polygonView;
    }
    if ([overlay isKindOfClass:[BMKGroundOverlay class]])
    {
        BMKGroundOverlayView* groundView = [[BMKGroundOverlayView alloc] initWithOverlay:overlay];
		return groundView;
    }
	return nil;
}

- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view{
    bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 64.5, 320, self.contentView.frame.size.height)];
    [bgView setBackgroundColor:[UIColor clearColor]];
    bgView.userInteractionEnabled = YES;
    UITapGestureRecognizer *bgViewtapGestureRecognizer = [[UITapGestureRecognizer alloc] init];
    [bgViewtapGestureRecognizer addTarget:self action:@selector(closeBgview)];
    [bgViewtapGestureRecognizer setNumberOfTapsRequired:1];
    [bgViewtapGestureRecognizer setNumberOfTouchesRequired:1];
    [bgView addGestureRecognizer:bgViewtapGestureRecognizer];
    [self.view addSubview:bgView];
    ProjectModel *model = [showArr objectAtIndex:view.tag];
    NSMutableDictionary *dic = [ProjectStage JudgmentStr:model];
    _MapContent = [[MapContentView alloc] initWithFrame:CGRectMake(0, 568, 320, 190) dic:dic number:[numberArr objectAtIndex:view.tag]];
    [self.view addSubview:_MapContent];
    [UIView animateWithDuration:0.5 animations:^{
        _MapContent.frame = CGRectMake(0, 378, 611, 260);
    }];
}

-(void)removeAnnotationsOnTheMap
{
    NSArray *annArray = [[NSArray alloc]initWithArray:_mapView.annotations];
    NSArray *overlaysArray = [[NSArray alloc] initWithArray:_mapView.overlays];
    [_mapView removeAnnotations: annArray];
    [_mapView removeOverlays:overlaysArray];
}


-(void)loadServer{
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"GET" URLString:[NSString stringWithFormat:@"%s/projects/%@",serverAddress,[LoginSqlite getdata:@"UserToken" defaultdata:@"UserToken"]] parameters:nil error:nil];
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSLog(@"JSON: %@", responseObject);
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
        
        for(int i=0;i<showArr.count;i++){
            ProjectModel *model = [showArr objectAtIndex:i];
            if([[NSString stringWithFormat:@"%@",model.a_longitude] isEqualToString:@"<null>"]||[[NSString stringWithFormat:@"%@",model.a_longitude] isEqualToString:@"(null)"]||[[NSString stringWithFormat:@"%@",model.a_longitude] isEqualToString:@""]){
                [logArr addObject:@"0"];
            }else{
                [logArr addObject:model.a_longitude];
            }
            if([[NSString stringWithFormat:@"%@",model.a_latitude] isEqualToString:@"<null>"]||[[NSString stringWithFormat:@"%@",model.a_latitude] isEqualToString:@"(null)"]||[[NSString stringWithFormat:@"%@",model.a_latitude] isEqualToString:@""]){
                [latArr addObject:@"0"];
            }else{
                [latArr addObject:model.a_latitude];
            }
            //NSLog(@"log==>%@,lat===>%@",model.a_longitude,model.a_latitude);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    [[NSOperationQueue mainQueue] addOperation:op];
}

-(void)closeBgview{
    [bgView removeFromSuperview];
    bgView=nil;
    [UIView animateWithDuration:0.5 animations:^{
        _MapContent.frame = CGRectMake(0, 568, 611, 260);
        [_MapContent removeFromSuperview];
        _MapContent = nil;
    }];
}
@end
