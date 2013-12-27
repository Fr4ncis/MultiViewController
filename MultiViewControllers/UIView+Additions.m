//
//  UIView+Additions.m
//  MultiViewControllers
//
//  Created by Francesco Mattia on 25/12/2013.
//  Copyright (c) 2013 Francesco Mattia. All rights reserved.
//

#import "UIView+Additions.h"

@implementation UIView (Additions)

- (void)setOrigin:(CGPoint)point
{
    self.frame = CGRectMake(point.x, point.y, self.frame.size.width, self.frame.size.height);
}

- (float)frameHeight {
    return self.frame.size.height;
}

- (float)frameWidth {
    return self.frame.size.width;
}


@end
