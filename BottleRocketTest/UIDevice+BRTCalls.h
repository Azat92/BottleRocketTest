//
//  BRTCalls.h
//  BottleRocketTest
//
//  Created by Azat Almeev on 20.09.16.
//  Copyright © 2016 Azat Almeev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (BRTCalls)

+ (BOOL)canMakePhoneCall:(NSString *)phone;

@end
