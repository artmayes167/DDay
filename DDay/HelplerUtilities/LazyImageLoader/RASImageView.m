//
//  RASImageView.m
//  RetailAssistant
//
//  Created by arthur.e.mayes on 2/10/15.
//  Copyright (c) 2015 Accenture. All rights reserved.
//

#import "RASImageView.h"
#import "RASImageCache.h"

#define KDEFAULTPLACEHOLDERIMAGEASSETNAME @"img_placeholder_300"
#define KDEFAULTAVATARIMAGEASSETNAME @"avatar_placeholder_44"

@implementation RASImageView

- (void)loadImageDataFromAsset:(NSString*)imageName
{
    self.url = imageName;
    self.placeHolderImageName = imageName;  // This image will be the default placeHolder image for further usage of this instance.
    self.image = [UIImage imageNamed:imageName];
}

- (void)loadImageDataFromUrl:(NSString *)urlString
{
    [self loadImageDataFromUrl:urlString placeHolderAssetName:nil withCompletionBlock:nil];
}

- (void)loadImageDataFromUrl:(NSString*)urlString avatar:(BOOL)isAvatar
{
    NSString *placeHolderName = isAvatar ? KDEFAULTAVATARIMAGEASSETNAME : nil;
    [self loadImageDataFromUrl:urlString placeHolderAssetName:placeHolderName withCompletionBlock:nil];
}

- (void)loadImageDataFromUrl:(NSString*)urlString withCompletionBlock:(void (^)(BOOL success, UIImageView* imageView))completionBlock
{
    [self loadImageDataFromUrl:urlString placeHolderAssetName:nil withCompletionBlock:^(BOOL success, UIImageView *imageView) {
        completionBlock(success, imageView);
    }];
}

- (void)loadImageDataFromUrl:(NSString*)urlString placeHolderAssetName:(NSString*)placeHolder
{
    [self loadImageDataFromUrl:urlString placeHolderAssetName:placeHolder withCompletionBlock:nil];
}

-(void)showIndicator {
    
    [self hideIndicator];
    
    self.indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    self.indicator.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.indicator];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.indicator attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.indicator attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    
    // This is causing pics to be blurry in the collection view http://stackoverflow.com/questions/1182945/how-is-layoutifneeded-used
    //[self layoutIfNeeded];

    [self.indicator startAnimating];
}

-(void)hideIndicator {
    
    if (self.indicator) {
        [self.indicator stopAnimating];
        [self.indicator removeFromSuperview];
        self.indicator = nil;
    }
}

- (void)loadImageFromUrl:(NSString*)urlString withCompletionBlock:(void (^)(UIImage *image))completionBlock
{
    
    self.url = urlString;
    NSString *placeHolderImageAssetName = KDEFAULTPLACEHOLDERIMAGEASSETNAME;
    
    if ([urlString length]) {
        [self setHasLoadingCompleted:NO];
        
        dispatch_queue_t imageDownloadQ = dispatch_queue_create("imageDownloadQueue", NULL);
        dispatch_async(imageDownloadQ, ^{
            __block UIImage *image = [self imageData:urlString];
            if (image) {
                CGSize expectedSize = [self getExpectedImageSize];
                if (image.size.width > expectedSize.width && image.size.height > expectedSize.height) {
                    image = [self resizedImageWithMaximumSize:expectedSize forImage:image];
                }
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (!image) {
                    image = [UIImage imageNamed:placeHolderImageAssetName];
                    self.url = @"";
                }
                if (completionBlock) {
                    completionBlock(image);
                }
                [self setHasLoadingCompleted:YES];
            });
        });
    }
    else {
        if (completionBlock) {
            completionBlock(nil);
        }
    }
}

- (void)loadImageDataFromUrl:(NSString*)urlString placeHolderAssetName:(NSString*)placeHolder withCompletionBlock:(void (^)(BOOL success, UIImageView* imageView))completionBlock
{
        //NSLog(@"RASImageView: LoadImageFromUrl");
    
//    if ([urlString isEqualToString:self.url]) {
//        // We are already loading or have already loaded the image
//        NSLog(@"RASImageView: Picture already loading or shown: %@", self.url);
//        return;
//    }
    
    self.url = urlString;
    NSString *placeHolderImageAssetName = [placeHolder length] ? placeHolder : [self.placeHolderImageName length] ? self.placeHolderImageName : KDEFAULTPLACEHOLDERIMAGEASSETNAME;
    
    // Show placeholder image while the image is loading. If no placeHolder, use default placeholder image.
    // Loads from system cache if available. So, if we already show the placeholder, the performance impact is minimal.
    self.image = [UIImage imageNamed:placeHolderImageAssetName];
    
    if ([urlString length]) {
        UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        activityIndicator.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:activityIndicator];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:activityIndicator attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:activityIndicator attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
        
        // This is causing pics to be blurry in the collection view http://stackoverflow.com/questions/1182945/how-is-layoutifneeded-used
        //[self layoutIfNeeded];
        
        //        [activityIndicator setCenter:self.center];
        [self setHasLoadingCompleted:NO];
        [activityIndicator startAnimating];
        
        dispatch_queue_t imageDownloadQ = dispatch_queue_create("imageDownloadQueue", NULL);
        dispatch_async(imageDownloadQ, ^{
            UIImage *image = [self imageData:urlString];
            if (image) {
                CGSize expectedSize = [self getExpectedImageSize];
                if (image.size.width > expectedSize.width && image.size.height > expectedSize.height) {
                    image = [self resizedImageWithMaximumSize:expectedSize forImage:image];
                }
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (image) {
                    self.image = image;
                    // set completion block
                    if (completionBlock) {
                        completionBlock(YES, self);
                    }
                } else {
                    if (completionBlock) {
                        completionBlock(NO, self);
                    }
                    self.image = [UIImage imageNamed:placeHolderImageAssetName];
                    self.url = @"";
                }
                [activityIndicator stopAnimating];
                [activityIndicator removeFromSuperview];
                [self setHasLoadingCompleted:YES];
            });
        });
    } else {
        self.image = [UIImage imageNamed:placeHolderImageAssetName];
    }
}

