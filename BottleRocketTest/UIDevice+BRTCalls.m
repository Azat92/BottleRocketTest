//
//  BRTCalls.m
//  BottleRocketTest
//
//  Created by Azat Almeev on 20.09.16.
//  Copyright © 2016 Azat Almeev. All rights reserved.
//

#import "UIDevice+BRTCalls.h"

@implementation UIDevice (BRTCalls)

+ (BOOL)canMakePhoneCall:(NSString *)phone
{
    if (phone.length == 0)
    {
        return NO;
    }
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", phone]]];
}

@end
