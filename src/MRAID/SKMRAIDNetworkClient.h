//
//  SKMRAIDNetworkClient.h
//  MRAID
//
//  Created by Stas Kochkin on 18/09/2017.
//  Copyright © 2017 Nexage. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SKMRAIDNetworkClient;

@protocol SKMRAIDNetworkClientDelegate <NSObject>

- (void)networkClient:(SKMRAIDNetworkClient *)networkClient didLoadData:(NSString *)dataString;
- (void)networkClient:(SKMRAIDNetworkClient *)networkClient didFailToLoadDataWithError:(NSError *)error;

@end

@interface SKMRAIDNetworkClient : NSObject

@property (nonatomic, weak) id<SKMRAIDNetworkClientDelegate> delegate;

- (void)loadDataFromURL:(NSURL *)URL;

@end
