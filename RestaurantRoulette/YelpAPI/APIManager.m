//
//  APIManager.m
//  RestaurantRoulette
//
//  Created by rutvims on 7/13/21.
//

#import <Foundation/Foundation.h>
#import "APIManager.h"

@implementation APIManager

+ (YLPClient *)shared {
    APIManager *newManager = [APIManager new];
    newManager.client = [[YLPClient alloc] initWithAPIKey:@"9HPB1gbeS07fnj3rTnTa6GdJttqt2RuD3tFtqVogDowEk68EfuGAjjEZ5m8BYOCMyrWIUNfo0WyzfhbZRg9FkNYhg2x-Z3yHcnhzpteGdnf8OALDUaAcZpqfgeftYHYx"];
    return  newManager.client;
}

//- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    self.client = [[YLPClient alloc] initWithAPIKey:@"9HPB1gbeS07fnj3rTnTa6GdJttqt2RuD3tFtqVogDowEk68EfuGAjjEZ5m8BYOCMyrWIUNfo0WyzfhbZRg9FkNYhg2x-Z3yHcnhzpteGdnf8OALDUaAcZpqfgeftYHYx"];
//
//    return YES;
//}

@end
