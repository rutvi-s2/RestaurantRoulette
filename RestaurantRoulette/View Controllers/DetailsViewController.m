//
//  DetailsViewController.m
//  RestaurantRoulette
//
//  Created by rutvims on 7/19/21.
//

#import "DetailsViewController.h"
#import "PhotoMapViewController.h"
#import "UIImageView+AFNetworking.h"
#import "ReviewCell.h"
#import "RestaurantPhoto.h"
#import "APIManager.h"
#import <YelpAPI/YLPClient+Reviews.h>
#import <YelpAPI/YLPBusinessReviews.h>
#import <YelpAPI/YLPClient+Business.h>
#import <YelpAPI/YLPUser.h>
#import "RatingBar.h"

@interface DetailsViewController ()<UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.restaurantPhotos.delegate = self;
    self.restaurantPhotos.dataSource = self;
    self.restaurantReviews.delegate = self;
    self.restaurantReviews.dataSource = self;
    
    [[APIManager shared] businessWithId:self.business.identifier completionHandler:^(YLPBusiness * _Nullable business, NSError * _Nullable error) {
        self.business = business;
        dispatch_async(dispatch_get_main_queue(), ^{
            self.photoURLs = self.business.photos;
            [self.restaurantPhotos reloadData];
        });
    }];
    
    self.restaurantName.text = self.business.name;
    [self.restaurantImage setImageWithURL:self.business.imageURL];
    self.restaurantNumber.text = self.business.phone;
    self.restaurantAddress.text = [NSString stringWithFormat:@"%@, %@ %@, %@",self.business.location.address.firstObject,self.business.location.city, self.business.location.stateCode, self.business.location.postalCode];
    
    [[APIManager shared] reviewsForBusinessWithId:self.business.identifier completionHandler:^(YLPBusinessReviews * _Nullable reviews, NSError * _Nullable error) {
        self.reviews = reviews.reviews;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.restaurantReviews reloadData];
        });
    }];
//    RatingBar *bar = [[RatingBar alloc] initWithFrame:CGRectMake(16, 217, 180, 30)];
//    [self.view addSubview:bar];
//    bar.starNumber = 4.5;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.reviews.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ReviewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReviewCell" forIndexPath:indexPath];
    if (indexPath.item <= [self.reviews count]) {
        YLPReview *review = self.reviews[indexPath.item];
        cell.excerpt.text = review.excerpt;
        NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"MM/dd/yyyy"];
        cell.timeCreated.text = [formatter stringFromDate:review.timeCreated];
        cell.user.text = review.user.name;
    }
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.photoURLs.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    RestaurantPhoto *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RestaurantPhoto" forIndexPath:indexPath];
    if (indexPath.item <= [self.photoURLs count]) {
        NSURL *url = [NSURL URLWithString:self.photoURLs[indexPath.item]];
        [cell.restaurantPhoto setImageWithURL:url];
    }
    return cell;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    PhotoMapViewController *mapViewController = [segue destinationViewController];
    mapViewController.business = self.business;
}


@end
