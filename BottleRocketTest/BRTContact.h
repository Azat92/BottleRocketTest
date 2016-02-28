//
//  BRTContact.h
//  BottleRocketTest
//
//  Created by Azat Almeev on 24.02.16.
//  Copyright © 2016 Azat Almeev. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface BRTContact : MTLModel <MTLJSONSerializing>

@property (nonatomic, readonly) BOOL havePhone;
@property (nonatomic, strong) NSString *formattedPhone;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *twitter;

@end
