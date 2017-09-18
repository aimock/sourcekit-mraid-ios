//
//  SKMRAIDNetworkClient.m
//  MRAID
//
//  Created by Stas Kochkin on 18/09/2017.
//  Copyright © 2017 Nexage. All rights reserved.
//

#import "SKMRAIDNetworkClient.h"
#import "NSError+SKExtension.h"


@interface SKMRAIDNetworkClient ()

@property (nonatomic, strong, readonly) NSURLSession * session;

@end

@implementation SKMRAIDNetworkClient

#pragma mark - Public

- (void)loadDataFromURL:(NSURL *)URL {
    __weak typeof(self) weakSelf = self;
    NSURLSessionDataTask * downloadTask = [self.session dataTaskWithURL:URL
                                                      completionHandler:^(NSData * data, NSURLResponse * response, NSError * error) {
                                                          NSString * dataString = [weakSelf downloadedData:data forResponse:response withError:&error];
                                                          if (error) {
                                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                                  [weakSelf.delegate networkClient:weakSelf
                                                                        didFailToLoadDataWithError:error];
                                                              });
                                                          } else {
                                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                                  [weakSelf.delegate networkClient:weakSelf
                                                                                       didLoadData:dataString];
                                                              });
                                                          }
                                                      }];
    [downloadTask resume];
}

#pragma mark - Private

- (NSString *)downloadedData:(NSData *)data
                 forResponse:(NSURLResponse *)response
                   withError:(NSError **)error {
    
    // Validate error object
    if (error != NULL && *error != nil) {
        *error = [*error sk_wrappedErrorWithCode:MRAIDPreloadNoFillError];
        return nil;
    }
    
    // Validate status code
    NSInteger responseCode = [response isKindOfClass:[NSHTTPURLResponse class]] ? [(NSHTTPURLResponse *)response statusCode] : 500;
    if (responseCode >= 400) {
        if (error != NULL) {
            *error = [NSError sk_errorWithCode:MRAIDPreloadNetworkError];
        }
        return nil;
    }
    
    // Validate response data lenght
    NSString * downloadedData = [[NSString alloc] initWithData:data
                                                      encoding:NSUTF8StringEncoding];
    if (downloadedData.length < 20) {
        if (error != NULL) {
            *error = [NSError sk_errorWithCode:MRAIDPreloadNetworkError];
        }
        return nil;
    }
    
    return downloadedData;
}

#pragma mark - Acessing

- (NSURLSession *)session {
    return [NSURLSession sharedSession];
}

@end
