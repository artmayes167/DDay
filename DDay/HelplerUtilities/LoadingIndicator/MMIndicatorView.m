//
//  ACNIndicatorView.m
//
//  Created by Jyrki Hoisko
//  Copyright (c) 2015 Accenture. All rights reserved.
//

#import "MMIndicatorView.h"
#import <QuartzCore/QuartzCore.h>

static const CGFloat side = 100;
static const CGFloat headerGap = 63;
static const NSTimeInterval MINIMUM_TIME_TO_SHOW_INDICATOR = 0.5;   // Minimum time indicator is shown even if dismissed.
static const NSTimeInterval INDICATOR_START_DELAY = 0.1;            // The indicator can be dismissed within start delay.

@interface MMIndicatorView()
@property (strong, nonatomic) NSDate *startedAnimatingAt;
@property (nonatomic) BOOL isAnimatingIndicator;
@property (nonatomic) bool shouldAnimate;
@end

//static int DEVICE_WIDTH = 600; // Todo: make dynamic!
//static int DEVICE_HEIGHT = 600; // Todo: make dynamic!

@implementation MMIndicatorView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)init {
    
    UIView *parentView = [self containerView];
    
    self = [super initWithFrame:CGRectMake(parentView.center.x, parentView.center.y-headerGap, side, side)];
    if (self) {
        UIView *IndicatorView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, side, side)];
        IndicatorView.layer.cornerRadius = 5;
        IndicatorView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
        
        self.indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        self.indicator.center = CGPointMake(side / 2, side / 2);
        self.autoresizingMask =   UIViewAutoresizingFlexibleBottomMargin |
        UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
        self.indicator.hidesWhenStopped = YES;
        [self.indicator startAnimating];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, side - 30, self.frame.size.width, 30)];
        label.font = [UIFont fontWithName:@"GillSans" size:18];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor clearColor];
        label.text = @"Loading... ";
        [IndicatorView addSubview:label];
        
        [IndicatorView addSubview:self.indicator];
        
        [self addSubview:IndicatorView];
    }
    return self;
}

+ (MMIndicatorView *)shared {
    static MMIndicatorView *_shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shared = [[self alloc] init];
    });
    
    return _shared;
}

+ (void)startAnimating {
    [[MMIndicatorView shared] startAnimating];
}

+ (void)stopAnimating {
    [[MMIndicatorView shared] stopAnimating];
}

- (void)startAnimating {
    [self startAnimatingInView:[self containerView]];
}

- (void)startAnimatingInView:(UIView *)parentView {
    
    self.shouldAnimate = YES;
    // Start a timer to determine if loading indicator needs to be shown.
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, INDICATOR_START_DELAY * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void) {
        // Ensure there is only one instance of animation
        if (self.shouldAnimate && !self.isAnimatingIndicator) {
            self.isAnimatingIndicator = true;
            self.startedAnimatingAt = [NSDate date]; // now
            [parentView addSubview:self];
            [self setCenter:parentView.center];
            NSLog(@"Starting animating indicator...");
            [self.indicator startAnimating];
        }
    });
}

- (void)stopAnimating
{
    self.shouldAnimate = NO;
    if (self.isAnimatingIndicator) {
        // Since indicator was started, therefore determine if the animation indicator has been shown long enough.
        // This will prevent odd and quick "flicker" when indicator is dismissed right after being started.
        NSTimeInterval timeShown = [self.startedAnimatingAt timeIntervalSinceNow]; // note: timeShown is always negative.
        
        if (timeShown < -MINIMUM_TIME_TO_SHOW_INDICATOR) {
            [self removeIndicator];
        } else {
            // Start a timer to wait for the minimum indicator time.
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (MINIMUM_TIME_TO_SHOW_INDICATOR + timeShown) * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void) {
                [self removeIndicator];
            });
        }
    }
}

- (void) removeIndicator
{
    
    [self containerView].userInteractionEnabled = YES;
    [self removeFromSuperview];
    // Fix to be able to call stopAnimating more oftan than startAnimating
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    self.isAnimatingIndicator = false;
}

- (UIView*)containerView {
    // debugging purposes only: UIViewController *rootVC = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    return [[[[[UIApplication sharedApplication] delegate] window] rootViewController] view];
}

@end