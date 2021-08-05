//
//  DetailsViewController.h
//  RestaurantRoulette
//
//  Created by rutvims on 7/19/21.
//

#import <UIKit/UIKit.h>
#import <YelpAPI/YLPBusiness.h>
#import <YLPReview.h>
#import "UserInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *restaurantImage;
@property (weak, nonatomic) IBOutlet UILabel *restaurantName;
@property (weak, nonatomic) IBOutlet UILabel *restaurantNumber;
@property (weak, nonatomic) IBOutlet UILabel *restaurantAddress;
@property (weak, nonatomic) IBOutlet UICollectionView *restaurantPhotos;
@property (weak, nonatomic) IBOutlet UITableView *restaurantReviews;
@property (strong, nonatomic) NSArray <YLPReview *> *reviews;
@property (strong, nonatomic) NSArray <NSString *> *photoURLs;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *DoneBarButton;
@property (nonatomic) BOOL finalView;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (strong, nonatomic) UserInfo *profile;

@property (strong, nonatomic) YLPBusiness *business;

@end

NS_ASSUME_NONNULL_END
