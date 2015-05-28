//
//  Movie.h
//  MovieSearch2
//
//  Created by Taylor Mott on 22 May 15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface Movie : NSObject
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSNumber *voteAverage;
@property (strong, nonatomic) NSNumber *numberOfVotes;
@property (strong, nonatomic) NSString *releaseDate;
@property (strong, nonatomic) NSString *iconPath;
@property (nonatomic) UIImageView *posterImageView; // Import UIKit to use this.
@property (nonatomic) BOOL isAdultFilm;


@end
