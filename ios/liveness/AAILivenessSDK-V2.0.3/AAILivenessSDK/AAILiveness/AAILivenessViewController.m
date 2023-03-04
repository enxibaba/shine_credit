//
//  AAILivenessWrapViewController.m
//  AAILivenessDemo
//
//  Created by Advance.ai on 2019/3/2.
//  Copyright © 2019 Advance.ai. All rights reserved.
//

#import "AAILivenessViewController.h"
#import "AAIHUD.h"
#import "AAILivenessResultViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface AAILivenessViewController ()<AAILivenessWrapDelegate>
{
    NSString *_pre_key;
    
    BOOL _isReady;
    BOOL _isRequestingAuth;
    BOOL _requestAuthSucceed;
    BOOL _isFlowFinished;
}
@property(nonatomic) BOOL isRequestingAuth;
@property(nonatomic) BOOL requestAuthSucceed;
@property(nonatomic) BOOL requestAuthComplete;
@property(nonatomic) BOOL requestAuthCached;
@property(nonatomic) BOOL hasPortraitDirection;

@property(nonatomic) NSTimeInterval prepareStartTime;
@property(nonatomic) NSTimeInterval authRequestCostTime;
@property(nonatomic) AAITimerWrapper *prepareStageTimer;
@end

@implementation AAILivenessViewController
@synthesize isRequestingAuth = _isRequestingAuth;
@synthesize requestAuthSucceed = _requestAuthSucceed;

- (void)livenessWrapViewDidLoad:(AAILivenessWrapView *)wrapView
{
    if (self.detectionActions != NULL) {
        wrapView.detectionActions = [self.detectionActions copy];
    }
    
    /*
    // Subclass can override this method to customize the UI
    wrapView.backgroundColor = [UIColor grayColor];
    wrapView.roundBorderView.layer.borderColor = [UIColor redColor].CGColor;
    wrapView.roundBorderView.layer.borderWidth = 2;
     
    //Custom corner radius and the shape of the preview area
    CGFloat cornerRadius = 20;
    wrapView.roundBorderView.layer.cornerRadius = cornerRadius;
    wrapView.configAvatarPreviewPathV2 = ^(CGRect avatarPreviewFrame, UIBezierPath * _Nonnull originRectPath, AAILivenessWrapView * _Nonnull originWrapView) {
        UIBezierPath *squarePath = [UIBezierPath bezierPathWithRoundedRect:avatarPreviewFrame cornerRadius:cornerRadius];
        [originRectPath appendPath: [squarePath bezierPathByReversingPath]];
    };

    
    //Custom preview area margin top
    wrapView.configAvatarPreviewMarginTop = ^CGFloat(CGRect wrapViewFrame) {
        return 64;
    };
     
    //Custom preview area width
    wrapView.configAvatarPreviewWidth = ^CGFloat(CGRect wrapViewFrame) {
        return 300;
    };
    */
}

