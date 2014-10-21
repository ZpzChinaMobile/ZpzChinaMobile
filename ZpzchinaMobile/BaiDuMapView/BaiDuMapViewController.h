//
//  BaiDuMapViewController.h
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-23.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "BMapKit.h"
#import "MapContentView.h"
@interface BaiDuMapViewController : BaseViewController<BMKMapViewDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate,CLLocationManagerDelegate>{
    BMKMapView* _mapView;
    BMKLocationService* _locService;
    BMKGeoCodeSearch* _geocodesearch;
    BMKAnnotationView* newAnnotation;
    BMKPointAnnotation* annotationPoint;
    UIImageView *imageView;//绘画层
    CGMutablePathRef pathRef;//手指画线的Path
    CGPoint locationConverToImage;//存储转换测试位置的CGPoint
    CLLocationCoordinate2D testLocation;//测试的位置(经纬度)
    UIView *btnView;
    UIButton *drawBtn;
    UIButton *refreshBtn;
    UIButton *resetBtn;
    bool isGeoSearch;
    NSMutableArray *showArr;
    NSMutableArray *latArr;
    NSMutableArray *logArr;
    NSMutableArray *pointArr;
    MapContentView *_MapContent;
    UIView *bgView;
    NSArray *numberArr;
    int topCount;
    UIView *topBgView;
    UILabel *countLabel;
    NSMutableArray *coordinates;
    BMKPolygon* polygon;
    CLLocationManager  *locationManager;
}

@end
