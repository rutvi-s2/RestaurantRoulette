//
//  RestaurantsViewController.h
//  RestaurantRoulette
//
//  Created by rutvims on 7/13/21.
//

#import <UIKit/UIKit.h>
#import <YelpAPI/YLPBusiness.h>

NS_ASSUME_NONNULL_BEGIN

@interface RestaurantsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) double radius;
@property (strong, nonatomic) NSString* price;
@property (strong, nonatomic) NSString* cuisine;
@property (nonatomic) NSUInteger time;
@property (strong, nonatomic) NSString* zipcode;
@property (strong, nonatomic) NSString *latitudeValue;
@property (strong, nonatomic) NSString *longtitudeValue;
@property (strong, nonatomic) NSMutableArray <NSString*> *cuisineFilter;
@property (strong, nonatomic) NSMutableArray <YLPBusiness *> *spinnerItems;

@end

NS_ASSUME_NONNULL_END