- (UIImage *)resizedImageWithMaximumSize:(CGSize)size forImage:(UIImage*)image
{
    CGImageRef imgRef = [self CGImageWithCorrectOrientationForImage:image];
    CGFloat original_width  = CGImageGetWidth(imgRef);
    CGFloat original_height = CGImageGetHeight(imgRef);
    CGFloat width_ratio = size.width / original_width;
    CGFloat height_ratio = size.height / original_height;
    CGFloat scale_ratio = width_ratio < height_ratio ? width_ratio : height_ratio;
    CGImageRelease(imgRef);
    return [self drawImageInBounds: CGRectMake(0, 0, round(original_width * scale_ratio), round(original_height * scale_ratio)) forImage:image];
}

- (CGImageRef)CGImageWithCorrectOrientationForImage:(UIImage *)passedImage CF_RETURNS_RETAINED
{
    if (passedImage.imageOrientation == UIImageOrientationDown) {
        //retaining because caller expects to own the reference
        CGImageRef cgImage = [passedImage CGImage];
        CGImageRetain(cgImage);
        return cgImage;
    }
    
    UIGraphicsBeginImageContext(passedImage.size);
    CGContextRef context = UIGraphicsGetCurrentContext();

    if (passedImage.imageOrientation == UIImageOrientationRight) {
        CGContextRotateCTM (context, 90 * M_PI/180);
    } else if (passedImage.imageOrientation == UIImageOrientationLeft) {
        CGContextRotateCTM (context, -90 * M_PI/180);
    } else if (passedImage.imageOrientation == UIImageOrientationUp) {
        CGContextRotateCTM (context, 180 * M_PI/180);
    }
    [passedImage drawAtPoint:CGPointMake(0, 0)];
    CGImageRef cgImage = CGBitmapContextCreateImage(context);
    UIGraphicsEndImageContext();
    return cgImage;
    
}

- (UIImage *)drawImageInBounds:(CGRect)bounds forImage:(UIImage *)passedImage
{
    UIGraphicsBeginImageContext(bounds.size);
    [passedImage drawInRect: bounds];
    UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resizedImage;
}

- (CGSize)getExpectedImageSize
{
    CGFloat screenScale = [[UIScreen mainScreen] scale];
    return CGSizeMake(self.bounds.size.width * screenScale, self.bounds.size.width * screenScale);
}



// internal helper function.
// fetch image data from cache if available
- (UIImage *)imageData:(NSString*)urlString
{
    NSData *nsdata = [urlString dataUsingEncoding:NSUTF8StringEncoding];
    // Get NSString from NSData object in Base64
    NSString *fileId = [nsdata base64EncodedStringWithOptions:0];
    RASImageCache *cache = [RASImageCache getInstance];
    NSString *cachePath = [cache cachePathFor:fileId];
    NSData *data;
    
    if (!cachePath) {
        // Load from Internet
        NSURL *url = [NSURL URLWithString:urlString];
            //NSLog(@"* * Fetching from internet: %@ * *", url);
        data = [NSData dataWithContentsOfURL:url];
        [cache addToCache:fileId havingData:data];
    } else {
        // Load from Cache
        data = [NSData dataWithContentsOfFile:cachePath];
        if (!data) {
            // file couldn't be loaded. Clean up cache for this item. (Usually happens when updating app over XCode during dev).
            [cache removeFromCache:fileId];
            // In case file could not be loaded from cached path, then load from Internet
            NSURL *url = [NSURL URLWithString:urlString];
                //NSLog(@"* * Re-Fetching from internet: %@ * *", url);
            data = [NSData dataWithContentsOfURL:url];
            [cache addToCache:fileId havingData:data];
        }
    }
    return data ? [UIImage imageWithData:data] : nil;
}

- (void)reset
{
    self.url = @"";
}


+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    //UIGraphicsBeginImageContext(newSize);
    // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
    // Pass 1.0 to force exact pixel size.
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end

