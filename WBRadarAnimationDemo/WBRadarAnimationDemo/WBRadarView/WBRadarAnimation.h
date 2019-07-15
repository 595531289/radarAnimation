//
//  WBRadarAnimation.h
//  NewTongDaOA
//
//  Created by 王斌 on 2019/7/12.
//  Copyright © 2019 wangbin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WBRadarAnimation : UIView

// Radar color gradually  *default yellowColor
@property (nonatomic, strong) UIColor * radarColor;

//Radar multiple  *default 3
@property (nonatomic, assign) CGFloat scaleTimes;

//Radar  Duration  *default 2.5second
@property (nonatomic, assign) CFTimeInterval singleRadarDuration;



- (instancetype )initWithFrame:(CGRect)frame;

- (void)startRadarAnimation;

- (void)stopRadarAnimation;

@end

NS_ASSUME_NONNULL_END
