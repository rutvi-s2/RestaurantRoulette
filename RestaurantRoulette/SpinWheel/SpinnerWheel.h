//
//  SpinnerWheel.h
//  RestaurantRoulette
//
//  Created by rutvims on 7/20/21.
//

#import <UIKit/UIKit.h>
#import "SpinnerProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface SpinnerWheel : UIControl

@property (weak) id <SpinnerProtocol> delegate;
@property (nonatomic, strong) UIView *container;
@property int numberOfWedges;

- (id) initWithFrame:(CGRect)frame andDelegate:(id)del withWedges: (int)wedgesNumber;
- (void) rotate;

@end

NS_ASSUME_NONNULL_END
