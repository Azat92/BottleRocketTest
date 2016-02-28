//
//  BRTRestaurant.h
//  BottleRocketTest
//
//  Created by Azat Almeev on 24.02.16.
//  Copyright © 2016 Azat Almeev. All rights reserved.
//

#import "BRTLocation.h"
#import "BRTContact.h"
@import MapKit;

@interface BRTRestaurant : MTLModel <MTLJSONSerializing, MKAnnotation>

@property (nonatomic, strong) NSString *backgroundImageURL;
@property (nonatomic, strong) NSString *category;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) BRTContact *contact;
@property (nonatomic, strong) BRTLocation *location;

@end
