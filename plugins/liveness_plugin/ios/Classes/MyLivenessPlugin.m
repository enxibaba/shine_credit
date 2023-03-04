#import "MyLivenessPlugin.h"
@import AAILivenessSDK;
#import "AAILivenessViewController.h"

@interface AAICustomLivenessViewController: AAILivenessViewController
@end
@implementation AAICustomLivenessViewController

- (void)tapBackBtnAction
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end

@interface MyLivenessPlugin()
{
    BOOL _collectImgSequence;
    NSInteger _actionTimeoutInterval;
}
@property(nonatomic, copy, nullable) NSArray<NSNumber *> *detectionActions;
@property(nonatomic, strong) FlutterMethodChannel *methodChannel;
@end

@implementation MyLivenessPlugin

- (instancetype)init {
    self = [super init];
    if (self) {
        _collectImgSequence = NO;
        _actionTimeoutInterval = -1;
    }
    return self;
}

- (void)dealloc {
    
}

- (void)livenessDetectionComplete:(NSDictionary *)resultInfo {
    
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    if (rootVC != NULL) {
        [rootVC dismissViewControllerAnimated:YES completion:^{
            if ([resultInfo[@"isSuccess"] boolValue] == YES) {
                [self.methodChannel invokeMethod:@"onDetectionSuccess" arguments:resultInfo];
            } else {
                [self.methodChannel invokeMethod:@"onDetectionFailure" arguments:resultInfo];
            }
        }];
    }
}

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel* channel = [FlutterMethodChannel methodChannelWithName:@"liveness_plugin" binaryMessenger:[registrar messenger]];
    MyLivenessPlugin* instance = [[MyLivenessPlugin alloc] init];
    instance.methodChannel = channel;
    [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSString *callMethod = call.method;
    if ([@"getPlatformVersion" isEqualToString:callMethod]) {
        result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
    } else if ([@"initSDK" isEqualToString:callMethod]) {
        [self initSDK:call result:result];
    } else if ([@"initSDKOfLicense" isEqualToString:callMethod]) {
        [self initSDKOfLicense:call result:result];
    } else if ([@"setLicenseAndCheck" isEqualToString:callMethod]) {
        [self configLicenseAndCheck:call result:result];
    } else if ([@"startLivenessDetection" isEqualToString:callMethod]) {
        [self startLivenessDetection];
    } else if ([@"setActionSequence" isEqualToString:callMethod]) {
        [self configActionSequence:call result:result];
    } else if ([@"bindUser" isEqualToString:callMethod]) {
        [self configUserId:call result:result];
    } else if ([@"getSDKVersion" isEqualToString:callMethod]) {
        result([AAILivenessSDK sdkVersion]);
    } else if ([@"getLatestDetectionResult" isEqualToString:callMethod]) {
        result(FlutterMethodNotImplemented);
    } else if ([@"setDetectOcclusion" isEqualToString:callMethod]) {
        [self configDetectOcclusion:call result:result];
    } else if ([@"setResultPictureSize" isEqualToString:callMethod]) {
        [self configResultPictureSize:call result:result];
    } else if ([@"setCollectImageSequence" isEqualToString:callMethod]) {
        [self configCollectImgSequence:call result:result];
    } else if ([@"setDetectionLevel" isEqualToString:callMethod]) {
        [self configDetectionLevel:call result:result];
    } else if ([@"setActionTimeoutMills" isEqualToString:callMethod]) {
        [self configActionTimeoutMills:call result:result];
    } else {
        result(FlutterMethodNotImplemented);
    }
}

