//
//  SKMRAIDBridge.m
//  MRAID
//
//  Created by Stas Kochkin on 18/09/2017.
//  Copyright © 2017 Nexage. All rights reserved.
//

#import "SKMRAIDBridge.h"
#import "SKMRAIDUtil.h"
#import <UIKit/UIKit.h>


@implementation SKMRAIDBridge

#pragma mark - Public

// Convenience methods
- (void)fireErrorEventWithAction:(NSString *)action
                         message:(NSString *)message {
    [self injectJavaScript:SK_MRAID_ERROR_EVENT_SCRIPT(message, action)];
}

- (void)fireReadyEvent {
    [self injectJavaScript:SK_MRAID_READY_EVENT_SCRIPT];
}

- (void)fireExpandEvent {
    int x = floor(self.currentWebView.frame.origin.x);
    int y = floor(self.currentWebView.frame.origin.y);
    
    int width   = floor(self.currentWebView.frame.size.width);
    int height  = floor(self.currentWebView.frame.size.height);
    
    [self fireResizeToX:x y:y width:width height:height];
}

- (void)fireResizeEvent:(CGRect)resizeRect {
    int x = floor(resizeRect.origin.x);
    int y = floor(resizeRect.origin.y);
    
    int width   = floor(resizeRect.size.width);
    int height  = floor(resizeRect.size.height);
    
    [self fireResizeToX:x y:y width:width height:height];
}

- (void)fireStateChangeEvent:(NSInteger)event {
    NSArray *stateNames = @[
                            @"loading",
                            @"default",
                            @"expanded",
                            @"resized",
                            @"hidden",
                            ];
    [self injectJavaScript:SK_MRAID_STATE_CHANGE_EVENT_SCRIPT(stateNames[event])];
    
}

- (void)fireViewableChangeEvent:(BOOL)viewable {
//    if (self.isInterstitial && self.isViewable) {
//        [self startVideoIfNeeded:self.currentWebView];
//    } else {
//        [self disableFullscreenVideoInWebView:self.currentWebView];
//    }
    
    [self injectJavaScript:SK_MRAID_VIEWABLE_EVENT_SCRIPT(viewable)];
}

- (void)setDefaultPosition:(CGRect)position {
    [self injectJavaScript:SK_MRAID_SET_DEFAULT_POSITION_SCRIPT(position.origin.x, position.origin.y, position.size.width, position.size.height)];
//    // getDefault position from the parent frame if we are not directly added to the rootview
//    if(self.superview != self.rootViewController.view) {
//        [self injectJavaScript:[NSString stringWithFormat:@"mraid.setDefaultPosition(%f,%f,%f,%f);", self.superview.frame.origin.x, self.superview.frame.origin.y, self.superview.frame.size.width, self.superview.frame.size.height]];
//    } else {
//        [self injectJavaScript:[NSString stringWithFormat:@"mraid.setDefaultPosition(%f,%f,%f,%f);", self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height]];
//    }
}

- (void)setMaxSize:(CGSize)size {
    [self injectJavaScript:SK_MRAID_SET_MAX_SIZE_SCRIPT((int)floor(size.width), (int)floor(size.height))];
//    if (self.isInterstitial) {
//        // For interstitials, we define maxSize to be the same as screen size, so set the value there.
//        return;
//    }
//    CGSize maxSize = self.rootViewController.view.bounds.size;
//    if (!CGSizeEqualToSize(maxSize, self.previousMaxSize)) {
//       
//                                (int)maxSize.width,
//                                (int)maxSize.height]];
//        self.previousMaxSize = CGSizeMake(maxSize.width, maxSize.height);
//    }
}

- (void)setScreenSize {
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    // screenSize is ALWAYS for portrait orientation, so we need to figure out the
    // actual interface orientation to get the correct current screenRect.
    UIInterfaceOrientation interfaceOrientation = [UIApplication sharedApplication].statusBarOrientation;
    BOOL isLandscape = UIInterfaceOrientationIsLandscape(interfaceOrientation);
    CGFloat scale = [UIScreen mainScreen].scale;
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
        screenSize = CGSizeMake(screenSize.width * scale, screenSize.height * scale);
    } else {
        if (isLandscape) {
            screenSize = CGSizeMake(screenSize.height * scale, screenSize.width * scale);
        }
    }
    
    // TODO: // Screen size
    
//        [self injectJavaScript:SK_MRAID_SET_SCREEN_SIZE_SCRIPT((int)floor(screenSize.width), (int)floor(screenSize.height))];
//        
//        if (CGSizeEqualToSize(self., <#CGSize size2#>)(0, <#CGFloat height#>)) {
//            [self injectJavaScript:[NSString stringWithFormat:@"mraid.setMaxSize(%d,%d);",
//                                    (int)screenSize.width,
//                                    (int)screenSize.height]];
//            [self injectJavaScript:[NSString stringWithFormat:@"mraid.setDefaultPosition(0,0,%d,%d);",
//                                    (int)screenSize.width,
//                                    (int)screenSize.height]];
//        }
//    }
}

- (void)setPlacementType:(BOOL)fullscreen {
    [self injectJavaScript:SK_MRAID_SET_PLC_TYPE_SCRIPT(fullscreen)];
}


- (void)setSupports:(NSSet *)currentFeatures {
    [currentFeatures enumerateObjectsUsingBlock:^(NSString * feature, BOOL * stop) {
        [self injectJavaScript:SK_MRAID_SET_SUPPORTED_FEATURE_SCRIPT(feature)];
    }];
}

#pragma mark - Private

- (void)fireResizeToX:(int)x y:(int)y width:(int)width height:(int)height {
    UIInterfaceOrientation interfaceOrientation = [UIApplication sharedApplication].statusBarOrientation;
    BOOL isLandscape = UIInterfaceOrientationIsLandscape(interfaceOrientation);
    BOOL adjustOrientationForIOS8 = isLandscape && !SYSTEM_VERSION_LESS_THAN(@"8.0");
    [self injectJavaScript:SK_MRAID_SIZE_CHANGE_EVENT_SCRIPT(x, y, adjustOrientationForIOS8 ? height : width, adjustOrientationForIOS8 ? width : height)];
}

- (void)injectJavaScript:(NSString *)js {
    [self.currentWebView evaluateJavaScript:js completionHandler:nil];
    //    [self.currentWebView evaluateJavaScript:js completionHandler:^(id _Nullable callback, NSError * _Nullable error) {
    //        NSLog(@"Callback %@ \n Error: %@", callback, error);
    //    }];
}

@end
