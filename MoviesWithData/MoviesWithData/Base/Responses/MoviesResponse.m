//
//  MoviesResponse.m
//  MoviesStartProject
//
//  Created by inmanage on 28/10/2021.
//

#import "MoviesResponse.h"
#import "Movie.h"
#import "ApplicationManager.h"



@interface MoviesResponse ()
@end

@implementation MoviesResponse

-(void)parseData:(NSDictionary *)JSON {
    
    
    NSLog(@"movies json %@",JSON[@"movies"]);
    NSString * lastMoviesUpdate = [[ApplicationManager sharedInstance].movieManager lastMoviesUpdate];
    
    NSString * currentMoviesUpdate = @"1";//JSON[@"movies_last_update"]; //@"1";
    
    if ([lastMoviesUpdate isEqual:currentMoviesUpdate]) {
        return;
    }
    
    [self moviesUpdateNeeded];

    [[ApplicationManager sharedInstance].movieManager setLastMoviesUpdate:currentMoviesUpdate];
    NSArray *jsonMoviesArray = JSON[@"movies"];
    
    NSMutableDictionary *moviesDictionary = [[NSMutableDictionary alloc] init];
    NSMutableArray *moviesArray = [[NSMutableArray alloc] init];
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    
    for (int i = 0; i < jsonMoviesArray.count; i++) {
        NSString *year = jsonMoviesArray[i][@"year"];
        
        Movie *movie = [Movie new];
        movie.name = jsonMoviesArray[i][@"name"];
        movie.category = jsonMoviesArray[i][@"category"];
        movie.movieId = jsonMoviesArray[i][@"id"];
        movie.cinemasId = jsonMoviesArray[i][@"cenimasId"];
        movie.year = [numberFormatter numberFromString: year];
        
        NSLog(@"%@ %@", [movie.year class], [jsonMoviesArray[i][@"year"] class]);
        [moviesArray addObject:movie];
        [moviesDictionary setObject:movie forKey:movie.movieId];
        
    }
    
    [[ApplicationManager sharedInstance].movieManager setMoviesArray:moviesArray];
    [[ApplicationManager sharedInstance].movieManager setMoviesDictionary:moviesDictionary];
    
}

-(Boolean)moviesUpdateNeeded {
//    NSString *userMoviesUpdate = [[NSUserDefaul standardUserDefaults] valueForKey:@"userMoviesUpdate"];
    
//    if ([userMoviesUpdate isEqual:currentMoviesUpdate]) {
//        return false;
//    }
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
//
//    NSString *documentName = @"moviesList";
//
//    NSURL *documentsDirectory = [[fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];
    
    NSURL *url = [[ApplicationManager sharedInstance].movieManager getUrl:@"moviesList"]; //[documentsDirectory URLByAppendingPathComponent:documentName];
    
    [fileManager removeItemAtURL:url error:nil];
    
//    [[NSUserDefaults standardUserDefaults] setObject:currentMoviesUpdate forKey:@"userMoviesUpdate"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
    
    return true;
}

@end
