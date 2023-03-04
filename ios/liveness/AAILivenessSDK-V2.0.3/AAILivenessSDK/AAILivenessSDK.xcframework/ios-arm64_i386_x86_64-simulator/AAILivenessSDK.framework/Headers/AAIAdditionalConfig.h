//
//  AAIAdditionalConfig.h
//  AAILivenessSDK
//
//  Created by advance on 2022/11/17.
//  Copyright © 2022 Advance.ai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AAILivenessSDK/AAIDetectionConstant.h>

NS_ASSUME_NONNULL_BEGIN

@interface AAIAdditionalConfig : NSObject

/// The color of the round border in the avatar preview area. Default is clear color.
@property(nonatomic) UIColor *roundBorderColor;

/// The color of the ellipse dashed line that appears during the liveness detection. Default is white color.
@property(nonatomic) UIColor *ellipseLineColor;

/// The difficulty of liveness detection. Default is AAIDetectionLevelNormal.
@property(nonatomic) AAIDetectionLevel detectionLevel;

@end

NS_ASSUME_NONNULL_END
