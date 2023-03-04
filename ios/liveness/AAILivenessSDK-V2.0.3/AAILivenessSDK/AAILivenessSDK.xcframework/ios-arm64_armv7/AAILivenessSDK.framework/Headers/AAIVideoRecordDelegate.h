//
//  AAIVideoRecordDelegate.h
//  AAILivenessSDK
//
//  Created by advance on 2022/10/17.
//  Copyright © 2022 Advance.ai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AAILivenessSDK/AAIVideoRecordResult.h>

NS_ASSUME_NONNULL_BEGIN

@protocol AAIVideoRecordDelegate <NSObject>

@optional

/// Tell the delegate that video recording is complete.
/// @param result An AAIVideoRecordResult instance.
///
/// @warning This method is called on other thread, not on the main thread.
- (void)onRecordVideoComplete:(AAIVideoRecordResult *)result;

@end

NS_ASSUME_NONNULL_END
