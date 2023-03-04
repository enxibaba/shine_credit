//
//  AAILDSDK.h
//  AAILivenessSDK
//
//  Created by Advance.ai on 2019/2/21.
//  Copyright © 2019 Advance.ai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AAILivenessSDK/AAIDetectionConstant.h>
#import <AAILivenessSDK/AAILocalizationUtil.h>
#import <AAILivenessSDK/AAILivenessWrapView.h>
#import <AAILivenessSDK/AAIVideoConfig.h>
#import <AAILivenessSDK/AAIVideoRecordResult.h>
#import <AAILivenessSDK/AAIAdditionalConfig.h>

NS_ASSUME_NONNULL_BEGIN

@interface AAILivenessSDK : NSObject

/// This method is used to initialize the SDK and this method is the first method that needs to be called before any other method of the SDK can be used.
/// You need to bind the your app bundle id to the accessKey secretKey on our cms website before using the SDK.
///
/// @param accesskey accessKey
/// @param secretkey secretKey
/// @param market market
///
/// This method is the easiest way to initialize the sdk. For higher security requirements, you should call the "initWithMarket:" method to initialize the SDK.
+ (void)initWithAccessKey:(NSString *)accesskey secretKey:(NSString *)secretkey market:(AAILivenessMarket)market;

/// This method is similar to the method "initWithAccessKey:secretKey:market:", the only difference is that this method can specify whether the SDK is a global service,
/// @param accesskey accessKey
/// @param secretkey secretKey
/// @param market market
/// @param isGlobalService whether the SDK is used as a global service. Pass YES indicates that the SDK is used as a global service, If NO is passed, this method is equivalent to the method "initWithAccessKey:secretKey:market:"
+ (void)initWithAccessKey:(NSString *)accesskey secretKey:(NSString *)secretkey market:(AAILivenessMarket)market isGlobalService:(BOOL)isGlobalService;

/// This method is also used to initialize the SDK, compared to the above method, this method does not need to pass accessKey and secretKey, so as to prevent your accesskey from being leaked.
/// You need to bind the your app bundle id to the accessKey secretKey on our cms website before using the SDK.
/// @param market market
///
/// If you use this initialization method, then you need to call the "configLicenseAndCheck:" method before displaying the AAILivenessViewController page. For example:
/// @code
/// [AAILivenessSDK initWithMarket:AAILivenessMarketIndonesia];
/// NSString *result = [AAILivenessSDK configLicenseAndCheck: @"your-license-content"];
/// if ([result isEqualToString:@"SUCCESS"]) {
///     AAILivenessViewController *vc = [[AAILivenessViewController alloc] init];
///     [self.navigationController pushViewController:vc animated:YES];
/// }
///
+ (void)initWithMarket:(AAILivenessMarket)market;

/// This method is similar to the method "initWithMarket:", the only difference is that this method can specify whether the SDK is used as a global service,
/// @param market market
/// @param isGlobalService whether the SDK is used as a global service. Pass YES indicates that the SDK is used as a global service, If NO is passed, this method is equivalent to the method "initWithMarket:"
+ (void)initWithMarket:(AAILivenessMarket)market isGlobalService:(BOOL)isGlobalService;



+ (NSString *)sdkVersion;

+ (void)configTicket:(NSString *)ticket;

+ (void)configQueryId:(NSString *)queryId;

+ (void)configUserId:(NSString *)userId;

/// This method is used to set the license content.
/// @param license license content
/// @return error infomation. "SUCCESS" means the verification license passed; "LICENSE_EXPIRE" means the license is expired; "APPLICATION_ID_NOT_MATCH"  means your app bundle identifier does not match the license.
///
/// The license content is obtained by your server calling our openapi.
///
/// If the license verification is passed, the SDK will cache the license information in memory, that is, you only need to call this method once, after that you can directly display the liveness page, no need to call this method again.
/// If you call this method every time before the AAILivenessViewController page is displayed, that's fine.
+ (NSString *)configLicenseAndCheck:(NSString *)license;

/// This method is used to customize the size of the resulting image, which is actually the size of the image obtained in the 'onDetectionComplete:' callback.
/// This method should be called before the AAILivenessViewController is initialized.
/// @param size Image size
///
/// Note that the default result image size is 600x600. This value can be set in the interval [300, 1000], the larger the value, the more memory the SDK will consume.
+ (void)configResultPictureSize:(CGFloat)size;

/// This method is used to set the timeout for action detection, the default is 10s.
/// This method should be called before the AAILivenessViewController is initialized.
/// @param actionTimeout timeout in second
+ (void)configActionTimeoutSeconds:(NSTimeInterval)actionTimeout;

/// Set whether to detect face occlusion.
/// This method should be called before the AAILivenessViewController is initialized.
///
/// If this value is set to YES, SDK will detect  face occlusion  in preparation phase and action detection phase. The default value is NO.
+ (void)configDetectOcclusion:(BOOL)detectOcc;

/// This method is used to set the path of `AAIModel.bundle`.
///
/// By default the SDK will look for`AAIModel.bundle` from the `[NSBundle mainBundle]`, if you put the `AAIModel.bundle` file somewhere else, then you must call this method to tell the SDK where the bundle file is located, otherwise the SDK will crash.
/// @param modelBundlePath `AAIModel.bundle` file path.
+ (void)configModelBundlePath:(NSString *)modelBundlePath;

/// Configure the SDK about recording video.
/// @param videoConfig A AAIVideoConfig instance.
+ (void)configVideo:(AAIVideoConfig *)videoConfig;

+ (nullable AAIVideoConfig *)videoConfig;

/// Get the latest recorded video result synchronously. You can only call this method when video recording is enabled.
///
/// Note that this method can only be called in "detectionFailedBlk" and "detectionSuccessBlk" of AAILivenessViewController, and you should
/// always check if video recording is enabled before calling this method.
///
/// @code
/// AAIVideoConfig *originVConfig = [AAILivenessSDK videoConfig];
/// if (originVConfig != nil && originVConfig.recordStage != AAIVideoRecordStageUnspecified) {
///    AAIVideoRecordResult *videoResult = [AAILivenessSDK syncGetLatestVideoRecordResult];
///    NSLog(@"Video result:%@", videoResult.videoPath);
/// }
/// @endcode
///
+ (nullable AAIVideoRecordResult *)syncGetLatestVideoRecordResult;

/// Get additional configuration for the SDK.
+ (AAIAdditionalConfig *)additionalConfig;

@end

NS_ASSUME_NONNULL_END

