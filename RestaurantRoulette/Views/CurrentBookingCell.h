//
//  CurrentBookingCell.h
//  RestaurantRoulette
//
//  Created by rutvims on 7/26/21.
//

#import <UIKit/UIKit.h>
#import <YelpAPI/YLPBusiness.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CurrentBookingDelegate

- (void) alertNewBusiness:(YLPBusiness *)business index:(NSInteger)index;

@end

@interface CurrentBookingCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *businessImage;
@property (weak, nonatomic) IBOutlet UILabel *businessName;
@property (strong, nonatomic) YLPBusiness *business;
@property (nonatomic, weak) id<CurrentBookingDelegate> delegate;
@property (nonatomic) NSInteger index;


@end

NS_ASSUME_NONNULL_END
