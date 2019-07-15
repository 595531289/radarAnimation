//
//  WBRadarAnimation.m
//  NewTongDaOA
//
//  Created by 王斌 on 2019/7/12.
//  Copyright © 2019 wangbin. All rights reserved.
//

#import "WBRadarAnimation.h"
#define KRGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

@interface WBRadarAnimation()

@property (nonatomic, strong) CALayer * pulsingLayer1;
@property (nonatomic, strong) CALayer * pulsingLayer2;
@property (nonatomic, strong) CALayer * pulsingLayer3;

@property (nonatomic, strong) UIImageView *imv;//Here,Combined with robot more vivid animation("imv" alternative or delete)

@end

@implementation WBRadarAnimation

- (instancetype )initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0];
        self.layer.masksToBounds = NO;
        self.clipsToBounds = NO;
        [self addSubview:self.imv];
        [self addImageViewAnimation];
        [self addAnimationLayer];
        
    }
    return self;
}
#pragma mark start animation
- (void)startRadarAnimation{
    //robot animating(alternative or delete)
    [self.imv startAnimating];
    self.hidden = NO;
    [self startAnimation];
}
#pragma mark stop animation

- (void)stopRadarAnimation{
    [self.imv stopAnimating];
    [self stopAnimation];
    self.hidden = YES;
}
- (void)addAnimationLayer {
    CGFloat width = self.frame.size.width - 2;
    
    _pulsingLayer1 = [CALayer layer];
    _pulsingLayer1.frame = CGRectMake((self.frame.size.width -width)/2, (self.frame.size.width -width)/2, width, width);
    _pulsingLayer1.cornerRadius = width/2;
    _pulsingLayer1.borderColor = self.radarColor?self.radarColor.CGColor:KRGBA(14, 134, 254, 0.5).CGColor;
    _pulsingLayer1.borderWidth = 0.5;
    [self.layer addSublayer:_pulsingLayer1];
    _pulsingLayer2  = [CALayer layer];
    _pulsingLayer2.frame = CGRectMake((self.frame.size.width -width)/2, (self.frame.size.width -width)/2, width, width);
    _pulsingLayer2.cornerRadius = width/2;
    _pulsingLayer2.borderColor = self.radarColor?self.radarColor.CGColor:KRGBA(14, 134, 254, 0.5).CGColor;
    _pulsingLayer2.borderWidth = 0.5;
    [self.layer addSublayer:_pulsingLayer2];
    
    _pulsingLayer3 = [CALayer layer];
    _pulsingLayer3.frame = CGRectMake((self.frame.size.width -width)/2, (self.frame.size.width -width)/2, width, width);
    _pulsingLayer3.cornerRadius = width/2;
    _pulsingLayer3.borderColor = self.radarColor?self.radarColor.CGColor:KRGBA(14, 134, 254, 0.5).CGColor;
    _pulsingLayer3.borderWidth = 0.5;
    [self.layer addSublayer:_pulsingLayer3];
    
    _pulsingLayer1.hidden = YES;
    _pulsingLayer2.hidden = YES;
    _pulsingLayer3.hidden = YES;
}
- (void)addImageViewAnimation{
    NSMutableArray * animateArray = [[NSMutableArray alloc]initWithCapacity:2];
    [animateArray addObject:[UIImage imageNamed:@"home_voice_btn_1"]];
    [animateArray addObject:[UIImage imageNamed:@"home_voice_btn_2"]];
    self.imv.animationImages= animateArray;
    self.imv.animationDuration=1.0;
    self.imv.animationRepeatCount=0;
}

- (void)setRippleColor:(UIColor *)rippleColor{
    _radarColor = rippleColor;
    _pulsingLayer1.borderColor = _radarColor.CGColor;
    _pulsingLayer2.borderColor = _radarColor.CGColor;
    _pulsingLayer3.borderColor = _radarColor.CGColor;
}

- (void)startAnimation {
    _pulsingLayer1.hidden = NO;
    _pulsingLayer2.hidden = NO;
    _pulsingLayer3.hidden = NO;
    [_pulsingLayer1 addAnimation:[self rippleAnimationGroupWithIndex:0] forKey:@"ripple"];//pulsing
    [_pulsingLayer2 addAnimation:[self rippleAnimationGroupWithIndex:1] forKey:@"ripple"];
    [_pulsingLayer3 addAnimation:[self rippleAnimationGroupWithIndex:2] forKey:@"ripple"];
}

- (void)stopAnimation{
    _pulsingLayer1.hidden = YES;
    _pulsingLayer2.hidden = YES;
    _pulsingLayer3.hidden = YES;
    [_pulsingLayer1 removeAllAnimations];
    [_pulsingLayer2 removeAllAnimations];
    [_pulsingLayer3 removeAllAnimations];
}
- (CAAnimationGroup *)rippleAnimationGroupWithIndex:(NSInteger )index{
    NSArray * animateArr = @[[self scaleAnimate]  , [self borderColorAnimate]];
    CAAnimationGroup * group = [CAAnimationGroup animation];
    group.animations = animateArr;
    group.beginTime = CACurrentMediaTime() + (double)index * 0.5;
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    group.duration = self.singleRadarDuration>0?self.singleRadarDuration:2.5;
    group.repeatCount = HUGE;
    group.removedOnCompletion = NO;
    return group;
}

- (CABasicAnimation *)scaleAnimate{
    CABasicAnimation * scaleAnimate = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimate.repeatCount = HUGE;
    scaleAnimate.fromValue = @(1.0);
    scaleAnimate.toValue = self.scaleTimes?@(self.scaleTimes):@(3.0);
    return scaleAnimate;
}

- (CAKeyframeAnimation *)borderColorAnimate{
    CAKeyframeAnimation * animate = [CAKeyframeAnimation animation];
    animate.keyPath = @"borderColor";
    animate.values = @[(__bridge id) [self.radarColor colorWithAlphaComponent:0.5].CGColor ? (__bridge id) [self.radarColor colorWithAlphaComponent:0.5].CGColor : (__bridge id)KRGBA(255, 216, 87, 0.5).CGColor,
                       (__bridge id) [self.radarColor colorWithAlphaComponent:0.4].CGColor ? (__bridge id) [self.radarColor colorWithAlphaComponent:0.4].CGColor : (__bridge id)KRGBA(255,231,152,0.4).CGColor,
                       (__bridge id) [self.radarColor colorWithAlphaComponent:0.2].CGColor ? (__bridge id) [self.radarColor colorWithAlphaComponent:0.2].CGColor : (__bridge id)KRGBA(255, 241, 197, 0.2).CGColor,
                       (__bridge id) [self.radarColor colorWithAlphaComponent:0].CGColor ? (__bridge id) [self.radarColor colorWithAlphaComponent:0].CGColor : (__bridge id)KRGBA(255, 241, 197, 0).CGColor
                       ];
    animate.keyTimes = @[@0.3,@0.6,@0.9,@1];
    return animate;
}

- (UIImageView *)imv {
    if (!_imv) {
        _imv =[[UIImageView alloc]initWithFrame:self.bounds];
    }
    return _imv;
}
@end
