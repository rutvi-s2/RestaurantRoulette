//
//  APIManager.h
//  RestaurantRoulette
//

#import <UIKit/UIKit.h>
#import <YLPClient.h>

@interface APIManager : UIResponder<UISceneDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) YLPClient *client;

+ (YLPClient *)shared;

@end

