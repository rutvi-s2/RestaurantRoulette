//
//  PreferencesViewController.m
//  RestaurantRoulette
//
//  Created by rutvims on 7/13/21.
//

#import "PreferencesViewController.h"
#import "RestaurantsViewController.h"
#import "APIManager.h"
#import "CategoryCell.h"
#import <YelpAPI/YLPClient+Search.h>
#import <YelpAPI/YLPSortType.h>
#import <YelpAPI/YLPSearch.h>
#import <YelpAPI/YLPBusiness.h>
#import <YelpAPI/YLPCategory.h>

@interface PreferencesViewController () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

@property (nonatomic) BOOL filtered;
@property (nonatomic) BOOL ready;
@property (strong, nonatomic) NSMutableArray<YLPCategory *> *cuisineCategory;
@property (strong, nonatomic) NSArray<YLPCategory *> *cuisineCategoryFiltered;
@property (strong, nonatomic) NSMutableArray<CategoryCell *> *allCuisineCells;

@end

@implementation PreferencesViewController

- (void)viewDidLoad {
    self.ready = false;
    self.filtered = false;
    [super viewDidLoad];
    self.allCuisineCells = [NSMutableArray new];
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CategoryCell" forIndexPath:indexPath];
    if (!self.ready) {
        cell.categoryLabel.text = @"";
    }
    else {
        [cell.checkboxButton setBackgroundImage:[UIImage imageNamed:@"checkbox_empty"] forState:UIControlStateNormal];
        cell.categoryLabel.text = [self.cuisineCategoryFiltered objectAtIndex:indexPath.item].name;
        cell.categoryAlias = [self.cuisineCategoryFiltered objectAtIndex:indexPath.item].alias;
        [self.allCuisineCells addObject:cell];
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
    for(CategoryCell *cell in self.allCuisineCells){
        if ([[cell.checkboxButton currentBackgroundImage] isEqual: [UIImage imageNamed:@"checkbox_checked"]] && ![restaurantController.cuisineFilter containsObject:cell.categoryAlias]){
            [restaurantController.cuisineFilter addObject: cell.categoryAlias];
        }
    }
}


@end
