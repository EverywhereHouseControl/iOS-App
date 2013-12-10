//
//  API.h
//  TriviSeries
//
//  Created by Kinki on 4/28/13.
//  Copyright (c) 2013 AKA7. All rights reserved.
//

#import "AFHTTPClient.h"
#import "AFNetworking.h"

//API call completion block with result as json
typedef void (^JSONResponseBlock)(NSDictionary* json);

@interface API : AFHTTPClient{
    int idUs;
}

//the authorized user
@property (strong, nonatomic) NSDictionary* user;
@property (nonatomic) int idUs;

+(API*)sharedInstance;

//check whether there's an authorized user
-(BOOL)isAuthorized;

//send an API command to the server
-(void)commandWithParams:(NSMutableDictionary*)params onCompletion:(JSONResponseBlock)completionBlock;

@end
