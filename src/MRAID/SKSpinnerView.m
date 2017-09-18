//
//  SKSpinnerView.m
//  MRAID
//
//  Created by Stas Kochkin on 18/09/2017.
//  Copyright © 2017 Nexage. All rights reserved.
//

#import "SKSpinnerView.h"
#import "UIView+SKExtension.h"

@interface SKSpinnerView ()

@property (nonatomic, strong) UIActivityIndicatorView * indicator;
@property (nonatomic, strong) UIVisualEffectView * blurView;

@end

@implementation SKSpinnerView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self createBlurView];
        [self createIndicator];
        [self layoutViews];
    }
    return self;
}

- (void)createBlurView {
    UIBlurEffect * effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    self.blurView = [[UIVisualEffectView alloc] initWithEffect:effect];
}

- (void)createIndicator {
    self.indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
}

- (void)layoutViews {
    [self addSubview:self.blurView];
    [self addSubview:self.indicator];
    
    [self.blurView sk_makeEdgesEqualToView:self];
    [self.indicator sk_makeCenterEqualToView:self];
}

- (void)showOnView:(UIView *)view {
    [view addSubview:self];
    [self sk_makeEdgesEqualToView:view];
    [self.indicator startAnimating];
}

- (void)hide {
    [self.indicator stopAnimating];
    [UIView animateWithDuration:0.2f animations:^{
        [self removeFromSuperview];
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
