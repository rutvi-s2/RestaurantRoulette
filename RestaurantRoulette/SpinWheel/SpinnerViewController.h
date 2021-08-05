//
//  SpinnerViewController.h
//  RestaurantRoulette
//
//  Created by rutvims on 7/19/21.
//

#import <UIKit/UIKit.h>
#import "SpinnerProtocol.h"
#import <YelpAPI/YLPBusiness.h>
#import "UserInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface SpinnerViewController : UIViewController<SpinnerProtocol>

@property (strong, nonatomic) NSMutableArray <YLPBusiness *> *spinnerItems;
@property (strong, nonatomic) NSString *timeTracker;
@property (strong, nonatomic) UserInfo *profile;
@property (weak, nonatomic) IBOutlet UIImageView *background;
@property (weak, nonatomic) IBOutlet UIImageView *yellowArrow;

@end

NS_ASSUME_NONNULL_END
