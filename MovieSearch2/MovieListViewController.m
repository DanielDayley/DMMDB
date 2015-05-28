//
//  ViewController.m
//  MovieSearch2
//
//  Created by Taylor Mott on 22 May 15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "NetworkController.h"
#import "MovieListViewController.h"
#import "MovieDetailViewController.h"
#import "MovieController.h"
#import "Movie.h"

@interface MovieListViewController ()
@property (weak, nonatomic) IBOutlet UINavigationItem *navBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBarItem;
@end

@implementation MovieListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section { // Take the number of movies we have from MovieController and allocate enough cells for each of them.
    return [[MovieController sharedInstance].resultMovies count] -1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *primaryCell = [tableView dequeueReusableCellWithIdentifier:@"movieCellID"]; // Usual cell stuff. Make a cell if there ain't one, etc.
    if (!primaryCell) {
        primaryCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"movieCellID"];
    }
    // 1. Make a pointer to the movie at index path. 2. Set the cell text to movie title. 3. Format the year and set that as the subtitle. 4. Return the cell. Don't forget to change your cell type to 'Subtitle' in your storyboard!
    Movie *movieAtCurrentIndex = [MovieController sharedInstance].resultMovies[indexPath.row]; // 1
    primaryCell.textLabel.text = movieAtCurrentIndex.title; // 2
    NSArray* charactersInDate = [movieAtCurrentIndex.releaseDate componentsSeparatedByString:@"-"]; // 3
    NSString* yearDate = charactersInDate[0];
    primaryCell.detailTextLabel.text = [NSString stringWithFormat:@"%@",yearDate];
    return primaryCell; // 4
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar { // Similar to button selected
    NSString *searchString = self.searchBarItem.text;
    NSArray* wordsInSearchString = [searchString componentsSeparatedByCharactersInSet :[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString* webCompatableString = [wordsInSearchString componentsJoinedByString:@"%20"];
// The last two statements split the string by it's whitespace characters (spaces) and put's it back together with a web-friendly '%20' to join them. The next line logs your search query for your debugging pleasure.
    NSLog(@"Querying \"https://api.themoviedb.org/3/search/movie?api_key=53e0bfbe5a380567f77ec24bafd01593&query=%@\"",webCompatableString);
    [[NetworkController sharedInstance] executeSessionSearchRequest:webCompatableString withBlock:^{/* Make note that this is the block that we want the NetworkController to tell us to execute when it's done. This code WILL NOT be executed right away, remember that.*/
        [[MovieController sharedInstance] parseEntriesFromDictionary:[NetworkController sharedInstance].searchResultsDictionary];
        [self.tableView reloadData];
    }];
    [searchBar resignFirstResponder];    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath { // Remember, you have to be assigned as the tableView's delegate for this guy to ever get called. Add delegate protocol to class, set as delegate in storyboard.
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get him on the same page (movie)
    NSLog(@"Calling segue %@",segue.identifier);
    MovieDetailViewController *detailController = [segue destinationViewController]; // Get the instance of DetailView that will be called.
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    self.selectedMovie = [MovieController sharedInstance].resultMovies[indexPath.row];
    detailController.currentMovie = self.selectedMovie;
    [[NetworkController sharedInstance] executeSessionPosterRequest:self.selectedMovie.iconPath withBlock:^(NSData *data) { // This request is a little different, because it returns NSData * with the execution of the block. We do this to get the image out of the NetworkController without having NetworkController barbarically set a property and expect us to pick up data from it.
        
        NSLog(@"Image data: %@",data); // This should be huge. Just sayin'.
        dispatch_async(dispatch_get_main_queue(), ^{
            detailController.imageData = data;// Tada!
        });
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
