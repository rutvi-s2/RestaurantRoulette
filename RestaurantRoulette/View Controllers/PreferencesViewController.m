//
//  PreferencesViewController.m
//  RestaurantRoulette
//
//  Created by rutvims on 7/13/21.
//

#import "PreferencesViewController.h"
#import "RestaurantsViewController.h"
#import "LoginViewController.h"
#import "APIManager.h"
#import "CategoryCell.h"
#import <YelpAPI/YLPClient+Search.h>
#import <YelpAPI/YLPSortType.h>
#import <YelpAPI/YLPSearch.h>
#import <YelpAPI/YLPBusiness.h>
#import <YelpAPI/YLPCategory.h>
#import <Parse/Parse.h>

@interface PreferencesViewController () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

@property (nonatomic) BOOL filtered;
@property (nonatomic) BOOL ready;
@property (strong, nonatomic) NSMutableArray<YLPCategory *> *cuisineCategory;
@property (strong, nonatomic) NSArray<YLPCategory *> *cuisineCategoryFiltered;

@end

@implementation PreferencesViewController

- (void)viewDidLoad {
    self.ready = false;
    self.filtered = false;
    [super viewDidLoad];
    self.cuisineCategory = [NSMutableArray new];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.searchBar.delegate = self;
    
    [[APIManager shared] categories:@"restaurants" completionHandler:^
          (NSMutableArray<YLPCategory *> *cuisineCategory, NSError *error){
             self.cuisineCategory = cuisineCategory;
             self.cuisineCategoryFiltered = self.cuisineCategory;
             dispatch_async(dispatch_get_main_queue(), ^{[self.tableView reloadData];
                 self.ready = true;
             });
         }];
}
- (IBAction)logoutPress:(id)sender {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        // PFUser.current() will now be nil
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LoginViewController *LoginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        [self presentViewController:LoginViewController animated:YES completion:^{
        }];
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CategoryCell" forIndexPath:indexPath];
    if (!self.ready) {
        cell.categoryLabel.text = @"";
    }
    else {
        cell.category = [self.cuisineCategoryFiltered objectAtIndex:indexPath.item];
        if(![self.cuisineCategoryFiltered objectAtIndex:indexPath.item].visited){
            [cell.checkboxButton setBackgroundImage:[UIImage imageNamed:@"checkbox_empty"] forState:UIControlStateNormal];
        }else{
            [cell.checkboxButton setBackgroundImage:[UIImage imageNamed:@"checkbox_checked"] forState:UIControlStateNormal];
        }
        cell.categoryLabel.text = [self.cuisineCategoryFiltered objectAtIndex:indexPath.item].name;
        cell.categoryAlias = [self.cuisineCategoryFiltered objectAtIndex:indexPath.item].alias;
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.cuisineCategoryFiltered.count;
}

-(void)searchBar: (UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if(searchText.length != 0){
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name CONTAINS %@", searchText];
        self.cuisineCategoryFiltered = [self.cuisineCategory filteredArrayUsingPredicate:predicate];
    }else{
        self.cuisineCategoryFiltered = self.cuisineCategory;
    }
    [self.tableView reloadData];
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
    restaurantController.cuisineFilter = [NSMutableArray new];
    for(YLPCategory *category in self.cuisineCategory){
        if (category.visited && ![restaurantController.cuisineFilter containsObject:category.alias]){
            [restaurantController.cuisineFilter addObject: category.alias];
        }
    }
}


@end