- (void)initSDK:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary *params = call.arguments;
    if (params == NULL) {
        result([FlutterError errorWithCode:@"ERROR_NULL" message:@"call.arguments is NULL" details:nil]);
        return;
    }
    
    NSString *marketStr = params[@"market"];
    if (marketStr == NULL) {
        result([FlutterError errorWithCode:@"ERROR_NULL" message:@"market is NULL" details:nil]);
        return;
    }
    
    NSInteger market = [self marketOfValue:marketStr];
    if (market < 0) {
        NSString *errorMsg = [NSString stringWithFormat:@"Market %@ is not support on iOS", marketStr];
        result([FlutterError errorWithCode:@"ERROR_MARKET" message:errorMsg details:nil]);
        return;
    }
    
    NSString *accessKey = params[@"accessKey"];
    NSString *secretKey = params[@"secretKey"];
    if (accessKey == NULL || secretKey == NULL) {
        result([FlutterError errorWithCode:@"ERROR_KEY" message:@"accessKey or secretKey is NULL" details:nil]);
        return;
    }

    BOOL isGlobalService = NO;
    NSNumber *isGlobalServiceObj = params[@"isGlobalService"];
    if (isGlobalServiceObj) {
        isGlobalService = [isGlobalServiceObj boolValue];
    }
    [AAILivenessSDK initWithAccessKey:accessKey secretKey:secretKey market:(AAILivenessMarket)market isGlobalService:isGlobalService];
}

- (void)initSDKOfLicense:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary *params = call.arguments;
    if (params == NULL) {
        result([FlutterError errorWithCode:@"ERROR_NULL" message:@"call.arguments is NULL" details:nil]);
        return;
    }
    
    NSString *marketStr = params[@"market"];
    if (marketStr == NULL) {
        result([FlutterError errorWithCode:@"ERROR_NULL" message:@"market is NULL" details:nil]);
        return;
    }
    
    NSInteger market = [self marketOfValue:marketStr];
    if (market < 0) {
        NSString *errorMsg = [NSString stringWithFormat:@"Market %@ is not support on iOS", marketStr];
        result([FlutterError errorWithCode:@"ERROR_MARKET" message:errorMsg details:nil]);
        return;
    }
    
    BOOL isGlobalService = NO;
    NSNumber *isGlobalServiceObj = params[@"isGlobalService"];
    if (isGlobalServiceObj) {
        isGlobalService = [isGlobalServiceObj boolValue];
    }
    [AAILivenessSDK initWithMarket:(AAILivenessMarket)market isGlobalService:isGlobalService];
}

- (void)startLivenessDetection {
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    if (rootVC != NULL) {
        AAICustomLivenessViewController *livenessVC = [[AAICustomLivenessViewController alloc] init];
        
        if (self.detectionActions != NULL && self.detectionActions.count > 0) {
            livenessVC.detectionActions = self.detectionActions;
        }

        if (_actionTimeoutInterval > 0) {
            livenessVC.actionTimeoutInterval = _actionTimeoutInterval;
        }
        
        livenessVC.detectionSuccessBlk = ^(AAILivenessViewController * rawVC, AAILivenessResult * result) {
            NSString *base64Str = [UIImageJPEGRepresentation(result.img, 1) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
            NSDictionary *tmpUserInfo = @{
                @"base64Image": base64Str,
                @"livenessId": result.livenessId,
                @"isSuccess": @(YES),
                @"message": @"SUCCESS",
                @"transactionId": result.transactionId
            };
            NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] initWithDictionary:tmpUserInfo];
            if (self->_collectImgSequence) {
                userInfo[@"imageSequenceList"] = result.imageSequenceList;
            } else {
                userInfo[@"imageSequenceList"] = @[];
            }
            [self livenessDetectionComplete:userInfo];
        };
        livenessVC.detectionFailedBlk = ^(AAILivenessViewController * rawVC, NSDictionary *errorInfo) {
            NSString *transactionId = errorInfo[@"transactionId"];
            NSString *message = errorInfo[@"message"];
            NSString *code = @"FAILED";
            if (transactionId) {
                // network request failed
                code = @"network_request_failed";
            } else {
                // action detection failed
                code = errorInfo[@"key"];
                message = errorInfo[@"state"];
            }
            
            if (transactionId == nil) {
                transactionId = @"";
            }
            if (code == nil) {
                code = @"";
            }
            if (message == nil) {
                message = @"";
            }
            
            NSDictionary *userInfo = @{
                @"isSuccess": @(NO),
                @"code": [code uppercaseString],
                @"message": message,
                @"transactionId": transactionId
            };
            [self livenessDetectionComplete:userInfo];
        };
        UINavigationController *navc = [[UINavigationController alloc] initWithRootViewController:livenessVC];
        navc.navigationBarHidden = YES;
        navc.modalPresentationStyle = UIModalPresentationFullScreen;
        [rootVC presentViewController:navc animated:YES completion:nil];
    }
}

