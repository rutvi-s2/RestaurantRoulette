//
//  CategoryCell.h
//  RestaurantRoulette
//
//  Created by rutvims on 7/15/21.
//

#import <UIKit/UIKit.h>
#import <YelpAPI/YLPCategory.h>

NS_ASSUME_NONNULL_BEGIN

@interface CategoryCell : UITableViewCell

@property (strong, nonatomic) YLPCategory *category;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UIButton *checkboxButton;
@property (strong, nonatomic) NSString *categoryAlias;

@end

NS_ASSUME_NONNULL_END
