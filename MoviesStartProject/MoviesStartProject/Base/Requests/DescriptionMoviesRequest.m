//
//  DescriptionMoviesRequest.m
//  MoviesStartProject
//
//  Created by inmanage on 25/10/2021.
//

#import "DescriptionMoviesRequest.h"
#import "DescriptionMoviesResponse.h"
#import "Constants.h"

static NSString* requestName  = mDescriptionMovies;

@implementation DescriptionMoviesRequest

-(BaseServerRequestResponse*)buildBaseServerResponse:(NSDictionary *)jsonParsed
{
    
    DescriptionMoviesResponse* descriptionMoviesResponse = [[DescriptionMoviesResponse alloc]init];
    [descriptionMoviesResponse createResponse:jsonParsed];
    
    return descriptionMoviesResponse;
}

-(NSString*)getMethodName
{
    return requestName;
}

@end