- (void)configActionSequence:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary *params = call.arguments;
    if (params == NULL) {
        result([FlutterError errorWithCode:@"ERROR_NULL" message:@"call.arguments is NULL" details:nil]);
        return;
    }
    
    NSArray<NSString *> *actionSequence = params[@"actionSequence"];
    if (actionSequence == NULL) {
        result([FlutterError errorWithCode:@"ERROR_ACTION_SEQUENCE" message:@"actionSequence is NULL" details:nil]);
        return;
    }
    
    NSNumber *shuffleObj = params[@"shuffle"];
    if (shuffleObj == NULL) {
        result([FlutterError errorWithCode:@"ERROR_SHUFFLE" message:@"shuffle is NULL" details:nil]);
        return;
    }
    
    NSMutableArray<NSNumber *> *actionTypeList = [[NSMutableArray alloc] init];
    for (NSString *actionStr in actionSequence) {
        NSInteger actionType = [self actionOfValue:actionStr];
        if (actionType < 0) {
            NSString *errorMsg = [NSString stringWithFormat:@"Action %@ is not support", actionStr];
            result([FlutterError errorWithCode:@"ERROR_ACTION" message:errorMsg details:nil]);
            return;
        } else {
            [actionTypeList addObject:@(actionType)];
        }
    }
    
    // Random index array
    BOOL shuffle = [shuffleObj boolValue];
    if (shuffle) {
        NSUInteger idx = actionTypeList.count - 1;
        while (idx) {
            [actionTypeList exchangeObjectAtIndex:idx withObjectAtIndex:arc4random_uniform((uint32_t)idx)];
            idx--;
        }
    }
    
    self.detectionActions = [actionTypeList copy];
}

- (void)configLicenseAndCheck:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary *params = call.arguments;
    if (params == NULL) {
        result([FlutterError errorWithCode:@"ERROR_NULL" message:@"call.arguments is NULL" details:nil]);
        return;
    }
    
    NSString *licenseStr = params[@"license"];
    if (licenseStr == NULL) {
        result(@"ERROR_NULL: license is null");
        return;
    }
    
    NSString *checkResult = [AAILivenessSDK configLicenseAndCheck:licenseStr];
    result(checkResult);
}

- (void)configUserId:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary *params = call.arguments;
    if (params == NULL) {
        result([FlutterError errorWithCode:@"ERROR_NULL" message:@"call.arguments is NULL" details:nil]);
        return;
    }
    NSString *userId = params[@"userId"];
    if (userId) {
        [AAILivenessSDK configUserId: userId];
    }
}

- (void)configDetectOcclusion:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary *params = call.arguments;
    if (params == NULL) {
        result([FlutterError errorWithCode:@"ERROR_NULL" message:@"call.arguments is NULL" details:nil]);
        return;
    }
    
    BOOL detectOcclusion = NO;
    NSNumber *detectOcclusionObj = params[@"detectOcclusion"];
    if (detectOcclusionObj) {
        detectOcclusion = [detectOcclusionObj boolValue];
    }
    [AAILivenessSDK configDetectOcclusion:detectOcclusion];
}

- (void)configCollectImgSequence:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary *params = call.arguments;
    if (params == NULL) {
        result([FlutterError errorWithCode:@"ERROR_NULL" message:@"call.arguments is NULL" details:nil]);
        return;
    }
    _collectImgSequence = NO;
    NSNumber *collectImgSequenceObj = params[@"collectImgSequence"];
    if (collectImgSequenceObj) {
        _collectImgSequence = [collectImgSequenceObj boolValue];
    }
}

- (void)configResultPictureSize:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary *params = call.arguments;
    if (params == NULL) {
        result([FlutterError errorWithCode:@"ERROR_NULL" message:@"call.arguments is NULL" details:nil]);
        return;
    }
    
    NSNumber *resultPictureSizeObj = params[@"resultPictureSize"];
    if (resultPictureSizeObj) {
        NSInteger resultPictureSize = [resultPictureSizeObj integerValue];
        [AAILivenessSDK configResultPictureSize:resultPictureSize];
    }
}

