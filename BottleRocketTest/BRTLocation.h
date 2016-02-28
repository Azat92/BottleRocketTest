//
//  BRTLocation.h
//  BottleRocketTest
//
//  Created by Azat Almeev on 24.02.16.
//  Copyright © 2016 Azat Almeev. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface BRTLocation : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *cc;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSString *crossStreet;
@property (nonatomic, strong) NSArray *formattedAddress;
@property (nonatomic, strong) NSNumber *lat;
@property (nonatomic, strong) NSNumber *lng;
@property (nonatomic, strong) NSString *postalCode;
@property (nonatomic, strong) NSString *state;

@end
