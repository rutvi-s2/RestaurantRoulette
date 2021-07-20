//
//  DetailsViewController.m
//  RestaurantRoulette
//
//  Created by rutvims on 7/19/21.
//

#import "DetailsViewController.h"
#import "PhotoMapViewController.h"
#import "UIImageView+AFNetworking.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.restaurantName.text = self.business.name;
    [self.restaurantImage setImageWithURL:self.business.URL];
    self.restaurantNumber.text = self.business.phone;
    self.restaurantAddress.text = [NSString stringWithFormat:@"%@, %@ %@, %@",self.business.location.address.firstObject,self.business.location.city, self.business.location.stateCode, self.business.location.postalCode];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    PhotoMapViewController *mapViewController = [segue destinationViewController];
    mapViewController.business = self.business;
}


@end
