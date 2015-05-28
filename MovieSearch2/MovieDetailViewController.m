//
//  MovieDetailViewController.m
//  MovieSearch2
//
//  Created by Taylor Mott on 22 May 15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "MovieDetailViewController.h"

@interface MovieDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *labelForTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelForYear;
@property (weak, nonatomic) IBOutlet UILabel *labelForVotes;
@property (weak, nonatomic) IBOutlet UILabel *labelForRating;
@property (weak, nonatomic) IBOutlet UIImageView *posterImage;

@end

@implementation MovieDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    [self updateLabels];
}

-(void)viewDidAppear:(BOOL)animated { // Just in case. Since I call this on prepareForSegue, it gets called twice (for good measure;-)
    self.posterImage.image = [UIImage imageWithData:self.imageData];
}

- (void)updateLabels {  // Everything I need to set in all the DetailViewProperties is done here. This methods assumes that self.currentMovie is not nil.
    NSLog(@"Current Title: %@",self.currentMovie.title);
    self.labelForTitle.text = self.currentMovie.title;
    NSArray* charactersInDate = [self.currentMovie.releaseDate componentsSeparatedByString:@"-"];
    NSString* yearDate = charactersInDate[0];
    self.labelForYear.text = yearDate;
    self.labelForVotes.text = [NSString stringWithFormat:@"%2@",self.currentMovie.numberOfVotes];
    self.labelForRating.text = [NSString stringWithFormat:@"%2@",self.currentMovie.voteAverage];
    NSLog(@"Labels Updated.");

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
