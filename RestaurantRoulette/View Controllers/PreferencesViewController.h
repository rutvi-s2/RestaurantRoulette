//
//  PreferencesViewController.h
//  RestaurantRoulette
//
//  Created by rutvims on 7/13/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PreferencesViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISlider *distanceSlider;
@property (weak, nonatomic) IBOutlet UISegmentedControl *priceControl;
@property (weak, nonatomic) IBOutlet UIDatePicker *timePicker;
@property (strong, nonatomic) NSString *zipcode;
@property (strong, nonatomic) NSString *latitudeValue;
@property (strong, nonatomic) NSString *longtitudeValue;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

NS_ASSUME_NONNULL_END