- (void)configDetectionLevel:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary *params = call.arguments;
    if (params == NULL) {
        result([FlutterError errorWithCode:@"ERROR_NULL" message:@"call.arguments is NULL" details:nil]);
        return;
    }

    NSString *detectionLevelObj = params[@"detectionLevel"];
    if (detectionLevelObj) {
        AAIAdditionalConfig *additionalConfig = [AAILivenessSDK additionalConfig];
        if ([detectionLevelObj.lowercaseString isEqualToString:@"easy"]) {
            additionalConfig.detectionLevel = AAIDetectionLevelEasy;
        } else if ([detectionLevelObj.lowercaseString isEqualToString:@"normal"]) {
            additionalConfig.detectionLevel = AAIDetectionLevelNormal;
        } else if ([detectionLevelObj.lowercaseString isEqualToString:@"hard"]) {
            additionalConfig.detectionLevel = AAIDetectionLevelHard;
        }
    }
}

- (void)configActionTimeoutMills:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary *params = call.arguments;
    if (params == NULL) {
        result([FlutterError errorWithCode:@"ERROR_NULL" message:@"call.arguments is NULL" details:nil]);
        return;
    }

    NSNumber *actionTimeoutMillsObj = params[@"actionTimeoutMills"];
    if (actionTimeoutMillsObj) {
        NSInteger actionTimeoutMills = [actionTimeoutMillsObj integerValue];
        _actionTimeoutInterval = actionTimeoutMills/1000;
    }
}

- (NSInteger)marketOfValue:(NSString *)marketStr {
    NSInteger market = -1;
    if ([marketStr.lowercaseString isEqualToString:@"indonesia"]) {
        market = AAILivenessMarketIndonesia;
    } else if ([marketStr.lowercaseString isEqualToString:@"india"]) {
        market = AAILivenessMarketIndia;
    } else if ([marketStr.lowercaseString isEqualToString:@"philippines"]) {
        market = AAILivenessMarketPhilippines;
    } else if ([marketStr.lowercaseString isEqualToString:@"vietnam"]) {
        market = AAILivenessMarketVietnam;
    } else if ([marketStr.lowercaseString isEqualToString:@"thailand"]) {
        market = AAILivenessMarketThailand;
    } else if ([marketStr.lowercaseString isEqualToString:@"mexico"]) {
        market = AAILivenessMarketMexico;
    } else if ([marketStr.lowercaseString isEqualToString:@"malaysia"]) {
        market = AAILivenessMarketMalaysia;
    } else if ([marketStr.lowercaseString isEqualToString:@"pakistan"]) {
        market = AAILivenessMarketPakistan;
    } else if ([marketStr.lowercaseString isEqualToString:@"nigeria"]) {
        market = AAILivenessMarketNigeria;
    } else if ([marketStr.lowercaseString isEqualToString:@"laos"]) {
        market = AAILivenessMarketLAOS;
    } else if ([marketStr.lowercaseString isEqualToString:@"cambodia"]) {
        market = AAILivenessMarketCambodia;
    } else if ([marketStr.lowercaseString isEqualToString:@"myanmar"]) {
        market = AAILivenessMarketMyanmar;
    } else if ([marketStr.lowercaseString isEqualToString:@"singapore"]) {
        market = AAILivenessMarketSingapore;
    } else if ([marketStr.lowercaseString isEqualToString:@"canada"]) {
        market = AAILivenessMarketCanada;
    } else if ([marketStr.lowercaseString isEqualToString:@"america"]) {
        market = AAILivenessMarketAmerica;
    } else if ([marketStr.lowercaseString isEqualToString:@"unitedkingdom"]) {
        market = AAILivenessMarketUnitedKingdom;
    } else if ([marketStr.lowercaseString isEqualToString:@"colombia"]) {
        market = AAILivenessMarketColombia;
    }
    
    return market;
}

- (NSInteger)actionOfValue:(NSString *)actionStr {
    NSInteger actionType = -1;
    if ([actionStr.lowercaseString isEqualToString:@"mouth"]) {
        actionType = AAIDetectionTypeMouth;
    } else if ([actionStr.lowercaseString isEqualToString:@"blink"]) {
        actionType = AAIDetectionTypeBlink;
    } else if ([actionStr.lowercaseString isEqualToString:@"pos_yaw"]) {
        actionType = AAIDetectionTypePosYaw;
    }
    
    return actionType;
}

@end
