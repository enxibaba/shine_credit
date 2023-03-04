//
//  AAILivenessVideoConfig.h
//  AAILivenessSDK
//
//  Created by advance on 2022/10/9.
//  Copyright © 2022 Advance.ai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AAILivenessSDK/AAIVideoRecordResult.h>
#import <AAILivenessSDK/AAIVideoRecordDelegate.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, AAIVideoRecordStage) {
    /// Don't record video.
    AAIVideoRecordStageUnspecified = 0,
    
    /// Record videos of the preparation stage and the motion stage.
    AAIVideoRecordStagePrepareAndMotion = 1,
    
    /// Only record the video of the preparation stage.
    AAIVideoRecordStagePrepare = 2,
    
    /// Only record the video of the motion stage.
    AAIVideoRecordStageMotion = 3
};

@interface AAIVideoConfig : NSObject

/// An object conforming to the AAIVideoRecordDelegate protocol that will receive video result when the recording is done.
///
/// @warning Normally you should call `[AAILivenessSDK syncGetLatestVideoRecordResult]` to get the video result.
///
/// There are some special cases where no corresponding callback method is called in AAILivenessViewController when the user clicks the back button or when the preparation phase times out.
/// So if you need to get the video results for these special cases, you should implement the delegate method.
@property(nonatomic, weak) id<AAIVideoRecordDelegate> delegate;

/// The stage of the video to be recorded. Default is "AAIVideoRecordStagePrepareAndMotion".
@property(nonatomic) AAIVideoRecordStage recordStage;

/// Maximum duration of video recording, in seconds, default is 60s.
@property(nonatomic) NSInteger maxRecordDuration;

/// Generate a default AAIVideoConfig instance. Not that you should always call this method to generate a AAIVideoConfig instance.
+ (AAIVideoConfig *)defaultConfig;

@end

NS_ASSUME_NONNULL_END
