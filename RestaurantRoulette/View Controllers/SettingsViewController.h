//
//  SettingsViewController.h
//  RestaurantRoulette
//
//  Created by rutvims on 7/22/21.
//

#import <UIKit/UIKit.h>
#import "UserInfo.h"
#import <Parse/Parse.h>

@import Parse;

NS_ASSUME_NONNULL_BEGIN

@interface SettingsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *editProfilePic;
@property (weak, nonatomic) IBOutlet UITextField *nameChange;
@property (weak, nonatomic) IBOutlet UITextField *bioChange;
@property (weak, nonatomic) IBOutlet PFImageView *profilePic;
@property (strong,nonatomic) UserInfo *profile;

@end

NS_ASSUME_NONNULL_END
