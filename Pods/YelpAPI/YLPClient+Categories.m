//
//  YLPClient+Categories.m
//  YelpAPI
//
//  Created by rutvims on 7/14/21.
//

#import "YLPClient+Categories.h"
#import "YLPClientPrivate.h"
#import "YLPResponsePrivate.h"
#import "YLPSearch.h"


@implementation YLPClient (Categories)

- (NSURLRequest *)categoriesFilter {
    NSString *phoneSearchPath = @"/v3/categories/restaurants";
    return [self requestWithPath:phoneSearchPath];
}

- (void)categories:(NSString *)categories
              completionHandler:(YLPCategoriesCompletionHandler)completionHandler {
    NSURLRequest *req = [self categoriesFilter];
    
    [self queryWithRequest:req completionHandler:^(NSDictionary *responseDict, NSError *error) {
        if (error) {
            completionHandler(nil, error);
            
        } else {
            NSMutableArray<NSString *> *restaurantCategories = [[NSMutableArray alloc] init];
            for(NSDictionary *category in responseDict[@"categories"]){
                NSArray *parent_aliases = category[@"parent_aliases"];
                if([parent_aliases.firstObject isEqualToString:@"restaurants"]){
                    [restaurantCategories addObject:category[@"title"]];
                }
            }
        }
    }];
}

@end

