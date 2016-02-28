//
//  BRTMapViewController.m
//  BottleRocketTest
//
//  Created by Azat Almeev on 25.02.16.
//  Copyright © 2016 Azat Almeev. All rights reserved.
//

#import "BRTMapViewController.h"
#import "BRTLocationWorker.h"

@interface BRTMapViewController () <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, assign) BOOL didUpdateMap;

@end

@implementation BRTMapViewController

- (void)viewDidLoad
{
    NSParameterAssert(self.markers != nil);
    [super viewDidLoad];
    [BRTLocationWorker requestPermissions];
    self.mapView.showsUserLocation = YES;
    [self.mapView addAnnotations:self.markers];
    [self.mapView showAnnotations:self.mapView.annotations animated:NO];
}

- (IBAction)doneButtonDidClick:(id)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Map View Delegate

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    if (userLocation && !self.didUpdateMap)
    {
        self.didUpdateMap = YES;
        [self.mapView showAnnotations:[self.mapView.annotations arrayByAddingObject:userLocation] animated:YES];
    }
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if (annotation != self.mapView.userLocation)
    {
        static NSString *viewIdentifier = @"RestaurantViewIdentifier";
        MKAnnotationView *view = [mapView dequeueReusableAnnotationViewWithIdentifier:viewIdentifier];
        if (!view)
        {
            view = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:viewIdentifier];
            view.canShowCallout = YES;
            if (self.delegate)
            {
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                [button setImage:[UIImage imageNamed:@"btn_mapNavigate"] forState:UIControlStateNormal];
                [button sizeToFit];
                view.rightCalloutAccessoryView = button;
            }
        }
        return view;
    }
    return nil;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    if (view.annotation != self.mapView.userLocation && self.delegate)
    {
        [self.delegate mapViewController:self didSelectMarker:view.annotation];
    }
}

@end
