//
//  SKMRAIDBridge.h
//  MRAID
//
//  Created by Stas Kochkin on 18/09/2017.
//  Copyright © 2017 Nexage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

@interface SKMRAIDBridge : NSObject

@property (nonatomic, weak) WKWebView * currentWebView;


- (void)fireErrorEventWithAction:(NSString *)action
                         message:(NSString *)message;
- (void)fireReadyEvent;
- (void)fireExpandEvent;
- (void)fireResizeEvent:(CGRect)resizeRect;
- (void)fireStateChangeEvent:(NSInteger)event;
- (void)fireViewableChangeEvent:(BOOL)viewable;
- (void)setDefaultPosition:(CGRect)position;
- (void)setMaxSize:(CGSize)size;
- (void)setScreenSize;
- (void)setPlacementType:(BOOL)fullscreen;
- (void)setSupports:(NSSet *)currentFeatures;

@end
