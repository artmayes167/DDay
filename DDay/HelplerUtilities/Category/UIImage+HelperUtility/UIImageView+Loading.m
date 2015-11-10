//
//  UIImageView+Loading.m
//  RetailAssistant
//
//  Created by arthur.e.mayes on 2/10/15.
//  Copyright (c) 2015 Accenture. All rights reserved.
//

#import "UIImageView+Loading.h"
#import "RASImageCache.h"

@implementation UIImageView (Loading)

- (void)loadImageFromUrl:(NSString *)urlString
{
    [self loadImageFromUrl:urlString avatar:NO];
}

- (void)loadImageFromUrl:(NSString*)urlString withCompletionBlock:(void (^)(BOOL success, UIImageView* imageView))completionBlock {
    [self loadImageFromUrl:urlString avatar:NO withCompletionBlock:^(BOOL success, UIImageView *imageView) {
        completionBlock(success, imageView);
    }];
}

- (void)loadImageFromUrl:(NSString*)urlString avatar:(BOOL)avatar
{
    if ([urlString length]) {
        UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        [self addSubview:activityIndicator];
        [activityIndicator setCenter:self.center];
        [activityIndicator startAnimating];
        dispatch_queue_t imageDownloadQ = dispatch_queue_create("HistoryListQueue", NULL);
        dispatch_async(imageDownloadQ, ^{
            
            UIImage *image = [self imageData:urlString];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (image) {
                    self.image = image;
                } else {
                    self.image = avatar ? [UIImage imageNamed:@"avatar_placeholder_44"] : [UIImage imageNamed:@"gfx_placeholder_lg"];
                }
                [activityIndicator stopAnimating];
                [activityIndicator removeFromSuperview];
            });
        });
    } else {
        
        self.image = avatar ? [UIImage imageNamed:@"avatar_placeholder_44"] : [UIImage imageNamed:@"gfx_placeholder_lg"];
    }
}


- (void)loadImageFromUrl:(NSString*)urlString avatar:(BOOL)avatar withCompletionBlock:(void (^)(BOOL success, UIImageView* imageView))completionBlock {
    
    if ([urlString length]) {
        UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        [self addSubview:activityIndicator];
        [activityIndicator setCenter:self.center];
        [activityIndicator startAnimating];
        
        dispatch_queue_t imageDownloadQ = dispatch_queue_create("HistoryListQueue", NULL);
        dispatch_async(imageDownloadQ, ^{
            
            UIImage *image = [self imageData:urlString];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (image) {
                    self.image = image;
                    
                    // set completion block
                    completionBlock(YES, self);
                    
                    
                } else {
                    self.image = avatar ? [UIImage imageNamed:@"avatar_placeholder_44"] : [UIImage imageNamed:@"gfx_placeholder_lg"];
                    
                }
                [activityIndicator stopAnimating];
                [activityIndicator removeFromSuperview];
            });
        });
    } else {
        
        self.image = avatar ? [UIImage imageNamed:@"avatar_placeholder_44"] : [UIImage imageNamed:@"gfx_placeholder_lg"];
    }
    
    
}

// internal helper function.
// fetch image data from cache if available
- (UIImage *)imageData:(NSString*)urlString
{
    //NSString *photoId = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
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

@end
