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
#import "ProgramDetailViewController.h"
@interface BaiDuMapViewController ()
@property(nonatomic)BOOL isShowing;//只有当从搜索出来的小卡片点进项目详情时，self.isShowing才会为真，所以只有当从详情页回来到这个页面触发viewWillAppear时才会再将这个值改为假
@property(nonatomic)BOOL isSelect;

@property(nonatomic,strong)UIButton* nextBtn;
@property(nonatomic,strong)UIButton* lastBtn;

@property(nonatomic)NSInteger pageCount;
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
    self.isShowing=NO;
    self.isSelect = NO;
    [self addBackButton];
    [self addtittle:@"地图搜索"];
    hasProject = 0;
    startIndex = 0;
    [self loadSelf];
}

-(void)loadSelf{
    j=0;
    numberArr = [[NSArray alloc] initWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z", nil];
    showArr = [[NSMutableArray alloc] init];
    logArr = [[NSMutableArray alloc] init];
    latArr = [[NSMutableArray alloc] init];
    pointArr = [[NSMutableArray alloc] init];
    coordinates = [[NSMutableArray alloc] init];
    _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, 320, kScreenHeight-63)];
    _mapView.zoomEnabled = YES;//允许Zoom
    _mapView.scrollEnabled = YES;//允许Scroll
    _mapView.mapType = BMKMapTypeStandard;//地图类型为标准，可以为卫星，可以开启或关闭交通
    [_mapView setZoomLevel:15];
    [self.contentView addSubview:_mapView];
    
    _locService = [[BMKLocationService alloc]init];
    
    
    _geocodesearch = [[BMKGeoCodeSearch alloc]init];
    
    CLLocationCoordinate2D coor;
    BMKCoordinateRegion viewRegion = BMKCoordinateRegionMake(coor, BMKCoordinateSpanMake(0.02f, 0));
    //调整后适合当前地图窗口显示的经纬度范围
    BMKCoordinateRegion adjusteRegion = [_mapView regionThatFits:viewRegion];
    // *设定当前地图的显示范围
    [_mapView setRegion:adjusteRegion animated:YES];
    
    btnView = [[UIView alloc] initWithFrame:CGRectMake(10, 24, 40, 40)];
    drawBtn =  [UIButton buttonWithType:UIButtonTypeCustom];
    drawBtn.frame = CGRectMake(0,0, 40, 40);
    [drawBtn setBackgroundImage:[GetImagePath getImagePath:@"mapsearch-1"] forState:UIControlStateNormal];
    [drawBtn addTarget:self action:@selector(drawFunction) forControlEvents:UIControlEventTouchUpInside];
    [btnView addSubview:drawBtn];
    
    [self.contentView addSubview:btnView];
    
    self.nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.nextBtn.frame = CGRectMake(10,150, 40, 40);
    [self.nextBtn setBackgroundImage:[GetImagePath getImagePath:@"项目地图搜索01"] forState:UIControlStateNormal];
    [self.nextBtn addTarget:self action:@selector(nextPage) forControlEvents:UIControlEventTouchUpInside];
    self.nextBtn.enabled=NO;
    [self.view addSubview:self.nextBtn];
    
    self.lastBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.lastBtn.frame = CGRectMake(10,200, 40, 40);
    [self.lastBtn setBackgroundImage:[GetImagePath getImagePath:@"项目地图搜索02"] forState:UIControlStateNormal];
    [self.lastBtn addTarget:self action:@selector(lastPage) forControlEvents:UIControlEventTouchUpInside];
    self.lastBtn.enabled=NO;
    [self.view addSubview:self.lastBtn];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated {
    if (!self.isShowing) {
        [self myViewWillAppear];
    }else{
        //只有当从搜索出来的小卡片点进项目详情时，self.isShowing才会为真，所以只有当从详情页回来到这个页面触发viewWillAppear时才会再将这个值改为假
        self.isShowing=!self.isShowing;
    }
}