- (void)loadAdditionalUI
{
    UIView *sv = self.view;
    
    //Back button
    if (self.navigationController.navigationBarHidden) {
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn setImage:[AAILivenessUtil imgWithName:@"arrow_back"] forState:UIControlStateNormal];
        [sv addSubview:backBtn];
        [backBtn addTarget:self action:@selector(tapBackBtnAction) forControlEvents:UIControlEventTouchUpInside];
        _backBtn = backBtn;
    }
    
    //Detect state label
    UILabel *stateLabel = [[UILabel alloc] init];
    stateLabel.font = [UIFont systemFontOfSize:16];
    stateLabel.textColor = [UIColor blackColor];
    stateLabel.numberOfLines = 0;
    stateLabel.textAlignment = NSTextAlignmentCenter;
    [sv addSubview:stateLabel];
    _stateLabel = stateLabel;
    
    //Action status imageView
    UIImageView *stateImgView = [[UIImageView alloc] init];
    stateImgView.contentMode = UIViewContentModeScaleAspectFit;
    [sv addSubview:stateImgView];
    _stateImgView = stateImgView;
    
    //Voice switch button
    UIButton *voiceBtn = [[UIButton alloc] init];
    [voiceBtn setImage:[AAILivenessUtil imgWithName:@"liveness_open_voice@2x.png"] forState:UIControlStateNormal];
    [voiceBtn setImage:[AAILivenessUtil imgWithName:@"liveness_close_voice@2x.png"] forState:UIControlStateSelected];
    [sv addSubview:voiceBtn];
    [voiceBtn addTarget:self action:@selector(tapVoiceBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    if ([AAILivenessUtil isSilent]) {
        voiceBtn.selected = YES;
    }
    
    _voiceBtn = voiceBtn;
    
    //Timeout interval label
    NSTimeInterval actionTimeout = _actionTimeoutInterval;
    [AAILivenessSDK configActionTimeoutSeconds:actionTimeout];
    
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.font = [UIFont systemFontOfSize:14];
    _timeLabel.textColor = [UIColor colorWithRed:(0x36/255.f) green:(0x36/255.f) blue:(0x36/255.f) alpha:1];
    _timeLabel.text = [NSString stringWithFormat:@"%.f S", actionTimeout];
    _timeLabel.textAlignment = NSTextAlignmentCenter;
    [sv addSubview:_timeLabel];
    
    _timeLabel.hidden = YES;
    _voiceBtn.hidden = YES;
}

- (void)layoutAdditionalUI
{
    CGSize size = self.view.frame.size;
    
    //top
    CGFloat top = 0, marginLeft = 20, marginTop = 20;
    if (@available(iOS 11, *)) {
        top = self.view.safeAreaInsets.top;
    } else {
        if (self.navigationController.navigationBarHidden) {
            top = [UIApplication sharedApplication].statusBarFrame.size.height;
        } else {
            top = self.navigationController.navigationBar.frame.size.height + [UIApplication sharedApplication].statusBarFrame.size.height;
        }
    }
    
    //Back button
    if (_backBtn) {
        _backBtn.frame = CGRectMake(marginLeft, top + marginTop, 40, 40);
    }
    
    //State image
    CGFloat stateImgViewWidth = 120;
    _stateImgView.frame = CGRectMake((size.width-stateImgViewWidth)/2, CGRectGetMaxY(_roundViewFrame) + 80, stateImgViewWidth, stateImgViewWidth);
    
    //Time label
    CGFloat timeLabelCenterY = 0;
    CGSize timeLabelSize = CGSizeMake(40, 24);
    if (_backBtn) {
        timeLabelCenterY = _backBtn.center.y;
    } else {
        timeLabelCenterY = top + marginTop + timeLabelSize.height/2;
    }
    _timeLabel.bounds = CGRectMake(0, 0, timeLabelSize.width, timeLabelSize.height);
    _timeLabel.center = CGPointMake(size.width - marginLeft - 20, timeLabelCenterY);
    _timeLabel.layer.cornerRadius = 12;
    _timeLabel.layer.borderWidth = 1;
    _timeLabel.layer.borderColor = _timeLabel.textColor.CGColor;
    
    _voiceBtn.bounds = CGRectMake(0, 0, 32, 32);
    _voiceBtn.center = CGPointMake(_timeLabel.center.x, CGRectGetMaxY(_timeLabel.frame)+20);
}

- (void)livenessWrapViewWillLayout:(AAILivenessWrapView *)wrapView
{
    /*
    // Custom preview frame and avatar preview area
    CGRect rect = self.view.frame;
    wrapView.currPreviewFrame = CGRectMake(0, 0, rect.size.width, rect.size.height);
    
    CGFloat marginLeft = 20;
    CGFloat marginTop = 50;
    CGFloat avatarPreviewWidth = (rect.size.width - 2 * marginLeft);
    wrapView.currAvatarPreviewArea = CGRectMake(marginLeft, marginTop, avatarPreviewWidth, avatarPreviewWidth);
    */
    
    /*
    // Hide the default viewfinder
    wrapView.roundBorderView.hidden = YES;
    // Configure your own viewfinder view or layer
     */
}

- (void)willPlayAudio:(NSString *)audioName
{
    [_util playAudio:audioName lprojName:_language];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _showHUD = YES;
        _detectPhonePortraitDirection = NO;
        _prepareTimeoutInterval = 10;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _pre_key = nil;
    _isReady = NO;
    _isRequestingAuth = NO;
    _requestAuthSucceed = NO;
    _requestAuthComplete = NO;
    _requestAuthCached = NO;
    _isFlowFinished = NO;
    
    _util = [[AAILivenessUtil alloc] init];
    
    // Config model file path
    NSString *modelPath = [[NSBundle mainBundle] pathForResource:@"AAIModel.bundle" ofType:NULL];
    if (modelPath == NULL) {
        modelPath = [[NSBundle bundleForClass:[AAILivenessViewController class]] pathForResource:@"AAIModel.bundle" ofType:NULL];
    }
    if (modelPath == NULL) {
        NSLog(@"ERROR: AAIModel.bundle Not Found!");
        return;
    }
    [AAILivenessSDK configModelBundlePath: modelPath];
    
    UIView *sv = self.view;
    AAILivenessWrapView *wrapView = [[AAILivenessWrapView alloc] init];
    [sv addSubview:wrapView];
    
    [self livenessWrapViewDidLoad:wrapView];
    
    wrapView.wrapDelegate = self;
    _wrapView = wrapView;
    
    [self loadAdditionalUI];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(restartDetection) name:@"kAAIRestart" object:nil];
    [[AVAudioSession sharedInstance] addObserver:self forKeyPath:@"outputVolume" options:NSKeyValueObservingOptionNew context:nil];
    
    [_util saveCurrBrightness];
    
    [self startPrepareStageTimer];
    [self startCamera];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    // Do not modify begin
    CGRect rect = self.view.frame;
    _wrapView.frame = rect;
    
    [self livenessWrapViewWillLayout:_wrapView];
    [_wrapView setNeedsLayout];
    [_wrapView layoutIfNeeded];
    
    CGRect tmpFrame = _wrapView.roundBorderView.frame;
    _roundViewFrame = [_wrapView.roundBorderView.superview convertRect:tmpFrame toView:self.view];
    // Do not modify end
    
    [self layoutAdditionalUI];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [_util graduallySetBrightness:1];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_util graduallyResumeBrightness];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self resetViewState];
    _wrapView.roundBorderView.backgroundColor = [UIColor whiteColor];
}

