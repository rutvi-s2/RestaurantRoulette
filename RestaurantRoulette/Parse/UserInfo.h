//
//  UserInfo.h
//  RestaurantRoulette
//
//  Created by rutvims on 7/23/21.
//

#import <Parse/Parse.h>
#import <Foundation/Foundation.h>
#import <YelpAPI/YLPBusiness.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserInfo : PFObject <PFSubclassing>

@property (nonatomic, strong) NSMutableArray *pastBookingsArray;
@property (nonatomic, strong) NSMutableArray *currentBookingsArray;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) PFFileObject *image;
@property (nonatomic, strong) PFUser *userDetails;
@property (nonatomic, strong) NSString *bio;


+ (void) newUser: (NSString * _Nullable )username withCompletion: (PFBooleanResultBlock  _Nullable)completion;
- (void) updatePastArray: (YLPBusiness *) business;

@end

NS_ASSUME_NONNULL_END
