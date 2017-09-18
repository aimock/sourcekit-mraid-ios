//
//  SKInstanceProvider+WebKit.m
//  MRAID
//
//  Created by Stas Kochkin on 18/09/2017.
//  Copyright © 2017 Nexage. All rights reserved.
//

#import "SKInstanceProvider+WebKit.h"
#import "SKMRAIDUtil.h"
#import "SKMRAIDServiceDelegate.h"


@implementation SKInstanceProvider (WebKit)

- (WKWebViewConfiguration *)configurationWithFeatures:(NSSet *)features
                                          webViewSize:(CGSize)webViewSize {
    
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    return configuration;
}

- (WKUserContentController *)contentController; {
    return [[WKUserContentController alloc] init];
}

@end
