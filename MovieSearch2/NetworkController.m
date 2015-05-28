//
//  NetworkController.m
//  MovieSearch2
//
//  Created by Daniel Dayley on 5/26/15.
//  Copyright (c) 2015 Mott Applications. All rights reserved.
//

#import "NetworkController.h"
#import "MovieListViewController.h"

@interface NetworkController()
@end
@implementation NetworkController

+ (NetworkController *)sharedInstance {
    
    static NetworkController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[NetworkController alloc] init];
    });
    return sharedInstance;
}

- (void)executeSessionSearchRequest:(NSString *)searchKey withBlock:(void (^)(void))completionBlock
{ // Our first grand GET request pulls in a dictionary of dictionaries that it thinks are search results. The request is launched on the default session (ie whenever the iOS device gets around to it) and returns nothing. It sets NetworkController's searchResultsDictionary to the monolithic dictionary mentioned above and runs the inputed block on it's sender when done.
    NSURLSession *defaultSession = [NSURLSession sharedSession];
    NSString *apiKey = @"api_key=877be163f3a8e0d10f8231c335833e82";
    NSURLSessionDataTask *defaultGETRequest = [defaultSession dataTaskWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://api.themoviedb.org/3/search/movie?%@&query=%@",apiKey,searchKey]] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
        NSLog(@"%@",error);
        }
        NSDictionary *serializedResults = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        self.searchResultsDictionary = [serializedResults objectForKey:@"results"];
        dispatch_async(dispatch_get_main_queue(), ^{
            completionBlock();
        });
    }];
    [defaultGETRequest resume];
}

- (void)executeSessionPosterRequest:(NSString *)imagePath withBlock:(void (^)(NSData *))completionBlock
{ // Our second GET request is a little different because it is pulling down a single image as a hunk of hex. Since we want to pass that data back to the controller elegantly, we will return NSData from the block we are given. What a nice gift! To do this, we run completionBlock(data) on the sender, giving it the data it needs.
    NSLog(@"ImagePath: http://image.tmdb.org/t/p/w92%@",imagePath);
    NSURLSession *defaultSession = [NSURLSession sharedSession];
    NSURLSessionDataTask *defaultGETRequest = [defaultSession dataTaskWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://image.tmdb.org/t/p/w92%@",imagePath]] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            NSLog(@"%@",error);
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            completionBlock(data);
        });
    }];
    [defaultGETRequest resume];
}


@end
