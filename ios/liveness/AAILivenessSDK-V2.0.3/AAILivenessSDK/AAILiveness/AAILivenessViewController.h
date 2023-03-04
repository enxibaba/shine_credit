//
//  AAILivenessWrapViewController.h
//  AAILivenessDemo
//
//  Created by Advance.ai on 2019/3/2.
//  Copyright © 2019 Advance.ai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AAILivenessSDK/AAILivenessSDK.h>
#import "AAILivenessUtil.h"

NS_ASSUME_NONNULL_BEGIN

/// This class is main page of liveness detection. It contains all the detection logic as well as the key UI parts.
///
/// You can implement custom UI and other logic by inheriting from this class.
@interface AAILivenessViewController : UIViewController
{
    UIButton *_backBtn;
    UILabel *_stateLabel;
    UIImageView *_stateImgView;
    //Voice
    UIButton *_voiceBtn;
    //Time label
    UILabel *_timeLabel;
    CGRect _roundViewFrame;
}
@property(nonatomic, strong) AAILivenessWrapView *wrapView;
@property(nonatomic) AAILivenessUtil *util;

/// Whether to display default HUD(loading view) in the network request. The default is YES.
@property(nonatomic) BOOL showHUD;

/// Detects if the phone is in the vertical orientation during the preparation phase. The default is NO.
@property(nonatomic) BOOL detectPhonePortraitDirection;

/**
 The list of detection actions, reference to AAIDetectionType, note that the `AAIDetectionTypeNone` will be ignored in this array.
 By default, the order of the first two actions is random, and the last action is fixed AAIDetectionTypePosYaw.
 
 You can configure this value like this:
 @code
 vc.detectionActions = @[@(AAIDetectionTypeMouth), @(AAIDetectionTypePosYaw), @(AAIDetectionTypeBlink)];
 */
@property(nonatomic, copy, nullable) NSArray<NSNumber *> *detectionActions;

/// Set the timeout for prepare stage, default is 10s.
///
/// This value refers to the time from when the sdk page is displayed to when the motion detection is ready.
/// For example, after the sdk page is presented, if the user does not hold the phone upright or put the face in the detection area,
/// and continues in this state for a certain period of time, then the `detectionFailedBlk` will be called,
/// and the value of the "key" in errorInfo is "fail_reason_prepare_timeout".
@property(nonatomic) NSInteger prepareTimeoutInterval;

/// Set the timeout for action detection, default is 10s.
///
/// Note that this value represents the timeout for an action,
/// not the total timeout for all actions.
@property(nonatomic) NSInteger actionTimeoutInterval;

/// Specify which language to use for the SDK.
///
/// The languages currently supported by sdk are as follows:
/// \code
/// "en" "id"  "vi"  "zh-Hans"  "th"  "es"  "ms" "hi"
@property(nonatomic, copy, nullable) NSString *language;

/// When the SDK starts, the SDK will check the camera permissions, and if the camera permission is denied, this block will be called.
@property(nonatomic, copy, nullable) void (^cameraPermissionDeniedBlk)(AAILivenessViewController *rawVC);

/// Call when SDK begin send request.
///
/// If needed, you can implement this block to show your own loading view.
@property(nonatomic, copy, nullable) void (^beginRequestBlk)(AAILivenessViewController *rawVC);

/// Call when SDK request complete.
///
/// If needed, you can implement this block to dismiss your own loading view.
@property(nonatomic, copy, nullable) void (^endRequestBlk)(AAILivenessViewController *rawVC, NSDictionary * _Nullable errorInfo);

/// Indicates that the liveness detection is ready and the first action(detectionType) is about to be detected.
///
/// - parameter rawVC: AAILivenessViewController.
///
/// - parameter detectionType: The first action type that will be detected.
///
/// - parameter info: Additional information about the detectionType, it will contain "key" and "state" fields.
@property(nonatomic, copy, nullable) void (^detectionReadyBlk)(AAILivenessViewController *rawVC, AAIDetectionType detectionType, NSDictionary *info);

/// Called whenever a new video frame is detected.
@property(nonatomic, copy, nullable) void (^frameDetectedBlk)(AAILivenessViewController *rawVC, AAIDetectionType detectionType, AAIActionStatus status, AAIDetectionResult result, NSDictionary *info);

/// Indicates that the liveness detection type is about to be changed.
///
/// - parameter rawVC: AAILivenessViewController.
///
/// - parameter toDetectionType: The action type that will be detected.
///
/// - parameter info: Additional information about the toDetectionType, it will contain "key" and "state" fields.
@property(nonatomic, copy, nullable) void (^detectionTypeChangedBlk)(AAILivenessViewController *rawVC, AAIDetectionType toDetectionType, NSDictionary *info);

