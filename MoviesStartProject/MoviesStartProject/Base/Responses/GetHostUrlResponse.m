//
//  GetHostUrlResponse.m
//  Meshulam
//
//  Created by inmanage on 8/17/15.
//  Copyright (c) 2015 inmanage. All rights reserved.
//

#import "GetHostUrlResponse.h"
#import "ApplicationManager.h"

@implementation GetHostUrlResponse

-(void)parseData:(NSDictionary *)JSON {

    self.hostURL = [ParseValidator getStringForKey:@"url" inJSON:JSON defaultValue:@""] ;
//    self.getURL = [ParseValidator getStringForKey:@"get_url" inJSON:JSON defaultValue:@""] ;
    
    self.strSplashTxt = [ParseValidator getStringForKey:@"splash_text" inJSON:JSON defaultValue:@""];
    self.strSplashSubTxt = [ParseValidator getStringForKey:@"splash_note_text" inJSON:JSON defaultValue:@""];
    self.getMethodsArr = [ParseValidator getArrayForKey:@"get_methods" inJSON:JSON defaultValue:[[NSArray alloc]init]];

}


@end