-(void)myViewWillAppear{
    j=0;
    [_mapView viewWillAppear];
    [_locService startUserLocationService];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _locService.delegate = self;
    _geocodesearch.delegate = self;
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    [self.mm_drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeNone];
}

-(void)dealloc{
    NSLog(@"baidumap dealloc");
}

-(void)viewWillDisappear:(BOOL)animated {
    if (!self.isShowing) {
        [self myViewWillDisappear];
    }
}

-(void)myViewWillDisappear{
    [_mapView viewWillDisappear];
    NSLog(@"baidumapDis");
    _mapView.delegate = nil; // 不用时，置nil
    _locService.delegate = nil;
    _geocodesearch.delegate = nil;
    [imageView removeFromSuperview];
    imageView = nil;
    [coordinates removeAllObjects];
    [self removeAnnotationsOnTheMap];
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [self.mm_drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
}

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
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
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
    NSString *AnnotationViewID = [NSString stringWithFormat:@"xidanMark%d",j];
	
    // 检查是否有重用的缓存
    BMKAnnotationView* annotationView = [view dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    
    // 缓存没有命中，自己构造一个，一般首次添加annotation代码会运行到此处
    if (annotationView == nil) {
        annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
		[annotationView setImage:[GetImagePath getImagePath:@"地图搜索1_09"]];
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 28.5, 30)];
//        label.textColor = [UIColor whiteColor];
//        label.font = [UIFont fontWithName:nil size:14];
//        label.text = [numberArr objectAtIndex:j];
//        label.textAlignment = NSTextAlignmentCenter;
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(0, 0, 28.5, 30)];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitle:[numberArr objectAtIndex:j] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont fontWithName:nil size:14];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        btn.tag = j;
        [btn addTarget:self action:@selector(showContentView:) forControlEvents:UIControlEventTouchUpInside];
        [annotationView addSubview:btn];
		// 设置重天上掉下的效果(annotation)
        ((BMKPinAnnotationView*)annotationView).animatesDrop = YES;
        annotationView.tag = j;
    }
	
    // 设置位置
	annotationView.centerOffset = CGPointMake(0, -(annotationView.frame.size.height * 0.5));
    annotationView.annotation = annotation;
    // 单击弹出泡泡，弹出泡泡前提annotation必须实现title属性
    if(showArr.count !=0){
        annotationView.canShowCallout = NO;
    }else{
        annotationView.canShowCallout = YES;
    }
    
	
    // 设置是否可以拖拽
    annotationView.draggable = NO;
    j++;
    return annotationView;
}

