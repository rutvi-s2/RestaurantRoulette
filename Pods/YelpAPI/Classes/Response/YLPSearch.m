//
//  YLPSearch.m
//  Pods
//
//  Created by David Chen on 1/28/16.
//
//

#import "YLPSearch.h"
#import "YLPResponsePrivate.h"

@implementation YLPSearch
- (instancetype)initWithDictionary:(NSDictionary *)searchDict {
    if (self = [super init]) {
        _total = [searchDict[@"total"] unsignedIntegerValue];
        _businesses = [self.class businessesFromJSONArray:searchDict[@"businesses"]];
    }
    
    return self;
}

//- (instancetype)initWithCategory:(NSDictionary *)searchDict {
//    if (self = [super init]) {
//        _category = [self.class categoriesFromJSONArray:searchDict[@"categories"]];
//    }
//    
//    return self;
//}

+ (NSArray *)businessesFromJSONArray:(NSArray *)businessesJSON {
    NSMutableArray<YLPBusiness *> *mutableBusinessesJSON = [[NSMutableArray alloc] init];
    
    for (NSDictionary *business in businessesJSON) {
        [mutableBusinessesJSON addObject:[[YLPBusiness alloc] initWithDictionary:business]];
    }
    
    return mutableBusinessesJSON;
}

//+ (NSArray *)categoriesFromJSONArray:(NSArray *)categoriesJSON {
//    NSMutableArray *mutableCategories = [[NSMutableArray alloc] init];
//    for (NSDictionary *category in categoriesJSON) {
//        [mutableCategories addObject:[[YLPCategory alloc] initWithDictionary:category]];
//    }
//    return mutableCategories;
//}

@end