- (void)updateStateLabel:(NSString * _Nullable)state key:(NSString * _Nullable)key
{
    CGRect frame = _roundViewFrame;
    CGFloat w = frame.size.width;
    CGFloat marginTop = 40;
    if (state) {
        _stateLabel.text = state;
        CGSize size = [_stateLabel sizeThatFits:CGSizeMake(w, 1000)];
        _stateLabel.frame = CGRectMake(frame.origin.x, CGRectGetMaxY(frame) + marginTop, w, size.height);
    } else {
        _stateLabel.text = nil;
        _stateLabel.frame = CGRectMake(frame.origin.x, CGRectGetMaxY(frame) + marginTop, frame.size.width, 30);
    }
}

- (void)showImgWithType:(AAIDetectionType)detectionType
{
    switch (detectionType) {
        case AAIDetectionTypeBlink:
        case AAIDetectionTypeMouth:
        case AAIDetectionTypePosYaw: {
            [_stateImgView stopAnimating];
            NSArray *array = [AAILivenessUtil stateImgWithType:detectionType];
            _stateImgView.animationImages = array;
            _stateImgView.animationDuration = array.count * 1/5.f;
            [_stateImgView startAnimating];
            break;
        }
        default:
            break;
    }
}

#pragma mark - Network

- (BOOL)isRequestingAuth
{
    return _isRequestingAuth;
}

- (BOOL)requestAuthSucceed
{
    return _requestAuthSucceed;
}

#pragma mark - UserAction

- (void)startCamera
{
    __weak typeof(self) weakSelf = self;
    [_wrapView checkCameraPermissionWithCompletionBlk:^(BOOL authed) {
        if (!weakSelf) return;
        
        if (weakSelf.cameraPermissionDeniedBlk) {
            weakSelf.cameraPermissionDeniedBlk(weakSelf);
        }
        //Alert no permission
        if (weakSelf.showHUD) {
            [AAIHUD showMsg:[AAILivenessUtil localStrForKey:@"no_camera_permission" lprojName:weakSelf.language] onView:weakSelf.view duration:1.5];
        }
    }];
}

