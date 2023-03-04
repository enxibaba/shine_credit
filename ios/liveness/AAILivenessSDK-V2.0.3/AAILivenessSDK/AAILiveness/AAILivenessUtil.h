//
//  AAILivenessUtil.h
//  AAILivenessDemo
//
//  Created by Advance.ai on 2019/3/2.
//  Copyright © 2019 Advance.ai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AAILivenessSDK/AAILivenessSDK.h>

NS_ASSUME_NONNULL_BEGIN

@interface AAILivenessUtil : NSObject

+ (BOOL)isSilent;
- (void)configPlayerVolume:(float)volume;
- (void)configVolume:(float)volume;
- (void)playAudio:(NSString *)audioName;
- (void)playAudio:(NSString *)audioName lprojName:(NSString * _Nullable)lprojName;
- (void)removeVolumeView;

+ (NSString *)currLanguageKey;
+ (NSString *)localStrForKey:(NSString *)key;
+ (NSString *)localStrForKey:(NSString *)key lprojName:(NSString * _Nullable)lprojName;

+ (UIImage *)imgWithName:(NSString *)imgName;
+ (NSArray<UIImage *> * _Nullable)stateImgWithType:(AAIDetectionType)detectionType;

- (void)saveCurrBrightness;
- (void)graduallySetBrightness:(CGFloat)value;
- (void)graduallyResumeBrightness;
- (void)fastResumeBrightness;

@end

@interface AAITimerWrapper : NSObject

@property(nonatomic, weak) NSTimer *timer;

+ (AAITimerWrapper *)scheduledTimerWithTimeInterval:(NSTimeInterval)timeInterval
                                            repeats:(BOOL)repeats
                                          execBlock:(void(^)(AAITimerWrapper *timerWrapper))execBlock;
- (void)invalidate;

@end
NS_ASSUME_NONNULL_END
