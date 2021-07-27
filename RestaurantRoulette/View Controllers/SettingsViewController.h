//
//  SettingsViewController.h
//  RestaurantRoulette
//
//  Created by rutvims on 7/22/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SettingsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *editProfilePic;
@property (weak, nonatomic) IBOutlet UITextField *nameChange;
@property (weak, nonatomic) IBOutlet UITextField *bioChange;
@property (weak, nonatomic) IBOutlet UISwitch *notifications;
@property (weak, nonatomic) IBOutlet UIImageView *profilePic;

@end

NS_ASSUME_NONNULL_END