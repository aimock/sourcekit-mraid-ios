//
//  SKMRAIDUtil.m
//  MRAID
//
//  Created by Jay Tucker on 11/8/13.
//  Copyright (c) 2013 Nexage. All rights reserved.
//

#import "SKMRAIDUtil.h"

@implementation SKMRAIDUtil

+ (NSString *)processRawHtml:(NSString *)rawHtml {
    NSString *processedHtml = rawHtml;
    
    // Remove the mraid.js script tag.
    // We expect the tag to look like this:
    // <script src='mraid.js'></script>
    // But we should also be to handle additional attributes and whitespace like this:
    // <script  type = 'text/javascript'  src = 'mraid.js' > </script>
    
    NSString *pattern = @"<script\\s+[^>]*\\bsrc\\s*=\\s*([\\\"\\\'])mraid\\.js\\1[^>]*>\\s*</script>\\n*";
    NSError *error = NULL;
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    processedHtml = [regex stringByReplacingMatchesInString:processedHtml
                                                    options:0
                                                      range:NSMakeRange(0, [processedHtml length])
                                               withTemplate:@""];
    
    // Add html, head, and/or body tags as needed.
    BOOL hasHtmlTag = ([rawHtml containsString:@"<html"]) || ([rawHtml containsString:@"<!DOCTYPE html"]);
    BOOL hasHeadTag = [rawHtml containsString:@"<head"];
    BOOL hasBodyTag = [rawHtml containsString:@"<body"];
    
    // basic sanity checks
    if ((!hasHtmlTag && (hasHeadTag || hasBodyTag)) ||
        (hasHtmlTag && !hasBodyTag)) {
        return nil;
    }
    
    if (!hasHtmlTag) {
        processedHtml = [NSString stringWithFormat:
                         @"<html>\n"
                         "<head>\n"
                         "</head>\n"
                         "<body>\n"
                         "<div align='center'>\n"
                         "%@"
                         "</div>\n"
                         "</body>\n"
                         "</html>",
                         processedHtml
                         ];
    } else if (!hasHeadTag) {
        // html tag exists, head tag doesn't, so add it
        pattern = @"<html[^>]*>";
        error = NULL;
        regex = [NSRegularExpression regularExpressionWithPattern:pattern
                                                          options:NSRegularExpressionCaseInsensitive
                                                            error:&error];
        processedHtml = [regex stringByReplacingMatchesInString:processedHtml
                                                        options:0
                                                          range:NSMakeRange(0, [processedHtml length])
                                                   withTemplate:@"$0\n<head>\n</head>"];
    }
    
    // Add meta and style tags to head tag.
    NSString *metaTag   = SK_VIEWPORT_META_TAG;
    NSString *styleTag  = SK_STYLE_TAG;
    
    pattern = @"<head[^>]*>";
    error = NULL;
    regex = [NSRegularExpression regularExpressionWithPattern:pattern
                                                      options:NSRegularExpressionCaseInsensitive
                                                        error:&error];
    processedHtml = [regex stringByReplacingMatchesInString:processedHtml
                                                    options:0
                                                      range:NSMakeRange(0, [processedHtml length])
                                               withTemplate:[NSString stringWithFormat:@"$0\n%@\n%@", metaTag, styleTag]];
    
    return processedHtml;
}

@end
