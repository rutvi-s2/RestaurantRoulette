//
//  PastBookingCell.m
//  RestaurantRoulette
//
//  Created by rutvims on 7/26/21.
//

#import "PastBookingCell.h"
#import "DetailsViewController.h"
#import <Foundation/Foundation.h>

@implementation PastBookingCell

- (IBAction)infoButtonPressed:(id)sender {
    [self.delegate alertBusiness:self.business index:self.index];
}

@end
