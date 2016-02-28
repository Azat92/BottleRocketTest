//
//  BRTLunchCollectionViewCell.h
//  BottleRocketTest
//
//  Created by Azat Almeev on 22.02.16.
//  Copyright © 2016 Azat Almeev. All rights reserved.
//

#import "BRTReusavleCollectionViewCell.h"
#import "BRTRestaurant.h"

@interface BRTLunchCollectionViewCell : BRTReusavleCollectionViewCell

@property (nonatomic, strong) BRTRestaurant *restaurant;

@end
