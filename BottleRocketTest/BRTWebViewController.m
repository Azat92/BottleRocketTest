//
//  BRTWebViewController.m
//  BottleRocketTest
//
//  Created by Azat Almeev on 25.02.16.
//  Copyright © 2016 Azat Almeev. All rights reserved.
//

#import "BRTWebViewController.h"

@interface BRTWebViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation BRTWebViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.webView loadHTMLString:@"<html>Loading...</html>" baseURL:nil];
    [self.webView loadRequest:[NSURLRequest requestWithURL:@"http://www.bottlerocketstudios.com".toURL]];
}

- (IBAction)backButtonDidPress:(id)sender
{
    [self.webView goBack];
}

- (IBAction)reloadButtonDidPress:(id)sender
{
    [self.webView reload];
}

- (IBAction)forwardButtonDidPress:(id)sender
{
    [self.webView goForward];
}

@end
