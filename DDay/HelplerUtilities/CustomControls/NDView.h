//
//  NDView.h
//  NidecDemo
//
//  Created by Kumar Vijayakumar, D. on 10/21/15.
//  Copyright © 2015 Inturu, Ramanjaneyulu. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface NDView : UIView
@property (nonatomic) IBInspectable CGFloat cornerRadius;
@property (nonatomic) IBInspectable CGFloat borderWidth;
@property (nonatomic) IBInspectable UIColor* borderColor;

@end
