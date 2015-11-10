//
//  TheAnimator.h
//  SmartCooler
//
//  Created by Mayes, Arthur E. on 11/4/15.
//  Copyright © 2015 Mayes, Arthur E. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TheAnimator : NSObject

- (void)roundView:(UIView *)view;


- (void)addRandomGradient:(UIView *)view;


- (void)addGradientWithColors:(NSArray *)colors toView:(UIView *)view;


- (void)addRandomAnimation:(UIView *)view;


- (CAAnimation *)fadeAnimation;

- (CAAnimation*)stretchUpAnimation;

- (CAAnimation *)stretchOutAnimation;

- (CAAnimation *)pulseAnimation;

- (CAAnimation *)radarAnimationWithDuration:(double)duration;

- (CAAnimation *)fadeOutAnimationWithDuration:(double)duration;

@end
