//
//  ProfileViewController.h
//  RestaurantRoulette
//
//  Created by rutvims on 7/22/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProfileViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *profilePic;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *joinDate;
@property (weak, nonatomic) IBOutlet UICollectionView *pastBookings;
@property (weak, nonatomic) IBOutlet UICollectionView *currentBookings;
@property (weak, nonatomic) IBOutlet UILabel *bio;

@end

NS_ASSUME_NONNULL_END
