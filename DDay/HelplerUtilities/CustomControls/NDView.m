//
//  NDView.m
//  NidecDemo
//
//  Created by Kumar Vijayakumar, D. on 10/21/15.
//  Copyright © 2015 Inturu, Ramanjaneyulu. All rights reserved.
//

#import "NDView.h"

@implementation NDView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)setBorderColor:(UIColor *)borderColor{
    _borderColor = borderColor;
    self.layer.borderColor = borderColor.CGColor;
    
}

-(void)setBorderWidth:(CGFloat)borderWidth{
    _borderWidth = borderWidth;
    self.layer.borderWidth = borderWidth;
}


-(void)setCornerRadius:(CGFloat)cornerRadius{
    
    _cornerRadius = cornerRadius;
    self.layer.cornerRadius = cornerRadius;
}
@end
