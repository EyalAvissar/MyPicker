//
//  DetailViewController.m
//  MoviesStartProject
//
//  Created by inmanage on 31/10/2021.
//

#import "DetailViewController.h"

@interface DetailViewController ()
{
    NSString *moviePosterUrl;
}

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *movieYear = [NSString stringWithFormat:@"%@", self.movie.year];
    self.nameLabel.text = self.movie.name;
    self.yearLabel.text = [NSString stringWithFormat:@"year: %@", movieYear];
    self.categoryLabel.text = self.movie.category;
    
    [self requestMovie];
}

-(void)requestMovie {
    NSString *movieUrlStr = [NSString stringWithFormat:@"https://mobile.inmanage.com/mobile-test/descriptionMovies/%@.json", self.movie.movieId];
    
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:movieUrlStr]];
    
    //create the Method "GET"
    [urlRequest setHTTPMethod:@"GET"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *detailsTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                         {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if(httpResponse.statusCode == 200)
        {
            NSDictionary *moviesDetails = [NSJSONSerialization JSONObjectWithData:data options:nil error:nil];
            
            self->moviePosterUrl = [NSString stringWithFormat:@"%@", moviesDetails[@"data"][@"imageUrl"]];
            NSLog(@"address %@", moviesDetails);
            
            [self requestPoster];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.descriptionTextView.text = moviesDetails[@"data"][@"description"];
                self.ratingLabel.text = [NSString stringWithFormat: @"rate: %@",moviesDetails[@"data"][@"rate"]];
                [self.promoURL setTitle:moviesDetails[@"data"][@"promoUrl"] forState:UIControlStateNormal];
                
            });
        }
        else
        {
            NSLog(@"Error: %@", error);
        }
    }];
    [detailsTask resume];
    
}

-(void)requestPoster {
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:moviePosterUrl]];
    
    //create the Method "GET"
    [urlRequest setHTTPMethod:@"GET"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *imageTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    {
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    if(httpResponse.statusCode == 200)
    {
    
    UIImage *posterImage = [UIImage imageWithData:data];
    
    dispatch_async(dispatch_get_main_queue(), ^{
    self.movieImageView.image = posterImage;
    });
    
    }
    else
    {
    NSLog(@"Error: %@", error);
    }
    }];
    
    [imageTask resume];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)showPromo:(UIButton *)sender {
    NSString *urlString = self.promoURL.currentTitle;
    NSURL *promoURL = [NSURL URLWithString: urlString];
    [[UIApplication sharedApplication] openURL:promoURL options:@{} completionHandler:nil];
}
@end
