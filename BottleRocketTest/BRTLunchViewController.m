//
//  ViewController.m
//  BottleRocketTest
//
//  Created by Azat Almeev on 22.02.16.
//  Copyright © 2016 Azat Almeev. All rights reserved.
//

#import "BRTLunchViewController.h"
#import "BRTLunchCollectionViewCell.h"
#import "BRTLoadingView.h"
#import "BRTRestaurnatsManager.h"
#import "BRTLunchDetailViewController.h"
#import "BRTMapViewController.h"

@interface BRTLunchViewController () <BRTLoadingViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, BRTMapViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, readonly) BRTRestaurnatsManager *restaurantsManager;

@end

@implementation BRTLunchViewController

@synthesize restaurantsManager = _restaurantsManager;

- (BRTRestaurnatsManager *)restaurantsManager
{
    if (!_restaurantsManager)
    {
        @weakify(self);
        _restaurantsManager = [BRTRestaurnatsManager managerWithNewDataCallback:^(NSArray *items) {
            @strongify(self);
            self.collectionView.backgroundView = nil;
            self.navigationItem.rightBarButtonItem.enabled = YES;
            __block NSInteger index = 0;
            [self.collectionView insertItemsAtIndexPaths:[items bk_map:^id(id obj) {
                return [NSIndexPath indexPathForItem:index++ inSection:0];
            }]];
        } onUpdates:^(NSArray *items) {
            @strongify(self);
            [self.refreshControl endRefreshing];
            [self.collectionView reloadData];
        } onError:^(NSError *error) {
            @strongify(self);
            [self.refreshControl endRefreshing];
            if (!self.restaurantsManager.items)
            {
                BRTLoadingView *loadingView = (BRTLoadingView *)self.collectionView.backgroundView;
                loadingView.mode = BRTLoadingViewModeError;
                loadingView.statusText = error.localizedDescription;
            }
            else if (self.view.window)
            {
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.labelText = error.localizedDescription;
                [hud hide:YES afterDelay:3];
            }
        }];
    }
    return _restaurantsManager;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    BRTLoadingView *loadingView = [BRTLoadingView viewFromXib];
    loadingView.delegate = self;
    self.collectionView.backgroundView = loadingView;
    [self.collectionView registerNib:[BRTLunchCollectionViewCell cellNib] forCellWithReuseIdentifier:[BRTLunchCollectionViewCell cellReuseIdentifier]];
    [self.restaurantsManager reloadData];
    self.refreshControl = [UIRefreshControl new];
    [self.refreshControl addTarget:self action:@selector(refreshControlDidFire:) forControlEvents:UIControlEventValueChanged];
    [self.collectionView addSubview:self.refreshControl];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.collectionView reloadData];
}

- (IBAction)refreshControlDidFire:(id)sender
{
    [self.restaurantsManager reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ShowRestaurantSegue"])
    {
        BRTLunchDetailViewController *dvc = segue.destinationViewController;
        dvc.restaurant = sender;
    }
    else if ([segue.identifier isEqualToString:@"ShowOnMapSegue"])
    {
        UINavigationController *nvc = segue.destinationViewController;
        BRTMapViewController *dvc = nvc.viewControllers.firstObject;
        dvc.delegate = self;
        dvc.markers = self.restaurantsManager.items;
    }
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    [self.collectionView reloadData];
}

#pragma mark - Loading View Delegate

- (void)loadingViewDidCLickRetryButton:(BRTLoadingView *)loadingView
{
    [self.restaurantsManager reloadData];
}

#pragma mark - Collection View Data Source

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.restaurantsManager.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BRTLunchCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[BRTLunchCollectionViewCell cellReuseIdentifier] forIndexPath:indexPath];
    cell.restaurant = self.restaurantsManager.items[indexPath.item];
    return cell;
}

#pragma mark - Collection View Delegate Flow Layout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger divider = self.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassRegular ? 2 : 1;
    return CGSizeMake(self.view.width / divider, 180);
}

#pragma mark - Collection View Delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"ShowRestaurantSegue" sender:self.restaurantsManager.items[indexPath.item]];
}

#pragma mark - Map View Controller Delegate

- (void)mapViewController:(BRTMapViewController *)mapController didSelectMarker:(id<MKAnnotation>)marker
{
    [self dismissViewControllerAnimated:YES completion:^{
        [self performSegueWithIdentifier:@"ShowRestaurantSegue" sender:marker];
    }];
}

@end
