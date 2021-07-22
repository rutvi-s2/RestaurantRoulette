//
//  RestaurantCell.h
//  RestaurantRoulette
//
//  Created by rutvims on 7/13/21.
//

#import <UIKit/UIKit.h>
#import <YelpAPI/YLPBusiness.h>

NS_ASSUME_NONNULL_BEGIN

@interface RestaurantCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *restaurantImage;
@property (weak, nonatomic) IBOutlet UILabel *restaurantName;
@property (weak, nonatomic) IBOutlet UILabel *restaurantPrice;
@property (weak, nonatomic) IBOutlet UILabel *restaurantCategory;
@property (weak, nonatomic) IBOutlet UILabel *restaurantDistance;
@property (weak, nonatomic) IBOutlet UILabel *restaurantRating;
@property (weak, nonatomic) IBOutlet UIButton *checkboxButton;
@property (strong, nonatomic) YLPBusiness *business;

@end

NS_ASSUME_NONNULL_END
