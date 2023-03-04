//
//  AAILivenessResult.h
//  AAILivenessSDK
//
//  Created by advance on 2022/10/28.
//  Copyright © 2022 Advance.ai. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AAILivenessResult : NSObject

/// The best quality image captured by the SDK.
///
/// Note that the default image size is 600x600. You can call `[AAILivenessSDK configResultPictureSize:]` method to customize the size of the image.
@property(nonatomic, strong, readonly) UIImage *img;

/// LivenessId. This value can be used to call the anti-spoofing api.
@property(nonatomic, strong, readonly) NSString *livenessId;

@property(nonatomic, strong, readonly, nullable) UIImage *highestQualityOriginSquareImage;

@property(nonatomic, readonly) CGFloat uploadImgCostMillSeconds;

@property(nonatomic, strong, nullable) NSString *transactionId;

/// Base64 string list. It will contain one image for each action, and two images of the best quality.
- (NSArray<NSString *> * _Nullable)imageSequenceList;

@end

NS_ASSUME_NONNULL_END
