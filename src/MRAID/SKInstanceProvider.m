//
//  SKInstanceProvider.m
//  MRAID
//
//  Created by Stas Kochkin on 18/09/2017.
//  Copyright © 2017 Nexage. All rights reserved.
//

#import "SKInstanceProvider.h"

@implementation SKInstanceProvider

+ (SKInstanceProvider *)sharedProvider {
    static SKInstanceProvider * _sharedProvider;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedProvider = [SKInstanceProvider new];
    });
    return _sharedProvider;
}

@end
