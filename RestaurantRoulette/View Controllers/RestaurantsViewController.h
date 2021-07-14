//
//  RestaurantsViewController.h
//  RestaurantRoulette
//
//  Created by rutvims on 7/13/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RestaurantsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) double radius;
@property (strong, nonatomic) NSString* price;
@property (strong, nonatomic) NSString* cuisine;
@property (strong, nonatomic) NSString* time;
@property (strong, nonatomic) NSString* zipcode;
@end

NS_ASSUME_NONNULL_END