/// Call when liveness detection success.
@property(nonatomic, copy, nullable) void (^detectionSuccessBlk)(AAILivenessViewController *rawVC, AAILivenessResult *result);

/// The remaing detection time of the current detection type, this block is called about once per second.
@property(nonatomic, copy, nullable) void (^detectionRemainingTimeBlk)(AAILivenessViewController *rawVC, AAIDetectionType detectionType, NSTimeInterval remainingTime);

/// Call when liveness detection failed or timeout.
///
/// - parameter rawVC: AAILivenessViewController.
///
/// - parameter info: Detailed information about the failure. If it is a network request failure, it will contain "message", "code", "transactionId" fields.
///  If it is other failure reason, it will contain "key" and "state" fields, you can distinguish the different failure types by the "key" field.
///  e.g. When detection timeout, the value of the "key" will be "fail_reason_timeout".
/// \code
/// /*
/// This `errorInfo` value currently contains only two cases:
/// One is the case of a failed network request, for which the following three fields are available.
/// "message"
/// "code"
/// "transactionId"
///
/// The other is the case of failed action detection or action detection timeout, which corresponds to the following fields.
/// "key"
/// "state"
///
/// The values of the `key` are as follows:
/// "fail_reason_prepare_timeout"
/// "fail_reason_timeout"
/// "fail_reason_muti_face"
/// "fail_reason_facemiss_blink_mouth"
/// "fail_reason_facemiss_pos_yaw"
/// "fail_reason_much_action"
///
/// Generally there is no need to focus on this, just let the client to retry once detectionFailedBlk is called.
/// */
///
@property(nonatomic, copy, nullable) void (^detectionFailedBlk)(AAILivenessViewController *rawVC, NSDictionary *errorInfo);

/// Called after the `AAILivenessWrapView` is created.
/// @param wrapView AAILivenessWrapView
///
/// You can override this method to customize wrapView UI.
/// For more details, see the comment code in the implementation part of this method.
- (void)livenessWrapViewDidLoad:(AAILivenessWrapView *)wrapView;

/// Call before layout the  `AAILivenessWrapView`.
/// @param wrapView AAILivenessWrapView
///
/// You can override this method to configure the wrapView's to display liveness view in full screen.
/// For more details, see the comment code in the implementation part of this method.
- (void)livenessWrapViewWillLayout:(AAILivenessWrapView *)wrapView;

/// Call after the   `_backButton`, `_stateLabe`l, `_stateImgView`, `_voiceBtn`, `_timeLabel` are created.
///
/// You can override this method to make some additional settings for these UI controls, or add your UI controls.
- (void)loadAdditionalUI;

/// Call after the additional UI controls layout. Default this method will laytout the  `_backButton`, `_stateLabe`l, `_stateImgView`, `_voiceBtn`, `_timeLabel`.
///
/// You can override this method to make some additional frame settings for these UI controls.
- (void)layoutAdditionalUI;

/// This method will be called when the audio is about to be played. Default this method will auto play audio.
/// @param audioName Audio name
///
/// You can override this method to play custom audio, or disable play audio.
/// As long as the `[super willPlayAudio:]` method is not called, the audio will not be played.
- (void)willPlayAudio:(NSString *)audioName;

/// This method will be called when the `_stateLabel` needs to be updated.
/// @param state Local language string of the key
/// @param key The state key
///
/// You can override this method to make some additional settings for `_stateLabel`, such as frame, content, etc.
- (void)updateStateLabel:(NSString * _Nullable)state key:(NSString * _Nullable)key;

/// This method will be called when the image of  `_stateImgView` needs to be updated.
/// @param detectionType Current detection type
///
/// You can override this method to show your own image or other configurations about `_stateImgView`.
- (void)showImgWithType:(AAIDetectionType)detectionType;

/// This method will be called when the liveness view and other UI controls need to be reset.
///
/// You can override this method to reset your own UI cotrols.
- (void)resetViewState;

/// When liveness detection failed, you can call this method to retry it.
- (void)restartDetection;

/// This method will be called when the back button is clicked.
///
/// You can override this method to perform your own back actions.
- (void)tapBackBtnAction;

/// This method will be called when the voice button is clicked.
///
/// You can override this method to perform your own actions.
- (void)tapVoiceBtnAction:(UIButton *)btn;

@end

NS_ASSUME_NONNULL_END
