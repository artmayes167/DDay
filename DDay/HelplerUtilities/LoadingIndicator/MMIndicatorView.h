//
//  ACNIndicatorView.h
//
//  Created by jyrki hoisko
//  Copyright (c) 2015 Accenture. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface MMIndicatorView : UIView

@property (nonatomic, retain) UIActivityIndicatorView *indicator;

+ (MMIndicatorView *)shared;
+ (void)stopAnimating;
+ (void)startAnimating;
- (void)startAnimatingInView:(UIView *)parentView;

@end
