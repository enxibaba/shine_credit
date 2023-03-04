//
//  AAILivenessResultViewController.h
//  AAILivenessDemo
//
//  Created by Advance.ai on 2019/2/25.
//  Copyright © 2019 Advance.ai. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AAILivenessResultViewController : UIViewController

///If stateKey not exist in AAILanguageString.bundle, resultLabel or stateLabel's content will be stateKey.
- (instancetype)initWithResult:(BOOL)succeed resultState:(NSString * _Nullable)stateKey;

- (instancetype)initWithResultInfo:(NSDictionary *)resultInfo;

/// Specify which language to use for the SDK.
///
/// The languages currently supported by sdk are as follows:
/// \code
/// "en" "id"  "vi"  "zh-Hans"  "th"  "es"  "ms" "hi"
@property(nonatomic, copy, nullable) NSString *language;

@end

NS_ASSUME_NONNULL_END
