//
//  ProfileViewController.m
//  RestaurantRoulette
//
//  Created by rutvims on 7/22/21.
//

#import "ProfileViewController.h"
#import "PastBookingCell.h"
#import "CurrentBookingCell.h"
#import "UserInfo.h"
#import <Parse/Parse.h>
#import <YelpAPI/YLPClient+Business.h>
#import "UIImageView+AFNetworking.h"
#import "APIManager.h"
#import "SettingsViewController.h"
#import "DetailsViewController.h"

@interface ProfileViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, PastBookingDelegate, CurrentBookingDelegate>

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.currentBookings.delegate = self;
    self.currentBookings.dataSource = self;
    
    self.pastBookings.delegate = self;
    self.pastBookings.dataSource = self;
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    //    [self.view insertSubview:self.refreshControl atIndex: 0];
    
    [self parseHelper];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(collectionView == self.currentBookings){
        CurrentBookingCell *currentCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CurrentBookingCell" forIndexPath:indexPath];
        if(self.profile != nil && self.profile.currentBookingsArray != nil){
            currentCell.delegate = self;
            NSString *businessID = self.profile.currentBookingsArray[indexPath.row];
            currentCell.index = indexPath.row;
            [[APIManager shared] businessWithId:businessID completionHandler:^(YLPBusiness * _Nullable business, NSError * _Nullable error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    currentCell.business = business;
                    currentCell.businessName.text = business.name;
                    [currentCell.businessName sizeToFit];
                    [currentCell.businessImage setImageWithURL:business.imageURL];
                });
            }];
        }
        return currentCell;
    }else{
        PastBookingCell *pastCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PastBookingCell" forIndexPath:indexPath];
        if(self.profile != nil && self.profile.pastBookingsArray != nil){
            pastCell.delegate = self;
            NSString *businessID = self.profile.pastBookingsArray[indexPath.row];
            pastCell.index = indexPath.row;
            [[APIManager shared] businessWithId:businessID completionHandler:^(YLPBusiness * _Nullable business, NSError * _Nullable error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    pastCell.business = business;
                    pastCell.businessName.text = business.name;
                    [pastCell.businessName sizeToFit];
                    [pastCell.businessImage setImageWithURL:business.imageURL];
                });
            }];
        }
        return pastCell;
    }
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if(collectionView == self.currentBookings){
        if(self.profile != nil && self.profile.currentBookingsArray != nil){
            return self.profile.currentBookingsArray.count;
        }else{
            return 0;
        }
    }else{
        if(self.profile != nil && self.profile.pastBookingsArray != nil){
            return self.profile.pastBookingsArray.count;
        }else{
            return 0;
        }
    }
}

- (void) parseHelper{
    PFQuery *query = [PFQuery queryWithClassName:@"UserInfo"];
    [query includeKey: @"username"];
    [query whereKey:@"username" equalTo:PFUser.currentUser.username];
    query.limit = 20;
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *profiles, NSError *error){
        if(profiles != nil){
            self.profile = profiles.firstObject;
            [self getCurrentandPastBookings];
            [self.currentBookings reloadData];
            [self.pastBookings reloadData];
            self.name.text = self.profile.name;
            self.joinDate.text = [@"Joined on " stringByAppendingString:self.profile.joinDate];
            self.profilePic.file = self.profile.image;
            [self.profilePic loadInBackground];
        }else{
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

- (void) refresh{
    [self.currentBookings reloadData];
    [self.pastBookings reloadData];
    [self parseHelper];
    [self.refreshControl endRefreshing];
}

- (void) getCurrentandPastBookings{
    NSDate *now = [NSDate date];
    for(int i = 0; i < self.profile.currentBookingsArray.count; i++){
        if([self.profile.timeOfBooking[i] intValue] < [[NSString stringWithFormat:@"%.0f", [now timeIntervalSince1970]] intValue]){
            if(self.profile.pastBookingsArray == nil){
                self.profile.pastBookingsArray = [NSMutableArray new];
                self.profile [@"pastBookingsArray"] = [NSMutableArray new];
            }
            if(self.profile.timeOfPastBooking == nil){
                self.profile.timeOfPastBooking = [NSMutableArray new];
                self.profile [@"timeOfPastBooking"] = [NSMutableArray new];
            }
            [self.profile.pastBookingsArray addObject:[self.profile.currentBookingsArray objectAtIndex:i]];
            self.profile [@"pastBookingsArray"] = self.profile.pastBookingsArray;
            [self.profile.timeOfPastBooking addObject:[self.profile.timeOfBooking objectAtIndex:i]];
            self.profile [@"timeOfPastBooking"] = self.profile.timeOfPastBooking;
            [self.profile.currentBookingsArray removeObjectAtIndex:i];
            self.profile [@"currentBookingsArray"] = self.profile.currentBookingsArray;
            [self.profile.timeOfBooking removeObjectAtIndex:i];
            self.profile [@"timeOfBooking"] = self.profile.timeOfBooking;
            i--;
        }
    }
}

- (void)alertBusiness:(YLPBusiness *)business index:(NSInteger)index{
    NSString *timeOfBooking = self.profile.timeOfPastBooking[index];
    double unixTimeStamp = [timeOfBooking doubleValue];
    NSTimeInterval _interval = unixTimeStamp;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *formatter= [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale currentLocale]];
    [formatter setDateFormat:@"MM-dd-yyyy"];
    NSString *dateString = [formatter stringFromDate:date];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle: business.name message:[NSString stringWithFormat:@"This restaurant was booked on %@", dateString] preferredStyle:UIAlertControllerStyleAlert];
    // create a cancel action
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    // add the cancel action to the alertController
    [alert addAction:cancelAction];
    // create an OK action
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"View Details" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UINavigationController  *navigationController = [storyboard instantiateViewControllerWithIdentifier:@"DetailsViewNavigationController"];
        DetailsViewController *detailsViewController = (DetailsViewController *)navigationController.topViewController;
        detailsViewController.business = business;
        detailsViewController.finalView = true;
        [self presentViewController:navigationController animated:YES completion:^{}];
    }];
    // add the OK action to the alert controller
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:^{}];
}

- (void)alertNewBusiness:(YLPBusiness *)business index:(NSInteger)index{
    NSString *timeOfBooking = self.profile.timeOfBooking[index];
    double unixTimeStamp = [timeOfBooking doubleValue];
    NSTimeInterval _interval = unixTimeStamp;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *formatter= [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale currentLocale]];
    [formatter setDateFormat:@"MM-dd-yyyy"];
    NSString *dateString = [formatter stringFromDate:date];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle: business.name message:[NSString stringWithFormat:@"This restaurant was booked on %@", dateString] preferredStyle:UIAlertControllerStyleAlert];
    // create a cancel action
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    // add the cancel action to the alertController
    [alert addAction:cancelAction];
    // create an OK action
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"View Details" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UINavigationController  *navigationController = [storyboard instantiateViewControllerWithIdentifier:@"DetailsViewNavigationController"];
        DetailsViewController *detailsViewController = (DetailsViewController *)navigationController.topViewController;
        detailsViewController.business = business;
        detailsViewController.finalView = true;
        [self presentViewController:navigationController animated:YES completion:^{}];
    }];
    // add the OK action to the alert controller
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:^{}];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    SettingsViewController *settingsViewController = [segue destinationViewController];
    settingsViewController.profile = self.profile;
}

@end
