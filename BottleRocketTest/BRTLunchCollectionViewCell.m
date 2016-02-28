//
//  BRTLunchCollectionViewCell.m
//  BottleRocketTest
//
//  Created by Azat Almeev on 22.02.16.
//  Copyright © 2016 Azat Almeev. All rights reserved.
//

#import "BRTLunchCollectionViewCell.h"

@interface BRTLunchCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;

@end

@implementation BRTLunchCollectionViewCell

- (BRTRestaurant *)restaurant
{
    return self.model;
}

- (void)setRestaurant:(BRTRestaurant *)restaurant
{
    self.model = restaurant;
    self.nameLabel.text = restaurant.name;
    self.categoryLabel.text = restaurant.category;
    [self.backgroundImageView sd_setImageWithURL:restaurant.backgroundImageURL.toURL];
}

@end
