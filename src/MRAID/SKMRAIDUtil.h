//
//  SKMRAIDUtil.h
//  MRAID
//
//  Created by Jay Tucker on 11/8/13.
//  Copyright (c) 2013 Nexage. All rights reserved.
//

#import <Foundation/Foundation.h>

//  System Versioning Preprocessor Macros
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

// Used scripts declarations

#define SK_VIEWPORT_META_TAG            @"<meta name='viewport' content='width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no', shrink-to-fit=YES />"
#define SK_STYLE_TAG                    @"<style>\n body { margin:0; padding:0; }\n *:not(input) { -webkit-touch-callout:none; -webkit-user-select:none; -webkit-text-size-adjust:none; }\n </style>";
#define SK_DISABLE_SELECTION_SCRIPT     @"window.getSelection().removeAllRanges();"
#define SK_DISABLE_JS_ALERTS_SCRIPT     @"function alert(){}; function prompt(){}; function confirm(){}"

#define SK_MRAID_ERROR_EVENT_SCRIPT(Msg, Action)                            [NSString stringWithFormat:@"mraid.fireErrorEvent('%@','%@');", Msg, Action]
#define SK_MRAID_READY_EVENT_SCRIPT                                         @"mraid.fireReadyEvent()"
#define SK_MRAID_SIZE_CHANGE_EVENT_SCRIPT(XPoint, YPoint, Width, Height)    [NSString stringWithFormat:@"mraid.setCurrentPosition(%d,%d,%d,%d);", XPoint, YPoint, Width, Height]
#define SK_MRAID_STATE_CHANGE_EVENT_SCRIPT(Event)                           [NSString stringWithFormat:@"mraid.fireStateChangeEvent('%@');", Event]
#define SK_MRAID_VIEWABLE_EVENT_SCRIPT(Viewable)                            [NSString stringWithFormat:@"mraid.fireViewableChangeEvent(%@);", Viewable  ? @"true" : @"false"]
#define SK_MRAID_SET_DEFAULT_POSITION_SCRIPT(XPoint, YPoint, Width, Height) [NSString stringWithFormat:@"mraid.setDefaultPosition(%f,%f,%f,%f);", XPoint, YPoint, Width, Height]
#define SK_MRAID_SET_MAX_SIZE_SCRIPT(Width, Height)                         [NSString stringWithFormat:@"mraid.setMaxSize(%d,%d);", Width, Height]
#define SK_MRAID_SET_SCREEN_SIZE_SCRIPT(Width, Height)                      [NSString stringWithFormat:@"mraid.setScreenSize(%d,%d);", Width, Height]
#define SK_MRAID_SET_SUPPORTED_FEATURE_SCRIPT(Feature)                      [NSString stringWithFormat:@"mraid.setSupports('%@',%@);", Feature, @"true"]
#define SK_MRAID_SET_PLC_TYPE_SCRIPT(Fullscreen)                            [NSString stringWithFormat:@"mraid.setPlacementType('%@');", Fullscreen ? @"interstitial" : @"inline"]


@interface SKMRAIDUtil : NSObject

+ (NSString *)processRawHtml:(NSString *)rawHtml;

@end
