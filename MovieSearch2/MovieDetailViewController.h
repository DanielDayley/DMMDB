//
//  MovieDetailViewController.h
//  MovieSearch2
//
//  Created by Taylor Mott on 22 May 15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

@interface MovieDetailViewController : UIViewController
@property (nonatomic) Movie *currentMovie;
@property (nonatomic,strong) NSData *imageData;
- (void)updateLabels;

@end
