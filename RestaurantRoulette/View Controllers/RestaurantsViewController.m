//
//  RestaurantsViewController.m
//  RestaurantRoulette
//
//  Created by rutvims on 7/13/21.
//

#import "RestaurantsViewController.h"
#import "APIManager.h"
#import "RestaurantCell.h"
#import <YelpAPI/YLPClient+Search.h>
#import <YelpAPI/YLPSortType.h>
#import <YelpAPI/YLPSearch.h>
#import <YelpAPI/YLPCategory.h>
#import <YelpAPI/YLPBusiness.h>
#import "UIImageView+AFNetworking.h"
#import "DetailsViewController.h"

@interface RestaurantsViewController () <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) YLPSearch *search;
@property (strong, nonatomic) NSMutableArray <NSString *> *categoriesNames;

@end

@implementation RestaurantsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    [[APIManager shared] searchWithLocation:self.zipcode term:nil limit:20 offset:0 sort:YLPSortTypeBestMatched price:self.price radiusFilter:(self.radius * 1600) openAt:0 categoryFilter: self.cuisineFilter completionHandler:^
     (YLPSearch *search, NSError *error){
        self.search = search;
        dispatch_async(dispatch_get_main_queue(), ^{[self.tableView reloadData];
        });
    }];
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
        cell.restaurantName.text = self.search.businesses[indexPath.item].name;
        [cell.restaurantImage setImageWithURL:self.search.businesses[indexPath.item].imageURL];
        self.categoriesNames = [NSMutableArray new];
        for(YLPCategory *category in self.search.businesses[indexPath.item].categories){
            [self.categoriesNames addObject:category.name];
        }
        cell.restaurantCategory.text = [self.categoriesNames componentsJoinedByString:@" / "];
        cell.restaurantDistance.text = [[NSString stringWithFormat:@"%.2f", (self.search.businesses[indexPath.item].distance / 1609.34)] stringByAppendingString:@" miles"];
        cell.restaurantPrice.text = self.search.businesses[indexPath.item].price;
        cell.restaurantRating.text = [[NSString stringWithFormat:@"%.1f", self.search.businesses[indexPath.item].rating] stringByAppendingString: @" / 5"];
        
    }
    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UITableViewCell *tappedCell = sender;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
    YLPBusiness *business = self.search.businesses[indexPath.item];
    
    DetailsViewController *detailsViewController = [segue destinationViewController];
    detailsViewController.business = business;
    
}

@end
