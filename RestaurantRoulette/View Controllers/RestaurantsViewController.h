//
//  RestaurantsViewController.h
//  RestaurantRoulette
//
//  Created by rutvims on 7/13/21.
//

#import <UIKit/UIKit.h>
#import <YelpAPI/YLPBusiness.h>
#import <YelpAPI/YLPSearch.h>

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
@property (strong, nonatomic) NSString *timeTracker;
@property (nonatomic) BOOL card;
@property (strong, nonatomic) YLPSearch *search;
@property (strong, nonatomic) NSMutableArray <NSString *> *categoriesNames;
@property (strong, nonatomic) YLPSearch *cardSearch;

@end

NS_ASSUME_NONNULL_END
