//
//  NetworkController.h
//  MovieSearch2
//
//  Created by Daniel Dayley on 5/26/15.
//  Copyright (c) 2015 Mott Applications. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface NetworkController : NSObject
@property (strong, nonatomic) NSDictionary *searchResultsDictionary;
@property (nonatomic) UIImage *posterImage;

+ (NetworkController *)sharedInstance;
- (void)executeSessionSearchRequest:(NSString *)searchKey withBlock:(void (^)(void))completionBlock;
- (void)executeSessionPosterRequest:(NSString *)imagePath withBlock:(void (^)(NSData *))completionBlock;

@end
