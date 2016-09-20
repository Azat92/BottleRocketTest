//
//  BRTLunchDetailViewController.h
//  BottleRocketTest
//
//  Created by Azat Almeev on 25.02.16.
//  Copyright © 2016 Azat Almeev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BRTRestaurant.h"

static NSString * const SHOW_ON_MAP_SEGUE = @"ShowOnMapSegue";

@interface BRTLunchDetailViewController : UIViewController

@property (nonatomic, strong) BRTRestaurant *restaurant;

@end
