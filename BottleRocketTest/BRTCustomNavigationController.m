//
//  BRTCustomNavigationController.m
//  BottleRocketTest
//
//  Created by Azat Almeev on 22.02.16.
//  Copyright © 2016 Azat Almeev. All rights reserved.
//

#import "BRTCustomNavigationController.h"

@implementation BRTCustomNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationBar.barTintColor = [UIColor colorWithHexString:@"43E895"];
    self.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationBar.titleTextAttributes = @{ NSForegroundColorAttributeName : [UIColor whiteColor], NSFontAttributeName : [UIFont fontWithName:@"AvenirNext-DemiBold" size:17] };
}

@end
