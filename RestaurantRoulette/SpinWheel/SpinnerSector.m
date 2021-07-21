//
//  SpinnerSector.m
//  RestaurantRoulette
//
//  Created by rutvims on 7/21/21.
//

#import "SpinnerSector.h"

@implementation SpinnerSector

@synthesize minVal, maxVal, midVal, sector;

- (NSString *) description{
    return [NSString stringWithFormat:@"%i | %f, %f, %f", self.sector, self.minVal, self.midVal, self.maxVal];
}

@end
