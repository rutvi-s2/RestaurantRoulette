//
//  RestaurantsViewController.m
//  RestaurantRoulette
//
//  Created by rutvims on 7/13/21.
//

#import "RestaurantsViewController.h"
#import "APIManager.h"
#import "RestaurantCell.h"
#import <YelpAPI/YLPCoordinate.h>
#import <YelpAPI/YLPClient+Search.h>
#import <YelpAPI/YLPSortType.h>
#import <YelpAPI/YLPSearch.h>
#import <YelpAPI/YLPCategory.h>
#import <YelpAPI/YLPClient+Business.h>
#import <YelpAPI/YLPUser.h>
#import "UIImageView+AFNetworking.h"
#import "DetailsViewController.h"
#import "SpinnerViewController.h"

@interface RestaurantsViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation RestaurantsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.businesses = [NSArray new];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    if(!self.nonfavoriteTab){
        [self favoritesHelper];
    }else{
        if (!self.card){
            int const meterConversion = 1600;
            if([self.zipcode isEqualToString:@""]){
                YLPCoordinate *const myCoordinate = [[YLPCoordinate alloc] initWithLatitude:[self.latitudeValue doubleValue] longitude:[self.longtitudeValue doubleValue]];
                [[APIManager shared] searchWithCoordinate:myCoordinate term:nil limit:20 offset:0 sort:YLPSortTypeBestMatched price:self.price radiusFilter:(self.radius * meterConversion) openAt:self.time categoryFilter:self.cuisineFilter completionHandler:^(YLPSearch * _Nullable search, NSError * _Nullable error) {
                    self.search = search;
                    if(self.search.businesses.count == 0){
                        [self alertHelper:@"No restaurants available!"];
                    }
                    self.businesses = self.search.businesses;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.tableView reloadData];
                    });
                }];
            }else{
                [[APIManager shared] searchWithLocation:self.zipcode term:nil limit:20 offset:0 sort:YLPSortTypeBestMatched price:self.price radiusFilter:(self.radius * meterConversion) openAt:self.time categoryFilter: self.cuisineFilter completionHandler:^
                 (YLPSearch *search, NSError *error){
                    self.search = search;
                    if(self.search.businesses.count == 0){
                        [self alertHelper:@"No restaurants available!"];
                    }
                    self.businesses = self.search.businesses;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.tableView reloadData];
                    });
                }];
            }
        }else{
            self.search = self.cardSearch;
            self.businesses = self.search.businesses;
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.businesses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RestaurantCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RestaurantCell" forIndexPath:indexPath];
    if (indexPath.item > [self.businesses count]) {
        cell.restaurantName.text = @"";
    }
    else {
        cell.business = [self.businesses objectAtIndex:indexPath.item];
        if(![self.businesses objectAtIndex:indexPath.item].visited){
            [cell.checkboxButton setBackgroundImage:[UIImage imageNamed:@"checkbox_empty"] forState:UIControlStateNormal];
        }else{
            [cell.checkboxButton setBackgroundImage:[UIImage imageNamed:@"checkbox_checked"] forState:UIControlStateNormal];
        }
        cell.restaurantName.text = self.businesses[indexPath.item].name;
        [cell.restaurantImage setImageWithURL:self.businesses[indexPath.item].imageURL];
        self.categoriesNames = [NSMutableArray new];
        for(YLPCategory *category in self.businesses[indexPath.item].categories){
            [self.categoriesNames addObject:category.name];
        }
        double const milesConversion = 1609.34;
        cell.restaurantCategory.text = [self.categoriesNames componentsJoinedByString:@" / "];
        cell.restaurantDistance.text = [[NSString stringWithFormat:@"%.2f", (self.businesses[indexPath.item].distance / milesConversion)] stringByAppendingString:@" miles"];
        cell.restaurantPrice.text = self.businesses[indexPath.item].price;
        cell.restaurantRating.text = [[NSString stringWithFormat:@"%.1f", self.businesses[indexPath.item].rating] stringByAppendingString: @" / 5"];
        
    }
    return cell;
}
- (IBAction)confirmButtonPress:(id)sender {
    self.spinnerItems = [NSMutableArray new];
    for (YLPBusiness *business in self.businesses){
        if (business.visited){
            [self.spinnerItems addObject:business];
        }
    }
    if(self.spinnerItems.count == 0){
        [self alertHelper:@"No restaurants chosen!"];
    }
}

- (void) alertHelper : (NSString *)warning{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Warning" message: warning preferredStyle:UIAlertControllerStyleAlert];
    // create a cancel action
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:^{}];
    }];
    // add the cancel action to the alertController
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:^{}];
}

- (void) favoritesHelper{
    PFQuery *query = [PFQuery queryWithClassName:@"UserInfo"];
    [query includeKey: @"username"];
    [query whereKey:@"username" equalTo:PFUser.currentUser.username];
    query.limit = 20;
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *profiles, NSError *error){
        if(profiles != nil){
            self.profile = profiles.firstObject;
            [self favoritesListHelper];
        }else{
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

- (void) favoritesListHelper{
    NSMutableArray *newArray = [NSMutableArray new];
    int __block counter = 0;
    for(NSString *businessID in self.profile [@"likesArray"]){
        [[APIManager shared] businessWithId:businessID completionHandler:^(YLPBusiness * _Nullable business, NSError * _Nullable error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [newArray addObject:business];
                if (counter == self.profile.likesArray.count - 1){
                    self.businesses = newArray;
                    [self.tableView reloadData];
                }
                counter++;
            });
        }];
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"restaurantDetails"]){
        UITableViewCell *tappedCell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
        YLPBusiness *business = self.businesses[indexPath.item];
        DetailsViewController *detailsViewController = [segue destinationViewController];
        detailsViewController.business = business;
        detailsViewController.finalView = false;
    }else{
        SpinnerViewController *spinner = [segue destinationViewController];
        spinner.spinnerItems = self.spinnerItems;
        spinner.timeTracker = self.timeTracker;
    }
    
}

@end
