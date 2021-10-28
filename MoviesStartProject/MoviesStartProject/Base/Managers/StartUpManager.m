//
//  StartUpManager.m
//  MoviesStartProject
//
//  Created by inmanage on 24/10/2021.
//

#import "StartUpManager.h"
#import "GetHostUrlRequest.h"
#import "GetHostUrlResponse.h"
#import "ClearSessionRequest.h"
#import "ApplicationTokenRequest.h"
#import "ApplicationTokenResponse.h"
#import "SetSettingsRequest.h"
#import "ValidateVersionRequest.h"
#import "GeneralDeclarationRequest.h"
#import "MoviesRequest.h"
#import "CinemasRequest.h"
#import "DescriptionMoviesRequest.h"
#import "ApplicationManager.h"
#import "Constants.h"
#import <UIKit/UIKit.h>
#import "BannerViewController.h"
#import "UIWindow+Display.h"

static StartUpManager *_sharedInstance = nil;

@implementation StartUpManager
+ (StartUpManager *)sharedInstance {
    
    if (! _sharedInstance) {
        _sharedInstance = [[StartUpManager alloc] init];
    }
    
    return _sharedInstance;
}

- (void)start {
    self.inProcess = YES;
    [self getHostUrlRequest];
    
}


- (void)getHostUrlRequest {
    GetHostUrlRequest *getHostUrlRequest = [[GetHostUrlRequest alloc] initWithCallerObject:self andParams:nil];
    getHostUrlRequest.showHud = NO;
    getHostUrlRequest.allowSendingAboveMaxAttempts = YES;
    [[ApplicationManager sharedInstance].requestManager sendRequestForRequest:getHostUrlRequest];
}

-(void)clearSession {
    ClearSessionRequest *clearSessionRequest = [[ClearSessionRequest alloc] initWithCallerObject:self andParams:nil];
    
    [[ApplicationManager sharedInstance].requestManager sendRequestForRequest:clearSessionRequest];
}

-(void)applicationToken {
    ApplicationTokenRequest *applicationTokenRequest = [[ApplicationTokenRequest alloc] initWithCallerObject:self andParams:nil];
    
    [[ApplicationManager sharedInstance].requestManager sendRequestForRequest:applicationTokenRequest];
}

-(void)setSettings {
    SetSettingsRequest *setSettingsRequest = [[SetSettingsRequest alloc] initWithCallerObject:self andParams:nil];
    
    NSLog(@"token %@",[[ApplicationManager sharedInstance].requestManager strApplicationToken]);
    
    [[ApplicationManager sharedInstance].requestManager sendRequestForRequest:setSettingsRequest];
}

- (void)validateVersion {
    
    ValidateVersionRequest *validateVersionRequest = [[ValidateVersionRequest alloc] initWithCallerObject:self andParams:nil];
    validateVersionRequest.showHud = NO;
    validateVersionRequest.showMessage = NO;
    validateVersionRequest.allowSendingAboveMaxAttempts = YES;
    [[ApplicationManager sharedInstance].requestManager sendRequestForRequest:validateVersionRequest];
}

-(void)generalDeclaration {
    GeneralDeclarationRequest *generalDeclarationRequest = [[GeneralDeclarationRequest alloc] initWithCallerObject:self andParams:nil];
    [[ApplicationManager sharedInstance].requestManager sendRequestForRequest:generalDeclarationRequest];
}

-(void)movies {
    MoviesRequest *moviesRequest = [[MoviesRequest alloc] initWithCallerObject:self andParams:nil];
    [[ApplicationManager sharedInstance].requestManager sendRequestForRequest:moviesRequest];
}

-(void)cinemas {
    CinemasRequest *cinemasRequest = [[CinemasRequest alloc] initWithCallerObject:self andParams:nil];
    [[ApplicationManager sharedInstance].requestManager sendRequestForRequest:cinemasRequest];
}

-(void)descriptionMovies {
    DescriptionMoviesRequest *descriptionMoviesRequest = [[DescriptionMoviesRequest alloc] initWithCallerObject:self andParams:nil];
    [[ApplicationManager sharedInstance].requestManager sendRequestForRequest:descriptionMoviesRequest];
}

#pragma mark - ServerRequestDoneProtocol


- (void)serverRequestSucceed:(BaseServerRequestResponse*)baseResponse baseRequest:(BaseRequest*)baseRequest {
    [self callNextRequest:baseResponse];
}

- (void)serverRequestFailed:(BaseServerRequestResponse *)baseResponse baseRequest:(BaseRequest *)baseRequest {
}

- (void)callNextRequest:(BaseServerRequestResponse *)baseResponse {
    if ([baseResponse.methodName isEqual: mGetHostUrl]) {
        NSString *baseUrl = ((GetHostUrlResponse *) baseResponse).hostURL;
        NSLog(@"url %@",baseUrl);
        [[NSUserDefaults standardUserDefaults] setObject:baseUrl forKey:@"baseUrl"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [self clearSession];
    }
    else if ([baseResponse.methodName isEqual: mClearSession]) {
        [self applicationToken];
    }
    else if ([baseResponse.methodName isEqual: mApplicationToken]) {
        [ApplicationManager sharedInstance].requestManager.strApplicationToken = ((ApplicationTokenResponse*)baseResponse).strApplicationToken;
        
        [self setSettings];
    }
    else if ([baseResponse.methodName isEqual: mSetSettings]) {
        [self validateVersion];
    }
    else if ([baseResponse.methodName isEqual: mValidateVersion]) {
        
        [self generalDeclaration];
    }
    else if ([baseResponse.methodName isEqual:mGeneralDeclaration]) {
        [self movies];
    }
    else if ([baseResponse.methodName isEqual: mGetMovies]) {
        [self cinemas];
    }
}

@end
