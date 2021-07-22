//
//  SpinnerViewController.h
//  RestaurantRoulette
//
//  Created by rutvims on 7/19/21.
//

#import <UIKit/UIKit.h>
#import "SpinnerProtocol.h"
#import <YelpAPI/YLPBusiness.h>

NS_ASSUME_NONNULL_BEGIN

@interface SpinnerViewController : UIViewController<SpinnerProtocol>

@property (weak, nonatomic) IBOutlet UILabel *sectorLabel;
@property (strong, nonatomic) NSMutableArray <YLPBusiness *> *spinnerItems;

@end

NS_ASSUME_NONNULL_END
