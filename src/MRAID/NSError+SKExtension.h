//
//  NSError+SKExtension.h
//  MRAID
//
//  Created by Stas Kochkin on 18/09/2017.
//  Copyright © 2017 Nexage. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString * const kSKMRAIDErrorDomain;

typedef enum {
    MRAIDPreloadNoFillError,
    MRAIDPreloadNetworkError,
    MRAIDShowError,
    MRAIDValidationError,
    MRAIDSuspiciousCreativeError
} MRAIDError;



@interface NSError (SKExtension)

+ (NSError *)sk_errorWithCode:(MRAIDError)error;
+ (NSError *)sk_errorWithCode:(MRAIDError)error
                 descritption:(NSString *)descritption;
+ (NSError *)sk_errorWithCode:(MRAIDError)error
                 descritption:(NSString *)descritption
                       reason:(NSString *)reason;
- (NSError *)sk_wrappedErrorWithCode:(MRAIDError)error;

@end
