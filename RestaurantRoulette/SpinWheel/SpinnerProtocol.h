//
//  SpinnerProtocol.h
//  RestaurantRoulette
//
//  Created by rutvims on 7/20/21.
//

#import <Foundation/Foundation.h>

@protocol SpinnerProtocol <NSObject>

-(void) wheelValueChanged:(NSString *) newValue;

@end
