//
//  ViewController.m
//  NSSecureCodingProject
//
//  Created by inmanage on 02/12/2021.
//

#import "ViewController.h"
#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>
#import "DBanner.h"

@interface ViewController ()

@end

@implementation ViewController{
    UIManagedDocument *bannerDocument;
    UIImage *bannerImage;
    NSURL *url;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setURL];
//    if (![self setURL]) {
        [self callURLSession:^{
            [self prepareMoviesDataBaseFile];
        }];
//    }
    
    self.view.backgroundColor = [UIColor greenColor];
}

- (Boolean)setURL {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *documentsDirectory = [[fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];
    url = [documentsDirectory URLByAppendingPathComponent:@"banner_file"];
    
    bool fileExistsAtPath = [[NSFileManager defaultManager] fileExistsAtPath:[url path]];
    
    if(fileExistsAtPath) {
        bannerDocument = [[UIManagedDocument alloc] initWithFileURL:url];
        
        [bannerDocument openWithCompletionHandler:^(BOOL success) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self getBannerFromDataBase];
            });
        }];
        return true;
    }
    return false;
}


-(void)callURLSession:(void(^)(void))completion {
    
    NSURL *url = [NSURL URLWithString:@"https://x-mode.co.il/exam/allMovies/bannerImage.jpg"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask  *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if(httpResponse.statusCode == 200)
        {
            NSLog(@"Success");
            if (data) {
                self->bannerImage = [UIImage imageWithData:data];
                NSLog(@"Got image");
                completion();
            }
        }
        else
        {
            NSLog(@"Error: %@", error);
        }
    }];
    
    [task resume];
}

- (void)prepareMoviesDataBaseFile {
    [[NSFileManager defaultManager] removeItemAtURL:url error:nil];
    
    bannerDocument = [[UIManagedDocument alloc] initWithFileURL:url];
    
    [bannerDocument saveToURL:url forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
        if (success) {
            [self bannerDocumentIsReady];
            NSLog(@"file created");
        }
        else {
            NSLog(@"Could not create file at the given url");
        }
    }];
}

- (NSArray *)getBanner {
    NSManagedObjectContext *context = bannerDocument.managedObjectContext;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Banner"];
    
    NSError *error;
    
    NSArray *results = [context executeFetchRequest:request error:&error];
    
    if (error) {
        NSLog(@"error %@", error.localizedDescription);
    }
    else {
        NSLog(@"results %@", results);
    }
    return results;
}

- (void)setBanner {
    
}

-(DBanner *)getBannerFromDataBase {
    DBanner *banner = [DBanner new];
    
    if (bannerDocument.documentState == UIDocumentStateNormal) {
        banner.bannerImage = [[self getBanner] objectAtIndex:0];
    }
    return banner;
}


-(void)bannerDocumentIsReady {
    if (bannerDocument.documentState == UIDocumentStateNormal) {
        NSLog(@"banner document ready");
        
        NSManagedObjectContext *context = bannerDocument.managedObjectContext;
        
        NSManagedObject *banner = [NSEntityDescription insertNewObjectForEntityForName:@"Banner" inManagedObjectContext:context];
                
        [banner setValue:bannerImage forKey:@"bannerImage"];
        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            self.bannerImageView.image = bannerImage;
//        });
        //            NSManagedObject *movie = [NSEntityDescription insertNewObjectForEntityForName:@"MovieEntity" inManagedObjectContext:context];
        //
        //            [movie setValue:received.name forKey:@"name"];
        
    }
    else {
        NSLog(@"movies document not ready %lu", bannerDocument.documentState);
    }
}


@end