- (void)requestAuth
{
    _isRequestingAuth = YES;
    _isReady = NO;
    _timeLabel.hidden = YES;
    
    // Show HUD
    __weak typeof(self) weakSelf = self;
    if (_showHUD) {
        [AAIHUD showWaitWithMsg:[AAILivenessUtil localStrForKey:@"auth_check" lprojName:_language] onView:self.view];
    }
    
    // Begin request callback
    if (self.beginRequestBlk) {
        self.beginRequestBlk(self);
    }
    
    NSTimeInterval authStartTime = [[NSDate date] timeIntervalSince1970];
    [_wrapView startAuthWithCompletionBlk:^(NSError * _Nullable error) {
        
        // Dismiss HUD
        __strong AAILivenessViewController *strongSelf = weakSelf;
        if (strongSelf) {
            strongSelf.isRequestingAuth = NO;
            strongSelf.requestAuthComplete = YES;
            strongSelf.authRequestCostTime = [[NSDate date] timeIntervalSince1970] - authStartTime;

            if (error) {
                strongSelf.requestAuthSucceed = NO;
                [strongSelf.prepareStageTimer invalidate];
            } else {
                strongSelf.requestAuthCached = YES;
                strongSelf.requestAuthSucceed = YES;
            }
            
            if (strongSelf.showHUD) {
                [AAIHUD dismissHUDOnView:strongSelf.view afterDelay:0];
            }
        }
        
        // End request callback
        NSDictionary *errorInfo = nil;
        if (error) {
            NSString *transactionId = @"";
            if (error.userInfo) {
                transactionId = error.userInfo[@"transactionId"];
                if (!transactionId) {
                    transactionId = @"";
                }
            }
            errorInfo = @{
                @"message": error.localizedDescription,
                @"code": @(error.code),
                @"transactionId": transactionId
            };
        }
        
        if ((strongSelf != nil) && (strongSelf.endRequestBlk != nil)) {
            strongSelf.endRequestBlk(strongSelf, errorInfo);
        }
        
        // Detection failed callback
        if (error) {
            [strongSelf detectionDidFailed:errorInfo];
        }
        
    }];
}

- (void)tapVoiceBtnAction:(UIButton *)btn
{
    btn.selected = !btn.selected;
    if (btn.selected) {
        //Close
        [_util configVolume:0];
    } else {
        //Open
        [_util configVolume:0.5];
    }
}

- (void)tapBackBtnAction
{
    UINavigationController *navc = self.navigationController;
    if (navc && [navc.viewControllers containsObject:self]) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)resetViewState
{
    if (_stateLabel) {
        _stateLabel.text = nil;
    }
    _stateImgView.animationImages = nil;
    _isReady = NO;
    _timeLabel.hidden = YES;
    _voiceBtn.hidden = YES;
}

- (void)restartDetection
{
    [self resetViewState];
    _wrapView.roundBorderView.backgroundColor = [UIColor whiteColor];
    _hasPortraitDirection = NO;
    _requestAuthComplete = NO;
    _isFlowFinished = NO;
    
    // Stop old timer and start a new timer
    [self startPrepareStageTimer];
    [self startCamera];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self->_wrapView.roundBorderView.backgroundColor = [UIColor clearColor];
    });
}

- (void)startPrepareStageTimer
{
    [_prepareStageTimer invalidate];
    _prepareStartTime = [[NSDate date] timeIntervalSince1970];
    
    __weak typeof(self) weakSelf = self;
    _prepareStageTimer = [AAITimerWrapper scheduledTimerWithTimeInterval:1 repeats:YES execBlock:^(AAITimerWrapper * _Nonnull timerWrapper) {
        [weakSelf prepareStageCountDown];
    }];
}

- (void)prepareStageCountDown
{
    if (!_isReady) {
        NSTimeInterval costTime = [[NSDate date] timeIntervalSince1970] - _prepareStartTime;
        if (costTime >= _prepareTimeoutInterval) {
            if (_isRequestingAuth) return;

            if (_requestAuthComplete) {
                if (costTime - _authRequestCostTime >= _prepareTimeoutInterval) {
                    [self.prepareStageTimer invalidate];
                    [self.wrapView stopRunning];
                    
                    NSString *key = @"fail_reason_prepare_timeout";
                    NSString *state = [AAILivenessUtil localStrForKey:key lprojName:self.language];
                    [self detectionDidFailed: @{@"key": key, @"state": state}];
                }
                return;
            }
            // Other case: Auth request not start yet
            [self.prepareStageTimer invalidate];
            [self.wrapView stopRunning];
            
            NSString *key = @"fail_reason_prepare_timeout";
            NSString *state = [AAILivenessUtil localStrForKey:key lprojName:self.language];
            [self detectionDidFailed: @{@"key": key, @"state": state}];
        }
    } else {
        [self.prepareStageTimer invalidate];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"outputVolume"]) {
        float volume = [change[NSKeyValueChangeNewKey] floatValue];
        [_util configPlayerVolume:volume];
        if (volume == 0) {
            if (_voiceBtn.selected == NO) {
                _voiceBtn.selected = YES;
            }
        } else {
            if (_voiceBtn.selected == YES) {
                _voiceBtn.selected = NO;
            }
        }
    }
}

