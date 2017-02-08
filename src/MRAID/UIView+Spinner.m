//
//  UIView+Spinner.m
//  MRAID
//
//  Created by Lozhkin Ilya on 2/2/17.
//  Copyright © 2017 Nexage. All rights reserved.
//

#import "UIView+Spinner.h"
#import <objc/runtime.h>

@implementation UIView (Spinner)

static const char kSKSpinnerOnView;

- (void)setSk_spinner:(UIActivityIndicatorView *)spinner
{
    objc_setAssociatedObject(self, &kSKSpinnerOnView, spinner, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIActivityIndicatorView *)sk_spinner
{
    return objc_getAssociatedObject(self, &kSKSpinnerOnView);
}

- (void) showSpinner {
    if (!self.sk_spinner) {
        self.sk_spinner = [self spinnerWithStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [self.sk_spinner startAnimating];
        [self addSubview:self.sk_spinner];
        
        self.sk_spinner.layer.position = self.center;
        self.sk_spinner.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    }
}

- (void) hideSpinner {
    [self.sk_spinner removeFromSuperview];
    self.sk_spinner = nil;
}

- (UIActivityIndicatorView *) spinnerWithStyle:(UIActivityIndicatorViewStyle)style{
    UIActivityIndicatorView * spinner = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    spinner.activityIndicatorViewStyle = style;
    spinner.color = UIColor.whiteColor;
    return spinner;
}

@end
