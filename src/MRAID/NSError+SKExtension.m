//
//  NSError+SKExtension.m
//  MRAID
//
//  Created by Stas Kochkin on 18/09/2017.
//  Copyright © 2017 Nexage. All rights reserved.
//

#import "NSError+SKExtension.h"

NSString *const kSKMRAIDErrorDomain = @"com.skmraid.error";


@implementation NSError (SKExtension)

+ (NSError *)sk_errorWithCode:(MRAIDError)error {
    return [self sk_errorWithCode:error
                     descritption:nil
                           reason:nil];

}

+ (NSError *)sk_errorWithCode:(MRAIDError)error
                 descritption:(NSString *)descritption {
    
    return [self sk_errorWithCode:error
                     descritption:descritption
                           reason:nil];
}

+ (NSError *)sk_errorWithCode:(MRAIDError)error
                 descritption:(NSString *)descritption
                       reason:(NSString *)reason {
    
    NSMutableDictionary * userInfo = [NSMutableDictionary new];
    userInfo[NSLocalizedDescriptionKey]         = descritption ? NSLocalizedString(descritption, nil) : nil;
    userInfo[NSLocalizedFailureReasonErrorKey]  = reason ? NSLocalizedString(reason, nil) : nil;
    
    return [NSError errorWithDomain:kSKMRAIDErrorDomain
                               code:error
                           userInfo:userInfo];
}


- (NSError *)sk_wrappedErrorWithCode:(MRAIDError)error {
    return [NSError errorWithDomain:kSKMRAIDErrorDomain
                               code:error
                           userInfo:self.userInfo];
}

@end
