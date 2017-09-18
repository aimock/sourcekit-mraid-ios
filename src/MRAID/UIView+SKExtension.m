//
//  UIView+SKExtension.m
//  MRAID
//
//  Created by Stas Kochkin on 14/07/2017.
//  Copyright © 2017 Nexage. All rights reserved.
//

#import "UIView+SKExtension.h"

@implementation UIView (SKExtension)

- (void)sk_makeEdgesEqualToView:(UIView *)view {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint * left = [NSLayoutConstraint constraintWithItem:self
                                                             attribute:NSLayoutAttributeLeft
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:view
                                                             attribute:NSLayoutAttributeLeft
                                                            multiplier:1.0
                                                              constant:0.0];
    
    NSLayoutConstraint * right = [NSLayoutConstraint constraintWithItem:self
                                                              attribute:NSLayoutAttributeRight
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:view
                                                              attribute:NSLayoutAttributeRight
                                                             multiplier:1.0
                                                               constant:0.0];
    
    NSLayoutConstraint * top = [NSLayoutConstraint constraintWithItem:self
                                                            attribute:NSLayoutAttributeTop
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:view
                                                            attribute:NSLayoutAttributeTop
                                                           multiplier:1.0
                                                             constant:0.0];
    
    NSLayoutConstraint * bottom = [NSLayoutConstraint constraintWithItem:self
                                                               attribute:NSLayoutAttributeBottom
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:view
                                                               attribute:NSLayoutAttributeBottom
                                                              multiplier:1.0
                                                                constant:0.0];
    [view addConstraints:@[left, right, top, bottom]];
}

- (void)sk_makeCenterEqualToView:(UIView *)view {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint * middleX = [NSLayoutConstraint constraintWithItem:self
                                                             attribute:NSLayoutAttributeCenterX
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:view
                                                             attribute:NSLayoutAttributeCenterX
                                                            multiplier:1.0
                                                              constant:0.0];
    
    NSLayoutConstraint * middleY = [NSLayoutConstraint constraintWithItem:self
                                                              attribute:NSLayoutAttributeCenterY
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:view
                                                              attribute:NSLayoutAttributeCenterY
                                                             multiplier:1.0
                                                               constant:0.0];
    [view addConstraints:@[middleX, middleY]];
}

@end
