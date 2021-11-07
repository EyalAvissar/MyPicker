//
//  MoviesResponse.m
//  MoviesStartProject
//
//  Created by inmanage on 28/10/2021.
//

#import "MoviesResponse.h"
#import "Movie.h"
#import "ApplicationManager.h"

@implementation MoviesResponse

-(void)parseData:(NSDictionary *)JSON {

    NSLog(@"movies json %@",JSON[@"movies"]);

    NSArray *jsonMoviesArray = JSON[@"movies"];
    NSMutableArray *moviesArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < jsonMoviesArray.count; i++) {
        Movie *movie = [Movie new];
        movie.name = jsonMoviesArray[i][@"name"];
        movie.category = jsonMoviesArray[i][@"category"];
        movie.movieId = jsonMoviesArray[i][@"id"];
        movie.cinemasId = jsonMoviesArray[i][@"cenimasId"];
        movie.year = jsonMoviesArray[i][@"year"];

        [moviesArray addObject:movie];
    }
    
    [[ApplicationManager sharedInstance].appGD setMoviesArray:moviesArray];
    
}

@end
