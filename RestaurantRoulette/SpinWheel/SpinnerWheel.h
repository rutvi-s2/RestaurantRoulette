//
//  SpinnerWheel.h
//  RestaurantRoulette
//
//  Created by rutvims on 7/20/21.
//

#import <UIKit/UIKit.h>
#import "SpinnerProtocol.h"
#import "SpinnerSector.h"
#import <YelpAPI/YLPBusiness.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SpinnerWheelDelegate

- (void) alertBusiness:(YLPBusiness *)business;

@end

@interface SpinnerWheel : UIControl

@property (weak) id <SpinnerProtocol> delegate;
@property (nonatomic, strong) UIView *container;
@property int numberOfWedges;
@property CGAffineTransform startTransform;
@property (nonatomic, strong) NSMutableArray *sectors;
@property int currentSector;
@property (strong, nonatomic) NSMutableArray <YLPBusiness *> *spinnerItems;

- (id) initWithFrame:(CGRect)frame andDelegate:(id)del withWedges: (int)wedgesNumber withItems: (NSMutableArray <YLPBusiness *> *)spinnerItems;
- (void) rotate;

@end

NS_ASSUME_NONNULL_END
