//
//  YLPClient+Categories.h
//  Pods
//
//  Created by rutvims on 7/14/21.
//

#import "YLPClient.h"

@class YLPSearch;

NS_ASSUME_NONNULL_BEGIN

typedef void(^YLPCategoriesCompletionHandler)(YLPSearch *_Nullable search, NSError *_Nullable error);

@interface YLPClient (Categories)

- (void)categories:(NSString *)categories
              completionHandler:(YLPCategoriesCompletionHandler)completionHandler;

@end

NS_ASSUME_NONNULL_END
