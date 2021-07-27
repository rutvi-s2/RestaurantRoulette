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
@dynamic joinDate;


+ (nonnull NSString *)parseClassName {
    return @"UserInfo";
}

+ (void) newUser: (NSString * _Nullable)name withCompletion: (PFBooleanResultBlock  _Nullable)completion {
    
    UserInfo *newUser = [UserInfo new];
    newUser.username = [PFUser currentUser].username;
    newUser.userDetails = [PFUser currentUser];
    newUser.name = name;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    newUser.joinDate = [formatter stringFromDate:[PFUser currentUser].createdAt];
    
    [newUser saveInBackgroundWithBlock: completion];
}

- (void) updatePastArray:(YLPBusiness *)business{
    
}


@end