#pragma mark - WrapViewDelegate

- (void)onDetectionReady:(AAIDetectionType)detectionType
{
    _isReady = YES;
    _timeLabel.hidden = NO;
    
    [_prepareStageTimer invalidate];
    _prepareStageTimer = nil;
    
    NSString *key = nil;
    if (detectionType == AAIDetectionTypeBlink) {
        key = @"pls_blink";
        [self willPlayAudio:@"action_blink.mp3"];
    } else if (detectionType == AAIDetectionTypeMouth) {
        key = @"pls_open_mouth";
        [self willPlayAudio:@"action_open_mouth.mp3"];
    } else if (detectionType == AAIDetectionTypePosYaw) {
        key = @"pls_turn_head";
        [self willPlayAudio:@"action_turn_head.mp3"];
    }
    
    if (key) {
        NSString *state = [AAILivenessUtil localStrForKey:key lprojName:_language];
        _stateLabel.text = state;
        [self showImgWithType:detectionType];
        
        // Detection ready callback
        if (self.detectionReadyBlk) {
            self.detectionReadyBlk(self, detectionType, @{@"key": key, @"state": state});
        }
    }
}

- (void)onDetectionFailed:(AAIDetectionResult)detectionResult forDetectionType:(AAIDetectionType)detectionType
{
    [self willPlayAudio:@"detection_failed.mp3"];
    [AAILocalizationUtil stopMonitor];
    
    //Reset
    _pre_key = nil;
    
    NSString *key = nil;
    switch (detectionResult) {
        case AAIDetectionResultTimeout:
            key = @"fail_reason_timeout";
            break;
        case AAIDetectionResultErrorMutipleFaces:
            key = @"fail_reason_muti_face";
            break;
        case AAIDetectionResultErrorFaceMissing: {
            switch (detectionType) {
                case AAIDetectionTypeBlink:
                case AAIDetectionTypeMouth:
                    key = @"fail_reason_facemiss_blink_mouth";
                    break;
                case AAIDetectionTypePosYaw:
                    key = @"fail_reason_facemiss_pos_yaw";
                    break;
                default:
                    break;
            }
            break;
        }
        case AAIDetectionResultErrorMuchMotion:
            key = @"fail_reason_much_action";
            break;
        default:
            break;
    }
    
    //Show result page
    if (key) {
        NSString *state = [AAILivenessUtil localStrForKey:key lprojName:_language];
        [self updateStateLabel:state key:key];
        
        [_stateImgView stopAnimating];
        
        // Detection failed callback
        [self detectionDidFailed: @{@"key": key, @"state": state}];
    }
}

- (void)detectionDidFailed:(NSDictionary *)errorInfo
{
    // Avoid repeated call
    if (_isFlowFinished) {
        return;
    }
    _isFlowFinished = YES;
    [self.prepareStageTimer invalidate];
    
    // Detection failed callback
    if (self.detectionFailedBlk) {
        self.detectionFailedBlk(self, errorInfo);
    } else {
        NSString *resultState = errorInfo[@"key"];
        if (resultState == nil) {
            resultState = errorInfo[@"message"];
        }
        AAILivenessResultViewController *resultVC = [[AAILivenessResultViewController alloc] initWithResult:NO resultState:resultState];
        resultVC.language = _language;
        [self.navigationController pushViewController:resultVC animated:YES];
    }
}

