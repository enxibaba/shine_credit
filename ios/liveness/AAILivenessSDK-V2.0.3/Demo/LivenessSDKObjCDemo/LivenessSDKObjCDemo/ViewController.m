//
//  ViewController.m
//  LivenessSDKObjCDemo
//
//  Created by advance on 2021/7/21.
//

#import "ViewController.h"
@import AAILiveness;
#import "AAICustomLD03Controller.h"

@interface ViewController ()
{
    NSInteger _testType;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Init SDK
    [AAILivenessSDK initWithMarket:AAILivenessMarketIndonesia];
    
    // Configure SDK
    /*
    // Set the size(width) of `img` in `AAILivenessResult`. Image size(width) should be in range [300, 1000], default image size(width) is 600(600x600).
    [AAILivenessSDK configResultPictureSize:600];
    */

    /*
    // Set whether to detect face occlusion. The default value is NO.
    [AAILivenessSDK configDetectOcclusion:YES];
    */

    /*
    // Set action detection time interval. Default is 10s.
    [AAILivenessSDK configActionTimeoutSeconds: 10];
    */
    
    /*
    AAIAdditionalConfig *additionalConfig = [AAILivenessSDK additionalConfig];
    // Set the color of the round border in the avatar preview area. Default is clear color.
    // additionalConfig.roundBorderColor = [UIColor colorWithRed:0.36 green:0.768 blue:0.078 alpha:1.0];

    // Set the color of the ellipse dashed line that appears during the liveness detection. Default is white color.
    // additionalConfig.ellipseLineColor = [UIColor greenColor];

    // Set the level of liveness detection. Default is AAIDetectionLevelNormal.
    // Available levels are AAIDetectionLevelEasy, AAIDetectionLevelNormal, AAIDetectionLevelHard
    // The harder it is, the stricter the verification is.
    // additionalConfig.detectionLevel = AAIDetectionLevelNormal;
    */

    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, [UIScreen mainScreen].bounds.size.width, 40)];
    label.text = [NSString stringWithFormat:@"SDK version: %@", [AAILivenessSDK sdkVersion]];
    [self.view addSubview:label];
    
    [self addButton:@"Default test" frame:CGRectMake(40, 140, 140, 40) action:@selector(tapSDKBtnAction)];
    [self addButton:@"CustomUI test 03" frame:CGRectMake(40, 200, 200, 40) action:@selector(tapCustomUIBtn03Action)];
}

- (void)addButton:(NSString *)title frame:(CGRect)frame action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)tapSDKBtnAction
{
    _testType = 0;
    [self checkLicenseAndShowSDK];
}

- (void)tapCustomUIBtn03Action
{
    _testType = 3;
    [self checkLicenseAndShowSDK];
}

- (void)checkLicenseAndShowSDK
{
    // Load License
    /*
     The license content is obtained by your server calling our openapi.
     In order to facilitate the demonstration of this SDK, we directly put the content of the license into the file, in fact, you should call your server api to get the license content.
     */
    NSString *path = [[NSBundle mainBundle] pathForResource:@"SDK-DEMO-LICENSE" ofType:nil];
    if (path == NULL) {
        NSLog(@"SDK-DEMO-LICENSE file not exist!");
        return;
    }
    NSString *demoLicenseContent = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSString *checkResult = [AAILivenessSDK configLicenseAndCheck:demoLicenseContent];
    if ([checkResult isEqualToString:@"SUCCESS"]) {
       // license is valid, show SDK page
        [self showSDK];
    } else if ([checkResult isEqualToString:@"LICENSE_EXPIRE"]) {
        NSLog(@"LICENSE_EXPIRE: please call your server's api to generate a new license");
    } else if ([checkResult isEqualToString:@"APPLICATION_ID_NOT_MATCH"]) {
        NSLog(@"APPLICATION_ID_NOT_MATCH: please bind your app's bundle identifier on our cms website, then recall your server's api to generate a new license");
    } else {
        NSLog(@"%@", checkResult);
    }
}

- (void)showSDK
{
    // Demo: Push default liveness view controller
    if (_testType == 0) {
        AAILivenessViewController *vc = [[AAILivenessViewController alloc] init];
        vc.detectionSuccessBlk = ^(AAILivenessViewController * _Nonnull rawVC, AAILivenessResult * _Nonnull result) {
            // Get livenessId
            NSString *livenessId = result.livenessId;
            UIImage *bestImg = result.img;
            CGSize size = bestImg.size;
            NSLog(@">>>>>livenessId: %@, imgSize: %.2f, %.2f", livenessId, size.width, size.height);
            // Do something... (e.g., call anti-spoofing api to get score)
            
            [rawVC.navigationController popViewControllerAnimated:YES];
        };
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    // Demo: Present custom liveness view controller
    if (_testType == 3) {
        AAICustomLD03Controller *vc = [[AAICustomLD03Controller alloc] init];
        vc.title = @"Take a Selfie";
        vc.detectionSuccessBlk = ^(AAILivenessViewController * _Nonnull rawVC, AAILivenessResult * _Nonnull result) {
            // Get livenessId
            NSString *livenessId = result.livenessId;
            UIImage *bestImg = result.img;
            CGSize size = bestImg.size;
            NSLog(@">>>>>livenessId: %@, imgSize: %.2f, %.2f", livenessId, size.width, size.height);
            // Do something... (e.g., call anti-spoofing api to get score)

            [rawVC.presentingViewController dismissViewControllerAnimated:YES completion:nil];
        };
        UINavigationController *navc = [[UINavigationController alloc] initWithRootViewController:vc];
        navc.navigationBarHidden = YES;
        navc.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:navc animated:YES completion:nil];
    }
}


@end
