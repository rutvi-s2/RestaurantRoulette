//
//  CardViewController.h
//  RestaurantRoulette
//
//  Created by rutvims on 7/29/21.
//

#import <UIKit/UIKit.h>
#import <YelpAPI/YLPSearch.h>

NS_ASSUME_NONNULL_BEGIN

@interface CardViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *location;
@property (strong, nonatomic) YLPSearch* search;
@property (weak, nonatomic) IBOutlet UIButton *goButton;
@property (weak, nonatomic) IBOutlet UILabel *enterLocationLabel;
@property (strong, nonatomic) NSMutableArray <YLPBusiness *> *keepBusinesses;
@property (strong, nonatomic) NSMutableArray <YLPBusiness *> *keepBusinessesTracker;
@property (strong, nonatomic) YLPBusiness *currentBusiness;
@property (weak, nonatomic) IBOutlet UIButton *continueButton;

@end

NS_ASSUME_NONNULL_END
