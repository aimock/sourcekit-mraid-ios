//
//  SKInstanceProvider.h
//  MRAID
//
//  Created by Stas Kochkin on 18/09/2017.
//  Copyright © 2017 Nexage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface SKInstanceProvider : NSObject

+ (SKInstanceProvider *)sharedProvider;

@end
