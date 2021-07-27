//
//  SelectViewController.m
//  RestaurantRoulette
//
//  Created by rutvims on 7/13/21.
//

#import "SelectViewController.h"
#import "PreferencesViewController.h"

@interface SelectViewController () <CLLocationManagerDelegate>

@end

@implementation SelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)coordinateButton:(id)sender {
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager startUpdatingLocation];
    [self.locationManager requestWhenInUseAuthorization];
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *location = [locations lastObject];
    self.latitudeValue = [NSString stringWithFormat:@"%f", location.coordinate.latitude];
    self.longtitudeValue = [NSString stringWithFormat:@"%f", location.coordinate.longitude];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UINavigationController  *navigationController = [segue destinationViewController];
    PreferencesViewController  *preferencesController = (PreferencesViewController*)navigationController.topViewController;
    if([segue.identifier isEqualToString:@"SearchButton"]){
        preferencesController.zipcode = self.zipcodeText.text;
        preferencesController.latitudeValue = @"";
        preferencesController.longtitudeValue = @"";
    }else{
        preferencesController.latitudeValue = self.latitudeValue;
        preferencesController.longtitudeValue = self.longtitudeValue;
        preferencesController.zipcode = @"";
    }
}

@end
