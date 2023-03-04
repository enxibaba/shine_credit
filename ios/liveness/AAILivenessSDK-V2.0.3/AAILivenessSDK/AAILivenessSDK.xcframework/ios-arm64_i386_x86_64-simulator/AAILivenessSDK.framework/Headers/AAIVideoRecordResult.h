//
//  AAIVideoRecordResult.h
//  AAILivenessSDK
//
//  Created by advance on 2022/10/17.
//  Copyright © 2022 Advance.ai. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, AAIVideoRecordResultCode) {
    /**
     Record video succeed.
     
     Recording ends automatically because:
     1. Liveness detection succeed or failed.
     2. User cancels the detection (typically by tapping the naviagation bar back button).
     3. Preparation stage timeout.
     
     */
    AAIVideoRecordResultCodeOK = 0,
    
    /**
     Record video succeed.
     
     Because of the alarm clock, call interruption, etc. automatically end the recording.
     */
    AAIVideoRecordResultCodeOKInterrupted = 1,
    
    /**
     Record video succeed.
     
     Recording ends automatically because the recording duration exceeds the set maximum duration.
     */
    AAIVideoRecordResultCodeOKReachMaxDuration = 2,
    
    /**
     Record video failed.
     
     Recording video failed or the SDK has not yet entered the recording video stage or the video duration is 0s.
      
     case 1: if "detectPhonePortraitDirection" of AAILivenessViewController is set to YES,
     then after the sdk page is presented, if the user does not hold the phone upright and continues in this state for a certain period of time,
     it will fail when the "prepareTimeoutInterval" is reached. In this case, the SDK never enters the recording video stage, so the recording result also fails.
     */
    AAIVideoRecordResultCodeFailed = 3,
};

@interface AAIVideoRecordResult : NSObject

@property(nonatomic, readonly) AAIVideoRecordResultCode code;

/// Path to video file. Note that if the code is "AAIVideoRecordResultCodeFailed", this value will be nil.
///
/// Currently the SDK does not automatically delete the video file, so you can decide whether to delete it according to your needs.
/// The video file is located in /Documents/AAILDData/.
@property(nonatomic, nullable, copy, readonly) NSString *videoPath;

@end

NS_ASSUME_NONNULL_END
