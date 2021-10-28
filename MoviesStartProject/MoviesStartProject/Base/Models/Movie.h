//
//  Movie.h
//  MoviesStartProject
//
//  Created by inmanage on 28/10/2021.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Movie : NSObject

@property (nonatomic, strong) NSString *category;
@property (nonatomic, strong) NSArray *cinemasId;
@property (nonatomic, strong) NSNumber *movieId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *year;

@end

NS_ASSUME_NONNULL_END
