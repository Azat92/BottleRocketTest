//
//  BRTLunchDetailViewController.m
//  BottleRocketTest
//
//  Created by Azat Almeev on 25.02.16.
//  Copyright © 2016 Azat Almeev. All rights reserved.
//

#import "BRTLunchDetailViewController.h"
#import "BRTMapViewController.h"
#import "BRTLocationWorker.h"

@interface BRTLunchDetailViewController () <UIScrollViewDelegate, MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mapHeightConstraint;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIButton *phoneButton;
@property (weak, nonatomic) IBOutlet UILabel *twitterLabel;

@end

@implementation BRTLunchDetailViewController

- (void)viewDidLoad
{
    NSParameterAssert(self.restaurant != nil);
    [super viewDidLoad];
    [self.mapView addAnnotation:self.restaurant];
    [self.mapView showAnnotations:self.mapView.annotations animated:NO];
    self.nameLabel.text = self.restaurant.name;
    self.categoryLabel.text = self.restaurant.category;
    self.addressLabel.text = [self.restaurant.location.formattedAddress componentsJoinedByString:@", "];
    [self.phoneButton setTitle:self.restaurant.contact.formattedPhone forState:UIControlStateNormal];
    self.phoneButton.enabled = self.restaurant.contact.havePhone;
    self.phoneButton.userInteractionEnabled = !IS_IPAD;
    self.twitterLabel.text = self.restaurant.contact.twitter;
}

- (IBAction)phoneButtonDidClick:(id)sender
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:self.restaurant.name message:self.restaurant.contact.formattedPhone preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"Call" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString *phoneNumber = [NSString stringWithFormat:@"tel://%@", self.restaurant.contact.phone];
        [SharedApplication openURL:phoneNumber.toURL];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ShowOnMapSegue"])
    {
        UINavigationController *nvc = segue.destinationViewController;
        BRTMapViewController *dvc = nvc.viewControllers.firstObject;
        dvc.markers = @[ self.restaurant ];
    }
}

#pragma mark - Scroll View Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, MAX(scrollView.contentOffset.y, -400));
    self.mapHeightConstraint.constant = MAX(180, 180 - scrollView.contentOffset.y);
}

#pragma mark - Map View Delegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if (annotation == self.restaurant)
    {
        static NSString *viewIdentifier = @"RestaurantViewIdentifier";
        MKAnnotationView *view = [mapView dequeueReusableAnnotationViewWithIdentifier:viewIdentifier];
        if (!view)
        {
            view = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:viewIdentifier];
            view.canShowCallout = YES;
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setImage:[UIImage imageNamed:@"btn_mapNavigate"] forState:UIControlStateNormal];
            [button sizeToFit];
            view.rightCalloutAccessoryView = button;
        }
        return view;
    }
    return nil;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    if (view.annotation == self.restaurant)
    {
        MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:self.restaurant.coordinate addressDictionary:nil];
        MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
        mapItem.name = self.restaurant.name;
        [mapItem openInMapsWithLaunchOptions:@{ MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving }];
    }
}

@end
