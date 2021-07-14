//
//  SelectViewController.m
//  RestaurantRoulette
//
//  Created by rutvims on 7/13/21.
//

#import "SelectViewController.h"
#import "PreferencesViewController.h"

@interface SelectViewController ()

@end

@implementation SelectViewController

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
    PreferencesViewController  *preferencesController = (PreferencesViewController*)navigationController.topViewController;
    preferencesController.zipcode = self.zipcodeText.text;
    
}


@end
