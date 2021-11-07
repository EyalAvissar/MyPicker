//
//  LoadingViewController.m
//  MoviesStartProject
//
//  Created by inmanage on 24/10/2021.
//

#import "LoadingViewController.h"
#import "ApplicationManager.h"
#import "BannerViewController.h"
#import "Constants.h"

@interface LoadingViewController ()

@end

@implementation LoadingViewController
{
    int numOfCalls;
    int numOfFinishedCalls;
    int startingNumOfCalls;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationNameUpdateLoader:) name:kNotificationNameUpdateLoader object:nil];
    
    self.percentDone = 8;
    numOfFinishedCalls = 1;
    startingNumOfCalls = 0;
    self.percentLabel.text = @"8%";
    
    self.view.backgroundColor = [UIColor greenColor];
    [[ApplicationManager sharedInstance].startUpManager start];
    
}

- (void)updateLoaderWithMethodName:(NSString*)strMethodName {
    
    [self isVersionValid];
    numOfFinishedCalls++;
    
    // !shouldDownloadMediaZipFile && !canLogin
    if (numOfCalls == startingNumOfCalls) {
        self.percentDone += 16;
    }
    
    // shouldDownloadMediaZipFile || canLogin
    else if (numOfCalls == 7) {
        
        if (numOfFinishedCalls < 3) {
            self.percentDone += 8;
        }
        
        else {
            self.callsProgressBar.progress += 0.16;
            self.percentDone += 16;
        }
    }
    
    // shouldDownloadMediaZipFile && canLogin
    else {
        
        if (numOfFinishedCalls < 5) {
            self.percentDone += 8;
        }
        
        else {
            self.percentDone += 16;
        }
    }
    
    if (numOfFinishedCalls == numOfCalls) {
        self.percentDone = 100;
    }
    
    if (self.percentDone >= 99.0) {
        self.percentLabel.text = @"98%";
    }
    
    else {
        self.percentLabel.text = [NSString stringWithFormat:@"%i%%", self.percentDone];
    }
    

    self.callsProgressBar.progress = self.percentDone / 100.0;
}




#pragma mark - ServerRequestDoneProtocol

- (void)serverRequestSucceed:(BaseServerRequestResponse*)baseResponse baseRequest:(BaseRequest*)baseRequest {
    
    [self updateLoaderWithMethodName:baseRequest.getMethodName];
    
    if (numOfFinishedCalls == originalNumOfCalls) {
        [self loadBannerView];
    }
}

- (void)serverRequestFailed:(BaseServerRequestResponse *)baseResponse baseRequest:(BaseRequest *)baseRequest {
}

-(void)loadBannerView {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    BannerViewController *bannerController = [storyBoard instantiateViewControllerWithIdentifier:@"banneView"];

    [bannerController setModalPresentationStyle:UIModalPresentationFullScreen];
    
    [self presentViewController:bannerController animated:true completion:nil];
}

- (BOOL) isVersionValid {
    if (![ApplicationManager sharedInstance].startUpManager.isValidVersion) {
        
        NSString *alertTitle = @"Your app version  is not up to date";
        
        NSString *alertMessage = @"Please update your app in appStore";
        
        UIAlertController *invalidVersion = [UIAlertController alertControllerWithTitle: alertTitle message:alertMessage preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [invalidVersion addAction:cancel];
        [self presentViewController:invalidVersion animated:true completion:nil];
        
        return false;
    }
    return true;
}

@end
