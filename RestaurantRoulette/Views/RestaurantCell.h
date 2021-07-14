//
//  RestaurantCell.h
//  RestaurantRoulette
//
//  Created by rutvims on 7/13/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RestaurantCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *restaurantImage;
@property (weak, nonatomic) IBOutlet UILabel *restaurantName;

@end

NS_ASSUME_NONNULL_END
