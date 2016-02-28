//
//  BRTMapViewController.h
//  BottleRocketTest
//
//  Created by Azat Almeev on 25.02.16.
//  Copyright © 2016 Azat Almeev. All rights reserved.
//

#import <UIKit/UIKit.h>
@import MapKit;

@class BRTMapViewController;

@protocol BRTMapViewControllerDelegate <NSObject>

- (void)mapViewController:(BRTMapViewController *)mapController didSelectMarker:(id <MKAnnotation>)marker;

@end

@interface BRTMapViewController : UIViewController

@property (nonatomic, strong) NSArray *markers;
@property (nonatomic, weak) id <BRTMapViewControllerDelegate> delegate;

@end
