//
//  SKMRAIDWebView.h
//  MRAID
//
//  Created by Stas Kochkin on 18/09/2017.
//  Copyright © 2017 Nexage. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SKMRAIDWebView;

@protocol SKMRAIDWebViewDelegate <NSObject>

- (void)webView:(SKMRAIDWebView *)webView preparedContent:(NSString *)rawContent;
- (void)webView:(SKMRAIDWebView *)webView failedWithError:(NSError *)error;
- (void)webView:(SKMRAIDWebView *)webView navigateToURL:(NSURL *)URL;

@end

@interface SKMRAIDWebView : UIView

@property (nonatomic, weak) id<SKMRAIDWebViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame
            supportedFeatures:(NSSet *)supportedFeatures
                customScripts:(NSSet *)scripts;
//+ (instancetype)fullscreenWebViewWithFeatures:(NSSet *)supportedFeatures;

@end
