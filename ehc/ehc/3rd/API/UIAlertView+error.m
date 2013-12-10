//
//  UIAlertView+error.m
//  TriviSeries
//
//  Created by Kinki on 4/28/13.
//  Copyright (c) 2013 AKA7. All rights reserved.
//

#import "UIAlertView+error.h"

@implementation UIAlertView(error)
+(void)error:(NSString*)msg
{
    [[[UIAlertView alloc] initWithTitle:@"Error"
                                message:msg
                               delegate:nil
                      cancelButtonTitle:@"Close"
                      otherButtonTitles: nil] show];
}
@end