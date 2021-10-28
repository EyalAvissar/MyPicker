//
//  ApplicationManager.h
//  MoviesStartProject
//
//  Created by inmanage on 24/10/2021.
//

#import "BaseManager.h"
#import "StartUpManager.h"
#import "RequestManager.h"
#import "AppGeneralDeclarationResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface ApplicationManager : BaseManager

+ (ApplicationManager *)sharedInstance;

@property AppGeneralDeclarationResponse* appGD;

@property (strong,nonatomic) RequestManager *requestManager;

@property (strong, nonatomic) StartUpManager *startUpManager;
@end

NS_ASSUME_NONNULL_END
