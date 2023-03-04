//
//  AAICustomLD03Controller.m
//  LivenessSDKObjCDemo
//
//  Created by advance on 2022/12/7.
//

#import "AAICustomLD03Controller.h"

@interface AAICustomLD03Controller ()
{
    UILabel *_myTitleLabel;
    UIImageView *_myImgBorderView;
}
@end

@implementation AAICustomLD03Controller

- (void)livenessWrapViewDidLoad:(AAILivenessWrapView *)wrapView
{
    [super livenessWrapViewDidLoad:wrapView];
    
    // Subclass can override this method to customize the UI
//    wrapView.backgroundColor = [UIColor grayColor];
//    wrapView.roundBorderView.layer.borderColor = [UIColor redColor].CGColor;
//    wrapView.roundBorderView.layer.borderWidth = 2;
     
    // Custom corner radius and the shape of the preview area
    CGFloat cornerRadius = 0;
    wrapView.roundBorderView.layer.cornerRadius = cornerRadius;
    wrapView.configAvatarPreviewPathV2 = ^(CGRect avatarPreviewFrame, UIBezierPath * _Nonnull originRectPath, AAILivenessWrapView * _Nonnull originWrapView) {
        UIBezierPath *squarePath = [UIBezierPath bezierPathWithRoundedRect:avatarPreviewFrame cornerRadius:cornerRadius];
        [originRectPath appendPath: [squarePath bezierPathByReversingPath]];
    };

    /*
    //Custom preview area margin top
    wrapView.configAvatarPreviewMarginTop = ^CGFloat(CGRect wrapViewFrame) {
        return 64;
    };
     
    //Custom preview area width
    wrapView.configAvatarPreviewWidth = ^CGFloat(CGRect wrapViewFrame) {
        return 300;
    };
    */
    
    /*
    // Configure roundBorderView or hide it or add your own if needed
    wrapView.roundBorderView.hidden = YES;
     */
}

- (void)loadAdditionalUI
{
    [super loadAdditionalUI];
    
    // Configure your own UI
    // e.g. Remove UI controls that are not important to you.
    _stateImgView.hidden = YES;
    
    [_voiceBtn removeFromSuperview];
    
    _timeLabel.textColor = [UIColor blueColor];
    _timeLabel.layer.borderColor = [UIColor blackColor].CGColor;
    _stateLabel.textColor = [UIColor blackColor];
    
    UIImage *backBtnImg = [_backBtn imageForState:UIControlStateHighlighted];
    if (backBtnImg) {
        UIImage *newBackBtnImg = [backBtnImg imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [_backBtn setImage:newBackBtnImg forState:UIControlStateNormal];
        _backBtn.tintColor = [UIColor redColor];
    }
    
    // Add your UI
    _myTitleLabel = [[UILabel alloc] init];
    _myTitleLabel.textColor = [UIColor greenColor];
    _myTitleLabel.textAlignment = NSTextAlignmentCenter;
    _myTitleLabel.text = self.title;
    [self.view addSubview:_myTitleLabel];
    
    _myImgBorderView = [[UIImageView alloc] init];
    _myImgBorderView.layer.borderColor = UIColor.blueColor.CGColor;
    _myImgBorderView.layer.borderWidth = 2;
    [self.view addSubview:_myImgBorderView];
}

- (void)layoutAdditionalUI
{
    [super layoutAdditionalUI];
    
    // Ajust UI
    CGFloat offsetY = 10;
    CGRect originFrame = _backBtn.frame;
    originFrame.origin.y -= offsetY;
    _backBtn.frame = originFrame;
    
    originFrame = _timeLabel.frame;
    originFrame.origin.y -= offsetY;
    _timeLabel.frame = originFrame;
    
    CGFloat sw = self.view.frame.size.width;
    CGRect titleLabelBound = CGRectMake(0, 0, (sw - CGRectGetMaxX(_backBtn.frame) * 2), _backBtn.frame.size.height);
    _myTitleLabel.bounds = titleLabelBound;
    _myTitleLabel.center = CGPointMake(sw/2, _backBtn.center.y);
    
    _myImgBorderView.frame = _roundViewFrame;
}

- (void)tapBackBtnAction
{
    // Customize the back button logic
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

@end
