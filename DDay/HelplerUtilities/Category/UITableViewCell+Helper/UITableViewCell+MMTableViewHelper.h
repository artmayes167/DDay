//
//  UITableViewCell+MMTableViewHelper.h
//  MobileMerchant
//
//  Created by Madan, Bunty on 02/09/15.
//  Copyright (c) 2015 Accenture. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (MMTableViewHelper)
-(void)removeLayersIfExist;
-(void)needTopLayer:(CGRect)frame;
-(void)needBottomLayer:(CGRect)frame;
-(void)needRightLayer:(CGRect)frame;
-(void)needLeftLayer:(CGRect)frame;
@end
