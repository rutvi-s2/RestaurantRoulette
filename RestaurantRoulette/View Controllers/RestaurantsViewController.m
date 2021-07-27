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
#import "UIImageView+AFNetworking.h"
#import "DetailsViewController.h"
#import "SpinnerViewController.h"

@interface RestaurantsViewController () <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) YLPSearch *search;
@property (strong, nonatomic) NSMutableArray <NSString *> *categoriesNames;

@end

@implementation RestaurantsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    int meterConversion = 1600;
    if([self.zipcode isEqualToString:@""]){
        YLPCoordinate *myCoordinate = [[YLPCoordinate alloc] initWithLatitude:[self.latitudeValue doubleValue] longitude:[self.longtitudeValue doubleValue]];
        [[APIManager shared] searchWithCoordinate:myCoordinate term:nil limit:20 offset:0 sort:YLPSortTypeBestMatched price:self.price radiusFilter:(self.radius * meterConversion) openAt:self.time categoryFilter:self.cuisineFilter completionHandler:^(YLPSearch * _Nullable search, NSError * _Nullable error) {
            self.search = search;
            if(self.search.businesses.count == 0){
                [self alertHelper:@"No restaurants available!"];
            }
            dispatch_async(dispatch_get_main_queue(), ^{[self.tableView reloadData];
            });
        }];
    }else{
        [[APIManager shared] searchWithLocation:self.zipcode term:nil limit:20 offset:0 sort:YLPSortTypeBestMatched price:self.price radiusFilter:(self.radius * meterConversion) openAt:self.time categoryFilter: self.cuisineFilter completionHandler:^
         (YLPSearch *search, NSError *error){
            self.search = search;
            if(self.search.businesses.count == 0){
                [self alertHelper:@"No restaurants available!"];
            }
            dispatch_async(dispatch_get_main_queue(), ^{[self.tableView reloadData];
            });
        }];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.search.businesses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RestaurantCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RestaurantCell" forIndexPath:indexPath];
    if (indexPath.item > [self.search.businesses count]) {
        cell.restaurantName.text = @"";
    }
    else {
        cell.business = [self.search.businesses objectAtIndex:indexPath.item];
        if(![self.search.businesses objectAtIndex:indexPath.item].visited){
            [cell.checkboxButton setBackgroundImage:[UIImage imageNamed:@"checkbox_empty"] forState:UIControlStateNormal];
        }else{
            [cell.checkboxButton setBackgroundImage:[UIImage imageNamed:@"checkbox_checked"] forState:UIControlStateNormal];
        }
        cell.restaurantName.text = self.search.businesses[indexPath.item].name;
        [cell.restaurantImage setImageWithURL:self.search.businesses[indexPath.item].imageURL];
        self.categoriesNames = [NSMutableArray new];
        for(YLPCategory *category in self.search.businesses[indexPath.item].categories){
            [self.categoriesNames addObject:category.name];
        }
        double milesConversion = 1609.34;
        cell.restaurantCategory.text = [self.categoriesNames componentsJoinedByString:@" / "];
        cell.restaurantDistance.text = [[NSString stringWithFormat:@"%.2f", (self.search.businesses[indexPath.item].distance / milesConversion)] stringByAppendingString:@" miles"];
        cell.restaurantPrice.text = self.search.businesses[indexPath.item].price;
        cell.restaurantRating.text = [[NSString stringWithFormat:@"%.1f", self.search.businesses[indexPath.item].rating] stringByAppendingString: @" / 5"];
        
    }
    return cell;
}
- (IBAction)confirmButtonPress:(id)sender {
    self.spinnerItems = [NSMutableArray new];
    for (YLPBusiness *business in self.search.businesses){
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

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"restaurantDetails"]){
        UITableViewCell *tappedCell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
        YLPBusiness *business = self.search.businesses[indexPath.item];
        
        DetailsViewController *detailsViewController = [segue destinationViewController];
        detailsViewController.business = business;
    }else{
        SpinnerViewController *spinner = [segue destinationViewController];
        spinner.spinnerItems = self.spinnerItems;
    }
    
}

@end
