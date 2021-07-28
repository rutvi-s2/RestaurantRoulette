//
//  ReviewCell.h
//  RestaurantRoulette
//
//  Created by rutvims on 7/28/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ReviewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *user;
@property (weak, nonatomic) IBOutlet UILabel *timeCreated;
@property (weak, nonatomic) IBOutlet UILabel *excerpt;

@end

NS_ASSUME_NONNULL_END
