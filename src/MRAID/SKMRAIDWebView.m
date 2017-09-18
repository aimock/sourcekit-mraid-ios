//
//  SKMRAIDWebView.m
//  MRAID
//
//  Created by Stas Kochkin on 18/09/2017.
//  Copyright © 2017 Nexage. All rights reserved.
//

#import "SKMRAIDWebView.h"
#import "SKMRAIDServiceDelegate.h"
#import "SKMRAIDUtil.h"
#import "MRAIDSettings.h"
#import "UIView+SKExtension.h"
#import "SKInstanceProvider+WebKit.h"
#import "SKMRAIDBridge.h"


#define SK_OBSERVER_SCRIPT_HANDLER       @"observe"
#define SK_JS_LOG_SCRIPT_HANDLER         @"logHandler"



@interface SKMRAIDWebView () <WKUIDelegate, WKNavigationDelegate>

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) SKMRAIDBridge *bridge;
@property (nonatomic, strong) NSSet * features;

@end

@implementation SKMRAIDWebView

- (instancetype)initWithFrame:(CGRect)frame
            supportedFeatures:(NSSet *)supportedFeatures
                customScripts:(NSSet *)scripts {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Create controller
        WKUserContentController * controller = [[SKInstanceProvider sharedProvider] contentController];
       
        // Add message handlers
        [[[SKInstanceProvider sharedProvider] messageHandlers] enumerateObjectsUsingBlock:^(id<SKMessageHandler> handler, BOOL * stop) {
            [controller addScriptMessageHandler:handler
                                           name:handler.name];
        }];
        
        // Add user scripts
        [scripts enumerateObjectsUsingBlock:^(WKUserScript * script, BOOL * stop) {
            [controller addUserScript:script];
        }];
        
        // Create configuration
        WKWebViewConfiguration * configuration = [[SKInstanceProvider sharedProvider] configurationWithFeatures:supportedFeatures
                                                                                                    webViewSize:frame.size];
        configuration.userContentController = controller;
        BOOL fullscreen = CGSizeEqualToSize(frame.size, UIScreen.mainScreen.bounds.size);
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0")) {
            configuration.requiresUserActionForMediaPlayback = fullscreen;
        } else {
            configuration.mediaPlaybackRequiresUserAction = fullscreen;
        }
        
        configuration.allowsInlineMediaPlayback = [supportedFeatures containsObject:MRAIDSupportsInlineVideo];
        configuration.preferences.javaScriptCanOpenWindowsAutomatically = NO;
        
        // Create web view
        WKWebView * webView = [[SKInstanceProvider sharedProvider] webViewWithFrame:frame
                                                                      configuration:configuration];
        // Set delegates
        webView.navigationDelegate  = self;
        webView.UIDelegate          = self;
        webView.opaque = NO;
        
        [self addSubview:webView];
        [webView sk_makeEdgesEqualToView:self];
        
        // Disable scrolling
        webView.scrollView.scrollEnabled = NO;
        // Disable selection
        [webView evaluateJavaScript:SK_DISABLE_SELECTION_SCRIPT
                  completionHandler:nil];
        // Disable alerts
        if (SK_SUPPRESS_JS_ALERT) {
            [webView evaluateJavaScript:SK_DISABLE_JS_ALERTS_SCRIPT
                      completionHandler:nil];
        }
        
        self.bridge     = [[SKInstanceProvider sharedProvider] bridgeForWebView:webView];
        self.features   = supportedFeatures;
        self.webView    = webView;
        
    }
    return self;
}

