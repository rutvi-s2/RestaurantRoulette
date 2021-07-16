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

@interface PreferencesViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic) BOOL ready;
@property (strong, nonatomic) NSMutableArray<NSString *> *cuisineCategory;
@property (strong, nonatomic) NSMutableArray<NSString *> *cuisineAlias;
@property (strong, nonatomic) NSMutableArray<CategoryCell *> *allCuisineCells;

@end

@implementation PreferencesViewController

- (void)viewDidLoad {
    self.ready = false;
    [super viewDidLoad];
    self.allCuisineCells = [NSMutableArray new];
    self.cuisineCategory = [NSMutableArray new];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.cuisineCategory = [[APIManager shared] categories:@"restaurants" completionHandler:^
          (NSMutableArray<NSString *> *cuisineCategory, NSMutableArray<NSString *> *cuisineAlias, NSError *error){
             self.cuisineCategory = cuisineCategory;
             self.cuisineAlias = cuisineAlias;
             dispatch_async(dispatch_get_main_queue(), ^{[self.tableView reloadData];
                 NSLog(@"got data");
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
        cell.categoryLabel.text = [self.cuisineCategory objectAtIndex:indexPath.item];
        cell.categoryAlias = [self.cuisineAlias objectAtIndex:indexPath.item];
        [self.allCuisineCells addObject:cell];
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 193;
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
