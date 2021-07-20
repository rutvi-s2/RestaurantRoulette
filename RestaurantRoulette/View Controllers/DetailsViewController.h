//
//  DetailsViewController.h
//  RestaurantRoulette
//
//  Created by rutvims on 7/19/21.
//

#import <UIKit/UIKit.h>
#import <YelpAPI/YLPBusiness.h>

NS_ASSUME_NONNULL_BEGIN

@interface DetailsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *restaurantImage;
@property (weak, nonatomic) IBOutlet UILabel *restaurantName;
@property (weak, nonatomic) IBOutlet UILabel *restaurantNumber;
@property (weak, nonatomic) IBOutlet UILabel *restaurantAddress;

@property (strong, nonatomic) YLPBusiness *business;

@end

NS_ASSUME_NONNULL_END
