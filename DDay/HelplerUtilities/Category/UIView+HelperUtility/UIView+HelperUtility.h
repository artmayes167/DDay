//
//  UIView+HelperUtility.h
//  MobileMerchant
//
//  Created by Madan, Bunty on 09/04/15.
//  Copyright (c) 2015 Accenture. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (HelperUtility)


#pragma --Loading Indicator 
-(void)stopLoadingIndicator;
-(void)startLoadingIndicator;
-(void)startLoadingIndicatorInView;

- (void)simulateFixturesWithTime :(NSInteger )time completionBlock:(void (^)(void))block;
@end
