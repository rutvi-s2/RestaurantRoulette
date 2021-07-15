//
//  YLPClient+Search.m
//  Pods
//
//  Created by David Chen on 1/22/16.
//
//

#import "YLPSearch.h"
#import "YLPClient+Search.h"
#import "YLPCoordinate.h"
#import "YLPQuery.h"
#import "YLPQueryPrivate.h"
#import "YLPResponsePrivate.h"
#import "YLPClientPrivate.h"

@implementation YLPClient (Search)

- (void)searchWithLocation:(NSString *)location
         completionHandler:(YLPSearchCompletionHandler)completionHandler {
    YLPQuery *query = [[YLPQuery alloc] initWithLocation:location];
    [self searchWithQuery:query completionHandler:completionHandler];
}

- (void)searchWithLocation:(NSString *)location
                      term:(NSString *)term
                     limit:(NSUInteger)limit
                    offset:(NSUInteger)offset
                      sort:(YLPSortType)sort
                     price:(NSString *)price
              radiusFilter: (double)radiusFilter
                    openAt:(NSUInteger)openAt
         completionHandler:(YLPSearchCompletionHandler)completionHandler {
    YLPQuery *query = [[YLPQuery alloc] initWithLocation:location];
    query.term = term;
    query.limit = limit;
    query.offset = offset;
    query.sort = sort;
    query.price = price;
    query.radiusFilter = radiusFilter;
    query.openAt = openAt;
//    query.categoryFilter = [self categories:@"restaurants" completionHandler:^
//                            (YLPSearch *search, NSError *error){}];
    [self searchWithQuery:query completionHandler:completionHandler];
}

- (void)searchWithCoordinate:(YLPCoordinate *)coordinate
                        term:(NSString *)term limit:(NSUInteger)limit
                      offset:(NSUInteger)offset
                        sort:(YLPSortType)sort
           completionHandler:(YLPSearchCompletionHandler)completionHandler {
    YLPQuery *query = [[YLPQuery alloc] initWithCoordinate:coordinate];
    query.term = term;
    query.limit = limit;
    query.offset = offset;
    query.sort = sort;
    [self searchWithQuery:query completionHandler:completionHandler];
}

- (void)searchWithCoordinate:(YLPCoordinate *)coordinate
           completionHandler:(YLPSearchCompletionHandler)completionHandler {
    YLPQuery *query = [[YLPQuery alloc] initWithCoordinate:coordinate];
    [self searchWithQuery:query completionHandler:completionHandler];
}

- (NSURLRequest *)searchRequestWithParams:(NSDictionary *)params {
    return [self requestWithPath:@"/v3/businesses/search" params:params];
}

- (void)searchWithQuery:(YLPQuery *)query
      completionHandler:(YLPSearchCompletionHandler)completionHandler {
    NSDictionary *params = [query parameters];
    NSURLRequest *req = [self searchRequestWithParams:params];
    
    [self queryWithRequest:req completionHandler:^(NSDictionary *responseDict, NSError *error) {
        if (error) {
            completionHandler(nil, error);
        } else {
            YLPSearch *search = [[YLPSearch alloc] initWithDictionary:responseDict];
            completionHandler(search, nil);
        }
        
    }];
}

- (NSURLRequest *)categoriesFilter {
    NSString *categoriesSearchPath = @"/v3/categories";
    return [self requestWithPath:categoriesSearchPath];
}

- (NSMutableArray<NSString *> *)categories:(NSString *)categories
              completionHandler:(YLPSearchCompletionHandler)completionHandler {
    NSURLRequest *req = [self categoriesFilter];
    NSMutableArray<NSString *> *restaurantCategoriesTwo = [[NSMutableArray alloc] init];
    [self queryWithRequest:req completionHandler:^(NSDictionary *responseDict, NSError *error) {
        if (error) {
            completionHandler(nil, error);
        } else {
            for(NSDictionary *category in responseDict[@"categories"]){
                NSArray *parent_aliases = category[@"parent_aliases"];
                if([parent_aliases.firstObject isEqualToString:@"restaurants"]){
                    [restaurantCategoriesTwo addObject:category[@"title"]];
                }
            }
        }
    }];
    return restaurantCategoriesTwo;
}

@end

