//
//  UserInfo.m
//  RestaurantRoulette
//
//  Created by rutvims on 7/23/21.
//

#import "UserInfo.h"
#import "SpinnerViewController.h"

@implementation UserInfo

@dynamic username;
@dynamic name;
@dynamic image;
@dynamic bio;
@dynamic pastBookingsArray;
@dynamic currentBookingsArray;
@dynamic userDetails;


+ (nonnull NSString *)parseClassName {
    return @"UserInfo";
}

+ (void) newUser: (NSString * _Nullable )username withCompletion: (PFBooleanResultBlock  _Nullable)completion {
    
    UserInfo *newUser = [UserInfo new];
    newUser.username = [PFUser currentUser].username;
    newUser.userDetails = [PFUser currentUser];
    
    [newUser saveInBackgroundWithBlock: completion];
}

- (void) updatePastArray:(YLPBusiness *)business{
    
}


@end
