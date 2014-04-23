//
//  HousesCell.m
//  ehc
//
//  Created by Víctor Vicente on 23/04/14.
//  Copyright (c) 2014 EHC. All rights reserved.
//

#import "HousesCell.h"

@implementation HousesCell
@synthesize image,houseName;

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self setFrame:CGRectMake(0, 0, 130, 130)];
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */


@end
