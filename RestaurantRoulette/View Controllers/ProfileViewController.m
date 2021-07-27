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
    self.pastBookings.delegate = self;
    self.pastBookings.dataSource = self;
    self.currentBookings.delegate = self;
    self.currentBookings.dataSource = self;
    [self parseHelper];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
//    PastBookingCell *pastCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PastBookingCell" forIndexPath:indexPath];
    CurrentBookingCell *currentCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CurrentBookingCell" forIndexPath:indexPath];
    if(self.profile != nil && self.profile.currentBookingsArray != nil){
        NSString *businessID = self.profile.currentBookingsArray[indexPath.row];
        [[APIManager shared] businessWithId:businessID completionHandler:^(YLPBusiness * _Nullable business, NSError * _Nullable error) {
            currentCell.businessName.text = business.name;
            [currentCell.businessImage setImageWithURL:business.imageURL];
        }];
    }
    return currentCell;
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
            [self.currentBookings reloadData];
            self.name.text = self.profile.name;
            self.joinDate.text = [@"Joined on " stringByAppendingString:self.profile.joinDate];
        }else{
            NSLog(@"%@", error.localizedDescription);
        }
    }];
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
