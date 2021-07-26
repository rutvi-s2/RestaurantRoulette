//
//  SpinnerProtocol.h
//  RestaurantRoulette
//
//  Created by rutvims on 7/20/21.
//

#import <Foundation/Foundation.h>
#import <YelpAPI/YLPBusiness.h>

@protocol SpinnerProtocol <NSObject>

-(void) alertBusiness:(YLPBusiness *) business;

@end
