//
//  YLPClient+Search.h
//  Pods
//
//  Created by David Chen on 1/22/16.
//
//

#import "YLPClient.h"
#import "YLPSortType.h"

@class YLPCoordinate;
@class YLPQuery;
@class YLPSearch;

NS_ASSUME_NONNULL_BEGIN

typedef void(^YLPSearchCompletionHandler)(YLPSearch *_Nullable search, NSError *_Nullable error);
typedef void(^YLPCategoryCompletionHandler)(NSMutableArray<NSString *> *_Nullable cuisineCategory, NSMutableArray<NSString *> *_Nullable cuisineAlias, NSError *_Nullable error);

@interface YLPClient (Search)

- (void)searchWithQuery:(YLPQuery *)query
      completionHandler:(YLPSearchCompletionHandler)completionHandler;

- (void)searchWithLocation:(NSString *)location
                      term:(nullable NSString *)term
                     limit:(NSUInteger)limit
                    offset:(NSUInteger)offset
                      sort:(YLPSortType)sort
                     price:(NSString *)price
              radiusFilter:(double)radiusFilter
                    openAt:(NSUInteger)openAt
                categoryFilter: (NSMutableArray <NSString *>*) categoryFilter
         completionHandler:(YLPSearchCompletionHandler)completionHandler;

- (void)searchWithLocation:(NSString *)location
         completionHandler:(YLPSearchCompletionHandler)completionHandler;

- (void)searchWithCoordinate:(YLPCoordinate *)coordinate
                        term:(nullable NSString *)term
                       limit:(NSUInteger)limit
                      offset:(NSUInteger)offset
                        sort:(YLPSortType)sort
           completionHandler:(YLPSearchCompletionHandler)completionHandler;

- (void)searchWithCoordinate:(YLPCoordinate *)coordinate
           completionHandler:(YLPSearchCompletionHandler)completionHandler;

- (NSMutableArray<NSString *> *)categories:(NSString *)categories
completionHandler:(YLPCategoryCompletionHandler)completionHandler;

@property(strong, nonatomic) NSMutableArray<NSString *> *restaurantCategories;

@end

NS_ASSUME_NONNULL_END