- (BOOL)shouldDetect
{
    if (_hasPortraitDirection == NO) {
        if (_detectPhonePortraitDirection) {
            _hasPortraitDirection = [AAILocalizationUtil isPortraitDirection];
        } else {
            _hasPortraitDirection = YES;
        }
        
        if (_hasPortraitDirection) {
            if (_requestAuthCached == NO && _isRequestingAuth == NO && _requestAuthComplete == NO) {
                dispatch_sync(dispatch_get_main_queue(), ^{
                    if (_requestAuthCached == NO && _isRequestingAuth == NO && _requestAuthComplete == NO) {
                        [self requestAuth];
                    }
                });
            }
            return _requestAuthCached;
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (self->_isReady == NO) {
                    self->_timeLabel.hidden = YES;
                    self->_voiceBtn.hidden = YES;
                    self->_stateImgView.animationImages = nil;
                }
                NSString *state = [AAILivenessUtil localStrForKey:@"pls_hold_phone_v" lprojName:self.language];
                [self updateStateLabel:state key:@"pls_hold_phone_v"];
                self->_pre_key = @"pls_hold_phone_v";
            });
        }

        return NO;
    } else {
        if (_requestAuthCached == NO && _isRequestingAuth == NO  && _requestAuthComplete == NO) {
            dispatch_sync(dispatch_get_main_queue(), ^{
                if (_requestAuthCached == NO && _isRequestingAuth == NO  && _requestAuthComplete == NO) {
                    [self updateStateLabel:nil key:nil];
                    [self requestAuth];
                }
            });
        }
        return _requestAuthCached;
    }
    return YES;
}

- (void)onFrameDetected:(AAIDetectionResult)result status:(AAIActionStatus)status forDetectionType:(AAIDetectionType)detectionType
{
    // Avoid repeated call
    if (_isFlowFinished) {
        return;
    }
    
    NSString *key = nil;
    if (_isReady == NO && _detectPhonePortraitDirection && [AAILocalizationUtil isPortraitDirection] == NO) {
        key = @"pls_hold_phone_v";
    } else {
        switch (result) {
            case AAIDetectionResultFaceMissing:
                key = @"no_face";
                break;
            case AAIDetectionResultFaceLarge:
                key = @"move_further";
                break;
            case AAIDetectionResultFaceSmall:
                key = @"move_closer";
                break;
            case AAIDetectionResultFaceNotCenter:
                key = @"move_center";
                break;
            case AAIDetectionResultFaceNotFrontal:
                key = @"frontal";
                break;
            case AAIDetectionResultFaceNotStill:
                key = @"stay_still";
                break;
            case AAIDetectionResultFaceInAction: {
                if (detectionType == AAIDetectionTypeBlink) {
                    key = @"pls_blink";
                } else if (detectionType == AAIDetectionTypePosYaw) {
                    key = @"pls_turn_head";
                } else if (detectionType == AAIDetectionTypeMouth) {
                    key = @"pls_open_mouth";
                }
            }
                break;
            case AAIDetectionResultWarnMouthOcclusion: {
                key = @"face_occ";
                break;
            }
            case AAIDetectionResultWarnEyeOcclusion: {
                key = @"pls_open_eye";
                break;
            }
            case AAIDetectionResultWarnWeakLight: {
                key = @"low_light";
                break;
            }
            case AAIDetectionResultWarnTooLight: {
                key = @"high_light";
                break;
            }
            case AAIDetectionResultWarnFaceBiasRight: {
                key = @"face_move_left";
                break;
            }
            case AAIDetectionResultWarnFaceBiasLeft: {
                key = @"face_move_right";
                break;
            }
            case AAIDetectionResultWarnFaceBiasBottom: {
                key = @"face_move_upper";
                break;
            }
            case AAIDetectionResultWarnFaceBiasUp: {
                key = @"face_move_down";
                break;
            }
            default:
                break;
        }
    }
    
    if (key) {
        if ([key isEqualToString:_pre_key]) {
            return;
        }
        _pre_key = key;
        
        NSString *state = [AAILivenessUtil localStrForKey:key lprojName:_language];
        [self updateStateLabel:state key:key];
        
        // Frame detected callback
        if (self.frameDetectedBlk) {
            self.frameDetectedBlk(self, detectionType, status, result, @{@"key": key, @"state": state});
        }
    }
}

