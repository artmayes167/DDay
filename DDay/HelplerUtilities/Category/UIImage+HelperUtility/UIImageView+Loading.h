//
//  UIImageView+Loading.h
//  RetailAssistant
//
//  Created by arthur.e.mayes on 2/10/15.
//  Copyright (c) 2015 Accenture. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Loading)

- (void)loadImageFromUrl:(NSString*)urlString avatar:(BOOL)avatar;
- (void)loadImageFromUrl:(NSString*)urlString;
- (void)loadImageFromUrl:(NSString*)urlString avatar:(BOOL)avatar withCompletionBlock:(void (^)(BOOL success, UIImageView* imageView))completionBlock;
- (void)loadImageFromUrl:(NSString*)urlString withCompletionBlock:(void (^)(BOOL success, UIImageView* imageView))completionBlock;
@end
