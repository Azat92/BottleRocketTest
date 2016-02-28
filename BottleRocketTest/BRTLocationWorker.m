//
//  BRTLocationWorker.m
//  BottleRocketTest
//
//  Created by Azat Almeev on 27.02.16.
//  Copyright © 2016 Azat Almeev. All rights reserved.
//

#import "BRTLocationWorker.h"
@import MapKit;

@interface BRTLocationWorker () <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation BRTLocationWorker

static BRTLocationWorker *locationWorker;

+ (void)requestPermissions
{
    locationWorker = [BRTLocationWorker new];
    CLLocationManager *locationManager = [CLLocationManager new];
    locationManager.delegate = locationWorker;
    [locationManager requestWhenInUseAuthorization];
    locationWorker.locationManager = locationManager;
}

#pragma mark - Location Manager Delegate

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (status != kCLAuthorizationStatusNotDetermined)
    {
        locationWorker = nil;
    }
}

@end
