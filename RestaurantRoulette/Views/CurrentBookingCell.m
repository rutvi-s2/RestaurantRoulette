//
//  CurrentBookingCell.m
//  RestaurantRoulette
//
//  Created by rutvims on 7/26/21.
//

#import "CurrentBookingCell.h"

@implementation CurrentBookingCell

- (IBAction)infoButtonPressed:(id)sender {
    [self.delegate alertNewBusiness:self.business index:self.index];
}

@end
