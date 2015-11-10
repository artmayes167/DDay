//
//  NDButton.m
//  NidecDemo
//
//  Created by Kumar Vijayakumar, D. on 10/21/15.
//  Copyright © 2015 Inturu, Ramanjaneyulu. All rights reserved.
//

#import "NDButton.h"
#import "UIColor+HexColor.h"
#import "Styles.h"

@implementation NDButton

-(void)awakeFromNib{
    [super awakeFromNib];
    [self initProperties];
}

-(void)initProperties{
    
    self.backgroundColor = [UIColor colorWithHexString:kLoginButtonColour];
    
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = cornerRadius;
    self.layer.cornerRadius = cornerRadius;
}


@end
