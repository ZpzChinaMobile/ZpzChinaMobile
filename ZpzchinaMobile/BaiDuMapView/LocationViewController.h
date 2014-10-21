//
//  LocationViewController.h
//  ZpzchinaMobile
//
//  Created by 汪洋 on 14-6-30.
//  Copyright (c) 2014年 汪洋. All rights reserved.
//

#import "BaseViewController.h"
#import "BMapKit.h"
@protocol LocationViewDelegate;
@interface LocationViewController : BaseViewController<BMKMapViewDelegate,BMKGeoCodeSearchDelegate,BMKLocationServiceDelegate,UIAlertViewDelegate>{
    BMKMapView* _mapView;
    BMKGeoCodeSearch* _geocodesearch;
    BMKLocationService* _locService;
    BMKAnnotationView* newAnnotation;
    BMKPointAnnotation* annotationPoint;
    bool isGeoSearch;
    NSString *address;
    NSString *baseAddress;
    NSString *baseCity;
    CLLocationCoordinate2D testLocation;
    CLLocationManager  *locationManager;
}
@property(nonatomic ,weak) id <LocationViewDelegate> delegate;
@property(nonatomic ,retain) NSString *baseAddress;
@property(nonatomic ,retain) NSString *baseCity;
@end
@protocol LocationViewDelegate <NSObject>
-(void)locationBack:(NSString *)address testLocation:(CLLocationCoordinate2D)testLocation;
@end