//
//  TheAnimator.m
//  SmartCooler
//
//  Created by Mayes, Arthur E. on 11/4/15.
//  Copyright © 2015 Mayes, Arthur E. All rights reserved.
//

#import "TheAnimator.h"

@implementation TheAnimator

- (void)roundView:(UIView *)view
{
    [view.layer setMasksToBounds:YES];
    [view.layer setCornerRadius:view.frame.size.width/2];
}

- (void)addRandomGradient:(UIView *)view
{
    NSArray *colors = @[[UIColor redColor], [UIColor orangeColor], [UIColor yellowColor], [UIColor greenColor], [UIColor blueColor], [UIColor purpleColor], [UIColor blackColor], [UIColor grayColor]];
    
    NSUInteger int1 = arc4random_uniform((u_int32_t)[colors count]);
    NSUInteger int2 = arc4random_uniform((u_int32_t)[colors count]);
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = view.bounds;
    gradient.colors = @[(id)[colors[int1] CGColor], (id)[colors[int2] CGColor]];
    [view.layer insertSublayer:gradient atIndex:0];
}

- (void)addGradientWithColors:(NSArray *)colors toView:(UIView *)view
{
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = view.bounds;
    gradient.colors = @[(id)[[colors firstObject] CGColor], (id)[[colors lastObject] CGColor]];
    [view.layer insertSublayer:gradient atIndex:0];
}

- (void)addRandomAnimation:(UIView *)view
{
    switch (view.tag) {
        case 0:
        case 1:
        case 4:
            [view.layer addAnimation:[self stretchUpAnimation] forKey:@"up"];
            break;
        case 2:
        case 5:
        case 7:
            [view.layer addAnimation:[self stretchOutAnimation] forKey:@"out"];
            break;
        case 3:
        case 6:
            [view.layer addAnimation:[self pulseAnimation] forKey:@"pulse"];
            break;
    }
}

- (CAAnimation *)fadeAnimation
{
    CABasicAnimation *theAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    NSUInteger int1 = arc4random_uniform(22);
    theAnimation.duration = int1/10;
    theAnimation.repeatCount=HUGE_VALF;
    theAnimation.autoreverses=YES;
    theAnimation.fromValue=[NSNumber numberWithFloat:1.0];
    theAnimation.toValue=[NSNumber numberWithFloat:0.1];
    return theAnimation;
}

- (CAAnimation*)stretchUpAnimation
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.duration = 1.3;
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)];
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.5, 1.3, 2.0)];
    animation.repeatCount = HUGE_VAL;
    [animation setAutoreverses:YES];
    return animation;
}

- (CAAnimation *)stretchOutAnimation
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.duration = 1.5;
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)];
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.3, 0.5, 2.0)];
    animation.repeatCount = HUGE_VAL;
    [animation setAutoreverses:YES];
    return animation;
}

- (CAAnimation *)pulseAnimation
{
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnimation.duration = 1.9;
    scaleAnimation.repeatCount = HUGE_VAL;
    scaleAnimation.autoreverses = YES;
    scaleAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.7, 0.7, 0.9)];
    scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 2.0)];
    return scaleAnimation;
}

- (CAAnimation *)radarAnimationWithDuration:(double)duration
{
    CABasicAnimation *radarAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    radarAnimation.duration = duration;
    radarAnimation.repeatCount = HUGE_VAL;
    radarAnimation.autoreverses = NO;
    radarAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.0, 0.0, 0.0)];
    radarAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)];
    return radarAnimation;
}

- (CAAnimation *)fadeOutAnimationWithDuration:(double)duration
{
    CABasicAnimation *fadeOut = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeOut.toValue = [NSNumber numberWithFloat:0.0];
    fadeOut.duration = duration;
    fadeOut.repeatCount = HUGE_VAL;
    fadeOut.autoreverses = NO;
    return fadeOut;
}


@end
