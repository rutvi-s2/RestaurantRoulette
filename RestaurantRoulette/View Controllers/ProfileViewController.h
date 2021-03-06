//
//  ProfileViewController.h
//  RestaurantRoulette
//
//  Created by rutvims on 7/22/21.
//

#import <UIKit/UIKit.h>
#import "UserInfo.h"
#import <Parse/Parse.h>

@import Parse;

NS_ASSUME_NONNULL_BEGIN

@interface ProfileViewController : UIViewController

@property (weak, nonatomic) IBOutlet PFImageView *profilePic;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *joinDate;
@property (weak, nonatomic) IBOutlet UICollectionView *pastBookings;
@property (weak, nonatomic) IBOutlet UICollectionView *currentBookings;
@property (strong, nonatomic) UserInfo *profile;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

NS_ASSUME_NONNULL_END
