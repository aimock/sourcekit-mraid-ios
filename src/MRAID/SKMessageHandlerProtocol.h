//
//  SKMessageHandler.h
//  MRAID
//
//  Created by Stas Kochkin on 18/09/2017.
//  Copyright © 2017 Nexage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>


@protocol SKMessageHandler <WKScriptMessageHandler>

@property (nonatomic, readonly) NSString * name;

@end
