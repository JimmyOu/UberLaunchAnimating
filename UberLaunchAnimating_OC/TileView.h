//
//  TileView.h
//  UberLaunchAnimating_OC
//
//  Created by JimmyOu on 16/9/27.
//  Copyright © 2016年 JimmyOu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TileView : UIView

@property (nonatomic,assign) BOOL shouldEnableRipple;
- (instancetype)initWithTitleFileName:(NSString *)fileName;

- (void)startAnimatingWithDuration:(NSTimeInterval)duration
                         beginTime:(NSTimeInterval)beginTime
                       rippleDelay:(NSTimeInterval)rippleDelay
                      rippleOffset:(CGPoint)rippleOffset;

- (void)stopAnimating;
@end
