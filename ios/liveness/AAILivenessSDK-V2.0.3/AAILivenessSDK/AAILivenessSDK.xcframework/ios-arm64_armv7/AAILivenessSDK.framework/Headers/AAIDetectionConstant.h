//
//  AAIDetectionConstant.h
//  AAILivenessDemo
//
//  Created by Advance.ai on 2019/2/18.
//  Copyright © 2019 Advance.ai. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef AAIDetectionConstant_h
#define AAIDetectionConstant_h

typedef NS_ENUM(NSUInteger, AAIDetectionType) {
    ///Not detect
    AAIDetectionTypeNone = 0,
    ///Blink
    AAIDetectionTypeBlink = 1,
    ///Open mouth
    AAIDetectionTypeMouth = 2,
    ///Turn head
    AAIDetectionTypePosYaw = 3,
};

typedef NS_ENUM(NSInteger, AAIDetectionResult) {
    AAIDetectionResultTimeout = 0,
    AAIDetectionResultUnknown = 1,
    
    AAIDetectionResultFaceMissing = 2,
    AAIDetectionResultFaceLarge = 3,
    AAIDetectionResultFaceSmall = 4,
    AAIDetectionResultFaceNotCenter = 5,
    AAIDetectionResultFaceNotFrontal = 6,
    AAIDetectionResultFaceNotStill = 7,
    
    AAIDetectionResultWarnMutipleFaces = 8,
    AAIDetectionResultWarnEyeOcclusion = 9,
    AAIDetectionResultWarnMouthOcclusion = 10,
    
    AAIDetectionResultFaceCapture = 11,
    AAIDetectionResultFaceInAction = 12,
    AAIDetectionResultOkActionDone = 13,
    
    AAIDetectionResultErrorMutipleFaces = 14,
    AAIDetectionResultErrorFaceMissing = 15,
    AAIDetectionResultErrorMuchMotion = 16,
    
    AAIDetectionResultOkCounting = 17,
    
    AAIDetectionResultWarnMotion = 18,
    AAIDetectionResultWarnLargeYaw = 19,
    AAIDetectionResultWarnMouthOcclusionInMotion = 20,
    
    AAIDetectionResultWarnWeakLight = 21,
    AAIDetectionResultWarnTooLight = 22,
    AAIDetectionResultWarnFaceBiasRight = 23,
    AAIDetectionResultWarnFaceBiasLeft = 24,
    AAIDetectionResultWarnFaceBiasBottom = 25,
    AAIDetectionResultWarnFaceBiasUp = 26,
};

typedef NS_ENUM(NSInteger, AAIActionStatus) {
    AAIActionStatusUnknown = 0,
    AAIActionStatusNoFace = 1,
    AAIActionStatusFaceCheckSize = 2,
    AAIActionStatusFaceSizeReady = 3,
    AAIActionStatusFaceCenterReady = 4,
    AAIActionStatusFaceFrontalReady = 5,
    AAIActionStatusFaceCaptureReady = 6,
    AAIActionStatusFaceMotionReady = 7,
    AAIActionStatusFaceCheckOcclusion = 8
};

typedef NS_ENUM(NSUInteger, AAILivenessMarket) {
    AAILivenessMarketIndonesia = 0,
    AAILivenessMarketIndia = 1,
    AAILivenessMarketPhilippines = 2,
    AAILivenessMarketVietnam = 3,
    AAILivenessMarketThailand = 4,
    AAILivenessMarketMexico = 5,
    AAILivenessMarketMalaysia = 6,
    AAILivenessMarketPakistan = 7,
    AAILivenessMarketNigeria = 8,
    AAILivenessMarketColombia = 9,
    AAILivenessMarketLAOS = 10,
    AAILivenessMarketCambodia = 11,
    AAILivenessMarketMyanmar = 12,
    AAILivenessMarketSingapore = 13,
    AAILivenessMarketCanada = 14,
    AAILivenessMarketAmerica = 15,
    AAILivenessMarketUnitedKingdom = 16,
    AAILivenessMarketPhilippines2 = 17,
    AAILivenessMarketAksata = 18
};

typedef NS_ENUM(NSUInteger, AAIDetectionLevel) {
    AAIDetectionLevelNormal = 0,
    AAIDetectionLevelHard = 1,
    AAIDetectionLevelEasy = 2
};

///Detection timeout inteval
FOUNDATION_EXPORT int const aai_timeout_interval;

///Notification name when the network status changes.
FOUNDATION_EXPORT NSString * const AAINetworkDidChangedNotification;

///The key for current network status value in 'userInfo' object of NSNotification object
FOUNDATION_EXPORT NSString * const AAINetworkNotificationResultItem;

#endif /* AAIDetectionConstant_h */
