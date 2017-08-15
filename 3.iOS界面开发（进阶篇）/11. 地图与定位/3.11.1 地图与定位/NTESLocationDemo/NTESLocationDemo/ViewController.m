//
//  ViewController.m
//  NTESLocationDemo
//
//  Created by jeunfung on 16/10/25.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController ()<CLLocationManagerDelegate>
{
    CLLocationManager *_locationManager;
    
    CLGeocoder *_geoCoder;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:@"goto setting" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor orangeColor]];
    [button setFrame:CGRectMake(100, 100, 150, 50)];
    [button addTarget:self action:@selector(gotoSetting:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    
    //定位权限
    _locationManager =[[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    
    if (![CLLocationManager locationServicesEnabled])
    {
        NSLog(@"Location Service is Off!");
        return;
    }
    
    //请求定位服务
    [_locationManager requestWhenInUseAuthorization];
    [self startMonitorLocation];
}

- (void)startMonitorLocation
{
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    _locationManager.distanceFilter = 50;
    [_locationManager startUpdatingLocation];
}

- (void)stopMonitorLocation
{
    [_locationManager stopUpdatingLocation];
}

#pragma mark - location delegate
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    NSLog(@"CLAuthorizationStatus %zd", status);
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation *location = [locations firstObject];
    NSLog(@"location updated! %@", [NSString stringWithFormat:@"latitude %f, longtitude %f", location.coordinate.latitude, location.coordinate.longitude]);
    
    if (!_geoCoder) {
        _geoCoder = [[CLGeocoder alloc] init];
    }
    
    [_geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
       
        for (CLPlacemark *placemark in placemarks)
        {
            NSLog(@"name=%@,locality=%@ country=%@", placemark.name, placemark.locality, placemark.country);
        }
        
    }];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"location error");
    switch ([error code]) {
        case kCLErrorDenied:
            [self stopMonitorLocation];
            break;
        case kCLErrorLocationUnknown:
            [self stopMonitorLocation];
            break;
        default:
            break;
    }
}

#pragma mark - button
- (void)gotoSetting:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
