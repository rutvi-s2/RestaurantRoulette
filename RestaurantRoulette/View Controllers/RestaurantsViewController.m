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
#import <YelpAPI/YLPClient+Categories.h>
#import <YelpAPI/YLPSortType.h>
#import <YelpAPI/YLPSearch.h>
#import <YelpAPI/YLPBusiness.h>


@interface RestaurantsViewController () <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) YLPSearch *search;
@end

@implementation RestaurantsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [APIManager shared]
//    [[APIManager shared] searchWithLocation:self.zipcode term:nil limit:20 offset:0 sort:YLPSortTypeBestMatched price:self.price radiusFilter:(self.radius * 1600) completionHandler:^
//     (YLPSearch *search, NSError *error){
//        self.search = search;
//        dispatch_async(dispatch_get_main_queue(), ^{[self.tableView reloadData];
//
//        });
//    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RestaurantCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RestaurantCell" forIndexPath:indexPath];
    if (indexPath.item > [self.search.businesses count]) {
        cell.restaurantName.text = @"";
    }
    else {
        cell.restaurantName.text = self.search.businesses[indexPath.item].name;
    }
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
