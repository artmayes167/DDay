//
//  UITableViewCell+MMTableViewHelper.m
//  MobileMerchant
//
//  Created by Madan, Bunty on 02/09/15.
//  Copyright (c) 2015 Accenture. All rights reserved.
//

#import "UITableViewCell+MMTableViewHelper.h"

static NSString *TOP_LAYER      = @"TopLayer";
static NSString *RIGHT_LAYER    = @"RightLayer";
static NSString *LEFT_LAYER     = @"LeftLayer";
static NSString *BOTTOM_LAYER   = @"BottomLayer";


@implementation UITableViewCell (MMTableViewHelper)

-(void)removeLayersIfExist  {
    NSMutableArray *layers = [NSMutableArray new];
    for (CALayer *lay in [[self layer] sublayers]) {
        if ([lay.name isEqualToString:TOP_LAYER]  || [lay.name isEqualToString:RIGHT_LAYER] ||
            [lay.name isEqualToString:LEFT_LAYER] || [lay.name isEqualToString:BOTTOM_LAYER]) {
            [layers addObject:lay];
        }
    }
    for (CALayer *lay in layers) {
        [lay removeFromSuperlayer];
    }
}

-(void)needTopLayer:(CGRect)frame   {
    CALayer *rightShadowLayer = [[CALayer alloc]init];
    rightShadowLayer.frame = CGRectMake(0, -1,frame.size.width, 1);
    rightShadowLayer.backgroundColor = [UIColor grayColor].CGColor;
    rightShadowLayer.shadowColor = [UIColor blackColor].CGColor;
    rightShadowLayer.shadowRadius = 10.0;
    rightShadowLayer.shadowOpacity = 2;
    rightShadowLayer.name = TOP_LAYER;
    rightShadowLayer.shadowOffset = CGSizeMake(1, 0);
    [[self layer] insertSublayer:rightShadowLayer atIndex:0];
}

-(void)needBottomLayer:(CGRect)frame {
    CALayer *rightShadowLayer = [[CALayer alloc]init];
    rightShadowLayer.frame = CGRectMake(0, self.frame.size.height + 25, frame.size.width, 1);
    rightShadowLayer.backgroundColor = [UIColor grayColor].CGColor;
    rightShadowLayer.shadowColor = [UIColor blackColor].CGColor;
    rightShadowLayer.shadowRadius = 10.0;
    rightShadowLayer.shadowOpacity = 2;
    rightShadowLayer.name = BOTTOM_LAYER;
    rightShadowLayer.shadowOffset = CGSizeMake(1, 0);
    [[self layer] insertSublayer:rightShadowLayer atIndex:0];
}

-(void)needRightLayer:(CGRect)frame   {
    CALayer *rightShadowLayer = [[CALayer alloc]init];
    rightShadowLayer.frame = CGRectMake(frame.size.width, 10, 2 ,self.bounds.size.height+20);
    rightShadowLayer.backgroundColor = [UIColor grayColor].CGColor;
    rightShadowLayer.shadowColor = [UIColor blackColor].CGColor;
    rightShadowLayer.shadowRadius = 10.0;
    rightShadowLayer.shadowOpacity = 1;
    rightShadowLayer.name = RIGHT_LAYER;
    rightShadowLayer.shadowOffset = CGSizeMake(5, 0);
    [[self layer] insertSublayer:rightShadowLayer atIndex:0];
}

-(void)needLeftLayer:(CGRect)frame    {
    CALayer *rightShadowLayer = [[CALayer alloc]init];
    rightShadowLayer.frame = CGRectMake(100, 10, 2 ,self.frame.size.height);
    rightShadowLayer.backgroundColor = [UIColor grayColor].CGColor;
    rightShadowLayer.shadowColor = [UIColor blackColor].CGColor;
    rightShadowLayer.shadowRadius = 10.0;
    rightShadowLayer.shadowOpacity = 1;
    rightShadowLayer.name = LEFT_LAYER;
    rightShadowLayer.shadowOffset = CGSizeMake(5, 0);
    [[self layer] insertSublayer:rightShadowLayer atIndex:0];
}
@end
