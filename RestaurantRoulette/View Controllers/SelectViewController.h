//
//  SelectViewController.h
//  RestaurantRoulette
//
//  Created by rutvims on 7/13/21.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SelectViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *zipcodeText;
@property (strong, nonatomic) NSString *latitudeValue;
@property (strong, nonatomic) NSString *longtitudeValue;
@property (nonatomic,strong) CLLocationManager *locationManager;

@end

NS_ASSUME_NONNULL_END
