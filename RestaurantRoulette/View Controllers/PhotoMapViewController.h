//
//  PhotoMapViewController.h
//  RestaurantRoulette
//
//  Created by rutvims on 7/20/21.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <YelpAPI/YLPBusiness.h>
#import <YelpAPI/YLPLocation.h>
#import <YelpAPI/YLPCoordinate.h>

NS_ASSUME_NONNULL_BEGIN

@interface PhotoMapViewController : UIViewController

@property (strong, nonatomic) YLPBusiness *business;
@property (weak, nonatomic) IBOutlet UIImageView *mapFrame;
@property (weak, nonatomic) IBOutlet UILabel *hoursLabel;

@end

NS_ASSUME_NONNULL_END
