//
//  SKInstanceProvider+WebKit.h
//  MRAID
//
//  Created by Stas Kochkin on 18/09/2017.
//  Copyright © 2017 Nexage. All rights reserved.
//

#import "SKInstanceProvider.h"
#import "SKMessageHandlerProtocol.h"
#import "SKMRAIDBridge.h"
#import <WebKit/WebKit.h>

@interface SKInstanceProvider (WebKit)

- (WKWebViewConfiguration *)configurationWithFeatures:(NSSet *)features
                                          webViewSize:(CGSize)webViewSize;
- (WKUserContentController *)contentController;

- (NSSet <id<SKMessageHandler>> *)messageHandlers;

- (WKWebView *)webViewWithFrame:(CGRect)rect
                  configuration:(WKWebViewConfiguration *)configuration;

- (SKMRAIDBridge *)bridgeForWebView:(WKWebView *)webView;

@end
