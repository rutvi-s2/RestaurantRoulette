//
//  PastBookingCell.h
//  RestaurantRoulette
//
//  Created by rutvims on 7/26/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PastBookingCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *businessImage;
@property (weak, nonatomic) IBOutlet UILabel *businessName;

@end

NS_ASSUME_NONNULL_END
