//
//  PreferencesViewController.m
//  RestaurantRoulette
//
//  Created by rutvims on 7/13/21.
//

#import "PreferencesViewController.h"
#import "RestaurantsViewController.h"

@interface PreferencesViewController ()

@end

@implementation PreferencesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    UINavigationController  *navigationController = [segue destinationViewController];
    RestaurantsViewController  *restaurantController = (RestaurantsViewController*)navigationController.topViewController;
    restaurantController.radius = (double) self.distanceSlider.value;
    NSArray *prices = [NSArray arrayWithObjects:@"1",@"2",@"3",@"4",nil];
    restaurantController.price = prices[self.priceControl.selectedSegmentIndex];
    restaurantController.zipcode = self.zipcode;
}


@end
