//
//  UIImageView+Loading.h
//  RetailAssistant
//
//  Created by arthur.e.mayes on 2/10/15.
//  Copyright (c) 2015 Accenture. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RASImageView : UIImageView
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *placeHolderImageName;
@property (nonatomic) BOOL hasLoadingCompleted;
@property (nonatomic, strong) UIActivityIndicatorView *indicator;

- (void)reset;
- (void)loadImageDataFromAsset:(NSString*)imageName;
- (void)loadImageDataFromUrl:(NSString*)urlString avatar:(BOOL)avatar;
- (void)loadImageDataFromUrl:(NSString*)urlString;
- (void)loadImageDataFromUrl:(NSString*)urlString placeHolderAssetName:(NSString*)placeHolder;
- (void)loadImageDataFromUrl:(NSString*)urlString placeHolderAssetName:(NSString*)placeHolder withCompletionBlock:(void (^)(BOOL success, UIImageView* imageView))completionBlock;
- (void)loadImageDataFromUrl:(NSString*)urlString withCompletionBlock:(void (^)(BOOL success, UIImageView* imageView))completionBlock;
- (void)loadImageFromUrl:(NSString*)urlString withCompletionBlock:(void (^)(UIImage *image))completionBlock;
-(void)showIndicator;
-(void)hideIndicator;
+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;

@end
