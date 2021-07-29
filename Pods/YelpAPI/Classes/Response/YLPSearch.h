//
//  YLPSearch.h
//  Pods
//
//  Created by David Chen on 1/28/16.
//
//

#import <Foundation/Foundation.h>

@class YLPBusiness;

NS_ASSUME_NONNULL_BEGIN

@interface YLPSearch : NSObject

@property (nonatomic) NSArray<YLPBusiness *> *businesses;
//@property (nonatomic, readonly) NSArray<NSString *> *category;
@property (nonatomic) NSUInteger total;

@end

NS_ASSUME_NONNULL_END