-(void)drawFunction{
    j=0;
    startIndex = 0;
    if(imageView == nil){
        topCount = 0;
        [topBgView removeFromSuperview];
        topBgView = nil;
        [countLabel removeFromSuperview];
        countLabel = nil;
        imageView=[[UIImageView alloc] initWithFrame:_mapView.frame];
        [imageView setImage:[GetImagePath getImagePath:@"地图搜索_02"]];
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
//        _mapView.scrollEnabled = YES;
//        _mapView.zoomEnabled = YES;
//        _mapView.zoomEnabledWithTap = YES;
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
    self.nextBtn.enabled=NO;
    self.lastBtn.enabled=NO;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //NSLog(@"%d",touches.count);
    if(!bgView){
        if(imageView){
            UITouch *touch = [touches anyObject];
            
            CGPoint location = [touch locationInView:imageView];
            
            //创建path
            
            pathRef=CGPathCreateMutable();
            
            CGPathMoveToPoint(pathRef, NULL, location.x, location.y);
            
            CLLocationCoordinate2D coordinate = [_mapView convertPoint:location toCoordinateFromView:imageView];
            [coordinates addObject:[NSValue valueWithMKCoordinate:coordinate]];
        }
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    if(!bgView){
        if(imageView){
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
            
            CLLocationCoordinate2D coordinate = [_mapView convertPoint:location toCoordinateFromView:imageView];
            [coordinates addObject:[NSValue valueWithMKCoordinate:coordinate]];
        }
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if(!bgView){
        if(imageView){
            [logArr removeAllObjects];
            [latArr removeAllObjects];
            [showArr removeAllObjects];
            hasProject = 0;
            UITouch *touch = [touches anyObject];
            CGPoint location = [touch locationInView:imageView];
            CGPathAddLineToPoint(pathRef, NULL, location.x, location.y);
            CLLocationCoordinate2D coordinate = [_mapView convertPoint:location toCoordinateFromView:imageView];
            [coordinates addObject:[NSValue valueWithMKCoordinate:coordinate]];
            
            
            NSInteger numberOfPoints = [coordinates count];
            
            if (numberOfPoints > 2)
            {
                double maxLongitude=-9999;
                double minLongitude=9999;
                double maxLatitude=-9999;
                double minLatitude=9999;
                
                CLLocationCoordinate2D points[numberOfPoints];
                for (NSInteger i = 0; i < numberOfPoints; i++) {
                    points[i] = [coordinates[i] MKCoordinateValue];
                    if (points[i].longitude>maxLongitude) {
                        maxLongitude=points[i].longitude;
                    }
                    if (points[i].longitude<minLongitude){
                        minLongitude=points[i].longitude;
                    }
                    if (points[i].latitude>maxLatitude){
                        maxLatitude=points[i].latitude;
                    }
                    if (points[i].latitude<minLatitude){
                        minLatitude=points[i].latitude;
                    }
                    //NSLog(@"point==%f,%f",points[i].latitude,points[i].longitude);
                }
                //NSLog(@"%f,%f",(maxLatitude+minLatitude)*0.5, (maxLongitude+minLongitude)*.5);
                polygon = [BMKPolygon polygonWithCoordinates:points count:numberOfPoints];
                [_mapView addOverlay:polygon];
                
                
                centerLocation=CLLocationCoordinate2DMake((maxLatitude+minLatitude)*0.5, (maxLongitude+minLongitude)*.5);
                //NSLog(@"=====%f,%f",centerLocation.longitude,centerLocation.latitude);
                CLLocationCoordinate2D coor1=CLLocationCoordinate2DMake(maxLatitude,maxLongitude);
                BMKMapPoint mp1 = BMKMapPointForCoordinate(coor1);
                BMKMapPoint mp2 = BMKMapPointForCoordinate(centerLocation);
                dis = BMKMetersBetweenMapPoints(mp1, mp2);
                NSLog(@"%f",dis);
                self.pageCount=0;
                allCount=1;
                startIndex=-1;
                [self getMapSearch:centerLocation startIndex:YES dis:[NSString stringWithFormat:@"%f",dis/1000]];
                
                //            CLLocationCoordinate2D coors[2] = {0};
                //            coors[0].latitude = maxLatitude;
                //            coors[0].longitude = maxLongitude;
                //            coors[1].latitude = centerLocation.latitude;
                //            coors[1].longitude = centerLocation.longitude;
                //            BMKPolyline* polyline = [BMKPolyline polylineWithCoordinates:coors count:2];
                //            [_mapView addOverlay:polyline];
//                [imageView removeFromSuperview];
//                imageView = nil;
            }
            CGPathCloseSubpath(pathRef);
        }
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

-(void)showContentView:(UIButton *)button{
    NSLog(@"%d",showArr.count);
    if(showArr.count !=0){
        bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 64.5, 320, self.contentView.frame.size.height)];
        [bgView setBackgroundColor:[UIColor clearColor]];
        bgView.userInteractionEnabled = YES;
        UITapGestureRecognizer *bgViewtapGestureRecognizer = [[UITapGestureRecognizer alloc] init];
        [bgViewtapGestureRecognizer addTarget:self action:@selector(closeBgview)];
        [bgViewtapGestureRecognizer setNumberOfTapsRequired:1];
        [bgViewtapGestureRecognizer setNumberOfTouchesRequired:1];
        [bgView addGestureRecognizer:bgViewtapGestureRecognizer];
        [self.view addSubview:bgView];
        ProjectModel *model = [showArr objectAtIndex:button.tag];
        NSMutableDictionary *dic = [ProjectStage JudgmentStr:model];
        _MapContent = [[MapContentView alloc] initWithFrame:CGRectMake(0, kScreenHeight, 320, 260) dic:dic number:[numberArr objectAtIndex:button.tag]];
        _MapContent.userInteractionEnabled = YES;
        _MapContent.tag=button.tag;
        [self.view addSubview:_MapContent];
        
        [_MapContent addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoProgramDetailViewController:)]];
        
        [UIView animateWithDuration:0.5 animations:^{
            _MapContent.frame = CGRectMake(0, kScreenHeight-190, 611, 260);
        }];
    }else{
        if(!self.isSelect){
            [_mapView selectAnnotation:annotationPoint animated:YES];
            self.isSelect = YES;
        }else{
            [_mapView deselectAnnotation:annotationPoint animated:YES];
            self.isSelect = NO;
        }
        imageView.userInteractionEnabled = NO;
    }
}


-(void)gotoProgramDetailViewController:(UIGestureRecognizer*)gesture{
    self.isShowing=YES;
    ProjectModel *model = [showArr objectAtIndex:gesture.view.tag];
    NSMutableDictionary *dic = [ProjectStage JudgmentStr:model];

    ProgramDetailViewController* vc=[[ProgramDetailViewController alloc]init];
    vc.url=dic[@"url"];
    vc.isRelease=0;
    vc.fromView=1;
    vc.isFromAllProject=YES;
    vc.ID=[dic objectForKey:@"projectID"];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)removeAnnotationsOnTheMap
{
    NSArray *annArray = [[NSArray alloc]initWithArray:_mapView.annotations];
    NSArray *overlaysArray = [[NSArray alloc] initWithArray:_mapView.overlays];
    [_mapView removeAnnotations: annArray];
    [_mapView removeOverlays:overlaysArray];
    annotationPoint = nil;
}

-(void)closeBgview{
    [bgView removeFromSuperview];
    bgView=nil;
    [UIView animateWithDuration:0.5 animations:^{
        _MapContent.frame = CGRectMake(0, kScreenHeight, 611, 260);
        [_MapContent removeFromSuperview];
        _MapContent = nil;
    }];
}



-(void)getMapSearch:(CLLocationCoordinate2D)Location startIndex:(BOOL)isNext dis:(NSString *)distance{
    int tempStartIndex;
    if (isNext) {
        if (startIndex>=allCount-1) {
            tempStartIndex=allCount-1;
        }else{
            tempStartIndex=startIndex+1;
        }
    }else{
        if (startIndex<=0) {
            tempStartIndex=0;
        }else{
            tempStartIndex=startIndex-1;
        }
    }
    
    [ProjectModel GetMapSearchWithBlock:^(NSMutableArray *posts, NSError *error) {
        if (!error) {
            if([posts[1] intValue]%26 == 0){
                allCount = [posts[1] intValue]/26;
            }else{
                allCount = ([posts[1] intValue]/26)+1;
            }
            
            if (isNext) {
                if (startIndex<allCount-1) {
                    startIndex++;
                }
            }else{
                if (startIndex>0) {
                    startIndex--;
                }
            }
            
            if([posts[1] intValue] == 0){
                [[[UIAlertView alloc] initWithTitle:@"提示" message:@"没有找到项目" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil,nil]show];
                [self judgeBtnEnable];
                [imageView removeFromSuperview];
                imageView = nil;
            }else{
                [self addAnnotation:posts[0] isNext:isNext];
                //[self judgeBtnEnable];
            }
        }else{
            [imageView removeFromSuperview];
            imageView = nil;
        }
    } longitude:[NSString stringWithFormat:@"%lf",Location.longitude] latitude:[NSString stringWithFormat:@"%lf",Location.latitude] radius:distance startIndex:tempStartIndex];
}

-(void)addAnnotation:(NSMutableArray *)posts isNext:(BOOL)isNext{
    for(int i=0;i<posts.count;i++){
        ProjectModel *model = [posts objectAtIndex:i];
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
    }
    
    //地理坐标转换成点
    for(int i=0;i<posts.count;i++){
        testLocation.latitude = [[latArr objectAtIndex:i] doubleValue];
        testLocation.longitude = [[logArr objectAtIndex:i] doubleValue];
        if([self PtInPolygon:testLocation]){
            NSLog(@"point in path!");
            NSLog(@"%f====%f",locationConverToImage.x,locationConverToImage.y);
            ProjectModel *model = [posts objectAtIndex:i];
            [showArr addObject:model];
            annotationPoint = [[BMKPointAnnotation alloc]init];
            CLLocationCoordinate2D coor;
            coor.latitude = testLocation.latitude;
            coor.longitude = testLocation.longitude;
            annotationPoint.coordinate = coor;
            annotationPoint.title = model.a_landName;
            annotationPoint.subtitle = model.a_landAddress;
            [_mapView addAnnotation:annotationPoint];
        }
    }
    [imageView removeFromSuperview];
    imageView = nil;
    if(showArr.count == 0){
        if (isNext) {
            [self nextPage];
        }else{
            [self lastPage];
        }
    }else{
        if (isNext) {
            self.pageCount++;
        }else{
            self.pageCount--;
        }
    }
    [self judgeBtnEnable];
}

-(void)nextPage{
    if (!self.nextBtn.enabled) {
        [[[UIAlertView alloc] initWithTitle:@"提示" message:@"没有找到项目" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil,nil]show];
        self.pageCount++;
        [self judgeBtnEnable];
        return;
    }
    j = 0;
    [showArr removeAllObjects];
    [logArr removeAllObjects];
    [latArr removeAllObjects];
    NSArray *annArray = [[NSArray alloc]initWithArray:_mapView.annotations];
    [_mapView removeAnnotations: annArray];
    annotationPoint = nil;
    [self getMapSearch:centerLocation startIndex:1 dis:[NSString stringWithFormat:@"%f",dis/1000]];
}

-(void)lastPage{
    NSLog(@"222");
    j = 0;
    [showArr removeAllObjects];
    [logArr removeAllObjects];
    [latArr removeAllObjects];
    NSArray *annArray = [[NSArray alloc]initWithArray:_mapView.annotations];
    [_mapView removeAnnotations: annArray];
    annotationPoint = nil;
    [self getMapSearch:centerLocation startIndex:0 dis:[NSString stringWithFormat:@"%f",dis/1000]];
}

-(BOOL)PtInPolygon:(CLLocationCoordinate2D)p{
    int nCross = 0;
    NSInteger numberOfPoints = [coordinates count];
    for(int i = 0; i < numberOfPoints; i++){
        CLLocationCoordinate2D p1 = [coordinates[i] MKCoordinateValue];
        CLLocationCoordinate2D p2 = [coordinates[(i+1)%numberOfPoints] MKCoordinateValue];
        // 求解 y=p.y 与 p1p2 的交点
        if ( p1.latitude == p2.latitude ){// p1p2 与 y=p0.y平行
            continue;
        }
        if(p.latitude < MIN(p1.latitude, p2.latitude)){// 交点在p1p2延长线上
            continue;
        }
        if(p.latitude >= MAX(p1.latitude, p2.latitude)){
            continue;
        }
        double x = (double)(p.latitude - p1.latitude) * (double)(p2.longitude - p1.longitude) / (double)(p2.latitude - p1.latitude) + p1.longitude;
        if ( x > p.longitude ){
            nCross++;
        }
    }
    return (nCross % 2 == 1);
}


    

-(void)judgeBtnEnable{
    self.nextBtn.enabled=(startIndex<allCount-1);
    self.lastBtn.enabled=(self.pageCount>1);
}
@end
