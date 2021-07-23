//
//  UserInfo.h
//  RestaurantRoulette
//
//  Created by rutvims on 7/23/21.
//

#import <Parse/Parse.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserInfo : PFObject <PFSubclassing>

@property (nonatomic, strong) NSMutableArray *pastBookingsArray;
@property (nonatomic, strong) NSMutableArray *currentBookingsArray;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *username;

+ (void) newUser: (NSString * _Nullable )username withCompletion: (PFBooleanResultBlock  _Nullable)completion;

@end

NS_ASSUME_NONNULL_END
