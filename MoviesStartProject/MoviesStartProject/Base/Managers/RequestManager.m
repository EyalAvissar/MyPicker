//
//  RequestManager.m
//  MoviesStartProject
//
//  Created by inmanage on 24/10/2021.
//

#import "RequestManager.h"
#import "AFHTTPSessionManager.h"
#import "ApplicationManager.h"
#import "Constants.h"
#import "GetHostUrlResponse.h"

static RequestManager *_sharedInstance = nil;
static const NSTimeInterval methodTimeout = 1.5;

@implementation RequestManager
{
    NSMutableArray* serverRequestDoneDelegates;
//    UIViewController* vc;
    BOOL retryConter;
}

+ (RequestManager *)sharedInstance {
    
    if(! _sharedInstance) {
        _sharedInstance = [[RequestManager alloc] init];
    }
    
    return _sharedInstance;
}

-(id)init{
    self=[super init];
    serverRequestDoneDelegates=[[NSMutableArray alloc]init];
    return self;
}

-(void)addServerRequestDoneDelegate:(id<ServerRequestDoneProtocol>)caller{
    if (![serverRequestDoneDelegates containsObject:caller]) {
        
        BOOL newCaller = YES;
        
        for (id<ServerRequestDoneProtocol>delegate in serverRequestDoneDelegates) {
            if ([delegate isMemberOfClass:[caller class]]) {
                newCaller = NO;
                break;
            }
        }
        
        if (newCaller) {
            [serverRequestDoneDelegates addObject:caller];
            
        }
    }
}

-(void)removeServerRequestDoneDelegate:(id<ServerRequestDoneProtocol>)caller{
    [serverRequestDoneDelegates removeObject:caller];
}

-(void)sendRequestForRequest: (BaseRequest*) baseRequest {


    [baseRequest increaseAttemptCounter];
        
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    if([[baseRequest getMethodName]isEqualToString:mApplicationToken]) {
        [manager.requestSerializer setValue:kApplicationSecurityToken forHTTPHeaderField:@"TOKEN"];
    } else {
        [manager.requestSerializer setValue:nil forHTTPHeaderField:@"TOKEN"];
    }
    
    NSArray *allCookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];

    NSLog(@"\n 🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐 \n\n\n\n");
    NSString *baseUrl = [[NSUserDefaults standardUserDefaults] stringForKey: @"baseUrl"];
    
    baseUrl = (baseUrl)? baseUrl : @"https://mobile.inmanage.com/mobile-test/";

    if ([baseRequest isGET]) {

        
        NSString * _Nonnull extractedExpr = [NSString stringWithFormat:@"%@%@.json",baseUrl, baseRequest.getMethodName];
        NSString* strPostUrl = extractedExpr;
        
        NSLog(@"cmd GET METHOD %@:\r\nparamaters: %@", strPostUrl, baseRequest.dictParams);
        NSLog(@"\n\n\n\n ❇️❇️❇️❇️❇️❇️❇️❇️❇️❇️❇️❇️❇️❇️❇️❇️❇️❇️❇️❇️❇️❇️❇️❇️❇️❇️❇️❇️❇️❇️❇️❇️❇️❇️❇️❇️❇️❇️❇️❇️" );

        
                
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        
        [manager GET:strPostUrl parameters:baseRequest.dictParams headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSHTTPURLResponse *reponse = (NSHTTPURLResponse *)task.response;
//            NSLog(@"x-cache: %@ - method: strPostUrl %@", [[reponse allHeaderFields] objectForKey:@"x-cache"], strPostUrl);
            
            
            [self handleSuccess:baseRequest res:responseObject task:task];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self handleFailure:baseRequest task:task error:error];
        }];
    }
    else {
        NSString *baseUrl = [[NSUserDefaults standardUserDefaults] stringForKey: @"baseUrl"];
        
        NSString *strPostUrl = [NSString stringWithFormat:@"%@%@.json",baseUrl, baseRequest.getMethodName];
        
        manager.responseSerializer = [AFJSONResponseSerializer serializer];

        [manager POST:strPostUrl parameters:baseRequest.dictParams headers:nil constructingBodyWithBlock:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self handleSuccess:baseRequest res:responseObject task:task];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

            [self handleFailure:baseRequest task:task error:error];
        }];
    }
}

- (void)handleFailure:(BaseRequest*)baseRequest task:(NSURLSessionDataTask*)task error:(NSError*)error {
    NSLog(@"\n❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️ \n\n\n\n " );
    NSLog(@"cmd %@:\r\n failure: %@", baseRequest.getMethodName, error);
    NSLog(@"\n\n\n\n ❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️❗️" );
    
    if ([baseRequest canSendRequestAgain]) {
        
        NSTimeInterval requestAttemptDelay = ([ApplicationManager sharedInstance].appGD.methodTimeout > 0) ? [ApplicationManager sharedInstance].appGD.methodTimeout : methodTimeout;
        
//        NSArray *arrHUDs = [MBProgressHUD allHUDsForView:[UIApplication sharedApplication].keyWindow];
        
//        if (baseRequest.showHud && (!arrHUDs || arrHUDs.count == 0) && [UIApplication sharedApplication].keyWindow) {
//
////            [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
//        }
        
        [self performSelector:@selector(sendRequestForRequest:) withObject:baseRequest afterDelay:requestAttemptDelay];
        
        
    } else {
        
//        [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
        
//        BaseServerRequestResponse * baseRespone  = [[NoInternetResponse alloc]init];
        
//        [[[UIAlertView alloc]initWithTitle:@"" message:baseRespone.strMessage cancelButtonItem:[RIButtonItem itemWithLabel:buttonConfirmAlert action:^{
            //CONFIRM ACTION
//            if (baseRequest.allowSendingAboveMaxAttempts) {
//                [baseRequest resetAttemptCounter];
//                [self sendRequestForRequest:baseRequest];
//            }
//
//        }] otherButtonItems:nil] show];
        
        
//        [baseRequest.callerObject serverRequestFailed:baseRespone baseRequest:baseRequest];
        
        for (int i = 0; i < serverRequestDoneDelegates.count; i++) {
            
            id caller = [serverRequestDoneDelegates objectAtIndex:i];
            
            // Prevent multiple callbacks
            if (caller == baseRequest.callerObject) {
                continue;
            }
            
//            [caller serverRequestFailed:baseRespone baseRequest:baseRequest];
            
        }
        
    }
}

- (void)handleSuccess:(BaseRequest*)baseRequest res:(id)responseObject task:(NSURLSessionDataTask*)task {
    
    NSLog(@"In HandleSuccess - response for: %@ Response object %@", baseRequest.getMethodName , responseObject);

    BaseServerRequestResponse * baseResponse  = [baseRequest buildBaseServerResponse: responseObject];

    if(baseResponse.isSuccess) {
        
        baseResponse.methodName = baseRequest.getMethodName;
        
        if(![serverRequestDoneDelegates containsObject:baseRequest.callerObject]) {
            [baseRequest.callerObject serverRequestSucceed:baseResponse baseRequest:baseRequest];
            
        }
        
        for (int i =0; i<serverRequestDoneDelegates.count; i++) {
            id caller = [serverRequestDoneDelegates objectAtIndex:i];
            [caller serverRequestSucceed:baseResponse baseRequest:baseRequest];
            
        }
    }
}

@end
