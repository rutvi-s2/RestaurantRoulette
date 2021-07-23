//
//  UserInfo.m
//  RestaurantRoulette
//
//  Created by rutvims on 7/23/21.
//

#import "UserInfo.h"

@implementation UserInfo

@dynamic username;
@dynamic name;
@dynamic pastBookingsArray;
@dynamic currentBookingsArray;


+ (nonnull NSString *)parseClassName {
    return @"UserInfo";
}

+ (void) newUser: (NSString * _Nullable )username withCompletion: (PFBooleanResultBlock  _Nullable)completion {
    
    UserInfo *newUser = [UserInfo new];
    newUser.username = [PFUser currentUser].username;
    
    [newUser saveInBackgroundWithBlock: completion];
}
@end
