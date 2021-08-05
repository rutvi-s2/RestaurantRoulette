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
@dynamic timeOfBooking;
@dynamic timeOfPastBooking;
@dynamic likesArray;


+ (nonnull NSString *)parseClassName {
    return @"UserInfo";
}

+ (void) newUser: (UIImage * _Nullable)image name: (NSString * _Nullable)name withCompletion: (PFBooleanResultBlock  _Nullable)completion {
    
    UserInfo *newUser = [UserInfo new];
    newUser.username = [PFUser currentUser].username;
    newUser.userDetails = [PFUser currentUser];
    newUser.name = name;
    newUser.image = [self getPFFileFromImageHelper:image];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd-yyyy"];
    newUser.joinDate = [formatter stringFromDate:[PFUser currentUser].createdAt];
    
    [newUser saveInBackgroundWithBlock: completion];
}

- (PFFileObject *)getPFFileFromImage: (UIImage * _Nullable)image {
    // check if image is not nil
    if (!image) {
        return nil;
    }
    
    NSData *imageData = UIImagePNGRepresentation(image);
    // get image data and check if that is not nil
    if (!imageData) {
        return nil;
    }
    
    return [PFFileObject fileObjectWithName:@"image.png" data:imageData];
}

+ (PFFileObject *)getPFFileFromImageHelper: (UIImage * _Nullable)image{
       // check if image is not nil
       if (!image) {
           return nil;
       }
       
       NSData *imageData = UIImagePNGRepresentation(image);
       // get image data and check if that is not nil
       if (!imageData) {
           return nil;
       }
       
       return [PFFileObject fileObjectWithName:@"image.png" data:imageData];
}

@end
