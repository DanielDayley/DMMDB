//
//  MovieController.m
//  MovieSearch2
//
//  Created by Taylor Mott on 22 May 15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "MovieController.h"
#import "Movie.h"

@implementation MovieController

+ (MovieController *)sharedInstance { // One MovieController makes my life easier.
    
    static MovieController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [MovieController new];
    });
    return sharedInstance;
    
}

- (void)parseEntriesFromDictionary:(NSDictionary *)resultsDictionary { // Accepts a dictionary of movie dictionaries and makes movies out of them.
    NSMutableArray *arrayOfMovies = [[NSMutableArray alloc] init];
    for (NSDictionary *movieDictionary in resultsDictionary) {
        [arrayOfMovies addObject:[self movieFromDictionary:movieDictionary]];
    }
    self.resultMovies = arrayOfMovies;
}

- (Movie *)movieFromDictionary:(NSDictionary *)movieDictionary { // Returns a movie filled with properties from the dictionary
    Movie *newMovie = [[Movie alloc] init];
    newMovie.title = [movieDictionary objectForKey:@"title"];
    newMovie.voteAverage = [movieDictionary objectForKey:@"vote_average"];
    newMovie.numberOfVotes = [movieDictionary objectForKey:@"vote_count"];
    newMovie.releaseDate = [movieDictionary objectForKey:@"release_date"];
    newMovie.iconPath = [movieDictionary objectForKey:@"poster_path"];
    return newMovie;
}

@end
