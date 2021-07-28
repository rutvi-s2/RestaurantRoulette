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

@interface ProfileViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

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
            NSString *businessID = self.profile.currentBookingsArray[indexPath.row];
            [[APIManager shared] businessWithId:businessID completionHandler:^(YLPBusiness * _Nullable business, NSError * _Nullable error) {
                dispatch_async(dispatch_get_main_queue(), ^{
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
            NSString *businessID = self.profile.pastBookingsArray[indexPath.row];
            [[APIManager shared] businessWithId:businessID completionHandler:^(YLPBusiness * _Nullable business, NSError * _Nullable error) {
                dispatch_async(dispatch_get_main_queue(), ^{
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
    if(self.profile != nil && self.profile.currentBookingsArray != nil){
        return self.profile.currentBookingsArray.count;
    }else{
        return 0;
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
                self.profile.pastBookingsArray= [NSMutableArray new];
            }
            [self.profile.pastBookingsArray addObject:[self.profile.currentBookingsArray objectAtIndex:i]];
            self.profile [@"pastBookingsArray"] = self.profile.pastBookingsArray;
            [self.profile.currentBookingsArray removeObjectAtIndex:i];
            [self.profile.timeOfBooking removeObjectAtIndex:i];
            i--;
        }
    }
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
@end
