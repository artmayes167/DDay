//
//  UIImagePickerController+Utilities.m
//  NidecDemo
//
//  Created by Mayes, Arthur E. on 10/22/15.
//  Copyright © 2015 Inturu, Ramanjaneyulu. All rights reserved.
//

#import "UIImagePickerController+Utilities.h"

@implementation UIImagePickerController (Utilities)

- (BOOL)shouldAutorotate {
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return [[UIApplication sharedApplication] statusBarOrientation];
}

@end
