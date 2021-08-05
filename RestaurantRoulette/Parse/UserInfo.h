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
@property (nonatomic, strong) NSMutableArray *timeOfBooking;
@property (nonatomic, strong) NSMutableArray *timeOfPastBooking;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) PFFileObject *image;
@property (nonatomic, strong) PFUser *userDetails;
@property (nonatomic, strong) NSString *bio;
@property (nonatomic, strong) NSString *joinDate;
@property (nonatomic, strong) NSMutableArray *likesArray;


+ (void) newUser: (NSString * _Nullable )name withCompletion: (PFBooleanResultBlock  _Nullable)completion;
- (PFFileObject *)getPFFileFromImage: (UIImage * _Nullable)image;

@end

NS_ASSUME_NONNULL_END
