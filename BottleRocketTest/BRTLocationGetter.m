//
//  BRTLocationWorker.m
//  BottleRocketTest
//
//  Created by Azat Almeev on 27.02.16.
//  Copyright © 2016 Azat Almeev. All rights reserved.
//

#import "BRTLocationGetter.h"
@import MapKit;

@interface BRTLocationGetter () <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation BRTLocationGetter

static BRTLocationGetter *locationWorker;

+ (void)requestPermissions
{
    locationWorker = [BRTLocationGetter new];
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
