//
//  TileView.m
//  UberLaunchAnimating_OC
//
//  Created by JimmyOu on 16/9/27.
//  Copyright © 2016年 JimmyOu. All rights reserved.
//

#import "TileView.h"
#import "Contans.h"
@implementation TileView

static UIImage *_chimesSplashImage = nil;
static NSArray *_rippleAnimationKeyTimes = nil;
- (instancetype)initWithTitleFileName:(NSString *)fileName
{
    _chimesSplashImage = [UIImage imageNamed:fileName];
    _rippleAnimationKeyTimes = @[@0,@0.61,@0.7,@0.887,@1];
    self = [self initWithFrame:CGRectZero];
    _shouldEnableRipple = NO;
    self.frame = CGRectMake(0, 0, _chimesSplashImage.size.width, _chimesSplashImage.size.height);
    
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame: frame]) {
        self.layer.contents = (__bridge id _Nullable)(_chimesSplashImage.CGImage);
        self.layer.shouldRasterize = YES;
    }
    return self;
}
- (void)startAnimatingWithDuration:(NSTimeInterval)duration
                         beginTime:(NSTimeInterval)beginTime
                       rippleDelay:(NSTimeInterval)rippleDelay
                      rippleOffset:(CGPoint)rippleOffset
{
    CAMediaTimingFunction *timingFunction = [[CAMediaTimingFunction alloc] initWithControlPoints:0.25 :0 :0.2 :1];
    CAMediaTimingFunction *linearFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    CAMediaTimingFunction *easeOutFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    CAMediaTimingFunction *easeInOutTimingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    NSValue *zeroPointValue = [NSValue valueWithCGPoint:CGPointZero];
    
    NSMutableArray<CAAnimation *> *animations = [NSMutableArray array];
    if (_shouldEnableRipple)
    {
        // Transform.scale
        CAKeyframeAnimation *scaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnimation.values = @[@1, @1, @1.05, @1, @1];
        scaleAnimation.keyTimes = _rippleAnimationKeyTimes;
        scaleAnimation.timingFunctions = @[linearFunction, timingFunction, timingFunction, linearFunction];
        scaleAnimation.beginTime = 0.0;
        scaleAnimation.duration = duration;
        [animations addObject:scaleAnimation];
        
        // Position
        CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        positionAnimation.duration = duration;
        positionAnimation.timingFunctions = @[linearFunction, timingFunction, timingFunction, linearFunction];
        positionAnimation.keyTimes = _rippleAnimationKeyTimes;
        positionAnimation.values = @[zeroPointValue, zeroPointValue, [NSValue valueWithCGPoint:rippleOffset], zeroPointValue, zeroPointValue];
        positionAnimation.additive = YES;
        [animations addObject:positionAnimation];
        
    }
    
    // Opacity
    CAKeyframeAnimation *opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.duration = duration;
    opacityAnimation.timingFunctions = @[easeInOutTimingFunction, timingFunction, timingFunction, easeOutFunction, linearFunction];
    opacityAnimation.keyTimes = @[@0.0, @0.61, @0.7, @0.767, @0.95, @1.0];
    opacityAnimation.values = @[@0.0, @1.0, @0.45, @0.6, @0.0, @0.0];
    [animations addObject:opacityAnimation];
    
    // Group
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.repeatCount = MAXFLOAT;
    groupAnimation.fillMode = kCAFillModeBackwards;
    groupAnimation.duration = duration;
    groupAnimation.beginTime = beginTime + rippleDelay;
    groupAnimation.removedOnCompletion = NO;
    groupAnimation.animations = animations;
    groupAnimation.timeOffset = kAnimationTimeOffset;
    [self.layer addAnimation:groupAnimation forKey:@"ripple"];
    
}

- (void)stopAnimating
{
    [self.layer removeAllAnimations];
}

@end