- (void)onDetectionTypeChanged:(AAIDetectionType)toDetectionType
{
    // Avoid repeated call
    if (_isFlowFinished) {
        return;
    }
    
    NSString *key = nil;
    if (toDetectionType == AAIDetectionTypeBlink) {
        key = @"pls_blink";
        [self willPlayAudio:@"action_blink.mp3"];
    } else if (toDetectionType == AAIDetectionTypeMouth) {
        key = @"pls_open_mouth";
        [self willPlayAudio:@"action_open_mouth.mp3"];
    } else if (toDetectionType == AAIDetectionTypePosYaw) {
        key = @"pls_turn_head";
        [self willPlayAudio:@"action_turn_head.mp3"];
    }
    
    if (key) {
        NSString *state = [AAILivenessUtil localStrForKey:key lprojName:_language];
        [self updateStateLabel:state key:key];
        [self showImgWithType:toDetectionType];
        
        // Detection type changed callback
        if (self.detectionTypeChangedBlk) {
            self.detectionTypeChangedBlk(self, toDetectionType, @{@"key": key, @"state": state});
        }
    }
}

- (void)onDetectionComplete:(AAILivenessResult *)resultInfo
{
    // Avoid repeated call
    if (_isFlowFinished) {
        return;
    }
    _isFlowFinished = YES;
    
    [self willPlayAudio:@"detection_success.mp3"];
    [AAILocalizationUtil stopMonitor];
    NSString *state = [AAILivenessUtil localStrForKey:@"detection_success" lprojName:_language];
    [self updateStateLabel:state key:@"detection_success"];
    [_stateImgView stopAnimating];
    _pre_key = nil;
    
    // Detection success callback
    if (self.detectionSuccessBlk) {
        self.detectionSuccessBlk(self, resultInfo);
    } else {
        AAILivenessResultViewController *resultVC = [[AAILivenessResultViewController alloc] initWithResultInfo:@{}];
        resultVC.language = _language;
        [self.navigationController pushViewController:resultVC animated:YES];
    }
}

- (void)onDetectionRemainingTime:(NSTimeInterval)remainingTime forDetectionType:(AAIDetectionType)detectionType
{
    // Avoid repeated call
    if (_isFlowFinished) {
        return;
    }
    
    if (_isReady) {
        _timeLabel.hidden = NO;
        _voiceBtn.hidden = NO;
        _timeLabel.text = [NSString stringWithFormat:@"%.f S", remainingTime];
        
        // Detection remaining time callback
        if (self.detectionRemainingTimeBlk) {
            self.detectionRemainingTimeBlk(self, detectionType, remainingTime);
        }
    }
}

- (void)livenessViewBeginRequest:(AAILivenessWrapView * _Nonnull)param
{
    // Show HUD
    if (_showHUD) {
        [AAIHUD showWaitWithMsg:[AAILivenessUtil localStrForKey:@"auth_check" lprojName:_language] onView:self.view];
    }
    
    [self updateStateLabel:nil key:nil];
    [_stateImgView stopAnimating];
    
    // Begin request callback
    if (self.beginRequestBlk) {
        self.beginRequestBlk(self);
    }
}

- (void)livenessView:(AAILivenessWrapView *)param endRequest:(NSError * _Nullable)error
{
    // Dismiss HUD
    if (_showHUD) {
        [AAIHUD dismissHUDOnView:self.view afterDelay:0];
    }
    
    // End request callback
    NSDictionary *errorInfo = nil;
    if (error) {
        NSString *transactionId = @"";
        if (error.userInfo) {
            transactionId = error.userInfo[@"transactionId"];
            if (!transactionId) {
                transactionId = @"";
            }
        }
        errorInfo = @{
            @"message": error.localizedDescription,
            @"code": @(error.code),
            @"transactionId": transactionId
        };
    }
    
    if (self.endRequestBlk) {
        self.endRequestBlk(self, errorInfo);
    }
    
    // Detection failed callback
    if (error) {
        [self detectionDidFailed: errorInfo];
    }
}

- (void)dealloc
{
    //If `viewDidLoad` method not called, we do nothing.
    if (_util != nil) {
        [AAILocalizationUtil stopMonitor];
        [_util removeVolumeView];
        [_prepareStageTimer invalidate];
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"kAAIRestart" object:nil];
        [[AVAudioSession sharedInstance] removeObserver:self forKeyPath:@"outputVolume"];
    }
}

@end
