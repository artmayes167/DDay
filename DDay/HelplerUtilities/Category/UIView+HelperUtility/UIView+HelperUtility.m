//
//  UIView+HelperUtility.m
//  MobileMerchant
//
//  Created by Madan, Bunty on 09/04/15.
//  Copyright (c) 2015 Accenture. All rights reserved.
//

#import "UIView+HelperUtility.h"
#import "MMIndicatorView.h"

@implementation UIView (HelperUtility)

#pragma --Loading Indicator
-(void)stopLoadingIndicator    {
    [self setUserInteractionEnabled:YES];
    [MMIndicatorView stopAnimating];
}

-(void)startLoadingIndicator   {
    [MMIndicatorView startAnimating];
}

-(void)startLoadingIndicatorInView    {
     [self setUserInteractionEnabled:NO];
    [[MMIndicatorView shared] startAnimatingInView:self];
}

- (void)performCompletionBlock:(void (^)(void))block    {
    [self stopLoadingIndicator];
    block();
}

-(void)simulateFixturesWithTime:(NSInteger)time completionBlock:(void (^)(void))block   {
    [self startLoadingIndicator];
    [self performSelector:@selector(performCompletionBlock:) withObject:block afterDelay:time];
}
@end