//
//  GeneralDeclarationResponse.m
//  MoviesStartProject
//
//  Created by inmanage on 25/10/2021.
//

#import "GeneralDeclarationResponse.h"
#import "ApplicationManager.h"

@implementation GeneralDeclarationResponse

-(void)parseData:(NSDictionary*)JSON{
    NSString *container = JSON[@"banner"][@"imageUrl"];

    [[ApplicationManager sharedInstance].appGD setBannerImageUrl:container];
    
    container = JSON[@"banner"][@"videoUrl"];

    [[ApplicationManager sharedInstance].appGD setBannerVideoUrl:container];
}

@end
