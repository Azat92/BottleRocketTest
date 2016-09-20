//
//  BRTLoadingView.m
//  BottleRocketTest
//
//  Created by Azat Almeev on 23.02.16.
//  Copyright © 2016 Azat Almeev. All rights reserved.
//

#import "BRTLoadingView.h"

@interface BRTLoadingView ()

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIButton *retryButton;

@end

@implementation BRTLoadingView

- (void)setErrorWithStatusText:(NSString *)text
{
    self.mode = BRTLoadingViewModeError;
    self.statusText = text;
}

- (void)setMode:(BRTLoadingViewMode)mode
{
    _mode = mode;
    switch (mode)
    {
        case BRTLoadingViewModeLoading:
            [self.indicator startAnimating];
            self.statusText = nil;
            self.statusLabel.text = @"Loading...";
            self.retryButton.hidden = YES;
            break;
        case BRTLoadingViewModeError:
            [self.indicator stopAnimating];
            self.statusLabel.text = self.statusText ?: @"Error";
            self.retryButton.hidden = NO;
            break;
    }
}

- (void)setStatusText:(NSString *)statusText
{
    _statusText = [statusText copy];
    if (self.mode == BRTLoadingViewModeError)
    {
        self.statusLabel.text = _statusText;
    }
}

- (IBAction)retryButtonDidClick:(id)sender
{
    self.mode = BRTLoadingViewModeLoading;
    [self.delegate loadingViewDidClickRetryButton:self];
}

+ (instancetype)viewFromXib
{
    UINib *viewNib = [UINib nibWithNibName:@"BRTLoadingView" bundle:nil];
    return [viewNib instantiateWithOwner:self options:nil].firstObject;
}

@end
