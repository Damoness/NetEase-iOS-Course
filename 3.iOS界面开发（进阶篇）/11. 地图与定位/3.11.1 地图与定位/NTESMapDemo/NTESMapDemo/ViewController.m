//
//  ViewController.m
//  NTESMapDemo
//
//  Created by jeunfung on 16/10/25.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>

@interface ViewController ()<MKMapViewDelegate>
{
    MKMapView *_mapView;
    
    CLLocationManager *_locationManager;
    
    CLGeocoder *_geocoder;
    
    MKPointAnnotation *_pointAnnotation;
}
@property (nonatomic, strong) NSMutableArray *availableMaps;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //step1
    _mapView = [[MKMapView alloc] init];
    _mapView.frame = self.view.frame;
    _mapView.delegate = self;
    
    _mapView.mapType = MKMapTypeStandard;
    _mapView.showsUserLocation = YES;
    _mapView.showsScale = YES;
    _mapView.showsTraffic = YES;
    _mapView.showsCompass = YES;
    
    _mapView.userTrackingMode = MKUserTrackingModeFollowWithHeading;
    self.view = _mapView;
    
    _locationManager = [[CLLocationManager alloc] init];
    [_locationManager requestWhenInUseAuthorization];
    
    _geocoder = [[CLGeocoder alloc] init];
    
    _pointAnnotation = [[MKPointAnnotation alloc] init];
    _pointAnnotation.title = @"奶茶 刘若英";
    _pointAnnotation.subtitle = @"原来你也在这里 盛大开演";
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = 30.189845;
    coordinate.longitude = 120.187883;
    _pointAnnotation.coordinate = coordinate;
    [_mapView addAnnotation:_pointAnnotation];
    
    self.availableMaps = [NSMutableArray array];
    [self getAvailableMapsApps];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - mapview delegate
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    [_geocoder reverseGeocodeLocation:userLocation.location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
       
        if (placemarks.count > 0)
        {
            CLPlacemark *placemark = placemarks[0];
            userLocation.title = @"当前位置";
            userLocation.subtitle = [NSString stringWithFormat:@"%@ %@", placemark.locality, placemark.thoroughfare];
        }
        
    }];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKPointAnnotation class]])
    {
        NSString *pointAnnotationIdentifier = @"pointAnnotationIdentifier";
        MKAnnotationView *annotationView = [_mapView dequeueReusableAnnotationViewWithIdentifier:pointAnnotationIdentifier];
        if (!annotationView) {
            annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointAnnotationIdentifier];
            
            UIButton *testButton = [[UIButton alloc] init];
            [testButton setBackgroundColor:[UIColor orangeColor]];
            [testButton setTitle:@"Go" forState:UIControlStateNormal];
            testButton.frame = CGRectMake(0, 0, 50, 50);
            [testButton addTarget:self action:@selector(go:) forControlEvents:UIControlEventTouchUpInside];
            annotationView.rightCalloutAccessoryView = testButton;
        }
        annotationView.annotation = _pointAnnotation;
        annotationView.canShowCallout = YES;
        return annotationView;
    }
    return nil;
}


#pragma mark - button
- (void)go:(id)sender
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择导航" message:@"选择你要的导航服务" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"系统导航" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
       
        CLLocationCoordinate2D coordinateEnd = CLLocationCoordinate2DMake(31.18, 121.43);
        MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:coordinateEnd];
        MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:placemark];
        toLocation.name = @"目的地";
        
        MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
        
        [MKMapItem openMapsWithItems:@[currentLocation, toLocation] launchOptions:@{
                                                                                    MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving,
                                                                                    MKLaunchOptionsShowsTrafficKey:@YES
                                                                                    }];
    }];
    
    [alert addAction:action1];
    
    for (NSDictionary *dic in self.availableMaps)
    {
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:[NSString stringWithFormat:@"使用%@导航", dic[@"name"]] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
           
            NSString *string = dic[@"url"];
            string = [string stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            NSURL *url = [NSURL URLWithString:string];
            [[UIApplication sharedApplication] openURL:url];
        }];
        [alert addAction:action2];
    }
    
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action3];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}

- (void)getAvailableMapsApps
{
    [self.availableMaps removeAllObjects];
    
    CLLocationCoordinate2D coordinateStart = CLLocationCoordinate2DMake(30.19, 120.19);
    CLLocationCoordinate2D coordinateEnd = CLLocationCoordinate2DMake(30.23, 120.15);
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]])
    {
        NSString * urlString = [NSString stringWithFormat:@"baidumap://map/direction?origin=latlng:%f,%f|name:我的位置&destination=latlng:%f,%f|name:目的地&mode=driving",coordinateStart.latitude,coordinateStart.longitude,coordinateEnd.latitude,coordinateEnd.longitude];
        
        NSDictionary *dic = @{@"name" : @"百度地图", @"url" : urlString};
        [self.availableMaps addObject:dic];
    }
}


@end