#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView
didFinishNavigation:(WKNavigation *)navigation {
    
//    if (self.state == MRAIDStateLoading) {
//        self.state = MRAIDStateDefault;
    
//        [self disableFullscreenVideoInWebView:webView];
        
    [self.bridge setSupports:self.features];
    [self.bridge setDefaultPosition:webView.frame];
    [self.bridge setMaxSize:[UIScreen mainScreen].bounds.size];
    [self.bridge setScreenSize];
    [self.bridge fireStateChangeEvent:1];
//        [self setDefaultPosition];
//        [self setMaxSize];
//        [self setScreenSize];
//        [self fireStateChangeEvent];
//        [self fireSizeChangeEvent];
//        [self fireReadyEvent];
//    
//        if (self.prerenderingAllowed) {
//            if ([self.delegate respondsToSelector:@selector(mraidViewAdReady:)]) {
//                [self.delegate mraidViewAdReady:self];
//            }
//        } else {
//            [self.spinnerView hide];
//        }
    
        // Start monitoring device orientation so we can reset max Size and screenSize if needed.
//        if (![[UIDevice currentDevice] isGeneratingDeviceOrientationNotifications]) {
//            [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
//        }
//        [[NSNotificationCenter defaultCenter] addObserver:self
//                                                 selector:@selector(deviceOrientationDidChange:)
//                                                     name:UIDeviceOrientationDidChangeNotification
//                                                   object:nil];
//    }
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
//    if (!self.prerenderingAllowed) {
//        [self.spinnerView hide];
//    }
//    
//    if ([self.delegate respondsToSelector:@selector(mraidView:failToLoadAdThrowError:)]) {
//        NSError * mraidError = [NSError errorWithDomain:kSKMRAIDErrorDomain code:MRAIDShowError userInfo:error.userInfo];
//        [self.delegate mraidView:self failToLoadAdThrowError:mraidError];
//    }
}

- (void)webView:(WKWebView *)webView
decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction
decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    WKNavigationActionPolicy policy = WKNavigationActionPolicyCancel;
//    NSString * request = navigationAction.request.URL.absoluteString;
//    
//    if (self.state == MRAIDStateLoading) {
//        if ([request containsString:@"about:blank"] ||
//            [request containsString:@"http://"] ||
//            [request containsString:@"https://"]) {
//            
//            policy = WKNavigationActionPolicyAllow;
//        }
//    }
//    
//    if (self.state == MRAIDStateDefault) {
//        if (_bonafideTapObserved && (navigationAction.navigationType == WKNavigationTypeLinkActivated ||
//                                     navigationAction.navigationType == WKNavigationTypeOther)) {
//            if ([self.delegate respondsToSelector:@selector(mraidViewNavigate:withURL:)]) {
//                [self.delegate mraidViewNavigate:self withURL:navigationAction.request.URL];
//            }
//        } else {
//            NSString * scheme = navigationAction.request.URL.scheme;
//            BOOL iframe = ![navigationAction.request.URL isEqual:navigationAction.request.mainDocumentURL];
//            
//            // If we load a URL from an iFrame that did not originate from a click or
//            // is a deep link, handle normally and return safeToAutoloadLink.
//            if (iframe && !((navigationAction.navigationType == WKNavigationTypeLinkActivated) && ([scheme isEqualToString:@"https"] || [scheme isEqualToString:@"http"]))) {
//                BOOL safeToAutoload = navigationAction.navigationType == WKNavigationTypeLinkActivated ||
//                _bonafideTapObserved ||
//                [scheme isEqualToString:@"https"] ||
//                [scheme isEqualToString:@"http"];
//                
//                policy = safeToAutoload ? WKNavigationActionPolicyAllow : WKNavigationActionPolicyCancel;
//            }
//        }
//    }
    
    decisionHandler(policy);
}


#pragma mark - WKUIDelegate

- (WKWebView *)webView:(WKWebView *)webView
createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration
   forNavigationAction:(WKNavigationAction *)navigationAction
        windowFeatures:(WKWindowFeatures *)windowFeatures {
    
//    if (self.state == MRAIDStateDefault) {
//        NSString * scheme = navigationAction.request.URL.scheme;
//        BOOL isHttpLink = [scheme isEqualToString:@"https"] ||
//        [scheme isEqualToString:@"http"];
//        
//        BOOL safeToAutoload = navigationAction.navigationType == WKNavigationTypeLinkActivated ||
//        navigationAction.navigationType == WKNavigationTypeOther;
//        
//        if (_bonafideTapObserved && isHttpLink && safeToAutoload) {
//            if ([self.delegate respondsToSelector:@selector(mraidViewNavigate:withURL:)]) {
//                [self.delegate mraidViewNavigate:self withURL:navigationAction.request.URL];
//            }
//        }
//    }
    return nil;
}



@end
