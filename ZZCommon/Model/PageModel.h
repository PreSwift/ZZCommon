//
//  PageModel.h

//  Created by west007 on 2021/7/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PageModel<T:NSObject *> : NSObject

@property(nonatomic, assign) int current;
@property(nonatomic, assign) int size;
@property(nonatomic, assign) NSInteger total;
@property(nonatomic, assign) NSInteger pages;
@property(nonatomic, strong) NSArray<NSDictionary<NSString *, id> *> *records;

@property(nonatomic, strong) NSArray<T> *data;

@end

NS_ASSUME_NONNULL_END
